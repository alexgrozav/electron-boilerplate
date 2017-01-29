# Compile .coffee file extension, sourcemap, write and minify
#
module.exports = (gulp, plugins, paths) =>
  return =>
    Promise.all [
      bundle(paths.src.path('js', 'application', 'background.js'), paths.dist.path('js', 'application', 'background.js')),
      bundle(paths.src.path('js', 'application', 'app.js'), paths.dist.path('js', 'application', 'app.js'))
    ]
