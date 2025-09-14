---
layout: post
status: publish
published: true
title: Proxy-Einstellungen für Windows-Console setzen
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
wordpress_id: 79
wordpress_url: http://www.pindarsign.de/itnotes/?p=79
date: '2009-08-19 10:02:26 +0200'
date_gmt: '2009-08-19 08:02:26 +0200'
categories:
- tools
tags:
- windows
- help
- proxy
comments: []
---
<h2>Worum es geht</h2><br />
Man ist mit seinem Windows-PC in einem Netzwerk angemeldet, in dem man nur &uuml;ber einen Proxy in das WWW kommt. F&uuml;r die Webbrowser sind freilich entsprechende Einstellungen leicht durchzuf&uuml;hren, jedoch gelten diese meist nur in dem entsprechendem Programm. Ein Aufruf von ping auf der Console bekommt weiterhin keinen Zugriff auf das Internet.</p>
<h2>L&ouml;sung</h2><br />
Mit dem in Windows XP vorhandenen Programm proxycfg lassen sich die Einstellungen entweder manuell setzen, oder vom Internet Explorer &uuml;bernhemen. Beispielsweise werden die IE-Einstellungen durch proxycfg -u &uuml;bernommen. Anschlie&szlig;end l&auml;sst sich auch ein ping auf einen Internet-Computer absetzen.</p>
