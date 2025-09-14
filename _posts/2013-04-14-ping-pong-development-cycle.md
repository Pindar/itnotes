---
layout: post
title: Ping-Pong Development Cycle
date: '2013-04-14T15:19:00+02:00'
tags:
- TDD
- Softwareentwicklung
- agile
- cycle
tumblr_url: http://simondittlmann.tumblr.com/post/47949610384/ping-pong-development-cycle
comments: true
categories: ''
---
<p><em>oder die Kunst ein neues System nicht zu einem Legacy-Projekt verkommen zu lassen.</em></p>

<p>Die allermeisten Programmierer mögen Projekte lieber, die nicht auf einer bestehenden Code-Basis aufbauen. Sie lieben es selbst auf der grünen Wiese anzufangen und sind sich sicher, dass sie diesmal alles richtig machen werden. Diesmal wird am Ende ein wunderschönes Kunstwerk den Livegang beglücken. Doch dies ist meist ein Wunschtraum und schon nach kürzester Zeit werden die ersten Probleme sichtbar, denn die wahren Entscheidungen werden erst im Detail getroffen. Und nun beginnt der zu oft geführte Kampf um die Zeit, den Feature Scope und die Code-Qualität.</p>

<p>Wie in &#8220;Practices for Scaling Lean &amp; Agile Development: Successful Large, Multisite &amp; Offshore Product Development with Large-Scale Scrum&#8221; beschrieben liegt die größte Gefahr in einen Ping-Pong Zyklus zwischen Re-Designs und Feature-Requests zu geraten. Bei diesem wechseln sich Sprints mit überwiegend Business-Requirements mit Sprints mit überwiegend technischen Requirements ab.</p>

<h2>Warum entwickelt sich ein solcher Ping-Pong Zyklus?</h2>

<p>Der Ausgangspunkt ist meist das Verlangen Anforderungen so schnell wie möglich zu liefern. Zu Beginn des Projekts ist dies meist kein Problem, da jeder im Team alle Stellen im Code und alle Requirements kennt. Workarounds werden (noch) nicht benötigt. Unit-Tests und kontinuierliches Refactoring wird zu Beginn oft abgelehnt, da man ohne diese <em>lästigen Aufgaben</em> schneller Features liefern kann. Nachdem das Programm eine kritische Größe erreicht hat macht sich diese Nachlässigkeit umso stärker bemerkbar. Um die Liefergeschwindigkeit nicht zu beeinträchtigen beginnt man Code zu kopieren, um bestehende Funktionalität nicht versehentlich zu zerstören. Denn ohne automatisierte Tests kann bei dieser Größe des Projekts keiner mehr alle Funktionen manuell überprüfen. Die Code-Base beginnt immer mehr zu verotten. Der einzige Ausweg sind dann oft aufwändige Software-Redesigns und Regressionstests.</p>

<h2>Deshalb meine These:</h2>

<p><strong>Je länger die Zyklen dauern, desto schneller entwickelt sich das System zu einem Legacy-System.</strong></p>

<p>Wie aus den agilen Methoden bekannt, sind kleine Batches anzustreben. Dies gilt selbstverständlich auch für diese Ping-Pong zyklen. Die extremste Form ist die testgetriebene Softwareentwicklung. Hierbei ist Refactoring ein fester Bestandteil eines jeden Programmierers bei der jeder noch so kleinen Programmänderung. Das Programmdesign wird kontinuierlich von jedem Programmierer verbessert.</p>

<p>TDD hat aber auch einen sehr großen Vorteil für das Controlling.
Bei langen Ping-Pong Zyklen hat man den Nachteil, dass die Folgekosten, die durch ein Feature entstehen nicht während der Entwicklung sichtbar sind. Erst bei den nächsten Feature-Requests werden nötige Umbaumaßnahmen oft unausweichlich. Werden diese Features aus unterschiedlichen Kostentöpfen bezahlt stellt sich auf Business-Seite nun die berechtigte Frage, wieso vermeintlich kleine Features unter umständen teurer sein sollen als vorangegangene große Features? Ebenso ist es schwer Folgekosten auf bereits abgeschlossene Projekte zu verbuchen. Es steht also die Frage im Raum: Wer zahlt diese technischen Umbaumaßnahmen?
Test-Driven-Development verringert das Bedürfnis nach Redesigns, bzw. vermeidet diese im großen Stil fast vollständig. Umbaumaßnahmen werden bei jeder kleinen Änderung durchgeführt, sodass die Architektur immer die aktuellen Requirements widerspiegeln. Sollte sich das Business nicht allzu radikal zwischen zwei aufeinanderfolgenden Requirements ändern, bedarf es also keine extra Code-Redesigns. Selbstverständlich gibt es auch hier Ausnahmen, jedoch werden diese noch während der laufenden Entwicklung sichtbar und können deshalb auch auf das Projekt gebucht werden, das diese Business-Anforderungen eingebracht hat. Natürlich können sich die Prioritäten auf Grund der neuen Kostenlage auch entsprechend schneller ändern. Damit ist TDD auch ein Vorteil für Requirements-Manager (PM) oder Product Ownern (PO).</p>

<p>Würde man anstelle von TDD in langen Zyklen zwischen Redesigns und Business-Requirements arbeiten wird man schnell einen Punkt erreichen an dem technische Verbesserungen für PMs/POs nicht mehr Nachvollziehbar sind. Je länger die Zyklen sind, desto unklarer ist der Bezug zwischen technischen Verbesserungen zu fachlichen Anforderungen. Diese Unklarheit führt unweigerlich zu misstrauen, Unmut und erhöhten Druck auf die Programmierer. Nicht die vermeintlich goldenen Türklinken sollen verbaut werden, sondern die Anforderungen sollen schnell umgesetzt werden. Es beginnt nun eine Spirale die weitere Verbesserungen am Code verbieten, um schneller Anforderungen umzusetzen bis der Code irgendwann derart unwartbar geworden ist und wir von einem echten &#8220;gewachsenen&#8221; legacy System sprechen.</p>

<p>(see also: <a href="/articles/2012/04/10/refactoring/">Blogeintrag zum Thema Refactoring</a>)</p>
