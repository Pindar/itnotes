---
layout: post
title:  "Mock your backend with AngularJS and Grunt (Yeoman)"
date:   2014-10-03
categories: anguljarjs js frontend development
comments: true
---

I like to work independent of any backend implementation because of three reasons:

1. I don't want to wait until the backend is implemented if I can not do it by myself
2. I like to work offline even in trains when I have no reliable internet connection
3. I like the speed of the JS development process without restarting huge backend systems

All together ended in the idea to mock every backend call while developing JS frontends. The first time I was using this approach I was working in a big project where the frontend team had to start the implementation without any ready backend. This project was month before AngularJS was ready to use and we were working with BackboneJS and jQuery. But we got it working even with this setup and we loved the new way to work. So I'm using the same idea in my current AngularJS + Yeoman setup.

## Overview

The basic idea is that if you run `grunt serve` you get an offline development environment where all backend calls are mocked. But when you build your release `grunt` all backend calls are real.

## How

I'm bootsrapping a "different" dev-AngularJS app when starting it in development mode then when starting it in production. The difference is that this dev-app uses the production app as module, uses `ngMockE2E` and `$httpBackend` to mock all backend calls.

## Step by step

To see this steps better in a context a [demo project is available on github][demoproject].

1) Add all required packages to your package.json
<pre>
<code class="json">
{
  "name": "mockedbackendwithangularjs",
  "version": "0.0.0",
  "repository": {
    "type": "git",
    "url": "https://github.com/Pindar/mocked-backend-with-angularjs.git"
  },
  "dependencies": {},
  "devDependencies": {
    ...
    "grunt-processhtml": "^0.3.3"
  },
  "engines": {
    "node": ">=0.10.0"
  },
  "scripts": {
    "test": "grunt test"
  }
}
</code>
</pre>
and bower.json
<pre>
<code class="json">
"devDependencies": {
  "angular-mocks": "~1.2.0"
},
</code>
</pre>

then call `npm install && bower install`

2) Configure grunt-processhtml. Add the following to your Gruntfile
<pre>
<code class="javascript">
processhtml: {
  options: {
    commentMarker: 'process'
  },
  dist: {
    files: [
      {
        expand: true,
        cwd: '<%= yeoman.dist %>',
        src: ['*.html', 'views/{,*/}*.html'],
        dest: '<%= yeoman.dist %>'
      }
    ]
  }
}
grunt.registerTask('build', [
// ...
'processhtml',
'usemin',
'htmlmin'
]);

</code>
</pre>

3) Change way the application gets bootstrapped

  a) remove `ng-app="mockedBackendWithAngularjsApp"` from the body tag in the index.html

  b) add the code to your app.js to bootstrap the regular app
<pre>
<code class="javascript">
/**
 * @ngdoc bootstrap
 * @name mockedBackendWithAngularjsApp
 *
 */
(function () {

  if (!angular.mock) {
    angular.element(document).ready(function () {
      angular.bootstrap(document, ['mockedBackendWithAngularjsApp']);
    });
  }
})();
</code>
</pre>
  When you call grunt serve afterwards the app should still start.

  c) create app-mock.js
<pre>
<code class="javascript">
angular
  .module('mockedBackendWithAngularjsAppDev', ['mockedBackendWithAngularjsApp', 'ngMockE2E'])
  .run(function ($httpBackend) {
    'use strict';
    $httpBackend.whenGET(/^views\//).passThrough();
    $httpBackend.whenGET(/^res\//).passThrough();

    /* backend API calls here */
    $httpBackend.whenPOST(/^\/signup/).respond(200);
    $httpBackend.whenGET(/^\/api\/catalog\/US/).respond(200, TD.catalogUS);
    $httpBackend.whenPOST(/\/api\/\/exception\/(\S)*/).respond({});

  });
if (angular.mock) {
  angular.element(document).ready(function () {
    'use strict';
    angular.bootstrap(document, ['mockedBackendWithAngularjsAppDev']);
  });
}
</code>
</pre>

  d) add your mock files to ./test/mock, e.g.,
<pre>
<code class="javascript">
  window.TD = window.TD || {};
  TD.catalogUS = {
    key: 'Hello World!'
  };
</code>
</pre>

  e) make mock files available -- add folder to the livereload task in your Gruntfile
<pre>
<code class="javascript">
connect().use(
  '/mock',
  connect.static('./test/mock')
),
</code>
</pre>

  f) wire everything together -- add files to index.html
<pre>
<code class="html">
<!-- vendor scripts... -->
<!-- process:remove -->
<script src="bower_components/angular-mocks/angular-mocks.js"></script>
<!-- /process -->
<!-- your production scripts -->
<!-- process:remove -->
<script src="mock/catalog-us.js"></script>
<script src="scripts/app-mock.js"></script>
<!-- /process -->
</code>
</pre>

4) Implement your backend calls with `$http` as usual. You can find an example in the main.js controller in the [demo project][demoproject].


_Enjoy your new offline development environment!_

[demoproject]: https://github.com/Pindar/mocked-backend-with-angularjs

