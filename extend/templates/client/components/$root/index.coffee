module.exports =
  replace:  true
  template: require('./template')
  data:     require('./data')

  components:
    layout: require('../$layout')
    router: require('../$router')

  compiled: ->
    window.data   = @$data # to inspect the current state in the browser

  methods: {}
