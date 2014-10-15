fs   = require('fs')
path = require('path')

module.exports =
  getGulpDependencies: -> # parse gulpfile for dependencies
    content = fs.readFileSync "#{__dirname}/templates/gulpfile.js", 'utf8'
    lines   = content.split('\n')
    deps    = []

    for line in lines
      reqArr = line.split('require(')

      if reqArr.length is 2
        dep = reqArr[1].split(')')[0].split("'").join('')
        deps.push dep if dep.length

    deps

  otherNpmDependencies: [ # dependencies needed but not required in gulpfile
    # 'should'
  ]
