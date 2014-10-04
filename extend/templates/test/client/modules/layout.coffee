$      = require('cheerio')
should = require('should')

Layout = require('../../../client/modules/layout/module')
layout = new Layout

describe 'Layout Module', ->
  it 'should have the correct template', ->
    {{#if tools.ractive}}
    $('h1', layout.toHTML()).text().should.equal '{{name}}'
    {{else}}
    $('h1', layout.template).text().should.equal '{{name}}'
    {{/if}}
