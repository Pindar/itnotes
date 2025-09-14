---
layout: post
title:  "Idea to Production - with Gitlab and Kubernetes"
date:   2017-03-05
categories: 
    - gitlab 
    - kubernetes 
    - k8s 
    - GKE 
    - gcloud
comments: true
publisher: "Simon Dittlmann"
---

It's 2017 and you might think continuous integration/delivery is everywhere. Sadly it's not but with tools like Gitlab, Gitlab-CI and Kubernetes there is pretty much no excuse not to do it anymore. Think about it. The pain point to do proper continuous delivery is often to setup all the staging systems, connect them with your ticket system, connect it with your code repository and automate not even tests but basically your entire workflow -- end to end. And this took you usually month -- best case weeks. This's terrifying! But Kubernetes and Gitlab are here for the rescue. It simplifies the setup so much that you can focus on your business.
{f5 lh-copy measure mt0-ns}

## Overview

[![Overview](/assets/gitlab-kubernetes/idea_to_production_overview.svg)](/assets/gitlab-kubernetes/idea_to_production_overview.svg)

We are going to build a modern delivery pipeline starting with building and unit/integration testing the software. Afterwards we will deploy the current feature branch to a new one-time staging environment. Gitlab calls this a review app. And as soon as it's ready it will be integrated and deployed to a staging system for final integration testing. As soon as you'd like to release just tag the commit in git and the exact docker image will be tagged the same way. Finally the release is going to production and monitoring it is now the number one priority. Luckily we have [Stackdriver Logging](https://cloud.google.com/logging/docs/) on google cloud for all log file analysis. For server/kubernetes monitoring you can use for example [Datadog](http://docs.datadoghq.com/integrations/kubernetes/). How the workflow looks like from a branching perspective you can see here:

[![Overview](/assets/gitlab-kubernetes/idea_to_production_branching.svg)](/assets/gitlab-kubernetes/idea_to_production_branching.svg)

And these are the tools we will use within this flow:

- Gitlab: Git repository
- Gitlab-CI: continuous integration and deployments
- Google Container Registry: docker images
- Google Container Engine (GKE/Kubernetes): our application cluster (one or multiple clusters)
- Google Cloud: Logging
- Datadog: Performance Monitoring

[![Overview](/assets/gitlab-kubernetes/idea_to_production_tools.svg)](/assets/gitlab-kubernetes/idea_to_production_tools.svg)

Enough talking. Let's get it done. Just within the next 60 minutes.

## Setup, step by step

This step by step instructions will help you to get Google Cloud Platform, Google Container Engine (GKE/Kubernetes) up and running and wire everything with a gitlab installation -- even gitlab.com.

### Basis: Google Cloud Platform

1. The first thing you need to do is to create your own [Google Cloud Platform Account](https://console.cloud.google.com). With it you are able to use all services. Be aware you can sign-up for a trial of 60 days and with enough credits to play around. It's free, no strings attached.
1. After you're logged into your fresh Google Cloud account you should start the Cloud Shell. Check the [quick-start documentation](https://cloud.google.com/shell/docs/quickstart) if you need more assistance.
1. Now we are ready to setup our demo application. To do so clone the following git repository `git clone https://github.com/Pindar/gcloud-k8s-express-app.git && cd gcloud-k8s-express-app/`
1. Setup GCloud project `./k8s/gcp/setup_gcloud_project.sh [test-gitlabci-k8s-XXX]`. This creates a new [google cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) and activates billing for you as long as you are using a German account otherwise you need to change ``ACCOUNT_ID=${2:- ` gcloud alpha billing accounts list | grep "Mein Rechnungskonto" |  awk '{ print $1 }' ` }`` at [https://github.com/Pindar/gcloud-k8s-express-app/blob/master/k8s/gcp/setup_gcloud_project.sh#L11](https://github.com/Pindar/gcloud-k8s-express-app/blob/master/k8s/gcp/setup_gcloud_project.sh#L11)
1. Since you have a working Google Cloud Project the next step is to setup all required google cloud resources. In particular we need a Kubernetes cluster where we are going to deploy our application later onto. Furthermore we need a service account with restricted access to our account which is going to be used for deployments later on. To make both things as simple as possible you can just run the setup script with the project name as parameter: `./k8s/gcp/setup_gcloud_resources.sh [test-gitlabci-k8s-XXX]`

### Continuous Integration: Gitlab-CI

1. Register at [Gitlab](https://gitlab.com/users/sign_in)
1. Create your own repository and clone example repository https://github.com/Pindar/gcloud-k8s-express-app.git [![](/assets/gitlab-kubernetes/screencapture-gitlab-projects-new-1488711395727.png)](/assets/gitlab-kubernetes/screencapture-gitlab-projects-new-1488711395727.png)
1. Now we need to prepare Gitlab-CI. The first step is to prepare all required variables. A list is shown in the table below. To make your life easier you can run `create_gitlab_variables.sh [test-gitlabci-k8s-XXX]` where the first argument is again the google cloud project where it belongs to. For updating later on you can just call `update_gitlab_variables.sh [test-gitlabci-k8s-XXX]`. The scripts need all variables defined within a .gitlab-env file. So don't forget to create the file before running the script!

| Name                                 | Value                                                                     |
|--------------------------------------|---------------------------------------------------------------------------|
| GCLOUD_GITLAB_CI_SERVICE_ACCOUNT_KEY | output of previous step                                                   |
| CI_REGISTRY_IMAGE                    | eu.gcr.io/test-gitlabci-k8s-XXX/kbnw-express-app                          |
| CLUSTER_NAME                         | example-cluster                                                           |
| GCLOUD_GITLAB_CI_SERVICE_ACCOUNT     | gitlab-ci-token@test-gitlabci-k8s-XXX.iam.gserviceaccount.com             |
| GCLOUD_ZONE                          | europe-west1-b                                                            |
| DOMAIN                               | your domain name, e.g., example.com                                       |
| PROD_SUBDOMAIN                       | your production subdomain, e.g., www for www.example.com                  |
| STAGING_SUBDOMAIN                    | your staging subdomain, e.g., citeststaging for citeststaging.example.com |
| DOCKER_HOST                          | to get gitlab runner working on kubernetes set it to tcp://localhost:2375 |
| GCLOUD_PROJECT                       | google cloud project id, e.g., test-gitlabci-k8s-XXX                      |

[![](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/gitlab_secret_variables_section.png)](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/gitlab_secret_variables_section.png)

1. If you don't trust the shared gitlab-ci-runner on gitlab.com check out this related [how-to](https://github.com/Pindar/gcloud-k8s-express-app/blob/master/k8s/gitlab-ci-runner/README.md) to have your own runners on your GKE/Kubernetes cluster.
1. It's done. Now you can run a build. Make a small change at any file, commit, push and see how the pipeline kicks-in. [![](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/gitlab_pipeline.png)](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/gitlab_pipeline.png)

### DNS / Connecting Cluster

1. As soon as master was build once there will be a ingress load balancer which is going to have the public IP address. Therefore your last setup-step is to update your DNS settings to the ingress IP you get by calling `kubectl --namespace=production get ing`
1. Now you can also proxy to your Cluster from your Cloud Console. First run `kubectl proxy --port 8080` and second start web preview, see [![](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/web_preview.png)](https://raw.githubusercontent.com/Pindar/gcloud-k8s-express-app/master/doc/images/web_preview.png)

*In case you run it locally on your pc or mac*

1. configure kubectl `gcloud auth application-default login && gcloud --quiet container clusters get-credentials example-cluster --zone europe-west1-b && export KUBERNETES_CONFIG=~/.kube/config`
1. [OPTIONAL] activate context `kubectl config get-contexts`, `kubectl config use-context [CONTEXT_NAME]`

### Use it

Now it's time to create an issue at gitlab. Create a branch for it starting with the issue number and do some changes. When you're done push it to gitlab and create a merge request. You will see that Gitlab-CI will shortly afterwards start building/testing and deploying the changes as review app to your Kubernetes cluster. And as soon as you merge these changes to master and remove the feature-branch the review-app is going to tear down automatically and all the joy I was talking in the beginning is in place. Wasn't that easy?

### Clean up

To clean everything up again afterwards just call the following scripts which are doing basically the inverts of what we have done during the setup.

*kubectl config*

1. Remove context; list them `kubectl config get-contexts`, remove `kubectl config delete-context [CONTEXT_NAME]`
1. Remove cluster; list them `kubectl config get-clusters`, remove `kubectl config delete-cluster [CLUSTER_NAME]`

*project/resources*

1. `./k8s/teardown.sh`
1. `./k8s/gcp/tear_down_gcloud_resources.sh [test-gitlabci-k8s-XXX]`
1. `./k8s/gcp/tear_down_gcloud_project.sh [test-gitlabci-k8s-XXX]`

## Summary

I hope you've enjoyed this short blog post how to setup quickly a continuous integration/delivery pipeline with Gitlab and Kubernetes on Google Cloud Platform. If you find any bugs or have any question just write me in the comments or on twitter.

## Links

- Slides [https://www.slideshare.net/Pindar/idea-to-production-with-gitlab-and-kubernetes](https://www.slideshare.net/Pindar/idea-to-production-with-gitlab-and-kubernetes)
- Code [https://github.com/Pindar/gcloud-k8s-express-app](https://github.com/Pindar/gcloud-k8s-express-app)
