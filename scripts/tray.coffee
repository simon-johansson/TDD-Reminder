
gui = require('nw.gui')
win = gui.Window.get()

# win.showDevTools()

connectToParent = (parent, port, version) ->
  PageTransitions.init parent
  $('.server-address').text "http://localhost:#{port}"
  $('.version').text "v#{version}"

$('.info')[0].addEventListener 'click', ->
  gui.Shell.openExternal 'https://github.com/simon-johansson/TDD-Reminder/'
, false

$('.quit')[0].addEventListener 'click', ->
  gui.App.quit()
, false

win.on 'blur', ->
  win.hide()

