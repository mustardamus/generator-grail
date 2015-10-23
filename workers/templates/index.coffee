fs       = require('fs')
mongoose = require('mongoose')
argv     = require('yargs').argv
log      = require('npmlog')
moment   = require('moment')
config   = require('../server/config')

worker = argv.worker

unless worker
  console.log 'Please specify which worker to start with --worker=*'
  return

unless fs.existsSync("#{__dirname}/#{worker}.coffee")
  console.log "Worker '#{worker}.coffee' does not exist."
  return

unless config.workers.intervals[worker]
  console.log "Please specify a interval for the worker '#{worker}' in '../server/config.coffee'."
  return

initDir = (path) ->
  outObj = {}

  for fileName in fs.readdirSync(path)
    funcs = require("#{path}/#{fileName}")
    name  = fileName.split('.')[0]

    if funcs and name
      outObj[name] = funcs
      pathArr      = path.split('/')
      console.log "-> #{pathArr[pathArr.length - 1]}/#{fileName}"

  outObj

helpers = initDir(config.server.helpersDir)
models  = initDir(config.server.modelsDir)
db      = mongoose.connection

for resourceName, modelFunc of models
  models[resourceName] = modelFunc.call(mongoose, helpers)

db.on 'error', ->
  console.log "Can not connect to database #{config.database.url}! 'mongod' running?"

db.once 'open', ->
  console.log "Connected to database #{config.database.url}..."

  Worker     = require("./#{argv.worker}")
  workerCall = ->
    logFunc = (level, message, additional) ->
      time   = moment().format('HH:mm:ss')
      prefix = "[#{time}] - #{worker.toUpperCase()}"

      if additional
        log[level](prefix, message, additional)
      else
        log[level](prefix, message)

    new Worker(config, helpers, logFunc, models)

  setInterval ->
    workerCall()
  , 1000 * 60 * config.workers.intervals[argv.worker]

  workerCall()

mongoose.connect config.database.url
