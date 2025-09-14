---
layout: post
title: Twitter Bootstrap besser einbinden
date: '2014-03-16T13:02:36+01:00'
tags:
- css
- bootstrap
- nextweb
- bradypodion
tumblr_url: http://simondittlmann.tumblr.com/post/79751760235/twitter-bootstrap-besser-einbinden
comments: true
categories: ''
---
Twitter Bootstrap wurde über die letzten Jahre zum beinahe Standard wenn es um CSS-Frameworks geht. Natürlich will man aber dieses anpassen, damit seine eigene Seite nicht wie das original aussieht. Hier bietet getbootstrap.com die Sparte Customize an, jedoch kann man diesen Vorgang leider nicht versionieren. Die Alternative ist das Repository zu forken, jedoch kann es sein, dass man dann nicht mehr upgradefähig bleibt.

Auf dem Barcamp Next Web 2014 in Salzburg durfte ich einem Vortrag über Bradypodion&#8217;s CSS Architecture von Stephan Bönnemann hören, der eine einfache Lösung vorstellte. Er verwies darauf, dass LESS seit Oktober 2013 das feature &#8220;@import (reference)&#8221; bietet. Mit dem ist es möglich z. B. von Bootstrap nur die Klassen zu importieren, die man wirklich braucht und man kann diese auch entsprechend anpassen: <a href="http://lesscss.org/features/#import-options-reference">http://lesscss.org/features/#import-options-reference</a>

Alle die ein third party CSS Framework nutzen sollten sich dieses LESS Feature genauer anschauen.
