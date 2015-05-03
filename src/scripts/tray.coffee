
gui = require('nw.gui')
win = gui.Window.get()

connectToParent = (parent, port) ->
  PageTransitions.init parent
  $('.server-address').text "http://localhost:#{port}"

$('.info')[0].addEventListener 'click', ->
  gui.Shell.openExternal 'https://github.com/simon-johansson/tdd-helper/tree/dev'
, false

$('.quit')[0].addEventListener 'click', ->
  gui.App.quit()
, false

win.on 'blur', ->
  win.hide()

