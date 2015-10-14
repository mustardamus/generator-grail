module.exports = (config, helpers, io, models) ->
  config = config.auth
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
