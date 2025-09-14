---
layout: post
title: Deployments, Development Cycles and New Features
date: '2014-05-01T14:21:01+02:00'
tags:
- agile
- deployments
- scrum
- kanban
- feature-toggle
- feature_toggle
tumblr_url: http://simondittlmann.tumblr.com/post/84416907356/deployments-development-cycles-and-new-features
comments: true
categories: ''
---
<p>In classical companies deployments are very strong coupled with Development Cycles and they again with the availability of new features. But this coupling is only feasible when the company is small or best case one person is responsible for all of this three things. But in companies where the responsibilities are scattered across departments (Product Management, IT-Operations and IT-Development) you should de-couple the outcomes of this departments to be more flexible.</p>

<p><em>What happens if all three things are coupled?</em>
The obvious thing is that planed deployments happens only when a development cycle ends. And because development cycles are also coupled to new features we get deployments only when new features are available. In a world where nothing unexpected happens and where no bugs are possible this process fits perfect. If you find one let me know!</p>

<p>If you decouple deployments from development cycles you can decrease the live time of bugs. Why? Because you have not to wait until one of the development cycles are done (or starting one of the complicated hot-fix release processes). The only thing you are waiting for is a version with the bug fix or maybe the bug is unrelated to development at all, like heartbleed then you can deploy just the infrastructure code. With this in mind your goal should be to be able doing multiple deployments per day.</p>

<p>When you go one step further and also remove the coupling between new features and development cycles you can roll out the code of the new features when ever it&#8217;s done but someone else can schedule when to activate the feature. This means you can roll out even smaller batches, you&#8217;re reducing the lead time of features again and it&#8217;s still complaint to all agile processes (even scrum) and I would say even ITIL. Bussword for this idea is &#8220;feature toggle&#8221;.</p>
