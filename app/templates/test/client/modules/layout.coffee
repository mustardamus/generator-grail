should = require('should')

Layout = require('../../../client/modules/layout/module')
layout = new Layout

describe 'Layout Module', ->
  it 'should have the correct template', ->
    layout.template.should.equal '<h1>{{name}}</h1>\n'
