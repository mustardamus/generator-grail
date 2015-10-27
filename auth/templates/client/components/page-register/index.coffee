module.exports =
  replace:  true
  template: require('./template')

  data: ->
    username     : ''
    password     : ''
    passwordCheck: ''

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

      data = { username: @$data.username, password: @$data.password }

      @$ajax 'post', '/register', data, (err, response) ->
        if err
          $('form', @$el).addClass('error').removeClass('loading')
          $('input:first', @$el).first().focus()
        else
          $('form', @$el).removeClass 'error loading'

          @$root.$data.currentToken = response.token
          location.hash             = '#!/user'
