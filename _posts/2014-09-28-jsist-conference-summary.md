---
layout: post
title:  "JSist 2014 summary"
date:   2014-09-28 15:08:00
categories: conference js frontend development
comments: true
redirect_from: "/conference/js/frontend/development/2014/09/11/jsist-conference-summary/"
---

Now while I'm sitting at the airport in Istanbul I think it's a good time to note down what I learned the last two days at [JSist](http://lanyrd.com/2014/jsist/).

These two days in Istanbul were quite impressive but at the same time the weather was so unbelievable rainy that I couldn't visit much of the city. But beside that the conference about JS was worth to come -- so let's start with Saturday.

## Saturday 
It was a warm welcome and the registration process was well organized so I felt myself comfortable from the first minute on. The advertised breakfast wasn't that good but we were not traveled so far to get a good dish at the conference so I shouldn't bother. 

The first talk with the title "Javascript <3 Unicode" by Mathias Bynens sounded a bit boring but it wasn't at all. He pointed out all the pitfalls you will face in a daily business and this in a very entertaining talk. For example he explained the unicode plates, why a string reverse is not as simple as `"foo".split('').reverse().join('')` (try it with the unicode 'pile of poo') and mentioned quotes of celebrities to find the right solution. As general rule of thumb I will check the behavior of every user facing text input field regarding the unicode sign 'pile of poo' in the future. If this doesn't break the app that it's a good sign. And in addition I should mention that he pointed out even problems of MySQL (MySQL cut a string when it's not configured in UTF-8 embec (something...) mode) and unicode what was very surprising to me.

The second talk was about "This is bigger than us: Building a future for Open Source" by Lena Reinhard. She did a great job by presenting such a complex and abstract theme at a JS conference in a simple an practical way. One important thing I would like to repeat is that software development needs more diversity. I guess this is so true especially since she also pointed out that only less then one percent of the world population are software engineers. So at one developer there are 399 not developers... That's crazy when you look around and you find so many devices next to you in every second of your life. 

The last talk before lunch was about "Scaling Node.js Applications with Redis, RabbitMQ and cote.js" by Armağan Amcalar. Because I'm personally a fan of Microservices I was super interested in this talk to hear about how others are trying to achieve this architecture goal. He talked about decoupling of node.js applications through an event driven development style across node.js applications and how this can be achieved by using for example pup/sub of Redis or Messages of RabbitMQ. In addition he mentioned cote.js -- a library written by them which seems to be a more lite weight tool. But he couldn't talk too much about it so everybody should take a look and build her/his own meaning.

The lunch break was big enough to even walk a bit around but sadly it was still such a bad weather that I couldn't go around much. That's why I will directly continue with the talk about "Getting Started with ClojureScript" by Üstün Özgür. He was pointing out all the good parts of functional programming and I have to agree with him especially because I wrote three years ago also an article printed in a magazine about functional programming methods in web development. The only thing I don't agree is that ClojureScript is a better language then plain JS. In my opinion you can do already all the nice things directly with JS so I don't see the point of compiling -- I also haven't seen it for CoffeeScript or GWT. The only exception is ASM.JS but this is a different topic so I will not go deeper here.

At 3pm "Meteor for Everyone" by Barış Güler started. It was nice to see more about this framework and what it is actually for. For me it really looks like a perfect thing for prototyping or tools with not that much expected load. I would probably use it for company internal tools for example. What I dislike is that they also invited there own ecosystem by explicitly not using NPM. Maybe it makes them faster but it's even harder to get something like this running for production. Nevertheless the talk was enlightening.

"AngularJS Directives for D3JS" by Yaprak Ayazoğlu was the one talk I would have expected a bit more. She showed how you can encapsulate complicated d3.js statements within an AngularJS directive but this was it basically. Probably enough for people haven't worked with AngularJS or d3.js previously but for me there wasn't much new things.

The next talk about "Realtime MVC with Sails.js" by Serdar Doğruyol started pretty good by telling us about how easy it is to setup applications but the downside was that he didn't shared with us any live session. I was expecting that I could at least see how easy it is to setup a hello world app. Maybe next time...

The talk "Ember.js Framework" by Sean Yu was more about "Why we have chosen Ember.js" than about the Framework itself. So when we rename it in our minds it was very good to hear about the decision making process of other companies how they decide which framework fit to them best. When I think about it's one of the most important decisions you can make because probably a lot of developer will hate or love you even years after you made the decision. Beside this personal thing it can also lead to a lot of future development expense if you have made the wrong decision. That's why I was happy to get this insights.

The last talk of the first day was "Hardware Development for JavaScript Developers" by Tarık Keleştemur. He did a great job presenting a way how to use JavaScript and an arduino. Even some small practical examples he showed us on stage what was really a cool thing.

The evening I shared with friends but it was still rainy and very windy...

## Sunday
Actually I have to admit that we came a bit late on the second day and just hopped into the conference room when the first talk "Scaling TweetDeck's frontend" by Andy Hume started. Thank you for sharing how you guys at Twitter facing all the different kinds of problems. He mentioned that they have a lot of legacy code but trying to deal with it and get all new things done with there own framework called "Flight.JS". Also to hear about how modern a specification and documentation process can look like in such a big company gives me hope that it doesn't have to be always too bureaucratic.

Pascal Precht's talk about "Componentize all the things!" was super informative and gave the audience an idea how shiny the future of web development will look like. He covered to much in his talk that want start writing about all the things in this blog post but I highly recommend to check out his slides by yourself.

The last talk I could listen to was "It's never to late to fight your legacy" by Mate Nadasdi (after that I had to leave to get my flight). This talk was a very nice addition to the Tweetdeck one but was diving deeper into the  technical details about which tools can be helpful to move on and get out of the rotten code base. He mentioned tools like ESlint, Unit testing frameworks like sinon.js and so forth. It's definitely worth for every JS developer to look at the slides and check the list of tools -- it's likely that you will find some very useful ones.

All in all it was an awesome conference and I hope there will be another one next year. Keep your good work and thank you to everybody who made this conference possible.



