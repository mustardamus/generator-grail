module.exports =
  server:
    port         : 7799
    publicDir    : "#{__dirname}/../public"
    initializeDir: "#{__dirname}/initialize"
    helpersDir   : "#{__dirname}/helpers"
    routesDir    : "#{__dirname}/routes"
    modelsDir    : "#{__dirname}/models"

  database:
    url: 'mongodb://localhost/{{name}}'

  session:
    secret: '{{sessionSecret}}'

  auth:
    loginPath          : '/login'
    registerPath       : '/register'
    forgotPasswordPath : '/forgot-password'
    resetPasswordPath  : '/reset-password'
    secret             : '{{authSecret}}'
    saltLength         : 10
    resetTokenExpiresIn: '30m'

    messages  :
      userNotFound   : 'Can not find user.'
      wrongPassword  : 'Wrong password.'
      usernameMissing: 'Username missing.'
      passwordMissing: 'Password missing.'
      usernameExists : 'Username already exists.'
      emailExists    : 'E-Mail already exists.'
      emailMissing   : 'Provide a E-Mail address.'
      invalidEmail   : 'Invalid E-Mail address.'
      noToken        : 'No token provided.'
      invalidToken   : 'Invalid token.'
      sendEmailFailed: 'Failed sending E-Mail.'

      resetEmailSubject : 'Reset your Password'
      resetEmailBodyText: (resetLink) ->
        "Hey! You've requested to reset your password. Please follow the link below to do so: \n\n#{resetLink}"
      resetEmailBodyHtml: (resetLink) ->
        "Hey! You've requested to reset your password. Please <a href='#{resetLink}'>follow this link</a> to do so."

  mailgun:
    domain   : '[mailgun domain from settings]'
    apiKey   : '[mailgun api key from settings]'
    fromEmail: 'grail@mail.com'
