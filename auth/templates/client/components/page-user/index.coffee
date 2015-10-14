module.exports =
  replace:  true
  template: require('./template')

  data: ->
    updatePath      : '/users/me'
    currentUser     : @$root.$data.currentUser
    changePassword  : false
    passwordOld     : ''
    passwordNew     : ''
    passwordNewCheck: ''
    errorMessage    : ''

  ready: ->
    @$root.$watch 'currentUser', (val) =>
      @$data.currentUser = val
      @checkEmptyMail()

    @checkEmptyMail()

  methods:
    checkEmptyMail: ->
      if $('#email-field .icon.message').is(':visible')
        $('#email', @$el).focus()
      else
        $('#username', @$el).focus()

    onChangePasswordClick: ->
      @$data.changePassword = !@$data.changePassword

      setTimeout =>
        if @$data.changePassword
          $('#password-old', @$el).focus()
        else
          @checkEmptyMail()
      , 100

    onUpdateClick: (e) ->
      @updateRequest() if @validateForm()
      e.preventDefault()

    isValidEmail: (email) ->
      re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
      re.test(email)

    validateForm: ->
      valid = true

      unless @$data.changePassword
        if $.trim(@$data.currentUser.username).length is 0
          valid = false
          $('#username-field', @$el).addClass 'error'

        unless @isValidEmail(@$data.currentUser.email)
          valid = false
          $('#email-field', @$el).addClass 'error'
      else
        if $.trim(@$data.passwordOld).length is 0
          valid = false
          $('#password-old-field', @$el).addClass 'error'

        if $.trim(@$data.passwordNew).length is 0
          valid = false
          $('#password-new-field', @$el).addClass 'error'

        if $.trim(@$data.passwordNewCheck).length is 0
          valid = false
          $('#password-new-check-field', @$el).addClass 'error'

        if @$data.passwordNew isnt @$data.passwordNewCheck
          valid = false
          $('#password-new-check-field', @$el).addClass 'error'

      if valid
        $('.field.error', @$el).removeClass 'error'

      valid

    updateRequest: ->
      data =
        username: @$data.currentUser.username
        email: @$data.currentUser.email

      if @$data.changePassword
        data =
          passwordOld: @$data.passwordOld
          passwordNew: @$data.passwordNew

      $('form', @$el).addClass 'loading'

      $.ajax
        url     : @$data.updatePath
        type    : 'POST'
        dataType: 'json'
        data    : data
        success : @onUpdateSuccess
        error   : @onUpdateError

    resetPasswordFields: ->
      @$data.passwordOld        = ''
      @$data.passwordNew        = ''
      @$data.passwordNewCheck   = ''

    onUpdateSuccess: (res) ->
      @$root.$data.currentUser  = res.user
      @$root.$data.currentToken = res.token

      @resetPasswordFields()
      $('form', @$el).removeClass('loading error').addClass('success')

    onUpdateError: (res) ->
      @$data.errorMessage = res.responseJSON.message or 'Unknown Error.'

      @resetPasswordFields()
      $('form', @$el).removeClass('loading success').addClass('error')

      if @$data.errorMessage is 'Username already exists.'
        $('#username', @$el).focus()
      else
        @checkEmptyMail()

      if @$data.changePassword
        $('#password-old').focus()
