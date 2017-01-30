# Compile .coffee file extension, sourcemap, write and minify
#
module.exports = (gulp, plugins, paths, bundle) =>
  return =>
    Promise.all [
      bundle(paths.app.path('src', 'js', 'application', 'electron.js'), paths.app.path('electron.js')),
      bundle(paths.app.path('src', 'js', 'application', 'application.js'), paths.app.path('application.js'))
    ]
