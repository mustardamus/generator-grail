module.exports =
  server:
    port:          7799
    publicDir:     "#{__dirname}/../public"
    initializeDir: "#{__dirname}/initialize"
    helpersDir:    "#{__dirname}/helpers"
    routesDir:     "#{__dirname}/routes"
    modelsDir:     "#{__dirname}/models"

  database:
    url: 'mongodb://localhost/{{name}}'
