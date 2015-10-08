define ['jquery'], (jQuery) ->
  window.jQuery = window.$ = jQuery
  fastclick     = require('fastclick')
  Vue           = require('vue')

  if +location.port is 7891
    warning   = -> console.log('No Socket.io Server running')
    window.io = { on: warning, emit: warning }
  else
    window.io = require('socket.io-client')()

  # require('../bower_components/semantic-ui/dist/components/accordion.js')
  # require('../bower_components/semantic-ui/dist/components/checkbox.js')
  # require('../bower_components/semantic-ui/dist/components/dimmer.js')
  # require('../bower_components/semantic-ui/dist/components/dropdown.js')
  # require('../bower_components/semantic-ui/dist/components/embed.js')
  # require('../bower_components/semantic-ui/dist/components/modal.js')
  # require('../bower_components/semantic-ui/dist/components/nag.js')
  # require('../bower_components/semantic-ui/dist/components/popup.js')
  # require('../bower_components/semantic-ui/dist/components/progress.js')
  # require('../bower_components/semantic-ui/dist/components/rating.js')
  # require('../bower_components/semantic-ui/dist/components/search.js')
  # require('../bower_components/semantic-ui/dist/components/shape.js')
  # require('../bower_components/semantic-ui/dist/components/sidebar.js')
  # require('../bower_components/semantic-ui/dist/components/sticky.js')
  # require('../bower_components/semantic-ui/dist/components/tab.js')
  # require('../bower_components/semantic-ui/dist/components/transition.js')

  jQuery ->
    $root = Vue.extend(require('./components/$root'))

    $('<div/>', { id: 'app' }).appendTo 'body'
    new $root({ el: '#app' })

    fastclick(document.body)
