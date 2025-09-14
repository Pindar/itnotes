---
layout: post
status: publish
published: true
title: Monitoring in Webapplications
author: Simon Dittlmann
author_login: Simon
author_email: simon.dittlmann@itnotes.de
author_url: http://www.itnotes.de
wordpress_id: 87
wordpress_url: http://www.pindarsign.de/itnotes/?p=87
date: '2010-08-31 21:53:43 +0200'
date_gmt: '2010-08-31 19:53:43 +0200'
categories:
- articles
tags: []
comments:
- id: 5
  author: Matthias L&uuml;dtke
  author_email: email@matthias-luedtke.de
  author_url: http://better-idea.org
  date: '2010-09-01 08:57:58 +0200'
  date_gmt: '2010-09-01 06:57:58 +0200'
  content: "Sch&ouml;ne Streaming-Technik, der ich so noch nicht begegnet bin. Erinnert
    an forever frames, die kommen sogar ohne Flash aus. http://en.wikipedia.org/wiki/Comet_(programming)#Hidden_IFrame\r\n\r\nEinstweilen
    w&uuml;rde ich versuchen, die Zeit bis zu den HTML5 workers mit long polling auf
    einen Zweitserver zu &uuml;berbr&uuml;cken. Wie das allerdings mit knappen Serverresourcen
    skaliert, w&auml;re zu messen."
- id: 35
  author: Simon
  author_email: simon.dittlmann@itnotes.de
  author_url: http://www.itnotes.de
  date: '2011-12-03 12:22:54 +0100'
  date_gmt: '2011-12-03 11:22:54 +0100'
  content: "Eine Implementierung die diesen Vorschlag umsetzt ist Socket.io (http://socket.io/).\r\nAuf
    jeden Fall mal anschauen."
---
<p>Webanwendungen werden immer h&auml;ufiger auch genutzt, um near-real-time Daten zu visualisieren. In HTML 5 ist daf&uuml;r der Websocket definiert. Bis wir diesen nutzen k&ouml;nnen, m&uuml;ssen wir auf andere Techniken zur&uuml;ckgreifen. Long-Polling oder Bayeux Protocol sind hier die h&auml;ufigsten. Jedoch ist es nicht immer m&ouml;glich diese einzusetzten. Eine Alternative w&auml;re eine "Infection" der Webseite mit einer weiteren Technologie, um kein traditionelles Polling nutzen zu m&uuml;ssen.</p>
<h2>Das Problem.</h2><br />
&Uuml;bertragen wir das technische monitoring Problem in ein Beispiel unseres Lebens: Ein Kollege arbeitet gerade an einem Plakat. Sobald es fertig gedruckt ist, sollen wir es abholen. Woher wissen wir, wann wir es holen sollen?</p>
<h2>Old school.</h2><br />
Um daten per Ajax auf herk&ouml;mmlichen Weg zu &uuml;berwachen erstellt man eine Funktion, die in periodischen Zeitabst&auml;nden die Daten vom Server holt. Damit bekommt man h&auml;ufig &uuml;berhaupt keine Ver&auml;nderung, muss den Server aber dennoch "stubsen" und verbraucht Bandbreite.<br />
In unserem obigen Beispiel m&uuml;ssten wir in einem bestimmten Zeitintervall, sagen wir alle f&uuml;nf Minuten, zu unserem Kollgen laufen und ihn fragen, ob wir das Plakat schon mitnehmen k&ouml;nnen. Wenn nicht, gehen wir unverrichtete Dinge wieder zur&uuml;ck auf unseren Platz.</p>
<h2>Long-Polling.</h2><br />
Mit Long-Polling fr&auml;gt man genauso immer und immer wieder den Server an, jedoch wartet man auf dem Server auf die Antwort.</p>
<p>In unserem obigen Beispiel w&uuml;rden wir also einmal zu unserem Kollegen laufen und dort solange warten, bis er mit dem Plakat fertig ist und wir es mitnehmen k&ouml;nnen. Anschlie&szlig;end gehen wir erfolgreich zur&uuml;ck zu unserem Platz, legen das Plakat ab und gehen wieder zu unserem Kollegen um wieder auf das n&auml;chste Plakat zu warten.</p>
<h2>Infect your website.</h2><br />
Mit einer Ifection nutzt man den Umstand, dass auf nahezu allen Clients Plugins installiert sind. Man kann also w&auml;hlen ob man eine Seite mit Adobe Flash oder einem Websocket oder Silverlight infizieren will. Ich gehe hier von Adobe Flash aus.<br />
Wir starten also eine unsichtbare Flashanwendung, die nur eine Aufgabe hat: Sich mit einem Socket auf dem Server zu verbinden. Sobald Daten auf dem Server vorhanden sind, wird eine kleine Message "data available" an den Clienten verschickt. Dieser startet dann die Ajax-Anfragen. Der Vorteil die Daten nicht &uuml;ber den Socket zu senden, ist keinen Code zu duplizieren und den Dienst bei Bedarf jederzeit weglassen zu k&ouml;nnen. Sollte kein Flashplugin installiert sein, kann so einfach auf periodisches Polling zur&uuml;ckgegriffen werden. Der Vorteil gegen&uuml;ber Long-Polling ist, dass kein Prozess blockiert wird und keine Aufw&auml;ndigen Serveranwendungen wie beim Bayeux Protokoll n&ouml;tig sind. Nur eine simple Socketanwendung, die die entgegengenommenen Daten verwirft und durch z.B. einem Hook-Up eine "data available" Message verschickt.</p>
<p>In unserem obigen Beispiel w&uuml;rden wir zu unserem Kollegen nicht hingehen, sondern ihn vorher anrufen und diesen Anruf einfach neben uns liegen lassen. Sobald unser Kollege uns &uuml;bers Telefon Bescheid gibt, dass das Plakat fertig ist, machen wir uns auf den Weg. W&auml;re unser Telefon einmal kaputt, k&ouml;nnten wir auf jeden Fall ohne Probleme wieder periodisch zu ihm laufen.</p>
<h2>Fazit.</h2><br />
Websocket sind die definitiv beste Antwort auf near-real-time monitoring. Doch bis es soweit ist, dass diese Technologie in allen g&auml;ngigen Browsern verf&uuml;gbar ist, wird noch etwas Zeit verstreichen. Bis dahin ist eine Alternative zu nutzen. Ist man an bestimmte Servertechnologien gebunden und will trotzdem skalierbar bleiben ist long-polling oft nicht m&ouml;glich. Eine Alternative bietet hier die "Infection".</p>
