
# Load native UI library
gui = require('nw.gui')
states = require('./scripts/states.js')
# require('./server');

currentIndex = 0
# Create a tray icon
tray = new gui.Tray
  icon: states[0].icon
  iconsAreTemplates: false

getIndex = (state) ->
  index = undefined
  states.forEach (el, i) ->
    if el.phase is state
      index = i
  index

changeparentmethod = ->
  console.log 'Called & Came main window'
  setState()

window.setState = (state) ->
  if typeof state != 'undefined'
    currentIndex = getIndex(state)
  else
    currentIndex = if currentIndex >= 2 then 0 else currentIndex + 1
  tray.icon = states[currentIndex].icon
  # menu.items[0].label = states[currentIndex].label;

# global.getState = function () {
#   return states[currentIndex];
# };
win = gui.Window.get()
tryWindowShown = false
trayWindow = gui.Window.open 'tray.html',
  width: 340
  height: 305
  frame: false
  toolbar: false
  show: false
  resizable: false
  transparent: true
  'visible-on-all-workspaces': true

trayWindow.on 'loaded', ->
  console.log 'came loaded testpop'
  trayWindow.window.haveParent win

trayWindow.on 'focus', ->
  tryWindowShown = true

trayWindow.on 'blur', ->
  tryWindowShown = false

iconWidth = 12

showWindow = (position) ->
  if !tryWindowShown
    position.x -= Math.floor(trayWindow.width / 2 - iconWidth)
    trayWindow.moveTo position.x, position.y + 1
    trayWindow.show()
    trayWindow.focus()
  else
    trayWindow.hide()

tray.on 'click', showWindow
