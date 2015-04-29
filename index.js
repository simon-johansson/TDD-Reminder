
// Load native UI library
var gui = require('nw.gui');
var states = require('./states');

// require('./server');

var currentIndex = 0;

// Create a tray icon
var tray = new gui.Tray({
  icon: states[0].icon,
  iconsAreTemplates: false,
  // click: function () {
  //   tray.icon = states[currentIndex].icon;
  //   currentIndex = currentIndex >= states.length - 1 ? 0 : currentIndex + 1;
  // }
});

function getIndex (state) {
  var index;
  states.forEach(function (el, i) {
    if (el.phase === state) index = i;
  });
  return index;
}

window.setState = function(state){
  if (typeof state !== 'undefined') {
    currentIndex = getIndex(state);
  } else {
    currentIndex = currentIndex >= 2 ? 0 : currentIndex + 1;
  }
  tray.icon = states[currentIndex].icon;
  // menu.items[0].label = states[currentIndex].label;
};

// global.getState = function () {
//   return states[currentIndex];
// };


var win = gui.Window.get();

var tryWindowShown = false;
var trayWindow = gui.Window.open('tray.html', {
  width: 340,
  height: 305,
  frame: false,
  toolbar: false,
  show: false,
  resizable: false,
  transparent : true,
  'visible-on-all-workspaces': true
});

trayWindow.on('loaded', function(){
    console.log('came loaded testpop');
    trayWindow.window.haveParent(win);
});
function changeparentmethod(){
    console.log('Called & Came main window');
    setState();
}

trayWindow.on('focus', function(){
  tryWindowShown = true;
});

trayWindow.on('blur', function(){
  tryWindowShown = false;
});


var iconWidth = 12;

var showWindow = function(position) {
  if (!tryWindowShown){
    position.x -= Math.floor((trayWindow.width/2)-iconWidth);

    trayWindow.moveTo(position.x, position.y+1);

    trayWindow.show();
    trayWindow.focus();

  } else {
   trayWindow.hide();
  }
};

trayWindow.name = 'simon'

tray.on('click', showWindow);
