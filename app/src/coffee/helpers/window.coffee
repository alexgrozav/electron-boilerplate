# This helper remembers the size and position of your windows (and restores
# them in that place after app relaunch).
# Can be used for more than one window, just construct many
# instances of it and give each different name.

import { app, BrowserWindow, screen } from 'electron';
import jetpack from 'fs-jetpack';

export default (name, options) ->
  userDataDir = jetpack.cwd(app.getPath('userData'))
  stateStoreFile = 'window-state-' + name + '.json'
  defaultSize =
    width: options.width
    height: options.height
  state = {}
  win = undefined

  restore = ->
    restoredState = {}
    try
      restoredState = userDataDir.read(stateStoreFile, 'json')
    catch err
      # For some reason json can't be read (might be corrupted).
      # No worries, we have defaults.
    Object.assign {}, defaultSize, restoredState

  getCurrentPosition = ->
    position = win.getPosition()
    size = win.getSize()
    {
      x: position[0]
      y: position[1]
      width: size[0]
      height: size[1]
    }

  windowWithinBounds = (windowState, bounds) ->
    windowState.x >= bounds.x and windowState.y >= bounds.y and windowState.x + windowState.width <= bounds.x + bounds.width and windowState.y + windowState.height <= bounds.y + bounds.height

  resetToDefaults = (windowState) ->
    bounds = screen.getPrimaryDisplay().bounds
    Object.assign {}, defaultSize,
      x: (bounds.width - (defaultSize.width)) / 2
      y: (bounds.height - (defaultSize.height)) / 2

  ensureVisibleOnSomeDisplay = (windowState) ->
    visible = screen.getAllDisplays().some((display) ->
      windowWithinBounds windowState, display.bounds
    )
    if !visible
      # Window is partially or fully not visible now.
      # Reset it to safe defaults.
      return resetToDefaults(windowState)
    windowState

  saveState = ->
    if !win.isMinimized() and !win.isMaximized()
      Object.assign state, getCurrentPosition()
    userDataDir.write stateStoreFile, state, atomic: true
    return

  state = ensureVisibleOnSomeDisplay(restore())
  win = new BrowserWindow(Object.assign({}, options, state))
  win.on 'close', saveState
  win
