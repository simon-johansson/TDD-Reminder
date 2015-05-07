http       = require 'http'
path       = require 'path'
express    = require 'express'
bodyParser = require 'body-parser'

module.exports = (port) ->

  app    = express()
  router = express.Router()

  app.set 'port', port
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: false)

  router.post '/', (req, res, next) ->
    state = req.body.state
    if typeof state != 'undefined'
      if ['red', 'green', 'refactor'].indexOf(state.toLowerCase()) > -1
        global.setPhase state
        res.send "State set to #{state}"
      else next new Error('Error - possible states are "red", "green" and "refactor"')
    else next new Error('Error - no state supplied in post body')

  app.use '/', router

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next err

  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.json
      message: err.message
      error: err

  server = http.createServer(app)
  server.listen port
