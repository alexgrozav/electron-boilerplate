# Compile .coffee file extension, sourcemap, write and minify
#
module.exports = (gulp, plugins, paths) =>
  # Handle Coffeescript module files by compiling the base file in which they are
  # imported and used
  #
  coffee_partial = (input) ->
    basename = input.basename
    basedir = input.dirname.split('/')

    if basename != basedir[0]
      cache_path = paths.assets + paths.coffee + basedir[0] + '/' + basedir[0] + input.extname
      delete plugins.cached.caches[input.extname][require('path').resolve(cache_path)]
    return input

  return =>
    gulp.src(paths.assets_src + paths.coffee + '**/*.coffee')
      .pipe(plugins.rename(coffee_partial))
      .pipe(plugins.cached('.coffee'))
      .pipe(plugins.debug())
      .pipe(plugins.include()).on('error', console.log)
      .pipe(plugins.sourcemaps.init())
      .pipe(plugins.plumber())
      .pipe(plugins.coffee().on('error', console.log))
      .pipe(gulp.dest(paths.assets_src + paths.js))
      .pipe(plugins.ignore.exclude([ '*.map' ]))
      .pipe(plugins.babel({presets: ['babili']}))
      # .pipe(plugins.uglify().on('error', console.log))
      .pipe(plugins.rename(suffix: '.min'))
      .pipe(plugins.sourcemaps.write('../' + paths.maps))
      .pipe(gulp.dest(paths.assets_dist + paths.js))
      .pipe(plugins.livereload())
