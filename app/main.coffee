yeoman       = require('yeoman-generator')
chalk        = require('chalk')
prompts      = require('./prompts')
templates    = require('./templates')
dependencies = require('./dependencies')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  writing: ->
    files = templates.compile(templates.baseTemplates, @config.answers)

    for file in files
      @dest.write file.fileOut, file.content

    @src.copy 'client/images/favicon.png', 'client/images/favicon.png'

  install: ->
    done      = @async()
    gulpDeps  = dependencies.getGulpDependencies()
    otherDeps = dependencies.otherNpmDependencies

    @npmInstall gulpDeps.concat(otherDeps), { 'save-dev': true }, done

  end: ->
    @log chalk.yellow('\nDone! Now you have a nice development environment you can hack on.')
    @log chalk.yellow('What is next? You can install good tools to start with by running the command:')
    @log chalk.magenta('  yo grail:extend')

    @log chalk.yellow('\nTo create a Module (Script, Style, Template and/or Test) run the command:')
    @log chalk.magenta('  yo grail:create')
