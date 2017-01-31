# This gives you default context menu (cut, copy, paste)
# in all input fields and textareas across your app.
do ->
  'use strict'

  remote = require('electron').remote
  Menu = remote.Menu
  MenuItem = remote.MenuItem

  isAnyTextSelected = ->
    window.getSelection().toString() != ''

  cut = new MenuItem
    label: 'Cut'
    click: ->
      document.execCommand 'cut'
      return

  copy = new MenuItem
    label: 'Copy'
    click: ->
      document.execCommand 'copy'
      return

  paste = new MenuItem
    label: 'Paste'
    click: ->
      document.execCommand 'paste'
      return

  normalMenu = new Menu
  normalMenu.append copy

  textEditingMenu = new Menu
  textEditingMenu.append cut
  textEditingMenu.append copy
  textEditingMenu.append paste

  document.addEventListener 'contextmenu', (e) ->
    switch e.target.nodeName
      when 'TEXTAREA', 'INPUT'
        e.preventDefault()
        textEditingMenu.popup remote.getCurrentWindow()
      else
        if isAnyTextSelected()
          e.preventDefault()
          normalMenu.popup remote.getCurrentWindow()
    return
  , false

  return
