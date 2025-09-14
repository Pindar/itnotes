---
layout: post
status: publish
published: true
title: Refactoring
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
wordpress_id: 130
wordpress_url: http://www.pindarsign.de/itnotes/?p=130
date: '2012-04-10 10:10:15 +0200'
date_gmt: '2012-04-10 08:10:15 +0200'
categories:
- articles
tags:
- refactoring
- programming
- process
comments: []
---
<h2>Auswirkungen von Altlasten auf die Neuentwicklung von Features.</h2><br />
Altlasten in Softwaresystemen sind beinahe immer alte Anforderungen, die von anderen Personen vor l&auml;ngerer Zeit umgesetzt wurden. Trotz Dokumentationen in Form von JIRA-Tickets, WIKI-Eintr&auml;gen und Testdokumentation ist es sowohl f&uuml;r Softwareentwickler als auch f&uuml;r das Anforderungsmanagement kaum m&ouml;glich all diese Informationen in ad&auml;quater Zeit auszuwerten, um ein neues Feature kosteng&uuml;nstig liefern zu k&ouml;nnen.</p>
<p>Die in der Praxis g&auml;ngige Herangehensweise, um dieses Problem zu l&ouml;sen ist daher einfach nachzuvollziehen: Man versucht m&ouml;glichst nichts an der bestehenden Funktionalit&auml;t zu &auml;ndern (d.h. der Softwareentwickler versucht bestehenden Code nicht zu ver&auml;ndern) und f&uuml;gt seine neuen &Auml;nderungen einfach hinzu. Dieses Vorgehen funktioniert bei den ersten &Auml;nderungsanfragen auch wie gew&uuml;nscht. Nach einiger Zeit stellt sich jedoch eine Situation ein, die es unabdingbar macht bestehenden Code anzufassen. Sp&auml;testens, wenn neue Anforderungen im Widerspruch zu alten stehen. Dies ist der Knackpunkt an dem nun auch alle alten &Uuml;berlegungen mit bedacht werden m&uuml;ssten, um den &Uuml;berblick &uuml;ber das System beibehalten zu k&ouml;nnen. Das Produktrisiko steigt enorm an und die QA-Phase verl&auml;ngert sich deutlich st&auml;rker als nur linear (alte Anforderungen m&uuml;ssen "erforscht" und intensiv nachgetestet werden).<br />
Folge: Die Kosten f&uuml;r Neuentwicklungen steigen rasant an, jedoch sind die eben genannten Punkte den Auftraggebern oft nicht transparent.</p>
<h2>Warum man ein System nicht vorab so planen kann, dass es auf alle Eventualit&auml;ten erweiterbar ist.</h2><br />
In klassischer Softwareentwicklung ist eine Strategie gegen das Altlastenproblem die Software so zu planen, dass das Altlastenproblem nie entstehen wird. Das hei&szlig;t, dass die Software ohne &Auml;nderung bestehender Softwareteile ewig erweiterbar bleibt. Dass dies ein reiner Wunschgedanke bleibt, ist sp&auml;testens mit einer fachlichen Anforderung belegt, die im Widerspruch zu bestehenden, und bereits umgesetzten Anforderungen steht. Aus Gesch&auml;ftsstrategischer Sicht ist es einleuchtend, dass eine solche Situation in einer schnelllebigen Welt sehr oft eintreten kann. Einen statischen Plan zu entwickeln steht auch im gravierenden Widerspruch zur dynamischen Komplexit&auml;t, die die gesch&auml;ftliche Situation hier deutlich besser abbildet (siehe auch "Scaling Lean &amp; Agile Development: Thinking and Organizational Tools for Large-Scale Scrum: Successful Large, Multisite and Offshore Products with Large-scale Scrum", Craig Larmen und Bas Vodde).</p>
<h2>Wie man sich von Altlasten befreit und Agilit&auml;t erreicht.</h2><br />
Wie aus dem ersten Punkt hervorgeht ist es sehr einfach neue Altlasten aufzubauen. Welche L&ouml;sungen schl&auml;gt nun die Wissenschaft und Praxis vor, um das Altlastenproblem zu l&ouml;sen?</p>
<p>Die einstimmige Meinung unter agilen Softwareentwicklern ist, sich der Tatsache bewusst zu werden. Wenn man sich im klaren dar&uuml;ber ist, dass Softwaresysteme &uuml;ber die Zeit fehlerhaft und schwergewichtig werden, kann man Ma&szlig;nahmen umsetzen, die das kontinuierlich abmildern.<br />
Dazu geh&ouml;ren folgende Punkte:</p>
<p>1) Testgetriebene Softwareentwicklung (Test-Driven Development, Jeff Langr, http://pragprog.com/magazines/2011-11/testdriven-development, Practices for Scaling Lean and Agile Development: Large, Multisite, and Offshore Product Development with Large-Scale Scrum, Craig Larmen und Bas Vodde)<br />
2) Spezifikationen anhand von Beispielen (Specification by Example, Gojko Adzic)<br />
3) Kontinuierliche Upgrades von eingebundener Fremdsoftware<br />
4) Die einfachste L&ouml;sung umzusetzen, die die Anforderung erf&uuml;llt (&ldquo;You Ain&rsquo;t Gonna Need It&rdquo;, http://de.wikipedia.org/wiki/YAGNI)</p>
<p>Wie &auml;u&szlig;ern sich diese Ma&szlig;nahmen mittel- bzw. langfristig aus monet&auml;rer Sicht?</p>
<p>Ad 1) Testgetriebene Softwareentwicklung ist trotz seines Namens nicht gleichzusetzen mit Software zu testen ("Test-first coding is not a testing technique", Ward Cunningham). Vielmehr f&uuml;hrt es implizit zu einer jederzeit &auml;nderbaren Software, durch das kontinuierliche schreiben von automatischen Tests und dem noch wichtigerem kontinuierlichem Refactoring des neu geschriebenen Codes. Zusammengefasst: Die Kosten f&uuml;r Neuentwicklungen bleiben &uuml;ber die Zeit relativ konstant.</p>
<p>Ad 2) Wenn Anforderungen mit klaren Beispielen dokumentiert sind, werden diese schneller verstanden. Missverst&auml;ndnisse werden reduziert und die r&uuml;ckblickende Information was umgesetzt wurde ist klarer. Ebenso lassen sich Beispiele einfach automatisiert testen, wodurch Anforderungen kontinuierlich qualitativ gesichert werden k&ouml;nnen, ohne zus&auml;tzlichen Kostenaufwand &uuml;ber die Zeit.</p>
<p>Ad 3) Veraltete Fremdsoftware f&uuml;hrt langfristig dazu, dass keine Softwareentwickler mehr gefunden werden, die mit diesen Versionen arbeiten k&ouml;nnen. Das Umsetzen neuer Features wird bei alter Fremdsoftware also verl&auml;ngert, wodurch die Kosten steigen.</p>
<p>Ad 4) Das Feature wird so umgesetzt wie gefordert, aber auch nicht mehr. Der Aufwand wird auf das n&ouml;tigste reduziert und Kosten f&uuml;r Planungs-Overhead werden obsolet. Der Return of Investment steigt.</p>
<h2>Warum das eine kontinuierliche T&auml;tigkeit bleiben muss</h2><br />
Refactoring ist keine T&auml;tigkeit, die in einem Entwicklungszyklus erledigt werden kann, sondern es ist eine kontinuierliche T&auml;tigkeit. Man kann diese Aufgabe am besten mit der B&uuml;roreinigung vergleichen: W&uuml;rde man das B&uuml;ro nur einmal im Jahr reinigen, h&auml;tte man auch hier einen deutlich h&ouml;heren Aufwand und das Unbehagen in der &uuml;brigen Zeit w&auml;re bei allen Beteiligten nach kurzer Zeit sehr gro&szlig;.</p>
