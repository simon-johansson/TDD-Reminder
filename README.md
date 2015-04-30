#tdd-helper

> Status bar application to help reinforce the test-driven development mantra: RED-GREEN-REFACTOR

Only tested on Mac OSX but should work for Windows and Linux as well. Made with [nw.js](http://nwjs.io/).

##Install
Download and install nw.js

```
$ git clone git@github.com:simon-johansson/tdd-helper.git
$ cd tdd-helper
$ /path/to/nw .
```

##Change state from REST interface
The app starts a server (default port is 3000) in the background which accepts POST requests. ...

`curl -H "Content-Type: application/json" -X POST -d '{"state":"refactor"}' http://localhost:3000/




