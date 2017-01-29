# Include gulp
gulp = require('gulp')
plugins = require('gulp-load-plugins')()
runsequence = require('run-sequence')

batch = require('gulp-batch');
plumber = require('gulp-plumber');
jetpack = require('fs-jetpack');
bundle = require('./bundle');
utils = require('./utils');

plugins.jetpack = jetpack

livereload_port = 35729

paths =
  project: jetpack
  src: jetpack.cwd('./src')
  dist: jetpack.cwd('./app')

# JS
gulp.task('coffee', require('./app/coffee')(gulp, plugins, paths));
gulp.task('jsmin', require('./app/js')(gulp, plugins, paths));

# CSS
gulp.task('stylus', require('./app/stylus')(gulp, plugins, paths, require('nib')));
gulp.task('sass', require('./app/sass')(gulp, plugins, paths));
gulp.task('scss', require('./app/scss')(gulp, plugins, paths));
gulp.task('cssmin', require('./app/css')(gulp, plugins, paths));

# Fonts
gulp.task('fonts-copy', require('./app/copy').fonts(gulp, plugins, paths));

# Icons
gulp.task('icons-copy', require('./app/copy').icons(gulp, plugins, paths));

# Videos
gulp.task('videos-copy', require('./app/copy').videos(gulp, plugins, paths));

# Images
gulp.task('imagemin', require('./app/images')(gulp, plugins, paths));

# Copy Environment File
gulp.task('environment', require('./app/environment')(gulp, plugins, paths))

# Watch Asset Modifications
gulp.task('watch', require('./app/watch')(gulp, plugins, paths, livereload_port));

# Complete build
gulp.task('build', require('./app/build')(gulp, runsequence));

# Default task which is run using the 'gulp' command
gulp.task 'default', [
  'watch'
]