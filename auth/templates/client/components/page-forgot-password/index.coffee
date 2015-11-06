module.exports =
  replace:  true
  template: require('./template')

  data: ->
    errorMessage: ''
    email       : ''

  methods:
    onResetClick: ->
      @resetRequest() if @validateForm()

    isValidEmail: (email) ->
      re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
      re.test(email)

    validateForm: ->
      valid = true

      if $.trim(@$data.email).length is 0 or !@isValidEmail(@$data.email)
        valid = false
        $('#email-field', @$el).addClass 'error'

      if valid
        $('.field.error', @$el).removeClass 'error'

      valid

    resetRequest: ->
      $('form', @$el).addClass 'loading'

      @$ajax 'post', '/forgot-password', { email: @$data.email }, (err, response) ->
        if err
          $('form', @$el).addClass('error').removeClass('loading success')
          $('input', @$el).first().focus()

          @$data.errorMessage = err.responseJSON.message
        else
          $('form', @$el).removeClass('error loading').addClass 'success'
