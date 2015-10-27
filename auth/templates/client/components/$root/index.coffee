module.exports =
  replace : true
  template: require('./template')
  data    : require('./data')

  ready: ->
    @setHomeActiveState()

    token = localStorage.getItem('token')

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

    window.onhashchange = =>
      if location.hash is '#!/logout'
        @$data.currentToken = null
        location.hash       = '#!/'

  methods:
    setHomeActiveState: -> # small hack to remove persistent 'active' class
      homeEl = $('#header a.item.home', @$el)

      if $('#header a.active', @$el).length > 1
        homeEl.removeClass 'active'

      window.onhashchange = ->
        if location.hash isnt '#!/'
          homeEl.removeClass 'active'

    ajaxSetup: ->
      $.ajaxSetup
        beforeSend: (jqXHR) =>
          jqXHR.setRequestHeader 'x-access-token', @$data.currentToken

    getCurrentUser: ->
      @$ajax 'get', '/users/me', (err, userData) ->
        if err
          @$data.loggedIn    = false
          @$data.currentUser = null
        else
          @$data.loggedIn    = true
          @$data.currentUser = userData

    logout: ->
      localStorage.removeItem 'token'
      @$data.loggedIn    = false
      @$data.currentUser = null
