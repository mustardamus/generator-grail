module.exports =
  replace:  true
  template: require('./template')

  data: ->
    username       : ''
    password       : ''
    passwordCheck  : ''
    registerPath   : '/register'
    successRedirect: '/user'

  ready: ->
    $('input', @$el).first().focus()

  methods:
    onRegisterClick: (e) ->
      @registerRequest() if @validateForm()
      e.preventDefault()

    validateForm: ->
      valid = true

      if $.trim(@$data.username).length is 0
        valid = false
        $('#username-field', @$el).addClass 'error'

      if $.trim(@$data.password).length is 0
        valid = false
        $('#password-field', @$el).addClass 'error'

      if $.trim(@$data.passwordCheck).length is 0 or @$data.password isnt @$data.passwordCheck
        valid = false
        $('#password-check-field', @$el).addClass 'error'

      if valid
        $('.field.error', @$el).removeClass 'error'

      valid

    registerRequest: ->
      $('form', @$el).addClass 'loading'

      $.ajax
        url     : @$data.registerPath
        type    : 'POST'
        dataType: 'json'
        data    : { username: @$data.username, password: @$data.password }
        success : @onRegisterSuccess
        error   : @onRegisterError

    onRegisterSuccess: (res) ->
      $('form', @$el).removeClass 'error loading'

      @$root.$data.currentToken = res.token
      location.hash             = @$data.successRedirect

    onRegisterError: (res) ->
      $('form', @$el).addClass('error').removeClass('loading')
      $('input:first', @$el).first().focus()
