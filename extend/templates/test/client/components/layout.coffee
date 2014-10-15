$         = require('cheerio')
should    = require('should')
component = require('../../../client/components/layout')

describe 'layout Component', ->
  it 'should have a template to start with', ->
    templateEl = $(component.template)

    templateEl.hasClass('layout').should.ok
    templateEl.find('h1').text().should.equal '{{welcome}}'

  it 'should have data to start with', ->
    component.data.welcome.should.equal 'Move fast. Get shit done.'
