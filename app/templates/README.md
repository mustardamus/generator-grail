# {{name}}

{{description}}

## Application Stack

Latest and greatest in JavaScript development. This is only a development
environment and not a framework. You can use your front-end framework of
choice.

This environment is intended to be used in a modular way. Everything is a Module
and should work and be testable independently.

Generated with the [Grail Generator](https://github.com/mustardamus/generator-grail)
for [Yeoman](http://yeoman.io/).

### Tasking

Task management is done with [Gulp](http://gulpjs.com/), so your project is
easily extendible. This stack already uses some
[Gulp Plugins](http://gulpjs.com/plugins/):

  - [gulp-util](https://github.com/gulpjs/gulp-util) - `noop()` and logging
  - [gulp-concat](https://github.com/wearefractal/gulp-concat) - To concat files
    together
  - [gulp-imagemin](https://github.com/sindresorhus/gulp-imagemin) - Wrapper for
    imagemin, to optimize images
  - [gulp-stylus](https://github.com/stevelacy/gulp-stylus) - Wrapper for
    Stylus, to compile to CSS
  - [gulp-autoprefixer](https://github.com/sindresorhus/gulp-autoprefixer) -
    Wrapper for Autoprefixer, to vendor prefix CSS3
  - [gulp-csso](https://github.com/ben-eb/gulp-csso) - Wrapper for CSSO, to
    minify CSS
  - [gulp-uglify](https://github.com/terinjokes/gulp-uglify) - Wrapper for
    Uglify, to minify JavaScript
  - [gulp-spawn-mocha](https://github.com/KenPowers/gulp-spawn-mocha) - To run
    tests with Mocha

### Scripting

Codes are written mainly in [CoffeeScript](http://coffeescript.org/) and bundled
together with [Browserify](http://browserify.org/). Out of the box it comes with
some [transforms](https://www.npmjs.org/browse/keyword/browserify-transform) for
Browserify:

  - [coffeeify](https://github.com/jnordberg/coffeeify) - To compile
    CoffeeScript to JavaScript
  - [html2js-browserify](https://github.com/featurist/html2js-browserify) - To
    compile HTML templates to JavaScript strings
  - [debowerify](https://github.com/eugeneware/debowerify) - To use Bower
    components in Browserify
  - [deamdify](https://github.com/jaredhanson/deamdify) - To use AMD modules in
    Browserify

### Styling

Styles are written mainly in [Stylus](https://learnboost.github.io/stylus/).

### Watching

Watching for file changes is crucial if you pre-compile the Scripts and Styles.
For the Script re-bundle [Watchify](https://github.com/substack/watchify) is in
charge. For the rest of the files (HTML, Styles, Images) it uses
[gulp.watch](https://github.com/gulpjs/gulp/blob/master/docs/API.md#gulpwatchglob-opts-tasks).

### Serving

The generated and bundled files will be served with
[BrowserSync](http://www.browsersync.io/). That means the Application is
automatically reloaded if Scripts or Styles are changing.

### Testing

Module tests written in CoffeeScript, bundled by Browserify and run by
[Mocha](https://visionmedia.github.io/mocha/) with
[Should.js](https://github.com/visionmedia/should.js) as assertion library.


## Gulp Tasks

Source of all tasks is `./client` and destination is `./public`.

### `gulp html`

Copies the HTML Entry Point.

### `gulp stylus`

Bundles the Style Entry Point with Stylus. Also prefix CSS3 properties with
Autoprefixer.

### `gulp images`

Copies all images.

### `gulp browserify`

Bundles the Script Entry Point with Browserify. It executes several transforms:

  - coffeeify - transforms the CoffeeScript to JavaScript
  - html2js - transforms the HTML templates to JavaScript strings
  - debowerify - `require()` modules installed by Bower
  - deamdify - `require()` modules that are wrapped by AMD

### `gulp browserify-watch`

Watches files in the source directory and re-bundles the Script Entry Point.

### `gulp watch`

  - Run `browserify-watch`
  - Run `stylus` whenever a `./client/**/*.styl` changes
  - Run `images` whenever a file in `./client/images/*` changes
  - Run `html` whenever a `./client/*.html` changes

### `gulp server`

Starts a BrowserSync web server. Also starts the `watch` task. Whenever a file
in the source directory changes, the Script or Style Entry Point is re-bundled
and the browser reloaded. Styles are directly injected in the page without a
reload.

### `gulp test`

Bundles the Application Modules and Tests together and run them in Mocha.

### `gulp test-watch`

Whenever a Application of Test file changes re-run the `test` Task.

### `gulp build`

Run `browserify`, `stylus`, `images` and `html`. `gulp` without a task name will
also run this task.

### `gulp production`

Run this task if you want to release the Application for the audiences.

  - Run `browserify` and minify JS with Uglify
  - Run `stylus` and minify CSS with CSSO
  - Run `images` and minify them with Imagemin


## Application Structure

This is a one page application. It has three different entry points and one
default Layout module.

### HTML entry point - `./client/index.html`

This is your typical `index.html` page which is loaded first. It has references
to the Script and Stylesheet entry points.

If you'd like to add static content to this page, go ahead. But usually you
don't need to touch this file and add the HTML structure of your application to
`./client/modules/layout/template.html`.

### Script entry point - `./client/index.coffee`

Here you initialize modules, like the layout. Since the Script Bundle is packed
with Browserify you can simply `require()` the modules you want to use:

    Layout = require('./modules/layout/module')
    layout = new Layout

It is recommended to `require()` third party dependencies in the modules rather
than having globals. But if there is no other way, or you like shortcuts, you
can define globals like so:

    window.$ = require('jquery')

`$` is then available in the modules without initializing it again. Old school.

### Stylesheet entry point - `./client/index.styl`

Here you initialize stylesheets, third party stylesheets and variables. Stylus
will take care of the bundling, so all you need is `@import`.

For third party styles, include a `.css` file in a relative path:

    @import '../bower_components/foundation/css/foundation.css'

To import a module:

    @import './modules/layout/style'

If you define variables, you can use them in your imported modules:

    backgroundColor = #eee

And in `./client/modules/layout/style.styl`:

    body
      background: backgroundColor


## Module Structure

A module can have three different things: A Script, a Template, and a Style. All
three are optional, since it's in your hands how you initialize each part of a
module.

### Naming Convention

Again, you can name them like you want, really. I recommend this structure:

    ./client/modules/[moduleName]
      /module.coffee
      /template.html
      /style.styl

Why this naming? You can leave out the file extension when `require()`ing them
(which would not possible if every module-part has the same name):

    module   = require('../layout/module')
    template = require('./template')

With the `moduleName` as identifier, you describe with the filename which part
of the module it is: `layout/module`, `layout/template`, `layout/style`.

A disadvantage of this method is that it might not be clear if you are editing
multiple modules in your editor. But you should work on one module at a time
anyway.

### Testing a Module

You can and should test your Modules. Just like the Application Script Entry
Point, the Tests have a Entry Point too in `./test/client/index.coffee`. There
you `require()` the tests you write:

    require('./modules/layout')

Then just create the Module Test in a subfolder:
`./test/client/modules/layout.coffee`:

    should = require('should')

    Layout = require('../../../client/modules/layout/module')
    layout = new Layout

    describe 'Layout Module', ->
      it 'should have the correct template', ->
        layout.template.should.equal '<h1>grailtest</h1>\n'

Tests are written for Mocha and include Should.js for asserting things.

To bundle the Application and Tests, and run it in Mocha:

    gulp test

To automatically re-run the `test` task whenever Application or Test files
changes, run:

    gulp test-watch

### Generate a new Module

TBD.
