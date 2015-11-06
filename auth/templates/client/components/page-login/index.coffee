module.exports =
  replace:  true
  template: require('./template')

  data: ->
    username: ''
    password: ''

  ready: ->
    $('input', @$el).first().focus()

  methods:
    onLoginClick: ->
      @loginRequest() if @validateForm()

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

      data = { username: @$data.username, password: @$data.password }

      @$ajax 'post', '/login', data, (err, response) ->
        if err
          $('form', @$el).addClass('error').removeClass('loading')
          $('input', @$el).first().focus()
        else
          $('form', @$el).removeClass 'error loading'

          @$root.$data.currentToken = response.token
          location.hash             = '#!/user'
