$      = require('cheerio')
should = require('should')
Module = require('../../../client/modules/{{name}}/module')

{{name}} = new Module

describe '{{name}} Module', ->
  it 'should have the corrent initial data', ->
    {{name}}.data.on.should.equal false

  it 'should have the correct template', ->
    $('.{{name}}', {{name}}.toHTML()).html().should.equal '<span class="on">On</span> <span class="off">Off</span>'

  it 'should toggle the data', ->
    {{name}}.render()
    {{name}}.fire 'toggle'

    {{name}}.data.on.should.equal true
