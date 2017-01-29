argv = require('minimist')(process.argv)

exports.getEnvName = =>
  argv.env or 'development'

exports.beepSound = =>
  process.stdout.write '\u0007'
  return
