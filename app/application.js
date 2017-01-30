(function () {'use strict';

function _interopDefault (ex) { return (ex && (typeof ex === 'object') && 'default' in ex) ? ex['default'] : ex; }

var os = _interopDefault(require('os'));
var electron = require('electron');
var jetpack = _interopDefault(require('fs-jetpack'));

var greet = function() {
  return 'Hello World!';
};

var env;

env = jetpack.cwd(__dirname).read('config/env.json', 'json');

var env$1 = env;

var app;
var appDir;
var pack;

console.log('Loaded environment variables:', env$1);

app = electron.remote.app;

appDir = jetpack.cwd(app.getAppPath());

pack = appDir.read('package.json', 'json');

console.log('The author of this app is:', pack.author);

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('greet').innerHTML = greet();
  document.getElementById('platform-info').innerHTML = os.platform();
  return document.getElementById('env-name').innerHTML = env$1.name;
});

}());
//# sourceMappingURL=/Users/grozav/Workspace/application/assets/maps/application.js.map