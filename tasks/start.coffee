childProcess = require('child_process')
electron = require('electron')
gulp = require('gulp')

gulp.task 'start', [
  'build'
  'watch'
], =>
  childProcess.spawn(electron, [ '.' ], stdio: 'inherit').on 'close', =>
    # User closed the app. Kill the host process.
    process.exit()
    return
  return
