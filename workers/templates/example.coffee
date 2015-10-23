module.exports = class ExampleWorker
  constructor: (@config, @helpers, @log, @models) ->
    @log 'info', 'Keep on... working?'
