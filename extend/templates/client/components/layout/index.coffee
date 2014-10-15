Router = require('director').Router

module.exports =
  replace:  true
  template: require('./template')

  components: {} # define components here, in the template <div v-component=""/>

  data:
    welcome: 'Move fast. Get shit done.'

  ready: ->
    router = new Router
      '/:page': (route) ->
        console.log 'do something on route', route

    router.init()
