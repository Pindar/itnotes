---
layout: post
status: publish
published: true
title: "(Download) Java XSLT 2.0 Transformator"
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
excerpt: "<h2>Worum es geht</h2>\r\nXSLT ist eine auf XML basierte funktionale
  Sprache, die zur Umwandlung von XML-Dokumenten in eine andere XML bzw. Plaintextdarstellung
  dient. XSLT der Version 1.1 hat sich bereits auf breiter Front durchgesetzt und
  wird vom .Net-Framework 3.5 und Firefox unterst&uuml;zt. Die Nachfolgerversion 2.0,
  die einige n&uuml;tzliche Funktionalit&auml;ten bietet, ist bisher noch nicht so
  verbreitet. Das Framework <a href=\"http://saxon.sourceforge.net/\"
  target=\"_blank\">SAXON B</a> bietet ein, unter der <a title=\"MOZILLA PUBLIC
  LICENSE\" href=\"http://www.mozilla.org/MPL/MPL-1.0.html\" target=\"_blank\">MPL
  1.0</a> stehendes, Framework an, mit dem man die W3C-XSLT 2-Version verwenden
  kann.\r\n\r\nUm nun XML-Dokumente ganz einfach umwandeln zu k&ouml;nnen biete ich
  ein einfaches ausf&uuml;hrbares JAR-File an, das SAXON B der Version 9.1 verwendet
  und auf ein XML-Dokument ein XSLT-Dokument anwendet."
wordpress_id: 57
wordpress_url: http://www.pindarsign.de/itnotes/?p=57
date: '2009-08-03 10:08:10 +0200'
date_gmt: '2009-08-03 08:08:10 +0200'
categories:
- tools
tags:
- tool
- xslt
- xml
comments:
- id: 4
  author: Simon
  author_email: simon.dittlmann@itnotes.de
  author_url: http://www.itnotes.de
  date: '2009-08-03 11:33:09 +0200'
  date_gmt: '2009-08-03 09:33:09 +0200'
  content: "PS: Da der Nutzen gegen&uuml;ber dem originalen SAXON B nicht ganz klar
    ist, ein kurzes Statement:\r\nIch hatte nach einer einfachen M&ouml;glichkeit
    zum umwandeln f&uuml;r meine Kollegen gesucht, ohne viele Optionen beim Aufruf
    des Programms. Ebenso sollte es ohne setzten des Classpath auskommen. Das origniale
    SAXON-Jar kann also prinzipiell mehr als mein XSLT-Transformer, daf&uuml;r ist
    die Einstiegsdokumentation etwas viel zu lesen, f&uuml;r jemanden, der nur schnell
    transformieren will.\r\n\r\nIn den kommenden Tagen werde ich eine kleine Silverlight
    Anwendung einbinden (wenn's hinhaut :) ), die auch einfach nur transformiert,
    die Usability aber noch etwas vereinfachen wird."
---
<h2>Worum es geht</h2><br />
XSLT ist eine auf XML basierte funktionale Sprache, die zur Umwandlung von XML-Dokumenten in eine andere XML bzw. Plaintextdarstellung dient. XSLT der Version 1.1 hat sich bereits auf breiter Front durchgesetzt und wird vom .Net-Framework 3.5 und Firefox unterst&uuml;zt. Die Nachfolgerversion 2.0, die einige n&uuml;tzliche Funktionalit&auml;ten bietet, ist bisher noch nicht so verbreitet. Das Framework <a href="http://saxon.sourceforge.net/" target="_blank">SAXON B</a> bietet ein, unter der <a title="MOZILLA PUBLIC LICENSE" href="http://www.mozilla.org/MPL/MPL-1.0.html" target="_blank">MPL 1.0</a> stehendes, Framework an, mit dem man die W3C-XSLT 2-Version verwenden kann.</p>
<p>Um nun XML-Dokumente ganz einfach umwandeln zu k&ouml;nnen biete ich ein einfaches ausf&uuml;hrbares JAR-File an, das SAXON B der Version 9.1 verwendet und auf ein XML-Dokument ein XSLT-Dokument anwendet.<a id="more"></a><a id="more-57"></a></p>
<h2>Wie es geht</h2><br />
Voraussetzung sind ein XML-Dokument, ein XSLT-Dokument nach der <a href="http://www.w3.org/TR/xslt20/" target="_blank">XSLT 2.0 Spezifikation</a> und ein installiertes Java JRE 1.5 oder besser.</p>
<ol>
<li>Download der ZIP-Datei: <a href="http://www.pindarsign.de/itnotes/wp-content/uploads/2009/08/XSLT-Transformer.zip">XSLT-Transformer</a></li>
<li>Entpacken der ZIP-Datei in ein beliebiges Verzeichnis.</li>
<li>Umwandeln des XML-Dokuments mit dem XSLT-Dokument in das gew&uuml;nschte Zielformat durch folgenden Aufruf der Anwendung aus der Konsole (Windows: Start, Ausf&uuml;hren, CMD [ENTER]) heraus:<br />
java -jar [Verzeichnis in der die jar-Datei liegt]XSLT-Transformer.jar "[XML-Dokument-Pfad]" "[XSLT-Dokument-Pfad]" > "[Output.xml-Pfad\Output-Dateiname.xml]"</li><br />
</ol><br />
Das Zieldokument findet sich dann im angegebenen Verzeichnis. So einfach geht's!</p>
<p><em>Update:</em></p>
<p>Auf Wunsch gibt's noch eine zweite Version mit Parameter:</p>
<ol>
<li>Download der ZIP-Datei: <a href="http://www.pindarsign.de/itnotes/wp-content/uploads/2009/08/XSLT-TransformerV2_21.zip"></a><a href="http://www.pindarsign.de/itnotes/wp-content/uploads/2009/08/XSLT-TransformerV2_3.zip">XSLT-TransformerV2_3</a></li>
<li>Entpacken der ZIP-Datei in ein beliebiges Verzeichnis.</li>
<li>Umwandeln des XML-Dokuments mit dem XSLT-Dokument in das gew&uuml;nschte Zielformat durch folgenden Aufruf der Anwendung aus der Konsole (Windows: Start, Ausf&uuml;hren, CMD [ENTER]) heraus:<br />
java -jar [Verzeichnis in der die jar-Datei liegt]XSLT-TransformerV2_3.jar -xml [XML-Dokument-Pfad] -xslt [XSLT-Dokument-Pfad] -out [Output.xml-Pfad]</li><br />
</ol><br />
<em>Changelog:</em></p>
<ul>
<li>v2.1: encoding utf-8 fixed</li>
<li>v2.2: neuer optionaler Parameter -enc [encoding]. Ohne Angabe wird das Dokument in UTF-8 geschrieben.</li>
<li>V2.3: Parameter -enc wieder entfernt; encoding wird jetzt anhand des encoding-Attributes im xsl:output-Element angepasst. Falls nicht vorhanden wird UTF-8 angenommen (wie im Standard festgelegt).</li><br />
</ul><br />
<em>Bekannte Bugs:</em></p>
<ul>
<li>Verwendung in XMLSpy auf Windows Vista: Outputdatei kann nicht angezeigt werden, es treten Fehler auf. XMLSpy auf&nbsp; Windows XP ist davon nicht betroffen.</li><br />
</ul></p>
