module.exports =
  replace : true
  template: require('./template')
  data    : require('./data')

  components:
    layout: require('../$layout')
    router: require('../$router')

  compiled: ->
    window.data = @$data # to inspect the current state in the browser
    token       = localStorage.getItem('token')

    if(token)
      @$data.currentToken = token
      @ajaxSetup()
      @getCurrentUser()

    @$watch 'currentToken', (token) ->
      if token is null
        @logout()
      else
        localStorage.setItem 'token', token
        @ajaxSetup()
        @getCurrentUser()

    @$watch 'currentPage', (page) ->
      if page is 'logout'
        @$data.currentToken = null
        location.hash       = '/'

  methods:
    ajaxSetup: ->
      $.ajaxSetup
        beforeSend: (jqXHR) =>
          jqXHR.setRequestHeader 'x-access-token', @$data.currentToken

    getCurrentUser: ->
      $.ajax
        url:      '/users/me'
        type:     'GET'
        dataType: 'json'
        success:  (userData) =>
          @$data.loggedIn    = true
          @$data.currentUser = userData
        error: =>
          @$data.loggedIn    = false
          @$data.currentUser = null

    logout: ->
      localStorage.removeItem 'token'
      @$data.loggedIn    = false
      @$data.currentUser = null
