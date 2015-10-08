express    = require('express')
bodyParser = require('body-parser')

module.exports = (config, helpers, io, models) ->
  @use express.static(config.server.publicDir)
  @use bodyParser.json()

  io.on 'connection', (socket) ->
    console.log "Socket.io: User connected - #{socket.id}"

    socket.on 'disconnect', ->
      console.log "Socket.io: User disconnected - #{socket.id}"
