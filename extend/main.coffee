yeoman     = require('yeoman-generator')

module.exports = yeoman.generators.Base.extend
  writing: ->
    # append readme to dest readme
    # update index.styl
    # update index.coffee
    # write layout component and test

  install:
    bowerInstall: ->
      done = @async()
      @bowerInstall ['foundation'], { save: true }, done

    npmInstall: ->
      done = @async()
      @npmInstall ['jquery', 'fastclick', 'vue', 'director'], { save: true }, done

    npmDevInstall: ->
      done = @async()
      @npmInstall ['cheerio', 'should'], { saveDev: true }, done
