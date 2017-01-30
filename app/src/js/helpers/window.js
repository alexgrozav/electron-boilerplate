import {
  app,
  BrowserWindow,
  screen
} from 'electron';

import jetpack from 'fs-jetpack';

export default function(name, options) {
  var defaultSize, ensureVisibleOnSomeDisplay, getCurrentPosition, resetToDefaults, restore, saveState, state, stateStoreFile, userDataDir, win, windowWithinBounds;
  userDataDir = jetpack.cwd(app.getPath('userData'));
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
    bounds = screen.getPrimaryDisplay().bounds;
    return Object.assign({}, defaultSize, {
      x: (bounds.width - defaultSize.width) / 2,
      y: (bounds.height - defaultSize.height) / 2
    });
  };
  ensureVisibleOnSomeDisplay = function(windowState) {
    var visible;
    visible = screen.getAllDisplays().some(function(display) {
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
  win = new BrowserWindow(Object.assign({}, options, state));
  win.on('close', saveState);
  return win;
};
