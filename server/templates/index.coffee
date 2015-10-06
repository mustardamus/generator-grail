express    = require('express')
fs         = require('fs')
lodash     = require('lodash')
mongoose   = require('mongoose')
config     = require('./config')

initDir = (path) ->
  outObj   = {}
  filesArr = fs.readdirSync(path)

  for fileName in filesArr
    funcs = require("#{path}/#{fileName}")
    name  = fileName.split('.')[0]

    if funcs and name
      outObj[name] = funcs
      console.log "Initialized '#{lodash.last(path.split('/'))}/#{fileName}'"

  outObj

app       = express()
helpers   = initDir(config.server.helpersDir)
helpers._ = lodash
routes    = initDir(config.server.routesDir)
models    = initDir(config.server.modelsDir)
inits     = initDir(config.server.initializeDir)
db        = mongoose.connection

for resourceName, modelFunc of models
  models[resourceName] = modelFunc.call(mongoose, helpers)

for resourceName, routesFunc of routes
  routesFunc.call(app, models, helpers, config)

for initName, initFunc of inits
  initFunc.call(app, models, helpers, config)

app.listen(config.server.port)
console.log "Webserver started on port #{config.server.port}..."

db.once 'open', ->
  console.log "Connected to database #{config.database.url}"

db.on 'error', ->
  console.log "Oops, can not connect to database #{config.database.url}"

mongoose.connect config.database.url
