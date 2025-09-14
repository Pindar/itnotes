---
layout: post
title:  "Responsive infrastructure - How to setup rsyslog, elasticsearch and kibana on CoreOS and AWS (2)"
date:   2015-04-03
categories: coreos deployment tools infrastructure aws docker fleet
comments: true
image: log-shipping.png
---

Update: [In a new blog post I describe a better way to do the service discovery part](http://www.itnotes.de/coreos/deployment/tools/infrastructure/aws/docker/fleet/discovery/2015/06/14/service-discovery-and-log-shipping-with-docker/).

Centralized logging is a key feature of a modern platform architecture. Obviously CoreOS brings some CLI tools to get logs but usually you are not in the lucky position to have only a coreos cluster running. Instead you probably have to manage a lot of different applications on different systems.

My goal was to setup a centralized log system quickly and without writing too many custom scripts. To achieve these two goals I tried Opsworks, Saltstack and in the end coreos. And I have to admit that the simplest approach for me was to use a coreos cluster. In this blog post I like to guide you through the setup step by step and also explain the log shipping system briefly.

You can find all the code on github in my [coreos-demo project](https://github.com/Pindar/coreos-demo).

## Log shipping system overview

I thought the best approach to handle a tremendously amount of log messages is to use syslog as shipping mechanism and elasticsearch together with kibana for visualization.

![Log shipping overview](/log-shipping.png)

Each application will ship the logs to a central rsyslog server by using the syslog protocol. The good thing is that almost every application logger system supports syslog (log4j, monolog etc.). In case you have application container (container with only one application running) you can also use a separate docker container that ships the logs. The important thing is to tag each log entry for simpler log parsing in the next step. Now the central rsyslog server can do both parse each log message and forward each log message to elasticsearch. Finally you can visualize and search through the log entries with kibana.

## Hands On

Let's setup the following:

- running rsyslog service
- make rsyslog available through a private route53 dns entry (e.g. syslog.foobar.local)
- running elasticsearch cluster
- running kibana which points to the elasticsearch cluster
- make the kibana service available through a private route53 dns entry (e.g. kibana.foobar.local)

### Elasticsearch

Let's start with the elasticsearch cluster because both rsyslog and kibana depend on them. Luckily you can find an official ES image on dockerhub which means the only thing we need to do is writing the required systemd files. As reference implementation I found [the instructions of Matt Wright](http://mattupstate.com/coreos/devops/2014/06/26/running-an-elasticsearch-cluster-on-coreos.html)

I'm almost using Matt's approach. Only I'm using my own [announcement mechanism](https://github.com/Pindar/docker-announcement-health-service) which does health checking in addition and mounting the data to a different volume on the host. In the best case this volume is a EBS volume and gets attached to the instance through another service at runtime. But for simplicity I skip this part.

<pre>
<code class="ini">
[Unit]
Description=ElasticSearch service
After=docker.service

[Service]
TimeoutSec=180
EnvironmentFile=/etc/environment

ExecStartPre=/usr/bin/mkdir -p /vol/data/elasticsearch
ExecStartPre=/usr/bin/docker pull dockerfile/elasticsearch

ExecStart=/bin/bash -c '\
  curl -f ${COREOS_PRIVATE_IPV4}:4001/v2/keys/announce/services/elasticsearch/logs; \
  if [ "$?" = "0" ]; then \
      PEER_PATH=$(etcdctl ls /announce/services/elasticsearch/logs | head -1); \
      UNICAST_HOSTS=$(etcdctl get $PEER_PATH | awk \'/:/ { print $2 }\' | cut -d\'"\' -f 2); \
  else \
      UNICAST_HOSTS=""; \
  fi; \
  /usr/bin/docker run \
    --name %p-%i \
    -h `hostname` \
    --publish 9200:9200 \
    --publish 9300:9300 \
    --volume /vol/data/elasticsearch:/data \
    -e ES_HEAP_SIZE=512M \
    dockerfile/elasticsearch \
    /elasticsearch/bin/elasticsearch \
    --node.name=%p-%i \
    --cluster.name=logstash \
    --network.publish_host=${COREOS_PRIVATE_IPV4} \
    --discovery.zen.ping.multicast.enabled=false \
    --discovery.zen.ping.unicast.hosts=$UNICAST_HOSTS'

ExecStop=/usr/bin/docker stop %p-%i
ExecStop=/usr/bin/docker rm %p-%i

[X-Fleet]
Conflicts=%p@*.service
</code>
</pre>

Save this systemd configuration to `elasticsearch@.service` and submit it as systemd template to your CoreOS cluster by typing `fleetctl submit elasticsearch@.service`. At this point in time you can already start your elasticsearch cluster assuming your coreos cluster works and the required fleet metadata is set. Do so with `fleetctl start elasticsearch@1.service` and check the status with `fleetctl status elasticsearch@1.service`. To get the logs of our elasticsearch container you can use fleetctl again: `fleetctl journal elastichserach@1.service`.

Let's announce the new service.
<pre>
<code class="ini">
[Unit]
Description=ElasticSearch announce service
After=elasticsearch@%i.service
BindsTo=elasticsearch@%i.service

[Service]
EnvironmentFile=/etc/environment

ExecStartPre=-/usr/bin/docker kill elasticsearch-announce-%i
ExecStartPre=-/usr/bin/docker rm elasticsearch-announce-%i
ExecStartPre=/usr/bin/docker pull pindar/announcement-health-service

ExecStart=/bin/sh -c '\
/usr/bin/docker run \
--name elasticsearch-announce-%i \
-e SERVICE=elasticsearch \
-e THRESHOLD=5 \
-e TIMEOUT=45 \
-e ENVIRONMENT=logs \
-e NUMBER=%i \
-e HOST_IP=${COREOS_PRIVATE_IPV4} \
-e HEALTH_URL=http://${COREOS_PRIVATE_IPV4}:9200 \
-e ANNOUNCE_VALUE=\'{"IP": "${COREOS_PRIVATE_IPV4}", "PORT": "9200", "TRANSPORT_PORT": "9300" }\' \
pindar/announcement-health-service'

ExecStop=/usr/bin/docker stop elasticsearch-announce-%i

[X-Fleet]
MachineOf=elasticsearch@%i.service
</code>
</pre>

Just use the same fleetctl commands as above to start the announcement service.

### ElasticSearch Client node

To have a [smart load balancing for your elasticseach cluster](http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html) you can easily start client nodes. Afterwards you can connect kibana or rsyslog to this nodes instead of using the cluster directly.

<pre>
<code class="ini">
[Unit]
Description=ElasticSearch client service
After=docker.service

[Service]
TimeoutSec=180
EnvironmentFile=/etc/environment

ExecStartPre=/usr/bin/mkdir -p /vol/data/elasticsearch
ExecStartPre=/usr/bin/docker pull dockerfile/elasticsearch

ExecStart=/bin/bash -c '\
  curl -f ${COREOS_PRIVATE_IPV4}:4001/v2/keys/announce/services/elasticsearch/logs; \
  if [ "$?" = "0" ]; then \
      PEER_PATH=$(etcdctl ls /announce/services/elasticsearch/logs | head -1); \
      UNICAST_HOSTS=$(etcdctl get $PEER_PATH | awk \'/:/ { print $2 }\' | cut -d\'"\' -f 2); \
  else \
      UNICAST_HOSTS=""; \
  fi; \
  /usr/bin/docker run \
    --name %p-%i \
    -h `hostname` \
    --publish 9200:9200 \
    --publish 9300:9300 \
    --volume /vol/data/elasticsearch:/data \
    dockerfile/elasticsearch \
    /elasticsearch/bin/elasticsearch \
    --node.name=%p-%i \
    --node.data=false \
    --node.master=false \
    --cluster.name=logstash \
    --network.publish_host=${COREOS_PRIVATE_IPV4} \
    --discovery.zen.ping.multicast.enabled=false \
    --discovery.zen.ping.unicast.hosts=$UNICAST_HOSTS'

ExecStop=/usr/bin/docker stop %p-%i
ExecStop=/usr/bin/docker rm %p-%i

[X-Fleet]
Conflicts=%p@*.service
</code>
</pre>

You can find all configuration files also on my github account in the [demo project](https://github.com/Pindar/coreos-demo) -- you need two announcement services for the elasticsearch client nodes: one that announces the node in the es-cluster and one that announces the node as client node for other services.

### Kibana

Let's connect Kibana to our new elasticsearch instance. You can find a [dockerized version of kibana 4 on my github repo](https://github.com/pindar/docker-kibana) and an automated build on [dockerhub](https://registry.hub.docker.com/u/pindar/kibana/).

To start a container from this image we need again the systemd configuration for our coreos cluster.

<pre>
<code class="ini">
[Unit]
Description=Kibana logs front-end
After=elasticsearch-announce@*.service
Requires=elasticsearch-announce@*.service

[Service]
EnvironmentFile=/etc/environment
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill kibana
ExecStartPre=-/usr/bin/docker rm kibana
ExecStartPre=/usr/bin/docker pull pindar/kibana

ExecStart=/usr/bin/bash -c '\
curl -f ${COREOS_PRIVATE_IPV4}:4001/v2/keys/announce/services/elasticsearch-lb/logs/; \
  if [ "$?" = "0" ]; then \
      ELASTICSEARCH_ENDPOINT="http://$(etcdctl get /announce/services/elasticsearch-lb/logs/1 | awk \'/:/ { print $2 }\' | cut -d\'"\' -f 2):9200"; \
  else \
      ELASTICSEARCH_ENDPOINT=""; \
  fi; \
/usr/bin/docker run \
--name kibana \
-e ELASTICSEARCH_ENDPOINT=$ELASTICSEARCH_ENDPOINT \
-p 5601:5601 \
pindar/kibana'

ExecStop=/usr/bin/docker stop kibana

[X-Fleet]
Conflicts=kibana.service
</code>
</pre>

As soon as kibana is running you can try to connect to it on port 5601 and should see the interface.

<img src="/kibana-first-start.png" width="100%" alt="Kibana after startup" />

To make it more convenient to access the UI you can dynamically update your DNS server. In case you are using AWS Route53 even for private entries you can use [my fork](https://github.com/Pindar/go-route53-presence) of an implementation that exactly does it for you. The fork was necessary because I don't wont to remove the dns entry every time fleet moves the service because it takes some time that the entry gets visible again (TTL of the SOA).

<pre>
<code class="ini">
[Unit]
Description=kibana announcement service

After=docker.service
BindsTo=kibana.service

[Service]
ExecStartPre=-/usr/bin/docker kill %p
ExecStartPre=-/usr/bin/docker rm %p
ExecStartPre=/usr/bin/docker pull pindar/go-route53-presence

ExecStart=/usr/bin/bash -c \
"/usr/bin/docker run \
--name %p \
-e AWS_ACCESS_KEY=`etcdctl get /AWS_USER_ROUTE53_KEY` \
-e AWS_SECRET_KEY=`etcdctl get /AWS_USER_ROUTE53_SECRET` \
-e ROUTE53_RECORD_NAME=logs.example.local. \
-e ROUTE53_RECORD_TYPE='A' \
-e ROUTE53_TTL=15 \
-e ROUTE53_ZONE_ID=`etcdctl get /AWS_ROUTE53_ZONE_ID` \
-e ROUTE53_IP_TYPE=private \
pindar/go-route53-presence"

ExecStop=/usr/bin/docker stop %p

[X-Fleet]
MachineOf=kibana.service
</code>
</pre>

### Rsyslog

The last missing piece is the rsyslog container which will handle all the shipped logs. Even for this you can find a ready to use docker image on [dockerhub](https://registry.hub.docker.com/u/pindar/docker-rsyslog/)

<pre>
<code class="ini">
[Unit]
Description=Centralised RSyslog
After=docker.service

[Service]
User=core
TimeoutStartSec=0
EnvironmentFile=/etc/environment

ExecStartPre=-/usr/bin/docker kill central-rsyslog-%i
ExecStartPre=-/usr/bin/docker rm central-rsyslog-%i
ExecStartPre=/usr/bin/docker pull pindar/docker-rsyslog
ExecStartPre=/usr/bin/sudo /usr/bin/mkdir -p /vol/logs

ExecStart=/usr/bin/bash -c '\
ELASTICSEARCH_ENDPOINT="$(etcdctl get /announce/services/elasticsearch-lb/logs/1 | awk \'/:/ { print $2 }\' | cut -d\'"\' -f 2)"; \
/usr/bin/docker run \
--name central-rsyslog-%i \
-p 514:514 \
-p 514:514/udp \
-e ELASTICSEARCH_HOST=$ELASTICSEARCH_ENDPOINT \
-v /vol/logs:/var/log/remote \
pindar/docker-rsyslog'

ExecStop=/usr/bin/docker stop central-rsyslog-%i

[X-Fleet]
Conflicts=central-rsyslog@*.service
</code>
</pre>

To test the round trip lookup the ip where rsyslog is running `fleetctl list-units` and connect with telnet to write your first log message.

<pre>
<code class="bash">
telnet 172.17.8.101 514
Trying 172.17.8.101...
Connected to 172.17.8.101.
Escape character is '^]'.
test foobar : this is my message
^]
telnet> quit
Connection closed.
</code>
</pre>

<img src="/kibana-log-messages.png" width="100%" alt="Kibana first log messages" />

Now everything is up and running -- happy shipping!
