module.exports = (gulp, plugins, paths) =>
  utils = require('../utils');

  return =>
    configFile = 'config/env/env-' + utils.getEnvName() + '.json'
    paths.project.copy configFile, paths.app.path('config/env.json'), { overwrite: true }
