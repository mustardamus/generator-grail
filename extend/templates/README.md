## Client Extensions

### [Vue.js](http://vuejs.org/guide/)

#### `$root` Component

The entry point for the [Vue.js](http://vuejs.org/guide/) application is
`./client/components/$root/index.coffee`. This component is initialized in a
`<div id="app"/>` container on the `<body>` of the `./client/index.html` page,
by the Script entry point `./client/index.coffee`.

Use `./client/components/$root/data.coffee` to define data that are accessible
by every component via `@$root.$data`.

If you need to trigger events in components that are not related you should use
`@$root.$dispatch()` and `@$root.$on()`.

Global styles should go in `./client/components/$root/style.styl`. Colors can
be defined in and loaded from `./client/components/$root/colors.styl`.

#### `page-home` Component

This is a example component and acts as home page. Page-Components are defined
in the `$router` component. It's recommended to keep the `page-*` convention
when you create other top-level pages.

#### `routes` Definitions

Routes are made possible by [vue-router](https://github.com/vuejs/vue-router/).
Define your custom routes in `./client/routes/index.coffee`. Then you just link
them with `v-link` and you are set.

#### Mixins

You can extend a Vue.js application with
[Mixins](http://vuejs.org/guide/mixins.html). They should be stored in
`./client/mixins`.

##### `$ajax` Mixin

The Mixin `./client/mixins/ajax.coffee` is loaded by the app entry point. It is
a simple proxy function to make jQuery `$.ajax` calls more pleasant. Call it
like this:

    @$ajax('get|post|put|delete', dataObject, optionsObject, cb(err, response))

The `dataObject` and `optionsObject` are optional. `optionsObject` would extend
the options for the `$.ajax` call (see example below). If there is an error,
`err` would be filled with the `jqXHR` object.

The Mixin is attached to each VM. For example:

module.exports =
  ready: ->
    @$ajax 'get', '/accounts', (err, accounts) ->
      @$data.accounts = accounts

    @$ajax 'post', '/accounts', { username: 'hoy' }, (err, account) ->
      @$data.accounts.push account

    @$ajax 'delete', '/accounts', { id: 123 }, { beforeSend: -> console.log('before send') }, (err, response) ->
      console.log 'done', err, response


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

Note that Semantic-UI includes
[Font Awesome](http://semantic-ui.com/elements/icon.html) icons.

### [Socket.io](http://socket.io/docs/)

If you are running a Socket.io Server (`yo grail:server`, for starters) you can
use [Socket.io](http://socket.io/docs/). If the web application is serving from
`gulp server` (port `7891`), the global `window.io` object is stubbed and don't
do anything other than printing a warning to `console.log`.

### [FastClick](https://github.com/ftlabs/fastclick)

[FastClick](https://github.com/ftlabs/fastclick) library for eliminating the
300ms delay between a physical tap and the firing of a `click` event on mobile
browsers.

### [Cheerio](https://github.com/cheeriojs/cheerio)

[Cheerio](https://github.com/cheeriojs/cheerio) is a jQuery like helper for
Node.js. This makes running tests on HTML code pretty easy.

### [Should.js](https://github.com/visionmedia/should.js/)

[Should.js](https://github.com/visionmedia/should.js/) is a assertion library
that reads better than the `assert` functions that come with Node.js.


## Create a Vue.js Component

Use the command `yo grail:create` to create a component in
`./client/components`. You can choose which parts you want to create: Script,
Template, Style and/or Test.

Then you just `require()` the Script or Template, `@import()` the Style wherever
it is needed. Component names should be all lowercase and divided by a dash `-`
if multiple words.
