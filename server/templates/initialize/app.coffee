express    = require('express')
bodyParser = require('body-parser')

module.exports = (models, helpers, config) ->
  @use express.static(config.server.publicDir)
  @use bodyParser.json()
