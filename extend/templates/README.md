## Client Extensions

### [Vue.js](http://vuejs.org/guide/)

#### `$root` Component

The entry point for the [Vue.js](http://vuejs.org/guide/) application is
`./client/components/$root/index.coffee`. This component is initialized in a
`<div id="app"/>` container on the `<body>` of the `./client/index.html` page,
by the Script entry point `./client/index.coffee`.

Normally you should only touch `./client/index.coffee` to add new bootstrapping
functionality or glogbally defined libraries.

Use `./client/components/$root/data.coffee` to define data that are accessible
by every component via `@$root.$data`.

If you need to trigger events in components that are not related you should use
`@$root.$dispatch()` and `@$root.$on()`.

#### `$layout` Component

Components should be
[defined and initialized](http://vuejs.org/guide/composition.html) in
`./client/components/$layout/index.coffee` and
`./client/components/$layout/template.html`.
Global styles should go in `./client/components/$layout/style.styl`.

#### `$router` Component

The `$router` Component uses [Director](https://github.com/flatiron/director)
and sets `@$root.$data.currentPage` whenever the page changes. The `/#/` route
will become `home`. `/#/about`, for example, will become `about`.

Define your custom routes in `./client/components/$router/index.coffee`.

#### `page-home` Component

This acts as a example component. It is defined and initialized in the
`$layout` component, and is loaded whenever
`@$root.$data.currentPage === 'home'`.

It's recommended to keep the `page-*` convention when you create other
top-level pages.

### [jQuery](https://jquery.com/)

Ideally, you would not need [jQuery](https://jquery.com/) in combination with
Vue.js. But face it, you learned it for years and it is the fastest way to
interact with the DOM. You can use thousands of jQuery Plugins out of the box.
Also does the Semantic-UI Plugins rely on jQuery.

Get your app running as fast as possible, adjust, refactor and speed up later.

### [Semantic-UI](http://semantic-ui.com/)

[Semantic-UI](http://semantic-ui.com/) stylesheets are included in
`./client/index.styl` separately. Turn them on and off by commenting them in or
out.

Semantic-UI also offers a bunch of jQuery Plugins. They are included separately
in `./client/index.coffee`. Just like the stylesheets, turn them on and off as
needed.

Note that
Semantic-UI includes [Font Awesome](http://semantic-ui.com/elements/icon.html)
icons.

### Fastclick

[FastClick](https://github.com/ftlabs/fastclick) library for eliminating the
300ms delay between a physical tap and the firing of a `click` event on mobile
browsers.

### Cheerio

[Cheerio](https://github.com/cheeriojs/cheerio) is a jQuery like helper for
Node.js. This makes running tests on HTML code pretty easy.

### Should.js

[Should.js](https://github.com/visionmedia/should.js/) is a assertion library
that reads better than the `assert` functions that come with Node.js.


## Create a Vue.js Component

Use the command `yo grail:create` to create a component in `./client/components`.
You can choose which parts you want to create: Script, Template, Style and/or
Test.

Then you just `require()` the Script or Template, `@import()` the Style wherever
it is needed. Component names should be all lowercase and devided by a dash `-`
if multiple words.
