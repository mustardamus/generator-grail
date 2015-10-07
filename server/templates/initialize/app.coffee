express    = require('express')
bodyParser = require('body-parser')

module.exports = (config, helpers, models) ->
  @use express.static(config.server.publicDir)
  @use bodyParser.json()
