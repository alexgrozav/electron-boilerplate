module.exports = (gulp, plugins, paths) =>
  utils = require('../utils');

  return =>
    configFile = 'config/env-' + utils.getEnvName() + '.json'
    paths.project.copy configFile, paths.dist.path('env.json'), { overwrite: true }
