# Make the project by running all the build tasks
#
module.exports = (gulp, runsequence) =>
  return =>
    runsequence [
      'coffee'
      'stylus'
      'fonts-copy'
      'icons-copy'
      'videos-copy'
      'imagemin'
    ], [
      'cssmin'
      'jsmin'
    ]
