---
layout: post
title:  "Responsive infrastructure - or how to handle microservices with CoreOS and AWS (1)"
date:   2015-03-14 19:20:00
categories: docker coreos deployment layering infrastructure
comments: true
---

This is the first part of a series of three blog articles. This first one gives a more theoretical overview about how I layer an infrastructure.

Recently the micro-service architecture style is growing a lot but even without such an architectural approach you probably have to run a lot of different software components in your data center to provide a simple application. Just think about what you need for a single application you might develop. Your stack could look like the following:

- DNS entries
- IP routing
- firewall settings
- Virtual Machine / Server
- operating system
- load balancer
- apache/nginx
- tomcat with your application running
- database
- log aggregation service
- performance metrics

This means even a simple application needs some other services to run properly. In a more classic approach you would setup all the required software once and for each deployment you would replace just your developed binary (e.g. your war file). To have a more scalable approach it's good to start with a short planning. Let's try to sort each of the listed pieces in one of the three following layers ([more information](http://www.thoughtworks.com/insights/blog/layering-cloud)):

1. Visible (changes rarely): DNS entries, virtual machines, operating system, firewall settings, ip routing
2. Volatile (changes often): load balancer, apache, tomcat, database software, log aggregation software, performance metrics software, internal dns
3. Persistent (no changes): database data, log data, performance data

Since we have now a clear picture which parts of the system we'd like to change more often and fast we can think about how to achieve it.

Let's start with the Visible layer.

## Visible Layer

This layer captures all pieces changing from time to time but might affect the entire system. The risk to do a change is obviously high.

When you are a happy AWS customer and you'd like to have your infrastructure written in code then Cloudformation is probably your friend to handle this layer. You can write and test it with a separate stack even in a continuous integration process and update your production infrastructure after all testing is done.

But this layer is not the one with the highest risk. You should be really scarred while doing changes on the persistent layer.

## Persistence layer

Almost every single application needs to persistent data in the end. Data is usually the most valuable thing for a service and that's why it should be treated carefully. You probably do backups, never format the volume, do regular checks etc.

With AWS I'm using EBS volumes for this. It's perfect because you can move the volume from one instance to another one by attaching and detaching it. In addition you can take regularly snapshots and store it to s3.

To process all the data we need an application which probably will change rapidly and that's why it's in the volatile layer.

## Volatile layer

This layer is for all running applications regardless of whether it's developed by yourself or just managed. The reason why I don't differentiate is that you might need to update your managed application because of security reason fast and without hassle. Why should it be harder to deploy a third party application then something developed by yourself?

To keep things simple I'm containerize everything and try to follow the single responsibility rule which means a docker container should only have one process but multiple docker container might orchestrate one single service (also called pod). With this approach it's quite simple to update each part separately. Sadly docker has some [downsides](http://containerops.org/2014/12/19/docker-vs-rocket-gimme-a-break/) when orchestrating a pod but since the App Container Specification addresses most of them it will be just a matter of time that either Rocket (which implements APPC) or Docker (which doesn't implement APPC but it's developed by so many smart people) will solve them.

Nevertheless a containerized application is much simpler to deploy then a traditional one which makes it also simpler to manage your volatile layer.

In the next blog post I will explain how I created a CoreOS cluster with ElasticSearch, Kibana and Rsyslog while following this theories.
