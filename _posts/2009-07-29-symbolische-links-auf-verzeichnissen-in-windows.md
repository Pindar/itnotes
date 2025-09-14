---
layout: post
status: publish
published: true
title: Symbolische Links auf Verzeichnisse in Windows
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
wordpress_id: 53
wordpress_url: http://www.pindarsign.de/itnotes/?p=53
date: '2009-07-29 13:58:23 +0200'
date_gmt: '2009-07-29 11:58:23 +0200'
categories:
- tools
tags:
- tool
- windows
- ntfs
comments: []
---
<p>In Windows kann man zwar Verkn&uuml;pfungen auf Verzeichnisse erstellen, jedoch sind diese eigentlich Dateien, die als Information das Zielverzeichnis enthalten. Greifen eigene Programme auf diese Links zu, erreichen sie meist nicht das Zielverzeichnis. Abhilfe schafft das Tool <a title="Tool-Download-Page" href="http://technet.microsoft.com/de-de/sysinternals/bb896768.aspx" target="_blank">Junction</a>. Denn seit Windows 2000 mit NTFS werden echte Symbolische-Links, wie man sie aus *nix kennt, unterst&uuml;tzt.</p>
