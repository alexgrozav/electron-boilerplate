# Convenient way for opening links in external browser, not in the app.
# Useful especially if you have a lot of links to deal with.
#
# Usage:
#
# Every link with class ".js-external-link" will be opened in external browser.
# <a class="js-external-link" href="http://google.com">google</a>
#
# The same behaviour for many links can be achieved by adding
# this class to any parent tag of an anchor tag.
# <p class="js-external-link">
#    <a href="http://google.com">google</a>
#    <a href="http://bing.com">bing</a>
# </p>
do ->
  'use strict'
  shell = require('electron').shell

  supportExternalLinks = (e) ->
    href = undefined
    isExternal = false

    checkDomElement = (element) ->
      if element.nodeName == 'A'
        href = element.getAttribute('href')

      if element.classList.contains('js-external-link')
        isExternal = true

      if href and isExternal
        shell.openExternal href
        e.preventDefault()
      else if element.parentElement
        checkDomElement element.parentElement
      return

    checkDomElement e.target
    return

  document.addEventListener 'click', supportExternalLinks, false
  return
