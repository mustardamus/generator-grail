SocketIO = require('socket.io-client')

module.exports = ->
  if +location.port is 7891
    warning   = -> console.log('No Socket.io Server running')
    window.io = { on: warning, emit: warning }
  else
    window.io = SocketIO()
