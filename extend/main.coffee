yeoman = require('yeoman-generator')
chalk  = require('chalk')

module.exports = yeoman.generators.Base.extend
  writing: ->
    destReadme = @dest.read('README.md')
    srcReadme  = @src.read('README.md')
    filesArr   = [
      'client/index.coffee'
      'client/index.styl'
      'client/components/$root/index.coffee'
      'client/components/$root/data.coffee'
      'client/components/$root/template.html'
      'client/components/$root/style.styl'
      'client/components/$root/colors.styl'
      'client/components/$router/index.coffee'
      'client/components/page-home/index.coffee'
      'client/components/page-home/style.styl'
      'client/components/page-home/template.html'
      'test/client/index.coffee'
      'test/client/components/$root.coffee'
    ]

    @dest.write 'README.md', "#{destReadme}\n\n#{srcReadme}"

    for filePath in filesArr
      @src.copy filePath, filePath

  install:
    bowerInstall: ->
      done = @async()
      @bowerInstall ['semantic-ui'], { save: true }, done

    npmInstall: ->
      done = @async()
      @npmInstall ['jquery', 'fastclick', 'vue', 'vue-router', 'socket.io-client'], { save: true }, done

    npmDevInstall: ->
      done = @async()
      @npmInstall ['cheerio', 'should'], { saveDev: true }, done

  end: ->
    @log chalk.yellow('\nSweet, everything installed and generated!')
