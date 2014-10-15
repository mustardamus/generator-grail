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

    for componentPart in @config.answers.componentParts
      content  = @src.read(componentPart)
      template = Handlebars.compile(content)
      destPath = "client/components/#{name}/#{componentPart}"
      content  = template(@config.answers)

      if componentPart is 'test.coffee'
        destPath = "test/client/components/#{name}.coffee"

      @dest.write destPath, content

  end: ->
    name = @config.answers.name

    @log chalk.yellow('\nSweet, everything generated!')

    @log chalk.yellow('\nTo include your Component code do (in ./client/index.coffee or anywhere in your app):')
    @log chalk.magenta("  Component = require('./components/#{name}')")

    @log chalk.yellow('\nThe Component Style is automatically included (in ./client/index.styl):')

    @log chalk.yellow('\nTo include the Component test do (in ./test/client/index.coffee):')
    @log chalk.magenta("  require('./components/#{name}')")
