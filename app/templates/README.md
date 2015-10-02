# {{name}}

{{description}}

## Application Stack

Latest and greatest in JavaScript development. This is only a development
environment and not a framework. You can use your front-end framework of
choice.

This environment is intended to be used in a modular way. Everything is a
Component and should work and be testable independently.

Generated with the
[Grail Generator](https://github.com/mustardamus/generator-grail) for
[Yeoman](http://yeoman.io/).

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
  - [gulp-bump](https://github.com/stevelacy/gulp-bump) - To bump up the version
    number in `package.json`

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
charge.

Since the Styles are not in the JS bundle,
[Chokidar](https://github.com/paulmillr/chokidar) is used to watch and rebuild
them. `gulp.watch` isn't used here, since it does not pick up newly created
files.

For the rest of the files (HTML, Images) it uses
[gulp.watch](https://github.com/gulpjs/gulp/blob/master/docs/API.md#gulpwatchglob-opts-tasks).

### Serving

The generated and bundled files will be served with
[BrowserSync](http://www.browsersync.io/). That means the Application is
automatically reloaded if Scripts or Styles are changing.

### Testing

Component tests written in CoffeeScript, bundled by Browserify and run by
[Mocha](https://visionmedia.github.io/mocha/).


## Gulp Tasks

Source of all tasks is `./client` and destination is `./public`.

### `gulp html`

Copies the HTML Entry Point.

### `gulp fonts`

Copies fonts. This tasks copies the fonts of Font Awesome by default, but note
that you need to run `yo grail:extend`, so the fonts are available.

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

Bundles the Application Components and Tests together and run them in Mocha.

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

### `gulp bump`

Bumps up the version number in `package.json`.


## Application Structure

This is a one page application. It has three different entry points.

### HTML entry point - `./client/index.html`

This is your typical `index.html` page which is loaded first. It has references
to the Script and Stylesheet entry points.

Markup that is initially loaded (the Layout), is stored here.

### Script entry point - `./client/index.coffee`

Here you initialize components. Since the Script Bundle is packed
with Browserify you can simply `require()` the components you want to use:

    Post = require('./components/post')
    post = new Post

It is recommended to `require()` third party dependencies in the components
rather than having globals. But if you install the libraries with Bower, the
respective global will be defined without declaring it:

    require('jQuery') # $ is globally defined

However, if you declare it this way your tests may brake because they are run in
Node.js by default (todo: run them in PhantomJS).

### Stylesheet entry point - `./client/index.styl`

Here you initialize stylesheets, third party stylesheets and variables. Stylus
will take care of the bundling, so all you need is `@import`.

For third party styles, include a `.css` file in a relative path:

    @import '../bower_components/foundation/css/foundation.css'

To import a module style:

    @import './components/post/style'

Note that you don't need to include every single Component style since by
default every `style.styl` from the `./client/components` is imported.

If you define variables, you can use them in your imported components:

    backgroundColor = #eee

And in `./client/components/post/style.styl`:

    body
      background: backgroundColor


## Component Structure

A component can have three different things: A Script, a Template, and a Style.
All three are optional, since it's in your hands how you initialize each part of
a component.

### Naming Convention

Again, you can name them like you want, really. I recommend this structure:

    ./client/components/[component-name]
      /index.coffee
      /template.html
      /style.styl

Why this naming? You can leave out the file extension when `require()`ing them
(which would not possible if every component-part has the same name):

    post     = require('../post')    # respectively index.coffee
    template = require('./template')

With the `component-name` as identifier, and `index.coffee` as Script entry
point, you describe with the filename which part of the component you want to
`require()`: `post` (respectively `index.coffee`), `post/template` and
`post/style`.

A disadvantage of this method is that it might not be clear if you are editing
multiple components in your editor. But you should work on one component at a
time anyway.

### Testing a Component

You can and should test your Components. Just like the Application Script Entry
Point, the Tests have a Entry Point too in `./test/client/index.coffee`. There
you `require()` the components and tests:

    postTest = require('./components/post')

Then just create the component test a file named like the component:
`./test/client/components/post.coffee`:

    should = require('should')
    Post   = require('../../../client/components/post')
    post   = new Post

    describe 'Post Component', ->
      it 'should have the correct template', ->
        post.template.should.equal 'testing'

To bundle the Application and Tests, and run it in Mocha:

    gulp test

To automatically re-run the `test` task whenever Application or Test files
change, run:

    gulp test-watch

### Generate a new Component

You can generate the parts of a Component
(Script, Template, Style, Test) with this command:

    yo grail:create

You will be prompted for the name and which parts you like to create.


## Workflow

### Using third party Scripts

Third party libraries can be either installed with NPM or Bower. In the end, you
just need to `require()` the library.

#### NPM

    npm install moment --save

#### Bower

    bower install zepto --save

Then you can require the libraries wherever you want (usually in the Component):

    $      = require('zepto')
    moment = require('moment')

#### Manually

In the rare case you can't install a library from NPM or Bower, you also can
`require()` the `.js` from everywhere:

    lib = require('../path/to/lib.js')

### Using third party Styles

Install it via Bower:

    bower install foundation --save

And `@import` it in `./client/index.styl`:

    @import '../bower_components/foundation/css/foundation.css'
