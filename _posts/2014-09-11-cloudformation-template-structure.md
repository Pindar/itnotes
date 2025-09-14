---
layout: post
title:  "One possible way to structure Cloudformation templates"
date:   2014-09-11 21:08:00
categories: cloudformation development tools aws
comments: true
---

After one year working with AWS Cloudformation templates I've changed the way how the templates are structured. When I started I thought it might be a good idea to have everything that belongs to each other in one file. This means that this file includes Route53 entries, AutoScaling, Alarms, etc. Then I extracted Alarms and DNS entries but still Elastic Load Balancer, Security Groups and Auto Scaling Groups were defined in the same file. 

Today I think that it's better to split it into logical layers. For example I decided to have a Domain-Name Layer that defines all Route53 domain record sets. Then I have a layer that defines an environment without volatile items (e.g. Auto Scaling Groups) but with Elastic Load Balancer, Security Groups etc. Then I have a Template for each application cluster where a cluster consists of an AutoScalingGroup, a SecurityGroup, some Alarms etc. Furthermore alarms are defined again in a separate file and this is created as a referenced Stack (AWS::CloudFormation::Stack). With this approach it's very handy to deploy new applications by adding new cluster stacks. Furthermore if I'd like to change something on an ELB I don't need to fear that I break something on the application.

![Cloudformation Layer illustration](/assets/cloudformation-layer.svg)
