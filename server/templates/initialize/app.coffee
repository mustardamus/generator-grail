express    = require('express')
bodyParser = require('body-parser')
session    = require('express-session')

module.exports = (config, helpers, io, models) ->
  @use express.static(config.server.publicDir)
  @use bodyParser.json()
  @use bodyParser.raw({})
  @use bodyParser.urlencoded({ extended: true })
  @use session({ secret: config.session.secret, resave: true, saveUninitialized: true })

  io.on 'connection', (socket) ->
    console.log "Socket.io: User connected - #{socket.id}"

    socket.on 'disconnect', ->
      console.log "Socket.io: User disconnected - #{socket.id}"
