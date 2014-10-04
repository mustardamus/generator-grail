yeoman     = require('yeoman-generator')
Handlebars = require('handlebars')
chalk      = require('chalk')
prompts    = require('./prompts')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  writing: ->
    name = @config.answers.name

    for modulePart in @config.answers.moduleParts
      content  = @src.read(modulePart)
      template = Handlebars.compile(content)
      destPath = "client/modules/#{name}/#{modulePart}"
      content  = template(@config.answers)
      content  = content.split('<<').join('{{')
      content  = content.split('>>').join('}}') # >:)

      if modulePart is 'test.coffee'
        destPath = "test/client/modules/#{name}.coffee"

      @dest.write destPath, content

  end: ->
    name = @config.answers.name

    @log chalk.yellow('\nSweet, everything generated!')

    @log chalk.yellow('\nTo include your Module code do (in ./client/index.coffee or anywhere in your app):')
    @log chalk.magenta("  Module = require('./#{name}/module')")

    @log chalk.yellow('\nTo include your Module style do (in ./client/index.styl):')
    @log chalk.magenta("  @import './modules/#{name}/style'")

    @log chalk.yellow('\nTo include the Module test do (in ./test/client/index.coffee):')
    @log chalk.magenta("  require('./modules/#{name}')")
