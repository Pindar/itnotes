---
layout: post
status: publish
published: true
title: Anwendung der Pairwise-Methode für Eingaben auf Use Case-Ebene
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
excerpt: "<h2>Worum geht's?</h2>\r\nTesten von Software und das sicherstellen
  von korrekter Software in Bezug auf den Anforderungen und Anwendungsf&auml;llen.
  Um dieses Ziel zu erreichen, m&ouml;chte man nicht zu wenig, aber auch nicht zu
  viel Testen. Zu viel Tests w&uuml;rden das Testbudged strapazieren, zu wenige k&ouml;nnten
  die Qualit&auml;t der Software reduzieren.\r\nDeshalb werden beim Testen von Methoden
  generell zwei Verfahren angewendet, um die Testdatenmenge zu reduzieren.\r\n<ol>\r\n\t<li>&Auml;quivalenzklassen
  auf den Inputdefinitionsbereichen werden gebildet.\r\nBsp.: Eingabefeld Hausnummer
  wird aufgeteilt in g&uuml;ltige Eingaben den Integerwerten gr&ouml;&szlig;er 0,
  den ung&uuml;ltigen kleiner gleich 0 und den restlichen ung&uuml;ltigen Eingabem&ouml;glichkeiten.</li>\r\n\t<li>Um
  nicht alle &Auml;quivalenzklassen-Kombinationen bei mehreren Inputparametern testen
  zu m&uuml;ssen wird auf die <a title=\"Pairwise-Methode auf Wikipedia\" href=\"http://de.wikipedia.org/wiki/Pairwise-Methode\"
  target=\"_blank\">Pairwise-Methode</a> zur&uuml;ckgegriffen. Es werden dabei
  nur alle Eingabeparameter paarweise kombiniert anstelle des Kreuzproduktes.</li>\r\n</ol>\r\n"
wordpress_id: 19
wordpress_url: http://www.pindarsign.de/itnotes/?p=19
date: '2009-07-14 09:24:25 +0200'
date_gmt: '2009-07-14 07:24:25 +0200'
categories:
- articles
tags:
- pairwise
- systemtest
- methode
comments:
- id: 3
  author: Ben
  author_email: kontakt@benediktlang.de
  author_url: http://orangebud.net
  date: '2009-07-24 10:04:13 +0200'
  date_gmt: '2009-07-24 08:04:13 +0200'
  content: Sch&ouml;ner Artikel, ohne Wikiartikel h&auml;tte ich ihn allerdings nicht
    verstanden. Ich weiss dass es vielleicht nicht ins Konzept passt, aber ein wenig
    Programmcode w&auml;re genial um das ganze irgendwie ansatzweise in Aktion zu
    sehen (evtl zu lang, letztendlich versteht mans dann doch). Habe wieder etwas
    dazugelernt :) Danke
---
<h2>Worum geht's?</h2><br />
Testen von Software und das sicherstellen von korrekter Software in Bezug auf den Anforderungen und Anwendungsf&auml;llen. Um dieses Ziel zu erreichen, m&ouml;chte man nicht zu wenig, aber auch nicht zu viel Testen. Zu viel Tests w&uuml;rden das Testbudged strapazieren, zu wenige k&ouml;nnten die Qualit&auml;t der Software reduzieren.<br />
Deshalb werden beim Testen von Methoden generell zwei Verfahren angewendet, um die Testdatenmenge zu reduzieren.</p>
<ol>
<li>&Auml;quivalenzklassen auf den Inputdefinitionsbereichen werden gebildet.<br />
Bsp.: Eingabefeld Hausnummer wird aufgeteilt in g&uuml;ltige Eingaben den Integerwerten gr&ouml;&szlig;er 0, den ung&uuml;ltigen kleiner gleich 0 und den restlichen ung&uuml;ltigen Eingabem&ouml;glichkeiten.</li></p>
<li>Um nicht alle &Auml;quivalenzklassen-Kombinationen bei mehreren Inputparametern testen zu m&uuml;ssen wird auf die <a title="Pairwise-Methode auf Wikipedia" href="http://de.wikipedia.org/wiki/Pairwise-Methode" target="_blank">Pairwise-Methode</a> zur&uuml;ckgegriffen. Es werden dabei nur alle Eingabeparameter paarweise kombiniert anstelle des Kreuzproduktes.</li><br />
</ol><br />
<a id="more"></a><a id="more-19"></a>
<h2>Anwendungsfall</h2><br />
Bei einer neu programmierten Anwendung soll ein Systemtest durchgef&uuml;hrt werden, wobei mehrere spezifizierte Anwendungsf&auml;lle durchgepr&uuml;ft werden sollen; beispielsweise das Suchen nach einer Zugverbindung Berlin - Hamburg.</p>
<h2>Problem</h2><br />
Bei Tests auf Anwendungsfallebene bleiben trotz &Auml;quivalenzklassenbildung und Anwendung der Pairwise-Methode f&uuml;r die Kombinationen sehr viele verschiedene Testf&auml;lle &uuml;brig, da oftmals sehr viele Eingabeparameter f&uuml;r den Benutzer existieren (beispielsweise schon bei der Suche einer Zugverbindung). Die Frage ist, ob diese zum einen sinnvoll sind und zum anderen ob sie f&uuml;r eine ausreichende Testabdeckung notwendig sind.</p>
<p>F&uuml;hrt man das geschilderte Vorgehen in der Praxis aus, fallen zwei Dinge auf:</p>
<ol>
<li>Da die &Auml;quivalenzklassen auch Fehlerf&auml;lle widerspiegeln, kann es passieren, dass nachdem man die verschiedenen Inputvariablen mit der Pairwise-Methode kombiniert hat, keine Kombination den "Standardfall" wiedergibt; d. h. alle Kombinationen enthalten Eingabedaten, die zwangsl&auml;ufig einen Fehlerfall &uuml;berpr&uuml;fen.</li>
<li>Wenn man einen Systemtest durchf&uuml;hrt sind meist viel mehr Eingabeparameter zu ber&uuml;cksichtigen als dies bei Methoden mit oftmals verh&auml;ltnism&auml;&szlig;ig wenig Eingabeparametern der Fall ist. Folglich entstehen trotz den vorgeschlagenen Ma&szlig;nahmen sehr viele Testkombinationsf&auml;lle.</li><br />
</ol>
<h2>L&ouml;sung</h2><br />
Eine L&ouml;sung k&ouml;nnte das bilden von logischen Eingabeeinheiten sein, sodass nicht mehr alle Eingabefelder per se paarweise kombiniert werden, sondern nur noch die logischen Einheiten. Ein Verfahren, dass ich selbst praktisch angewendet habe, kann folgenderma&szlig;en skizziert werden:</p>
<ol>
<li>Schritt: Bildung von &Auml;quivalenzklassen auf Definitionsbereich der Eingabevariablen:<br />
Eingabevariablendefinitionsbereich &rarr; Aequivalenzklassen; Bsp.:<br />
<code>a<sub>1</sub> &isin; $$\mathbb{N}$$ &rarr; aA<sub>1</sub> = { M<sub>f</sub> = { intMin, .. ,0 }, N<sub>p</sub> = {1, .. , 43 }, O<sub>f</sub> = {44, .. , maxInt}}<br />
a<sub>2</sub> .. a<sub>n</sub> &rarr; aA<sub>2</sub>, .. , aA<sub>n</sub></code></li></p>
<li>Schritt: Bildung von logischen Einheiten auf den verschiedenen Eingabevariablen:<br />
Eingabevariablen &rarr; logische Einheit; Bsp.:<br />
<code>a<sub>1</sub>, a<sub>2</sub>, .. , a<sub>n</sub> &rarr; b<sub>1</sub> = {a<sub>1</sub>, a<sub>3</sub>, a<sub>4</sub>} und b<sub>2</sub> = {a<sub>2</sub>, a<sub>5</sub>} usw.</code></li></p>
<li>Clustering der &Auml;quivalenzklassen pro logische Einheit<br />
&Auml;quivalenzklassen pro logische Einheit &rarr; aggregierte &Auml;quivalenzklassen pro logische Einheit<br />
<code>bA<sub>1</sub> = {aA<sub>1</sub>, aA<sub>3</sub>, aA<sub>4</sub>} &hArr; {M<sub>f</sub>, N<sub>p</sub>, O<sub>f</sub>, ...} &rarr; BA<sub>1</sub> = {P, F<sub>1</sub>, F<sub>2</sub>}</code><br />
Wobei <sub>p</sub> Pass und <sub>f</sub> Fail bedeuteut.</li><br />
</ol><br />
Beispiel: Man hat eine Eingabemaske zu einer Person; (1) Dann kann man zu jedem Eingabefeld eine &Auml;quivalenzklasse bilden. (2) Anschlie&szlig;end aggregiert man die Felder (z.B. Heimadressfelder, Arbeitsadressfelder, Angaben zur Krankenkasse usw.) und (3) abschlie&szlig;end kombiniert man die &Auml;quivalenzklassen der aggregierten Felder.</p>
<p>Ergebnis: logische Einheiten mit aggrebierten &Auml;quivalenzklassen.</p>
<p>In den von mir eingesetzten F&auml;llen reduzieren sich die Eingabetestf&auml;lle erheblich. Zudem entstehen auch beim paarweisen kombinieren weiterhin Standardtestf&auml;lle. &Uuml;ber die Testqualit&auml;t kann ich nur eine Annahme treffen. Ich w&uuml;rde aber behaupten, dass diese nicht signifikant sinkt, denn:</p>
<ol>
<li>die logischen Einheiten bilden meist auch Subsysteme ab und diese sollten vorab von Subsystemtests getestet werden. Die Integration wird aber weiterhin durch die Kombinationen der logischen Einheiten getestet.</li>
<li>weiterhin werden Randf&auml;lle betrachtet und die Kombination daraus getestet. Auf einer logischen Ebene handelt es sich also um &Auml;quivalenzklassen bei den Aggregationen.</li><br />
</ol><br />
Falls ihr anderer Meinung seid, lasst es mich wissen. Ansonsten viel Erfolg beim Softwaretesten!
