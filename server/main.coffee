yeoman     = require('yeoman-generator')
chalk      = require('chalk')
Handlebars = require('handlebars')

module.exports = yeoman.generators.Base.extend
  writing: ->
    destReadme = @dest.read('README.md')
    srcReadme  = @src.read('README.md')
    filesArr   = [
      'helpers/app.coffee'
      'models/count.coffee'
      'routes/app.coffee'
      'initialize/app.coffee'
      'index.coffee'
    ]
    dirArr         = process.cwd().split('/')
    currentDir     = dirArr[dirArr.length - 1]
    configTemplate = Handlebars.compile(@src.read('config.coffee'))
    configCompiled = configTemplate({ name: currentDir })

    @dest.write 'server/config.coffee', configCompiled
    @dest.write 'README.md', "#{destReadme}\n\n#{srcReadme}"

    for filePath in filesArr
      @src.copy filePath, "server/#{filePath}"

  install:
    npmInstall: ->
      done = @async()
      @npmInstall ['express', 'body-parser', 'lodash', 'mongoose', 'socket.io'], { save: true }, done

  end: ->
    @log chalk.yellow('\nSweet, everything installed and generated!')
