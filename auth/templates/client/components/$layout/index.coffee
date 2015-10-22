module.exports =
  replace:  true
  template: require('./template')

  components:
    'page-home'    : require('../page-home')
    'page-login'   : require('../page-login')
    'page-user'    : require('../page-user')
    'page-register': require('../page-register')

  data: ->
    currentPage: ''
    loggedIn   : @$root.$data.loggedIn
    currentUser: @$root.$data.currentUser or { username: 'You' }

  compiled: ->
    @$root.$watch 'currentPage', (page) =>
      @$data.currentPage = page

    @$root.$watch 'loggedIn', (val) =>
      @$data.loggedIn = val

    @$root.$watch 'currentUser', (val) =>
      @$data.currentUser = val

  ready: ->
