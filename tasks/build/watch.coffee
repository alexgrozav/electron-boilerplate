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

    gulp.watch paths.assets + paths.coffee + '**/*.coffee', [ 'coffee' ]

    gulp.watch paths.assets + paths.stylus + '**/*.styl', [ 'stylus' ]
    gulp.watch paths.assets + paths.sass + '**/*.scss', [ 'scss' ]
    gulp.watch paths.assets + paths.sass + '**/*.sass', [ 'sass' ]

    gulp.watch paths.assets + paths.img + '**/*', [ 'imagemin' ]

    gulp.watch paths.app + '**/*.{op,md,html}', =>
      plugins.livereload.reload()
      return

    return
