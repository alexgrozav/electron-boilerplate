(function () {'use strict';

function _interopDefault (ex) { return (ex && (typeof ex === 'object') && 'default' in ex) ? ex['default'] : ex; }

var path = _interopDefault(require('path'));
var url = _interopDefault(require('url'));
var electron = require('electron');
var jetpack = _interopDefault(require('fs-jetpack'));

var devMenuTemplate = {
  label: 'Development',
  submenu: [
    {
      label: 'Reload',
      accelerator: 'CmdOrCtrl+R',
      click: function() {
        electron.BrowserWindow.getFocusedWindow().webContents.reloadIgnoringCache();
      }
    }, {
      label: 'Toggle DevTools',
      accelerator: 'Alt+CmdOrCtrl+I',
      click: function() {
        electron.BrowserWindow.getFocusedWindow().toggleDevTools();
      }
    }, {
      label: 'Quit',
      accelerator: 'CmdOrCtrl+Q',
      click: function() {
        electron.app.quit();
      }
    }
  ]
};

var editMenuTemplate = {
  label: 'Edit',
  submenu: [
    {
      label: 'Undo',
      accelerator: 'CmdOrCtrl+Z',
      selector: 'undo:'
    }, {
      label: 'Redo',
      accelerator: 'Shift+CmdOrCtrl+Z',
      selector: 'redo:'
    }, {
      type: 'separator'
    }, {
      label: 'Cut',
      accelerator: 'CmdOrCtrl+X',
      selector: 'cut:'
    }, {
      label: 'Copy',
      accelerator: 'CmdOrCtrl+C',
      selector: 'copy:'
    }, {
      label: 'Paste',
      accelerator: 'CmdOrCtrl+V',
      selector: 'paste:'
    }, {
      label: 'Select All',
      accelerator: 'CmdOrCtrl+A',
      selector: 'selectAll:'
    }
  ]
};

var createWindow = function(name, options) {
  var defaultSize, ensureVisibleOnSomeDisplay, getCurrentPosition, resetToDefaults, restore, saveState, state, stateStoreFile, userDataDir, win, windowWithinBounds;
  userDataDir = jetpack.cwd(electron.app.getPath('userData'));
  stateStoreFile = 'window-state-' + name + '.json';
  defaultSize = {
    width: options.width,
    height: options.height
  };
  state = {};
  win = void 0;
  restore = function() {
    var err, restoredState;
    restoredState = {};
    try {
      restoredState = userDataDir.read(stateStoreFile, 'json');
    } catch (error) {
      err = error;
    }
    return Object.assign({}, defaultSize, restoredState);
  };
  getCurrentPosition = function() {
    var position, size;
    position = win.getPosition();
    size = win.getSize();
    return {
      x: position[0],
      y: position[1],
      width: size[0],
      height: size[1]
    };
  };
  windowWithinBounds = function(windowState, bounds) {
    return windowState.x >= bounds.x && windowState.y >= bounds.y && windowState.x + windowState.width <= bounds.x + bounds.width && windowState.y + windowState.height <= bounds.y + bounds.height;
  };
  resetToDefaults = function(windowState) {
    var bounds;
    bounds = electron.screen.getPrimaryDisplay().bounds;
    return Object.assign({}, defaultSize, {
      x: (bounds.width - defaultSize.width) / 2,
      y: (bounds.height - defaultSize.height) / 2
    });
  };
  ensureVisibleOnSomeDisplay = function(windowState) {
    var visible;
    visible = electron.screen.getAllDisplays().some(function(display) {
      return windowWithinBounds(windowState, display.bounds);
    });
    if (!visible) {
      return resetToDefaults(windowState);
    }
    return windowState;
  };
  saveState = function() {
    if (!win.isMinimized() && !win.isMaximized()) {
      Object.assign(state, getCurrentPosition());
    }
    userDataDir.write(stateStoreFile, state, {
      atomic: true
    });
  };
  state = ensureVisibleOnSomeDisplay(restore());
  win = new electron.BrowserWindow(Object.assign({}, options, state));
  win.on('close', saveState);
  return win;
};

var env;

env = jetpack.cwd(__dirname).read('config/env.json', 'json');

var env$1 = env;

var mainWindow;
var setApplicationMenu;
var userDataPath;

mainWindow = void 0;

setApplicationMenu = function() {
  var menus;
  menus = [editMenuTemplate];
  if (env$1.name !== 'production') {
    menus.push(devMenuTemplate);
  }
  electron.Menu.setApplicationMenu(electron.Menu.buildFromTemplate(menus));
};

if (env$1.name !== 'production') {
  userDataPath = electron.app.getPath('userData');
  electron.app.setPath('userData', userDataPath + ' (' + env$1.name + ')');
}

electron.app.on('ready', function() {
  setApplicationMenu();
  mainWindow = createWindow('main', {
    width: 1000,
    height: 600
  });
  mainWindow.loadURL(url.format({
    pathname: path.normalize(__dirname + '/index.html'),
    protocol: 'file:',
    slashes: true
  }));
  if (env$1.name === 'development') {
    mainWindow.openDevTools();
  }
});

electron.app.on('window-all-closed', function() {
  electron.app.quit();
});

}());
//# sourceMappingURL=/Users/grozav/Workspace/application/assets/maps/electron.js.map