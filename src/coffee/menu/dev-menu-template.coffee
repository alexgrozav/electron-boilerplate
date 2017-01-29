import { app, BrowserWindow } from 'electron';

export devMenuTemplate =
  label: 'Development'
  submenu: [
    {
      label: 'Reload'
      accelerator: 'CmdOrCtrl+R'
      click: ->
        BrowserWindow.getFocusedWindow().webContents.reloadIgnoringCache()
        return

    }
    {
      label: 'Toggle DevTools'
      accelerator: 'Alt+CmdOrCtrl+I'
      click: ->
        BrowserWindow.getFocusedWindow().toggleDevTools()
        return

    }
    {
      label: 'Quit'
      accelerator: 'CmdOrCtrl+Q'
      click: ->
        app.quit()
        return

    }
  ]
