# Compile .sass file extension, sourcemap, write and minify
#
module.exports = (gulp, plugins, paths, nib) =>
  # Handle Sass _partial files by compiling the base file in which they are
  # imported and used
  #
  stylus_partial = (input) ->
    if input.basename[0] == '_'
      newdir = input.dirname.split('/')
      newpath = require('path').resolve paths.assets + paths.stylus + newdir[0] + '/[a-zA-Z\-]+' + input.extname
      newpath = new RegExp newpath

      for key in Object.keys(plugins.cached.caches[input.extname])
        if newpath.test key
          delete plugins.cached.caches[input.extname][key]
    return

  return =>
    gulp.src(paths.assets_dist + paths.stylus + '**/*.styl')
      .pipe(plugins.rename(stylus_partial))
      .pipe(plugins.cached('.styl'))
      .pipe(plugins.debug())
      .pipe(plugins.sourcemaps.init())
      .pipe(plugins.ignore( (file) => /\_.+\.styl$/.test file.relative ))
      .pipe(plugins.plumber())
      .pipe(plugins.stylus(
        'resolve url': true,
        'url'        : 'embedurl'
        'use'        : nib()
        'import'     : 'nib'
        # set: ['resolve url']
        # define: { url: plugins.stylus.stylus.resolver() }
      ))
      .pipe(plugins.autoprefixer())
      .pipe(plugins.sourcemaps.write('../' + paths.maps))
      .pipe(gulp.dest(paths.assets_src + paths.css))
      .pipe(plugins.ignore.exclude([ '**/*.map' ]))
      .pipe(plugins.cssmin())
      .pipe(plugins.rename(suffix: '.min'))
      .pipe(gulp.dest(paths.assets_dist + paths.css))
      .pipe(plugins.livereload())
