---
layout: post
title:  "Speed up your docker workflow with a Makefile"
date:   2014-08-31 12:10:00
categories: docker development tools
comments: true
---
 
While I'm working with [docker][dockerio] I use a handful of commands: build this project, run it with certain environment variables, remove the image/container. First I tried writing shell scripts to prevent me for typing this commands over and over. But the disadvantages are clear: I had quickly a bunch of scripts and I could not commit this scripts to our VCS because all this scripts were to much coupled to my setup.
After a while thinking I came up with this solution: I have a base Makefile that includes a configuration file which is ignored by the VCS. This way everyone profit from the handy make commands like `make build`, `make run` etc. but all my colleagues can configure their own setting.

Here the Makefile template (thanks to [@blang][blang] for the initial template)

<pre>
<code class="makefile">
include env_make
NS = your docker namespace
VERSION ?= latest

REPO = your docker repo name
NAME = name of the image
INSTANCE = default

.PHONY: build push shell run start stop rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

start:
	docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm $(NAME)-$(INSTANCE)

release: build
	make push -e VERSION=$(VERSION)

default: build

</code>
</pre>

and don't forget to place an env_make file next to your Makefile that is ignored by the VCS:

<pre>
<code class="makefile">
PORTS = -p 8080:80

VOLUMES = -v /var/log/docker:/var/log

ENV = \
  -e SOME_KEY=SOME_VALUE
</code>
</pre>

[blang]: https://github.com/blang
[dockerio]: https://www.docker.com
