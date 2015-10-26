$         = require('cheerio')
should    = require('should')
component = require('../../../client/components/$root')

describe '$root Component', ->
  it 'should have a template to start with', ->
    templateEl = $(component.template)

    templateEl.hasClass('layout').should.ok
