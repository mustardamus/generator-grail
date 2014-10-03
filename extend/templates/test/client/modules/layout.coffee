$      = require('cheerio')
should = require('should')

Layout = require('../../../client/modules/layout/module')
layout = new Layout

describe 'Layout Module', ->
  it 'should have the correct template', ->
    $('h1', layout.template).text().should.equal 'grailtest'
