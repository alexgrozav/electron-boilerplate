get_folders = require('./get-folders')

# Handle plugin preprocessing and copy them to the application assets folder
#
module.exports.coffee = (gulp, plugins, paths, collect_plugins) =>
  return =>
    for plugin in collect_plugins
      # plugins.merge get_folders(paths.plugins).map (folder) =>
      gulp.src(paths.plugins + "#{plugin}/coffee/#{plugin}/**/*.coffee")
        .pipe(plugins.cached('plugins-coffee'))
        .pipe(plugins.debug())
        .pipe gulp.dest(paths.assets_src + paths.coffee + "#{plugin}/")

# Handle plugin preprocessing and copy them to the application assets folder
#
module.exports.sass = (gulp, plugins, paths, collect_plugins) =>
  return =>
    for plugin in collect_plugins
      # plugins.merge get_folders(paths.plugins).map (folder) =>
      gulp.src(paths.plugins + "#{plugin}/sass/#{plugin}/**/*.sass")
        .pipe(plugins.cached('plugins-sass'))
        .pipe(plugins.debug())
        .pipe gulp.dest(paths.assets_src + paths.sass + "#{plugin}/")

# Handle plugin preprocessing and copy them to the application assets folder
#
module.exports.stylus = (gulp, plugins, paths, collect_plugins) =>
  return =>
    for plugin in collect_plugins
      # plugins.merge get_folders(paths.plugins).map (folder) =>
      gulp.src(paths.plugins + "#{plugin}/stylus/#{plugin}/**/*.styl")
        .pipe(plugins.cached('plugins-stylus'))
        .pipe(plugins.debug())
        .pipe gulp.dest(paths.assets_src + paths.stylus + "#{plugin}/")
