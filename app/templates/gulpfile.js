var gulp        = require('gulp');
var gutil       = require('gulp-util');
var stylus      = require('gulp-stylus');
var prefix      = require('gulp-autoprefixer');
var concat      = require('gulp-concat');
var uglify      = require('gulp-uglify');
var csso        = require('gulp-csso');
var mocha       = require('gulp-spawn-mocha');
var imagemin    = require('gulp-imagemin');
var bump        = require('gulp-bump');
var source      = require('vinyl-source-stream');
var buffer      = require('vinyl-buffer');
var browserify  = require('browserify');
var coffeeify   = require('coffeeify');
var html2js     = require('html2js-browserify');
var debowerify  = require('debowerify');
var deamdify    = require('deamdify');
var watchify    = require('watchify');
var chokidar    = require('chokidar');
var browserSync = require('browser-sync');

var port       = 7891;
var production = false;
var srcDir     = './client';
var destDir    = './public';
var testDir    = './test/client';
var tmpDir     = './temp';

var defineBundle = function(entry) {
  return browserify({
    cache: {},
    packageCache: {},
    fullPaths: false,
    extensions: ['.coffee', '.html']
  }).add(entry)
    .transform(coffeeify)
    .transform(html2js)
    .transform(debowerify)
    .transform(deamdify);
};

var jsBundle     = defineBundle(srcDir + '/index.coffee');
var jsTestBundle = defineBundle(testDir + '/index.coffee');

var jsBundling = function(bundle, outDir) {
  return bundle.bundle()
    .on('error', function(err) {
      gutil.log(gutil.colors.red('Coffee Script Error'));
      console.log(err);
      this.emit('end');
    })
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe(production ? uglify() : gutil.noop())
    .pipe(gulp.dest(outDir))
    .pipe(browserSync.reload({ stream: true }));
};

var cssBundling = function() {
  gulp.src(srcDir + '/index.styl')
    .pipe(stylus({ 'include css': true }))
    .pipe(prefix())
    .pipe(concat('bundle.css'))
    .pipe(production ? csso() : gutil.noop())
    .pipe(gulp.dest(destDir))
    .pipe(browserSync.reload({ stream: true }));
};

var imgProcessing = function() {
  gulp.src(srcDir + '/images/**')
    .pipe(production ? imagemin() : gutil.noop())
    .pipe(gulp.dest(destDir + '/images/'));
};

var runMocha = function(bundle) {
  bundle.pipe(mocha()).on('error', function() {});
};

gulp.task('html', function() {
  gulp.src(srcDir + '/*.html')
    .pipe(gulp.dest(destDir));
});

gulp.task('fonts', function() {
  gulp.src('./bower_components/semantic-ui/dist/themes/default/assets/fonts/*')
    .pipe(gulp.dest(destDir + '/themes/default/assets/fonts'));
});

gulp.task('stylus', cssBundling);
gulp.task('images', imgProcessing);

gulp.task('browserify', function() {
  jsBundling(jsBundle, destDir)
});

gulp.task('browserify-watch', ['browserify'], function() {
  watchify(jsBundle).on('update', function() {
    jsBundling(jsBundle, destDir);
  });
});

gulp.task('server', ['build', 'watch'], function() {
  browserSync({
    server: { baseDir: destDir },
    port:   port,
    open:   false,
    notify: false
  });
});

gulp.task('test', function() {
  runMocha(jsBundling(jsTestBundle, tmpDir));
});

gulp.task('test-watch', ['test'], function() {
  watchify(jsTestBundle).on('update', function() {
    runMocha(jsBundling(jsTestBundle, testDir));
  });
});

gulp.task('production', function() {
  production = true;
  jsBundling(jsBundle, destDir);
  cssBundling();
  imgProcessing();
});

gulp.task('bump', function() {
  gulp.src('./package.json')
    .pipe(bump())
    .pipe(gulp.dest('./'));
});

gulp.task('watch', ['browserify-watch'], function() {
  gulp.watch(srcDir + '/*.html',      ['html', browserSync.reload]);
  gulp.watch(srcDir + '/images/**/*', ['images', browserSync.reload]);

  chokidar.watch([srcDir + '/index.styl', srcDir + '/components/**/*.styl'])
    .on('all', function(event, path) {
      if(event === 'add' || event === 'change') {
        cssBundling();
      }
    });
});

gulp.task('build', ['html', 'browserify', 'images', 'stylus', 'fonts']);
gulp.task('default', ['build']);
