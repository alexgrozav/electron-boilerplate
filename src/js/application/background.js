var mainWindow, setApplicationMenu, userDataPath;

import path from 'path';

import url from 'url';

import {
  app,
  Menu
} from 'electron';

import {
  devMenuTemplate
} from '../menu/dev-menu-template';

import {
  editMenuTemplate
} from '../menu/edit-menu-template';

import createWindow from '../helpers/window';

import env from './env';

mainWindow = void 0;

setApplicationMenu = function() {
  var menus;
  menus = [editMenuTemplate];
  if (env.name !== 'production') {
    menus.push(devMenuTemplate);
  }
  Menu.setApplicationMenu(Menu.buildFromTemplate(menus));
};

if (env.name !== 'production') {
  userDataPath = app.getPath('userData');
  app.setPath('userData', userDataPath + ' (' + env.name + ')');
}

app.on('ready', function() {
  var mainWindow;
  setApplicationMenu();
  mainWindow = createWindow('main', {
    width: 1000,
    height: 600
  });
  mainWindow.loadURL(url.format({
    pathname: path.join(__dirname, 'app.html'),
    protocol: 'file:',
    slashes: true
  }));
  if (env.name === 'development') {
    mainWindow.openDevTools();
  }
});

app.on('window-all-closed', function() {
  app.quit();
});
