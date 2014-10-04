module.exports = require('ractive').extend
  el: 'body'
  template: require('./template')

  init: ->
    console.log 'lets get started', @toHTML()
