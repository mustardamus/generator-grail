Router = require('director').Router

module.exports =
  compiled: ->
    router = new Router
      '': =>
        @$root.$data.currentPage = 'home'

      '/:page': (route) =>
        @$root.$data.currentPage = route

    router.init('/')
