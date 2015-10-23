yeoman = require('yeoman-generator')
chalk  = require('chalk')

module.exports = yeoman.generators.Base.extend
  writing: ->
    destReadme = @dest.read('README.md')
    srcReadme  = @src.read('README.md')
    destConfig = @dest.read('server/config.coffee')
    srcConfig  = @src.read('config.coffee')
    filesArr   = ['index.coffee', 'example.coffee']

    @dest.write 'README.md', "#{destReadme}\n\n#{srcReadme}"
    @dest.write 'server/config.coffee', "#{destConfig}\n#{srcConfig}"

    for filePath in filesArr
      @src.copy filePath, "workers/#{filePath}"

  install:
    npmInstall: ->
      done = @async()
      @npmInstall ['npmlog', 'moment', 'yargs'], { save: true }, done

  end: ->
    @log chalk.yellow('\nDone. Let\'s work it!')
