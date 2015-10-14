yeoman     = require('yeoman-generator')
chalk      = require('chalk')
Handlebars = require('handlebars')
bcrypt     = require('bcrypt')

module.exports = yeoman.generators.Base.extend
  writing: ->
    destReadme = @dest.read('README.md')
    srcReadme  = @src.read('README.md')
    filesArr   = [
      'client/components/$layout/index.coffee'
      'client/components/$layout/template.html'
      'client/components/$root/index.coffee'
      'client/components/$root/data.coffee'
      'client/components/page-login/index.coffee'
      'client/components/page-login/style.styl'
      'client/components/page-login/template.html'
      'client/components/page-register/index.coffee'
      'client/components/page-register/style.styl'
      'client/components/page-register/template.html'
      'client/components/page-user/index.coffee'
      'client/components/page-user/style.styl'
      'client/components/page-user/template.html'
      'server/helpers/bcrypt.coffee'
      'server/helpers/token.coffee'
      'server/helpers/validate.coffee'
      'server/middleware/auth.coffee'
      'server/models/user.coffee'
      'server/routes/auth.coffee'
      'server/routes/users.coffee'
    ]

    @dest.write 'README.md', "#{destReadme}\n\n#{srcReadme}"

    for filePath in filesArr
      @src.copy filePath, filePath

    dirArr         = process.cwd().split('/')
    currentDir     = dirArr[dirArr.length - 1]
    configTemplate = Handlebars.compile(@src.read('server/config.coffee'))
    configCompiled = configTemplate({ name: currentDir, secret: bcrypt.genSaltSync(16) })

    @dest.write 'server/config.coffee', configCompiled

  install:
    npmInstall: ->
      done = @async()
      @npmInstall ['bcrypt', 'jsonwebtoken'], { save: true }, done

  end: ->
    @log chalk.yellow('\nAight. Happy logging in!')
