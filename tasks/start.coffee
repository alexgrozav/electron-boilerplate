childProcess = require('child_process')
electron = require('electron')
gulp = require('gulp')
runsequence = require('gulp-run-sequence')

gulp.task 'spawn', =>
  childProcess.spawn(electron, [ '.' ], stdio: 'inherit').on 'close', =>
    # User closed the app. Kill the host process.
    process.exit()
    return

gulp.task 'start', =>
  runsequence [
    'build'
    'watch'
  ], [
    'spawn'
  ]
  return
