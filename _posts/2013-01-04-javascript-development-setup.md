---
layout: post
title: JavaScript Development Setup
date: '2013-01-04T23:31:00+01:00'
comments: true
tags:
- javascript
- development
- setup
- grunt
- tools
tumblr_url: http://simondittlmann.tumblr.com/post/39688685358/javascript-development-setup
categories: ''
---
<p>To develop large scalable JavaScript projects you need the right setup. You can use a tool like <a href="https://github.com/yeoman">yeomen</a> to avoid boring setup effort. But in many projects you can&#8217;t use such tools (maybe you have to work with windows) and therefore you need to set up everything by yourself. In this blog post I will summarize what tools and frameworks I use to develop JavaScript efficient.</p>

<p>My aim is to setup a development environment in a way that you get early feedback!</p>

<h2>Use a fast build tool</h2>

<p>The baseline of your development velocity is the speed of your build tool. For me <a href="http://gruntjs.com/">grunt</a> is the tool of choice. It&#8217;s both easy to understand and easy to extend. In addition you get a lot of free plugins. The tool itself is super fast and for me definitely the best choice.</p>

<h2>Watch files to build instantly</h2>

<p>The compiling process should be invisible while you&#8217;re programing. But you should compile as much as possible to get early feedback. Therefore you can use the watch task which is already integrated in grunt. To compile your project all you have to do now is to save a file.</p>

<h2>Lint your JavaScript code</h2>

<p>Static code analysis is so useful. You can identify a lot of problems while compiling without executing even one line of your code. That&#8217;s awesome. I strongly recommend to lint your code, but configure your lint rules carefully. Your team should completely understand why all this rules are necessary and all team members should commit to the rule set. The tool: <a href="http://www.jshint.com/">jshint</a></p>

<h2>Test drive your code (TDD / BDD)</h2>

<p>Test driven development is the most important thing if you really want fast feedback. But no one likes to stop programming, switching to a browser, reloading the test page to see a red bar, switching to the IDE, programming, switching to the browser &#8230; you got it right? It&#8217;s annoying and therefore I use following tools to get a nice tdd feeling:</p>

<ul><li>basic test framework: <a href="http://pivotal.github.com/jasmine/">jasmine</a></li>
<li>mocking/stubing: <a href="http://sinonjs.org/">sinon.js</a></li>
<li><p>command line interface to avoid a bad development experiance: <a href="https://npmjs.org/package/grunt-jasmine-runner">grunt-jasmine-runner</a> and <a href="http://phantomjs.org/">PhantomJS</a></p>

<p>Combined with the watch files mechanism the only thing to get feedback is to save.</p></li>
</ul><h2>Completely Mock / Stub the server interface</h2>

<p>Test driven development let you develop your JavaScript(-App) without a working back end (REST interface or something else). But you still can&#8217;t watch your user interface without. So what I did is to mock all ajax requests. As a result you can not only test drive your application logic without a backend but you can also use the entire application! That&#8217;s awesome, right? I tried this development style first two years ago and I&#8217;m still loving it. You are so much faster and you are completely independent. I prefer this also when I&#8217;m working alone because you can try some things faster without heavy backend changes. All you need are two handy frameworks:</p>

<ul><li><a href="https://github.com/appendto/jquery-mockjax">jquery.mockjax</a></li>
<li><a href="http://experiments.mennovanslooten.nl/2010/mockjson/">jquery.mockjson</a></li>
</ul><h2>Use live reloading of updated watch files</h2>

<p>When you already mock everything the icing on the cake is to have live reloading of updated watch files. With this feature and a big screen you can see your changes right away. That&#8217;s brilliant and so easy with <a href="https://github.com/webxl/grunt-reload">grunt-reload</a>.</p>

<p>Now you know all tools I highly recommend; But there are even more which makes your development a lot easier:</p>

<ul><li><a href="https://github.com/visionmedia/jade/">grunt-jade</a> to compile your jade templates</li>
<li><a href="https://github.com/twitter/recess">recess</a> and <a href="https://github.com/sindresorhus/grunt-recess">grunt-recess</a> to compile your less code</li>
<li><a href="https://github.com/gruntjs/grunt-contrib-compress/">grunt-contrib-compress</a> to zip all your files into one artefact</li>
<li><a href="https://github.com/reputation/grunt-clean">grunt-clean</a> to remove old build</li>
<li><a href="https://github.com/gruntjs/grunt-contrib">grunt-contrib-copy</a> to copy assets like images etc.</li>
</ul><p>I hope you like this overview and you&#8217;re motivated to improve your development setup. Feel free to share your favourite tool with us, too &#8212; thx!</p>
