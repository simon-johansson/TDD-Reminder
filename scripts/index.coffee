
gui    = require 'nw.gui'
states = require '../scripts/states.js'

port   = process.env.TDD_REMINDER_PORT or 22789
require('../scripts/server')(port)

win             = gui.Window.get()
trayWindowShown = no
currentIndex    = 0

tray = new gui.Tray
  icon: states.get(0).icon
  iconsAreTemplates: no

trayWindow = gui.Window.open 'tray.html',
  width: 340
  height: 240
  frame: no
  toolbar: no
  show: no
  resizable: no
  transparent: yes
  'visible-on-all-workspaces': yes

trayWindow.on 'loaded', ->
  trayWindow.window.connectToParent win, port
trayWindow.on 'focus', ->
  trayWindowShown = yes
trayWindow.on 'blur', ->
  trayWindowShown = no

changeTrayIcon = (currentIndex) ->
  tray.icon = states.get(currentIndex).icon

global.setPhase = (state) ->
  currentIndex = states.getIndex(state)
  trayWindow.window.PageTransitions.nextPage currentIndex
  changeTrayIcon(currentIndex)

showWindow = (position) ->
  if !trayWindowShown
    position.x -= Math.floor(trayWindow.width / 2 - 12)
    trayWindow.moveTo position.x, position.y + 1
    trayWindow.show()
    trayWindow.focus()
  else
    trayWindow.hide()

tray.on 'click', showWindow


