module.exports = (cfg, helpers, io, models) ->
  config = cfg.auth
  msgs   = config.messages

  @post config.loginPath, (req, res, next) ->
    models.user.findOne { username: req.body.username }, (err, user) ->
      return next(err) if(err)
      return res.status(403).json({ message: msgs.userNotFound }) unless(user)

      unless helpers.bcrypt.compareSync(req.body.password, user.password)
        return res.status(403).json({ message: msgs.wrongPassword })

      res.json({ token: helpers.token.sign(user, config.secret) })

  @post config.registerPath, (req, res, next) ->
    return res.status(403).json({ message: msgs.usernameMissing }) unless(req.body.username)
    return res.status(403).json({ message: msgs.passwordMissing }) unless(req.body.password)

    models.user.findOne { username: req.body.username }, (err, user) ->
      return next(err) if(err)
      return res.status(403).json({ message: msgs.usernameExists }) if(user)

      salt = helpers.bcrypt.genSaltSync(config.saltLength)
      user = new models.user
        username: req.body.username
        password: helpers.bcrypt.hashSync(req.body.password, salt)

      user.save (err) ->
        return next(err) if(err)
        res.json({ token: helpers.token.sign(user, config.secret) })

  @post config.forgotPasswordPath, (req, res, next) ->
    return res.status(403).json({ message: msgs.emailMissing }) unless(req.body.email)

    models.user.findOne { email: req.body.email }, (err, user) ->
      return next(err) if(err)
      return res.status(403).json({ message: msgs.userNotFound }) unless(user)

      now       = (new Date()).getTime()
      resetObj  = { username: user.username, requestedAt: now }
      token     = helpers.token.sign(resetObj, config.secret, { expiresIn: config.resetTokenExpiresIn })
      port      = if req.hostname is 'localhost' then ":#{cfg.server.port}" else ''
      resetLink = "#{req.protocol}://#{req.hostname}#{port}/#!/reset-password/#{token}"
      emailText = msgs.resetEmailBodyText(resetLink)
      emailHtml = msgs.resetEmailBodyHtml(resetLink)

      helpers.email.sendTextHtml cfg.mailgun.fromEmail, user.email, msgs.resetEmailSubject, emailText, emailHtml, (err) ->
        if err
          res.status(403).json({ message: msgs.sendEmailFailed })
        else
          res.json({ success: true })

  @post config.resetPasswordPath, (req, res, next) ->
    return res.status(403).json({ message: msgs.invalidToken }) unless(req.body.token)
    return res.status(403).json({ message: msgs.passwordMissing }) unless(req.body.password)

    helpers.token.verify req.body.token, config.secret, (err, decoded) ->
      return res.status(403).json({ message: msgs.invalidToken }) if(err)

      models.user.findOne { username: decoded.username }, (err, user) ->
        return next(err) if(err)
        return res.status(403).json({ message: msgs.userNotFound }) unless(user)

        salt = helpers.bcrypt.genSaltSync(config.saltLength)

        user.update { password: helpers.bcrypt.hashSync(req.body.password, salt) }, (err) ->
          return next(err) if(err)

          res.json({ username: decoded.username })
