module.exports =
  replace:  true
  template: require('./template')

  data: ->
    username       : ''
    password       : ''
    loginPath      : '/login'
    successRedirect: '/user'

  ready: ->
    $('input', @$el).first().focus()

  methods:
    onLoginClick: (e) ->
      @loginRequest() if @validateForm()
      e.preventDefault()

    validateForm: ->
      valid = true

      if $.trim(@$data.username).length is 0
        valid = false
        $('#username-field', @$el).addClass 'error'

      if $.trim(@$data.password).length is 0
        valid = false
        $('#password-field', @$el).addClass 'error'

      if valid
        $('.field.error', @$el).removeClass 'error'

      valid

    loginRequest: ->
      $('form', @$el).addClass 'loading'

      $.ajax
        url     : @$data.loginPath
        type    : 'POST'
        dataType: 'json'
        data    : { username: @$data.username, password: @$data.password }
        success : @onLoginSuccess
        error   : @onLoginError

    onLoginSuccess: (res) ->
      $('form', @$el).removeClass 'error loading'

      @$root.$data.currentToken = res.token
      location.hash             = @$data.successRedirect

    onLoginError: (res) ->
      $('form', @$el).addClass('error').removeClass('loading')
      $('input', @$el).first().focus()
