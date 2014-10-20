yeoman = require('yeoman-generator')
chalk  = require('chalk')

module.exports = yeoman.generators.Base.extend
  writing: ->
    destReadme = @dest.read('README.md')
    srcReadme  = @src.read('README.md')
    filesArr   = [
      'client/index.coffee'
      'client/index.styl'
      'client/components/layout/index.coffee'
      'client/components/layout/style.styl'
      'client/components/layout/template.html'
      'test/client/index.coffee'
      'test/client/components/layout.coffee'
    ]

    @dest.write 'README.md', "#{destReadme}\n\n#{srcReadme}"

    for filePath in filesArr
      @src.copy filePath, filePath

  install:
    bowerInstall: ->
      done = @async()
      @bowerInstall ['foundation', 'fontawesome'], { save: true }, done

    npmInstall: ->
      done = @async()
      @npmInstall ['jquery', 'fastclick', 'vue', 'director'], { save: true }, done

    npmDevInstall: ->
      done = @async()
      @npmInstall ['cheerio', 'should'], { saveDev: true }, done

  end: ->
    @log chalk.yellow('\nSweet, everything installed and generated!')
