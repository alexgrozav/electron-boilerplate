(function() {
  (function() {
    'use strict';
    var shell, supportExternalLinks;
    shell = require('electron').shell;
    supportExternalLinks = function(e) {
      var checkDomElement, href, isExternal;
      href = void 0;
      isExternal = false;
      checkDomElement = function(element) {
        if (element.nodeName === 'A') {
          href = element.getAttribute('href');
        }
        if (element.classList.contains('js-external-link')) {
          isExternal = true;
        }
        if (href && isExternal) {
          shell.openExternal(href);
          e.preventDefault();
        } else if (element.parentElement) {
          checkDomElement(element.parentElement);
        }
      };
      checkDomElement(e.target);
    };
    document.addEventListener('click', supportExternalLinks, false);
  })();

}).call(this);
