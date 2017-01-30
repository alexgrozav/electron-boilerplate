# Include gulp
gulp = require('gulp')
plugins = require('gulp-load-plugins')()

batch = require('gulp-batch');
runsequence = require('gulp-run-sequence');

jetpack = require('fs-jetpack');
plugins.jetpack = jetpack

utils = require('./utils');
bundle = require('./bundle')


livereload_port = 35729
paths =
  project: jetpack
  app: jetpack.cwd('./app')

  maps: 'maps/'
  assets_src: 'app/src/'
  assets_dist: 'app/public/'
  sass: 'sass/'
  stylus: 'stylus/'
  css: 'css/'
  coffee: 'coffee/'
  js: 'js/'
  fonts: 'fonts/'
  video: 'video/'
  icon: 'icon/'
  img: 'img/'
  plugins: '../plugins/'
  views: 'views/'
  fixtures: 'fixtures/'


# JS
gulp.task('coffee', require('./build/coffee')(gulp, plugins, paths));
gulp.task('jsmin', require('./build/js')(gulp, plugins, paths));

# CSS
gulp.task('stylus', require('./build/stylus')(gulp, plugins, paths, require('nib')));
gulp.task('sass', require('./build/sass')(gulp, plugins, paths));
gulp.task('scss', require('./build/scss')(gulp, plugins, paths));
gulp.task('cssmin', require('./build/css')(gulp, plugins, paths));

# Fonts
gulp.task('fonts-copy', require('./build/copy').fonts(gulp, plugins, paths));

# Icons
gulp.task('icons-copy', require('./build/copy').icons(gulp, plugins, paths));

# Videos
gulp.task('videos-copy', require('./build/copy').videos(gulp, plugins, paths));

# Images
gulp.task('imagemin', require('./build/images')(gulp, plugins, paths));

# Copy Environment File
gulp.task('environment', require('./build/environment')(gulp, plugins, paths))
gulp.task('bundle', require('./build/bundle')(gulp, plugins, paths, bundle))

# Watch Asset Modifications
gulp.task('watch', require('./build/watch')(gulp, plugins, paths, livereload_port));

# Default task which is run using the 'gulp' command
gulp.task 'default', [
  'watch'
]

# Build all application assets
gulp.task 'build', =>
  runsequence [
    'coffee'
    'stylus'
    'imagemin'
  ], [
    'bundle'
    'environment'
  ]
