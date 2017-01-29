# Watch for file changes
module.exports = (gulp, plugins, paths, livereload_port, make) =>
  return =>
    plugins.livereload.listen
      port: livereload_port

    beepOnError = (done) =>
      return (err) =>
        if (err)
          utils.beepSound()
        done(err)

    gulp.watch paths.coffee + '**/*.coffee', [ 'coffee' ]
    gulp.watch paths.js + '**/*.js', ['jsmin']

    gulp.watch paths.stylus + '**/*.styl', [ 'stylus' ]
    gulp.watch paths.sass + '**/*.scss', [ 'scss' ]
    gulp.watch paths.sass + '**/*.sass', [ 'sass' ]
    gulp.watch paths.css + '**/*.css', ['cssmin']

    gulp.watch paths.img + '**/*', [ 'imagemin' ]

    gulp.watch paths.fonts + '**/*', [ 'fonts-copy' ]
    gulp.watch paths.video + '**/*', [ 'videos-copy' ]
    gulp.watch paths.icon + '**/*', [ 'icons-copy' ]

    gulp.watch paths.views + '**/*.{op,md}', =>
      plugins.livereload.reload()
      return

    return
