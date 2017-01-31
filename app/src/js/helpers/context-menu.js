(function() {
  (function() {
    'use strict';
    var Menu, MenuItem, copy, cut, isAnyTextSelected, normalMenu, paste, remote, textEditingMenu;
    remote = require('electron').remote;
    Menu = remote.Menu;
    MenuItem = remote.MenuItem;
    isAnyTextSelected = function() {
      return window.getSelection().toString() !== '';
    };
    cut = new MenuItem({
      label: 'Cut',
      click: function() {
        document.execCommand('cut');
      }
    });
    copy = new MenuItem({
      label: 'Copy',
      click: function() {
        document.execCommand('copy');
      }
    });
    paste = new MenuItem({
      label: 'Paste',
      click: function() {
        document.execCommand('paste');
      }
    });
    normalMenu = new Menu;
    normalMenu.append(copy);
    textEditingMenu = new Menu;
    textEditingMenu.append(cut);
    textEditingMenu.append(copy);
    textEditingMenu.append(paste);
    document.addEventListener('contextmenu', function(e) {
      switch (e.target.nodeName) {
        case 'TEXTAREA':
        case 'INPUT':
          e.preventDefault();
          textEditingMenu.popup(remote.getCurrentWindow());
          break;
        default:
          if (isAnyTextSelected()) {
            e.preventDefault();
            normalMenu.popup(remote.getCurrentWindow());
          }
      }
    }, false);
  })();

}).call(this);
