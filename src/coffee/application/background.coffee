# This is main process of Electron, started as first thing when your
# app starts. This script is running through entire life of your application.
# It doesn't have any windows which you can see on screen, but we can open
# window from here.

import path from 'path'
import url from 'url'
import { app, Menu } from 'electron'
import { devMenuTemplate } from '../menu/dev-menu-template'
import { editMenuTemplate } from '../menu/edit-menu-template'
import createWindow from '../helpers/window'

# Special module holding environment variables which you declared
# in config/env_xxx.json file.
import env from './env'

mainWindow = undefined

setApplicationMenu = ->
  menus = [ editMenuTemplate ]
  if env.name != 'production'
    menus.push devMenuTemplate
  Menu.setApplicationMenu Menu.buildFromTemplate(menus)
  return

# Save userData in separate folders for each environment.
# Thanks to this you can use production and development versions of the app
# on same machine like those are two separate apps.
if env.name != 'production'
  userDataPath = app.getPath('userData')
  app.setPath 'userData', userDataPath + ' (' + env.name + ')'
app.on 'ready', ->
  `var mainWindow`
  setApplicationMenu()
  mainWindow = createWindow('main',
    width: 1000
    height: 600)
  mainWindow.loadURL url.format(
    pathname: path.join(__dirname, 'app.html')
    protocol: 'file:'
    slashes: true)
  if env.name == 'development'
    mainWindow.openDevTools()
  return
app.on 'window-all-closed', ->
  app.quit()
  return
