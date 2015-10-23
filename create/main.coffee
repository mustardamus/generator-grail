yeoman     = require('yeoman-generator')
Handlebars = require('handlebars')
chalk      = require('chalk')
prompts    = require('./prompts')
_          = require('lodash')
pluralize  = require('pluralize')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done             = @async()
    componentPrompts = prompts.clientComponent

    @prompt prompts.name, (answers) =>
      @config.name = answers.name
      @config.type = answers.componentType

      if answers.componentType is 'server'
        componentPrompts = prompts.serverComponent

      if answers.componentType is 'worker'
        done()
        return

      @prompt componentPrompts, (answers) =>
        @config.answers = answers
        done()

  writing: ->
    name = @config.name
    type = @config.type

    if type is 'worker'
      content  = @src.read("workers/worker.coffee")
      template = Handlebars.compile(content)
      content  = template({ name: "#{_.capitalize(name)}Worker" })

      @dest.write "workers/#{name}.coffee", content
      return

    for componentPart in @config.answers.componentParts
      templateObj = _.extend
        name:       name
        pluralized: pluralize(name)
        modelName:  _.capitalize(name)
      , @config.answers
      content     = @src.read("#{type}/#{componentPart}")
      template    = Handlebars.compile(content)
      content     = template(templateObj)
      destPath    = "client/components/#{name}/#{componentPart}"

      if componentPart is 'test.coffee'
        destPath = "test/client/components/#{name}.coffee"

      if type is 'server'
        switch componentPart
          when 'initialize.coffee'
            destPath = "server/initialize/#{name}.coffee"
          when 'helper.coffee'
            destPath = "server/helpers/#{name}.coffee"
          when 'model.coffee'
            destPath = "server/models/#{name}.coffee"
          when 'route.coffee'
            destPath = "server/routes/#{pluralize(name)}.coffee"

      @dest.write destPath, content

  end: ->
    @log chalk.yellow('\nSweet, everything generated!')

    if @config.type is 'client'
      @log chalk.yellow('\nTo include your Component code do anywhere in your app:')
      @log chalk.magenta("  Component = require('../#{@config.name}')")

      @log chalk.yellow('\nThe Component Style is automatically included (in ./client/index.styl):')

      @log chalk.yellow('\nTo include the Component test do (in ./test/client/index.coffee):')
      @log chalk.magenta("  require('./components/#{@config.name}')")

    if @config.type is 'worker'
      @log chalk.yellow('\nWorker generated. Don\'t forget to specify the interval (in ./server/config.coffee):')
      @log chalk.magenta("  workers:")
      @log chalk.magenta("    intervals:")
      @log chalk.magenta("      #{@config.name}: 15")

      @log chalk.yellow('\nThe start Worker with:')
      @log chalk.magenta("  coffee workers --worker=#{@config.name}")
