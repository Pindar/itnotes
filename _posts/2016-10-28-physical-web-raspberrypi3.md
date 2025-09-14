---
layout: post
title:  "Physical Web and Raspberry PI 3"
date:   2016-10-28
categories: physical web raspberrypi eddystone ibeacon
comments: true
---

Lately I stumbled over [Google's Eddystone](https://developers.google.com/beacons/) protocol and how it brings the word wide web to the physical world or the other way around: how it enhances physical things with the internet. This idea is nothing new: there was/is RFID/NFC or even barcodes.
What I can see as real advantage of the [physical web](https://google.github.io/physical-web/) compared to these other technologies is that you get contextual information without opening any app or touching a specific physical thing.

<iframe width="560" height="315" src="https://www.youtube.com/embed/1yaLPRgtlR0" frameborder="0" allowfullscreen style="max-width: 100% !important;"></iframe>

Real contextual information is possible without being disturbed by push notifications. For instance you are waiting in public office area. Now you can pick up a digital ticket just as you enter or you get finally the online self care service shown.
An other good show case might be a train station which shows you the delays etc.
Means there are plenty of opportunities!

The good news are you can set-up a basic physical web experiment just within minutes if you have a Raspberry PI 3 with Jessie:

1. Enable Bluetooth `sudo hciconfig hci0 up`
1. Advertise and not-connectable `sudo hciconfig hci0 leadv 3`
1. Generate [Eddystone URL](https://github.com/google/eddystone/tree/master/eddystone-url) and call it http://yencarnacion.github.io/eddystone-url-calculator/
(only HTTPS target URLs are working: http -> https works, https -> http doesn't)


[How to enable Physical Web beacons on iOS](https://youtu.be/gxPcPXSE_O0).
<iframe width="560" height="315" src="https://www.youtube.com/embed/gxPcPXSE_O0" frameborder="0" allowfullscreen style="max-width: 100% !important;"></iframe>

And even more information and ideas you will find in this video:
<iframe width="560" height="315" src="https://www.youtube.com/embed/-kjzVB8plZE" frameborder="0" allowfullscreen style="max-width: 100% !important;"></iframe>
