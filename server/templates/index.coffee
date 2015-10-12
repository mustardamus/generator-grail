fs      = require('fs')
http    = require('http')
express = require('express')
socket  = require('socket.io')
config  = require('./config')

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

app       = express()
server    = http.Server(app)
io        = socket(server)
helpers   = initDir(config.server.helpersDir)
routes    = initDir(config.server.routesDir)
inits     = initDir(config.server.initializeDir)
models    = {}
modelsDir = config.server.modelsDir

if fs.existsSync(modelsDir) and fs.readdirSync(modelsDir).length
  mongoose = require('mongoose')
  models   = initDir(modelsDir)
  db       = mongoose.connection

  for resourceName, modelFunc of models
    models[resourceName] = modelFunc.call(mongoose, helpers)

  db.once 'open', ->
    console.log "Connected to database #{config.database.url}..."

  db.on 'error', ->
    console.log "Can not connect to database #{config.database.url}! 'mongod' running?"

  mongoose.connect config.database.url
  
for initName, initFunc of inits
  initFunc.call(app, config, helpers, io, models)

for resourceName, routesFunc of routes
  routesFunc.call(app, config, helpers, io, models)

server.listen config.server.port, ->
  console.log "\nWebserver started on port #{config.server.port}..."
