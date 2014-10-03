fs         = require('fs')
Handlebars = require('handlebars')

module.exports =
  baseTemplates: [
    { fileIn: '_package.json', fileOut: 'package.json' }
    { fileIn: '_bower.json', fileOut: 'bower.json' }
    { fileIn: '_gitignore', fileOut: '.gitignore' }
    { fileIn: 'gulpfile.js' } # if no fileOut then use same filename
    { fileIn: 'README.md' }
    { fileIn: 'client/index.html' }
    { fileIn: 'client/index.coffee' }
    { fileIn: 'client/index.styl' }
    { fileIn: 'client/modules/layout/template.html' }
    { fileIn: 'client/modules/layout/module.coffee' }
    { fileIn: 'client/modules/layout/style.styl' }
    { fileIn: 'test/client/index.coffee' }
    { fileIn: 'test/client/modules/layout.coffee' }
  ]

  compile: (files, config) ->
    outFiles = []

    for file in files
      file.fileOut = file.fileIn unless file.fileOut
      content      = fs.readFileSync("#{__dirname}/templates/#{file.fileIn}", 'utf8')
      template     = Handlebars.compile(content)
      file.content = template(config)

      outFiles.push file

    outFiles
