Router = require('director').Router

module.exports =
  compiled: ->
    router = new Router
      '': =>
        @$root.currentPage = 'home'

      '/:page': (route) =>
        @$root.currentPage = route

    router.init('/')
