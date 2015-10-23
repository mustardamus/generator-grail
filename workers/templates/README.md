## Workers

You can use Workers to run a continues process outside of the Server. They are
located in `./workers`. The loader for worker is `./workers/index.coffee`, it
passes the config, helpers, a log function and the models to the Worker.

The filename of the worker is also the name of the worker, for example lets
assume you have a worker `./workers/example.coffee`:

    module.exports = class ExampleWorker
      constructor: (@config, @helpers, @log, @models) ->
        @log 'info', 'Keep on... working?'

The interval in which the Worker is executed must be defined
`./server/config.coffee` (where all the other configs for the Worker are also
located):

    workers:
      intervals: # in minutes
        example: 15

Then you would start it with:

    coffee workers --worker=example
    # or with forever on the production server
