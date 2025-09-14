---
layout: post
title:  "Responsive infrastructure - Service discovery and log shipping with docker (3)"
date:   2015-06-14
categories: coreos deployment tools infrastructure aws docker fleet discovery
comments: true
---

In my previous post about [How to setup rsyslog, elasticsearch and kibana on CoreOS and AWS](http://www.itnotes.de/coreos/deployment/tools/infrastructure/aws/docker/fleet/2015/04/03/how-to-setup-rsyslog-elasticsearch-kibana-on-coreos/) I used some custom scripts in order each service discovers all the required ones. E.g. I wrote my own announcement mechanism which polluted all the systemd unit files of the services. The disadvantage of my first approach is clear: it's mixing responsibilities.

In times of microservices and single responsibilities it has to be a better way to deal with it and in fact after doing some research (also talking with pkircher on the coreos IRC channel) I came up with the following:

1. [Registrator](https://github.com/gliderlabs/registrator) (as docker container) runs on each server once and automatically register/deregisters services for Docker containers based on published ports and metadata from the container environment.
2. [SkyDNS](https://github.com/skynetservices/skydns) (as docker container) runs on each server once and provides DNS to discover available services.
3. [Logspout](https://github.com/gliderlabs/logspout) (as docker container) runs also on each server once and ships docker logs to a centralized syslog server.

When a service comes online the following happens:

<div class="diagram">
myService->DockerDeamon: start container
Registrator-->DockerDeamon: listen
Registrator->etcd: writes an entry
SkyDNS-->etcd: updates dns
Logspout-->DockerDeamon: read logs
</div>

The big advantage with this setup is that both the service discovery and the log shipping (through logspout) are completely decoupled from the application and still everything is dockerized - no further requirements on the host.

The simplified elasticsearch systemd-unit file can look like this:

<pre>
<code class="bash">
[Unit]
Description=ElasticSearch service
After=docker.service

[Service]
TimeoutSec=0
EnvironmentFile=/etc/environment

ExecStartPre=/usr/bin/mkdir -p /vol/data/elasticsearch
ExecStartPre=/usr/bin/docker pull dockerfile/elasticsearch

ExecStart=/bin/bash -c '\
  exec docker run \
  --name %p-%i \
  -h `hostname` \
  --publish 9200:9200 \
  --publish 9300:9300 \
  --volume /vol/data/elasticsearch:/usr/share/elasticsearch/data \
  -e SERVICE_ID=%p%i \
  -e ES_HEAP_SIZE=512M \
  --dns ${COREOS_PRIVATE_IPV4} \
  --dns-search=example.local \
  elasticsearch:1.5.2 \
  elasticsearch \
  --node.name=%p-%i \
  --cluster.name=logstash \
  --network.publish_host=${COREOS_PRIVATE_IPV4} \
  --discovery.zen.ping.multicast.enabled=false \
  --discovery.zen.ping.unicast.hosts=elasticsearch-9200.staging.example.local'

ExecStop=/usr/bin/docker stop %p-%i
ExecStop=/usr/bin/docker rm %p-%i

[X-Fleet]
Conflicts=%p@*.service
</code>
</pre>

It's just a simple reference to the unicast host of the "load balanced" skydns image route. Because one of the nice out of the box features of skydns is that it provides automatically round robin balancing of multiple registered docker-container from the same docker-image.

[You can find the updated code about the rsyslog/elasticsearch/kibana setup on github](https://github.com/Pindar/coreos-demo/releases/tag/v0.2).

----------

And because I like it this is written with [StackEdit](https://stackedit.io/).

<!-- <script>
$(".diagram").sequenceDiagram({theme: 'simple'});
</script> -->
