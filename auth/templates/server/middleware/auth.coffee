module.exports = (config, helpers) ->
  return (req, res, next) ->
    token = req.headers['x-access-token']

    unless(token)
      return res.status(403).send({ message: config.auth.messages.noToken })

    helpers.token.verify token, config.auth.secret, (err, user) ->
      return res.status(403).send({ message: config.auth.messages.invalidToken }) if(err)

      req.user = user
      next()
