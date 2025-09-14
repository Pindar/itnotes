---
layout: post
title: Der Mehrwert Features zu entfernen
date: '2013-01-21T22:42:38+01:00'
comments: true
tags:
- software
- redesign
- removing feature
tumblr_url: http://simondittlmann.tumblr.com/post/41136183370/the-value-to-remove-features
categories: ''
---
<p>In letzter Zeit sind mir einige Gedanken zum Thema Requirements durch den Kopf gegangen. Was sind Requirements und gibt es für Anforderungen eigentlich nur die eine Richtung immer mehr von einem System zu verlangen? Wenn man die Literatur befragt [3] findet man folgende Definition zu Requirements:</p>

<blockquote>
  <p>Requirements are&#8230;a specification of what should be implemented. They are descriptions of how
  the system should behave, or of a system property or attribute. They may be a constraint on the
  development process of the system.</p>
</blockquote>

<p>Nach dieser Definition kann es wohl kein Requirement geben, das fordert ein anderes Requirement auszubauen, doch kann es durch das Requirements Management sehr wohl vorkommen, dass bestehende Anforderungen als nicht mehr benötigt identifiziert werden und daher eine bestehende Anforderung nicht mehr an das Software besteht:</p>

<p>Requirements Management:</p>

<blockquote>
  <p>The central purpose of requirements management is to manage changes to a set of agreed-upon requirements that have been committed to a specific product release. Requirements management also includes tracking the status of individual requirements and tracing requirements both backward to their origins and forward into design elements, code modules, and tests.</p>
</blockquote>

<p>Dieses Requirements Management wird meiner Meinung nach in vielen Projekten zu wenig unter dem Aspekt der Feature-Reduzierung betrieben. Ein Grund dafür ist, dass in Anforderungen häufig mehr auf das &#8220;wie&#8221; und &#8220;was&#8221; als auf das &#8220;warum&#8221; Bezug genommen wird. Doch wie soll ein Requirements Manager eine Funktion als überholt identifizieren können, wenn der tiefere Sinn der Anforderung nicht dokumentiert wurde (darüber spricht James Robertson auch kurz in [1])? Und welchen Wert bringt es für neue Features einen solchen Aufwand zu betreiben?</p>

<p><strong>Der Mehrwert Features zu entfernen</strong></p>

<p>Gibt es für die Menge an Anforderungen an ein Softwaresystem nur die eine Richtung immer mehr davon zu realisieren, wird man irgendwann große Software-Redesigns nicht mehr vermeiden können. Diese Umbauten kosten im besten Fall nur deutlich mehr Entwicklungszeit. Im schlechtesten Fall lässt sich jedoch die Software nicht mehr einfach umstrukturieren und man verhindert weitere Features vollständig (wenn man realistische Kosten zu Grunde legt). Stellt man vorab jedoch fest, dass man bestehende Anforderungen nicht mehr nutzt, wird das geplante Redesign mit Sicherheit deutlich einfacher und auch als Ergebnis kann eine einfachere, wartbare Software geliefert werden.</p>

<p><strong>Wann sollten Features ausgebaut werden?</strong></p>

<p>Hier bin ich persönlich der Meinung, dass Features immer sofort ausgebaut werden sollten, wenn man weiß, dass diese nicht mehr benötigt werden. Davon ausgenommen sind Tabellenumstrukturierungen. Im Datenbank-Layer würde ich Features in manchen Fällen erhalten, damit die Datenbank nicht allzu sehr fragmentiert. 
Der späteste Zeitpunkt ein Feature auszubauen ist IMHO, wenn man bei neuen Anforderungen feststellt, dass diese nicht ohne eines massiven Redesigns umsetzbar sind. Bevor man sich also das neue Softwaredesign überlegt, sollte man zusammen mit den RMs prüfen, ob nicht einige der bestehenden Features unnötig geworden sind.</p>

<p><strong>Erfahrung aus der Praxis</strong></p>

<p>Ich persönlich konnte bereits mehrmals Features ausbauen, bei denen ein vermeintlicher Bug gemeldet wurde. Anstelle eines teuren und komplexen Bug-Fixes konnte nach einer Notwendigkeitsprüfung ein Ausbau des Features umgesetzt werden, was deutlich einfacher zu realisieren war, als der Bug-Fix.</p>

<p>Quellen:</p>

- <a href="http://www.se-radio.net/2012/09/episode-188-requirements-in-agile-projects/">http://www.se-radio.net/2012/09/episode-188-requirements-in-agile-projects/</a>
- <a href="http://gojko.net/2012/05/31/how-to-solve-not-enough-time/">http://gojko.net/2012/05/31/how-to-solve-not-enough-time/</a>

More about Software Requirements, Karl E. Wiegers, 2006
