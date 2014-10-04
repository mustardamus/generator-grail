module.exports = require('ractive').extend
  template: require('./template')
  data:
    on: false

  init: ->
    @on 'toggle', =>
      @set 'on', !@get('on')
