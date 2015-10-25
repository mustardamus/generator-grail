module.exports = class ExampleWorker
  constructor: (@config, @helpers, @log, @models, @doneCb) ->
    @log 'info', 'Keep on... working?'
    @doneCb() # if it only needs to run once, call this to exit process
