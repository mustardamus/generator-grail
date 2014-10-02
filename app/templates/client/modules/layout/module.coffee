module.exports = class Layout
  template: require('./template')

  constructor: ->
    if typeof document isnt 'undefined'
      document.body.innerHTML = @template
