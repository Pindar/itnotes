---
layout: post
title:  "Docker pipeline or Dockerize your development workflow"
date:   2015-04-22
categories: coreos deployment tools infrastructure docker fleet docker-compose fig
image: assets/container_z.jpg
comments: true
---

<div style="width: 100%; text-align: center;">
	<img src="/assets/container_z.jpg" alt="Container">
</div>

When you containerize your applications you will find out that you can do so much more with container and in particular with docker than just running your applications. You can use docker in all stages for different purposes:

## Development

- prepare a docker image with all required development tools for a certain project. With it it's easy to ramp up new team mates and keep everyone in sync.
- of course dockerize your application and use the dockerized version to be close to production even in the first stage. The downside is that this doesn't work well on MacOS or Windows yet. On MacOS you can have docker running in a VM but the mounting of the host files are causing performance issues even with NFS.
- run your databases within a container. This makes it easy to start from predefined states when you have some import scripts prepared. One use case is to test data migrations easily.

## Continuous Integration

- use the tooling container you already have for development also on your continuous integration server. Best case you don't need to install any other tool than docker on the host which makes all ci-jobs totally independent of each other. This is very handy if you have only one Jenkins Server but it has to run jobs for a lot of different teams.
- use docker-compose for continuous integration testing. With it you can for example start your application together with a dockerized database and a third container runs the end to end tests against both. As long as you have enough memory and CPU you can bring up even more complex environments. Note that you can run these tests even on open pull requests.

## Staging

- use [Kubernetes](http://kubernetes.io), [CoreOS](http://coreos.com) or [docker-compose](https://docs.docker.com/compose/) to start new environments quickly -- for example one per git branch.
- use [centralized application logging systems](/coreos/deployment/tools/infrastructure/aws/docker/fleet/2015/04/03/how-to-setup-rsyslog-elasticsearch-kibana-on-coreos/) like kibana or [loggly](https://www.loggly.com/) to find bugs early. Dockerized applications can easily log to stdout and these logs can be shipped by [logspout](https://github.com/gliderlabs/logspout) to a centralized syslog server or since docker 1.6 you can directly ship to syslog. To make the analysis simpler you should have a look at the [@CEE](http://cee.mitre.org/) logging project.
- use performance logging tools for example [datadog](http://datadoghq.com). Consider that you need to think in layers which means you need to monitor the underlying infrastructure independently of your application layer. With a proper service discovery and an overlay network you can centralize the gathering process of all application metrics.

## Production

- just use the same things as in your staging environment.


## Summary

These are just a few ideas how you can use docker in your continuous delivery pipeline. A general recommendation is to have your own self-hosted private docker repository or at least a docker registry cache running to avoid problems when your third party docker-registry is unavailable. These caches are speeding up the deployment times a little bit as well and reducing the bandwidth consumption which reduces your costs a little bit too.


<small><a href="https://www.flickr.com/photos/alessandro_tortora/9107456544/in/photolist-2UrVHv-ffC6iF-7LYpe-6BCmMw-2g7WPm-4MtokT-5o5H31-cKibz-8ffvuz-9fJb3k-7LYp8-eSN6wQ-6wxnw5-6P7h6L-7HrALP-75mqLa-fMsCgA-5MQQVH-bqtD65-4spGvX-hD812L-6BycMR-qyxTko-7vBa2x-kzLw9n-e8RuW9-4HjFTS-bMcSap-gLRa3J-7L6Kgr-qyxMwu-9AANh7-6TdaJA-deEn5b-6W7SPZ-mp184V-MtgM-e565pj-4LGK2-2g7WN7-i4r6Vs-gmkcM-bRf2oP-kKZgdV-6P7h67-9XSWct-5im4bs-2geu7-gMFuR2-bASsp6/">Photo is under creative commons</a></small>
