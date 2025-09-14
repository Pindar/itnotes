---
layout: post
status: publish
published: true
title: Why rapid deployments are so important
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
wordpress_id: 134
wordpress_url: http://www.pindarsign.de/itnotes/?p=134
date: '2012-05-17 23:39:58 +0200'
date_gmt: '2012-05-17 21:39:58 +0200'
categories:
- articles
tags:
- deployments
- software
- agile
comments: []
---

## What's the problem about rare deployments?

If your release cycle is very long, your customers will start asking for things that will make the system overly complex. Why? Because they want their ideas implemented as quickly as possible. They will therefore start thinking about a completely configurable system. These new requirements will result in a system that is more complex and harder to maintain.

## But... I can't release so often.

Yes, you can! It's always possible to release in short cycles. All you need is the right setup.

- **Continuous integration** is the most important thing. Without a CI server, you won't be able to do this.
- **Test automation.** You need unit tests, integration tests and, in some cases, UI tests.
- **Monitoring.** Your development team should always keep an eye on the log files. If you don't identify problems early on, you will have major issues later on.
- **Automated deployment.** If your deployment isn't automated yet and you want to deploy in short cycles, you won't have time to develop software.
- **Code management with Git.** This tool will dramatically speed up your deployments and blow you away.
- **Very close collaboration with your customer** to manage requirements. Don't write abstract requirements — use examples wherever possible.

In my humble opinion, this is the minimum setup you need for continuous deployment.

## What do you get?

Your customer gets what they want much faster. Your developers don't have to create unmaintainable software but can instead create awesome features. Developers and customers will love this new way to work. Rapid deployments end up in a happy collaboration between customer and developer. Not more, but also not less.
