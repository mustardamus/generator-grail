yeoman       = require('yeoman-generator')
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
    @log 'what is next? write sub-generators.'
