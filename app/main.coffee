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

    @log chalk.yellow('\nTo create a Express Node.js server (with Lodash and Mongoose):')
    @log chalk.magenta('  yo grail:server')

    @log chalk.yellow('\nTo create a registration/authentication boilerplate for the Server:')
    @log chalk.magenta('  yo grail:auth')

    @log chalk.yellow('\nTo create a continues Worker boilerplate (with Mongoose):')
    @log chalk.magenta('  yo grail:workers')

    @log chalk.yellow('\nTo create a Component (Client/Server/Worker) run the command:')
    @log chalk.magenta('  yo grail:create')
