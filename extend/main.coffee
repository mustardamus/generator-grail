yeoman     = require('yeoman-generator')
Handlebars = require('handlebars')
prompts    = require('./prompts')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  configuring: ->
    dirArr     = process.cwd().split('/')
    currentDir = dirArr[dirArr.length - 1]

    @config.answers.name  = currentDir
    @config.answers.tools = {}
    @config.answers.bower = []
    @config.answers.npm   = []

    for tool in @config.answers.extendTools
      toolInfo   = tool.split('|')
      toolSource = toolInfo[0].toLowerCase()
      toolName   = toolInfo[1].toLowerCase()

      @config.answers.tools[toolName] = true
      @config.answers[toolSource].push toolName

  writing: ->
    tools     = @config.answers.tools
    templates = []

    templates.push('client/index.styl') if tools.foundation or tools.fontawesome
    templates.push('client/modules/layout/module.coffee') if tools.ractive
    templates.push('test/client/modules/layout.coffee') if tools.cheerio or tools.ractive

    for file in templates
      content  = @src.read(file)
      template = Handlebars.compile(content)

      @dest.write file, template(@config.answers)

  install:
    bowerInstall: ->
      done = @async()
      @bowerInstall @config.answers.bower, { save: true }, done

    npmInstall: ->
      done = @async()
      @npmInstall @config.answers.npm, { saveDev: true }, done
