module.exports = (config, helpers, io, models) ->
  auth = require('../middleware/auth')(config, helpers)
  msgs = config.auth.messages

  @get '/users/me', auth, (req, res) ->
    delete req.user.password
    res.json req.user

  @post '/users/me', auth, (req, res, next) ->
    models.user.findById req.user._id, (err, user) ->
      return next(err) if(err)

      toGo        = 0
      errors      = 0
      usernameNew = req.body.username
      emailNew    = req.body.email
      passwordOld = req.body.passwordOld
      passwordNew = req.body.passwordNew

      errDone = (message) ->
        errors++
        if errors is 1 # only send one error at a time
          res.status(403).json({ message: message })

      done = ->
        if toGo is 0
          user.save (err) ->
            return next(err) if(err)

            delete user.password
            token = helpers.token.sign(user, config.auth.secret)

            res.json { user: user, token: token }

      if usernameNew and usernameNew.length isnt 0 and usernameNew isnt user.username
        toGo++

        models.user.findOne { username: usernameNew }, (err, userFound) ->
          return next(err) if(err)
          return errDone(msgs.usernameExists) if(userFound)

          user.username = usernameNew
          toGo--
          done()

      if emailNew and emailNew.length isnt 0 and emailNew isnt user.email
        unless helpers.validate.email(emailNew)
          return errDone(msgs.invalidEmail)

        toGo++

        models.user.findOne { email: emailNew }, (err, userFound) ->
          return next(err) if(err)
          return errDone(msgs.emailExists) if(userFound)

          user.email = emailNew
          toGo--
          done()

      if passwordOld and passwordOld.length isnt 0 and passwordNew and passwordNew.length isnt 0
        unless helpers.bcrypt.compareSync(passwordOld, user.password)
          return errDone(msgs.wrongPassword)

        salt          = helpers.bcrypt.genSaltSync(config.auth.saltLength)
        user.password = helpers.bcrypt.hashSync(passwordNew, salt)
        done()
      else
        done() # if nothing has changed, just return
