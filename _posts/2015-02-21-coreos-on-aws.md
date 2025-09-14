---
layout: post
title:  "CoreOS + Docker on AWS"
date:   2015-02-21 16:50:00
categories: coreos deployment tools infrastructure aws docker fleet
comments: true
---

After moving to docker half a year ago I tried a lot of different deployment/configuration tools on AWS:


* Deploying pre-provisioned AMIs
* Deploying new instances and polling all the docker container on startup
* Opsworks with Docker-Chef recipes
* Saltstack (only as POC)
* Kubernetes (only as POC)


Kubernetes is really nice but "Kubernetes is in pre-production beta!". And especially it's stated that you shouldn't use it with a high load. Also AWS Container Service is not ready for production yet.

So exciting docker is it's still a very young technology and I wanted to have a toolbox for it which is very flexible and let you deploy new software within minutes. One hard requirement to me is a easy configuration management. So I finally took a look at CoreOS again. And what I have seen so far is really nice. It focus really on "massive server deployments" and gives you all tools you need to get up and running in hours (including learning time).

I started my CoreOS journey with this [article about AWS deployments](https://coreos.com/docs/launching-containers/launching/fleet-example-deployment/) . And got our entire staging system running within one day. But there are also some minor things I'd like to have before it goes to production:


* blue/green deployments
* rolling deployments
* service announcement for discovery
* for some services a 1:1 mapping between AWS autoscaling and started container


The nice thing is that the side-kick service idea let's you do all of it with a couple of microservices. For the blue/green deployments I plan to update the port mapping on AWS ELBs. The new container will start on a different but fixed port and as soon as it's running the ELB will be updated. The rolling one is quite simple with fleet. Just a couple of bash lines.
For the Service Announcement/discovery I started also a small micro service and it's [open sourced](https://github.com/Pindar/docker-announcement-health-service). Not totally done yet but I'm working on it (pull requests are welcome).
And the hardest part is my "auto scaling". The idea is to store the desired amount of started containers for each service in etcd. This value is checked by a microservice which starts or stops the services. While a deployment happens this is obviously paused. The desired value can then come from different sources. One might be an AWS autoscaling group; or you calculate the load based on some metrics you have in e.g. Datadog. No matter how I will open source [this little microservice soon](https://github.com/Pindar/docker-coreos-autoscale-container).
