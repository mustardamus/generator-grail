## Extensions

The bare app is boosted with these awesome tools.

### Vue.js

[Vue.js](http://vuejs.org/guide/) is a awesome MVVM client-side framework.

The entry point for the Vue app is `./client/components/layout.coffee`. This
component is initialized in a `<div id="app"/>` container on the `body` of the
`./client/index.html` page.

Normall you should only touch `./client/index.coffee` (where the layout
component is initialized) to add new bootstrapping functionality. All components
should be [defined and initialized](http://vuejs.org/guide/composition.html) in
the layout component, split with the usual `require()`.

### Director

I still have to decide where and how to init
[Director](https://github.com/flatiron/director), which is a client side router.
Currently, for simple routing and until I decided where it belongs, the router
is initialized in `./client/components/layout/index.coffee`.

### jQuery

Ideally, you would not need [jQuery](https://jquery.com/) in combination with
Vue.js. But face it, you learned it for years and it is the fastest way to
interact with the DOM. You can use thousands of jQuery Plugins out of the box.
Also does the Foundation Plugins rely on jQuery.

Get your app running as fast as possible, adjust, refactor and speed up later.

### Foundation

[Normalize.css](https://necolas.github.io/normalize.css/) and
[Foundation](foundation.zurb.com/docs/) stylesheets are included in
`./client/index.styl`.

Foundation also offers a bunch of jQuery Plugins. Included by default in
`./client/index.styl` is the Base Plugin and the Reveal (Modal) Plugin. Extend
the list as needed to keep the bundle size to a minimum.

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
