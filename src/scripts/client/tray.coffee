
gui = require('nw.gui')
win = gui.Window.get()

haveParent = (theParent) ->
  console.log 'came haveParent'
  parentwindowcontrol theParent

parentwindowcontrol = (parentwindow) ->
  console.log 'came parentwindowcontrol'
  PageTransitions.init parentwindow

$('.quit')[0].addEventListener 'click', ->
  gui.App.quit()
, false

win.on 'blur', ->
  win.hide()

