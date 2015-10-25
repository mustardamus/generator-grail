## Workers

You can use Workers to run a continues process outside of the Server. They are
located in `./workers`. The loader for worker is `./workers/index.coffee`, it
passes the config, helpers, a log function and the models to the Worker.

The filename of the worker is also the name of the worker, for example lets
assume you have a worker `./workers/example.coffee`:

    module.exports = class ExampleWorker
      constructor: (@config, @helpers, @log, @models, @doneCb) ->
        @log 'info', 'Keep on... working?'
        @doneCb() # if it only needs to run once, call this to exit process

The interval in which the Worker is executed must be defined
`./server/config.coffee` (where all the other configs for the Worker are also
located):

    workers:
      intervals: # in minutes
        example: 15

Then you would start it with:

    coffee workers --worker=example
    # or with forever on the production server

If the Worker has its own interval cycle or only needs to be run once, pass the
`--once` flag like this:

    coffee worker --worker=example --once

The Worker is initialized with a `@doneCB` function. Call this function to exit
the process and disconnect the Worker from the database.
