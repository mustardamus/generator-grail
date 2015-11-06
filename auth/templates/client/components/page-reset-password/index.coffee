module.exports =
  replace:  true
  template: require('./template')

  data: ->
    token        : @$route.params.token
    errorMessage : ''
    password     : ''
    passwordCheck: ''
    username     : ''
    resetted     : false

  ready: ->
    $('input', @$el).first().focus()

  methods:
    onResetClick: ->
      @resetRequest() if @validateForm()

    validateForm: ->
      valid = true

      if $.trim(@$data.password).length is 0
        valid = false
        $('#password-field', @$el).addClass 'error'

      if $.trim(@$data.passwordCheck).length is 0 or @$data.password isnt @$data.passwordCheck
        valid = false
        $('#password-check-field', @$el).addClass 'error'

      if valid
        $('.field.error', @$el).removeClass 'error'

      valid

    resetRequest: ->
      $('form', @$el).addClass 'loading'

      data = { password: @$data.password, token: @$data.token }

      @$ajax 'post', '/reset-password', data, (err, response) ->
        if err
          $('form', @$el).addClass('error').removeClass('loading')
          $('input', @$el).first().focus()

          @$data.errorMessage = err.responseJSON.message
        else
          $('form', @$el).removeClass 'error loading'

          @$root.$data.currentToken = null
          @$data.username           = response.username
          @$data.resetted           = true
