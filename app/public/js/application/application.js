var app, appDir, pack;

import os from 'os';

import {
  remote
} from 'electron';

import jetpack from 'fs-jetpack';

import {
  greet
} from '../hello-world/hello-world';

import env from './env';

console.log('Loaded environment variables:', env);

app = remote.app;

appDir = jetpack.cwd(app.getAppPath());

pack = appDir.read('package.json', 'json');

console.log('The author of this app is:', pack.author);

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('greet').innerHTML = greet();
  document.getElementById('platform-info').innerHTML = os.platform();
  return document.getElementById('env-name').innerHTML = env.name;
});

//# sourceMappingURL=../../maps/application/application.js.map
