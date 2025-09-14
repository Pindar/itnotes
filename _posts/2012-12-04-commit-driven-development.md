---
layout: post
title: Commit Driven Development (CDD)
date: '2012-12-04T22:19:00+01:00'
comments: true
categories: ''
tags:
- cdd
- tdd
- bdd
- development
- agile
tumblr_url: http://simondittlmann.tumblr.com/post/37208402941/commit-driven-development
---
<p>Vor einiger Zeit hatte ich das erstmal von einer neuen Idee, dem so genannten Commit Driven Development gelesen und mir in letzter Zeit einige Gedanken dazu gemacht. </p>
<p><strong>Idee</strong></p>
<p>Wie bei TDD/BDD überlegt man sich die nächste Tätigkeit im Vorfeld und formuliert daher seine nächste Commit-Message bevor man mit der Entwicklung beginnt.</p>
<p><strong>Zyklus</strong></p>
<p>Message formulieren -&gt; Entwickeln (TDD) -&gt; Commit (check-in) -&gt; Message formulieren &#8230;</p>
<p><strong>Einordung</strong></p>
<p>CDD umschließt einige TDD Zyklen.</p>
<p><strong>Warum? Nutzen.</strong></p>
<p>Der Nutzen ist der selbe, wie auch bereits bei TDD. Man muss sich vorab in weiterhin sehr kleinen Schritten klar darüber sein, was man als nächstes umsetzen will. Selbstverständlich werden dadurch auch die Commit-Messages sehr wahrscheinlich deutlich qualitativ Aussagekräftiger. Die Konzentration auf den Arbeitsfortschritt ist ebenfalls klarer und der Entwickler wird stärker dazu angehalten öfter einzuchecken, was zu einer früheren Integration führen kann (bei SVN) auf jeden Fall jedoch zu einer besseren Nachvollziebarkeit.</p>
<p><strong>Tooling</strong></p>
<p>Leider existiert aktuell kein Versionskontrollsystem ein solches Vorgehen. Deshalb muss man sich vorher seine Message in einem Editor seiner Wahl vorschreiben und sie anschließend beim Commit kopieren. Ich hoffe aber, dass es bald möglich wird in Git ein Pre-Commit zu machen in dem man die Message vorformulieren kann.</p>
