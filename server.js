var http = require('http');
var path = require('path');

var express = require('express');
var bodyParser = require('body-parser');

var app = express();
var router = express.Router();

var port = process.env.PORT || 3000;
app.set('port', port);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// /* GET home page. */
router.post('/', function(req, res, next) {
  var state = req.body.state;
  if(typeof state !== 'undefined') {
    if(['red', 'green', 'refactor'].indexOf(state.toLowerCase()) > -1){
      global.setState(state);
      res.send('State set to ' + state);
    } else {
      next(new Error('Error - possible states are "red", "green" and "refactor"'));
    }
  } else {
    next(new Error('Error - no state supplied in post body'));
  }
});

app.use('/', router);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});


// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.json({
    message: err.message,
    error: err
  });
});

var server = http.createServer(app);
server.listen(port);
