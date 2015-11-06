Mailgun      = require('mailgun-js')
mailcomposer = require('mailcomposer')
config       = require('../config')

hasConfig = ->
  if !config.mailgun or !config.mailgun.domain or !config.mailgun.apiKey
    console.log 'Can\t send e-mails. Specify domain and API Key for MailGun in ./server/config.coffee'
    return false

  return true

module.exports =
  sendTextHtml: (from, to, subject, text, html, cb = ->) ->
    return unless hasConfig()

    mailgun = Mailgun({ apiKey: config.mailgun.apiKey, domain: config.mailgun.domain })
    mail    = mailcomposer({ from: from, to: to, subject: subject, body: text, html: html })

    mail.build (err, message) ->
      return cb(err) if(err)

      mailgun.messages().sendMime { to: to, message: message.toString('ascii') }, (err, body) ->
        if err
          cb(err)
        else
          cb(null, body)
