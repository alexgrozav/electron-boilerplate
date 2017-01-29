# Optimize images for the web
#
module.exports = (gulp, plugins, paths) =>
  return =>
    gulp.src(paths.assets_src + paths.img + '**/*.{jpg,png,gif}')
      .pipe(plugins.cached('img'))
      .pipe(plugins.debug())
      .pipe(plugins.imagemin(
        svgoPlugins: [ { removeViewBox: false } ]
        optimizationLevel: 3,
        progessive: true,
        interlaced: true
      ))
      .pipe gulp.dest(paths.assets_dist + paths.img)
