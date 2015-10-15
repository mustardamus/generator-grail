define ['jquery'], (jQuery) ->
  window.jQuery = window.$ = jQuery
  fastclick     = require('fastclick')
  Vue           = require('vue')

  # comment this out if you don't plan to use socket.io
  if +location.port is 7891
    warning   = -> console.log('No Socket.io Server running')
    window.io = { on: warning, emit: warning }
  else
    window.io = require('socket.io-client')()

  # require('../bower_components/semantic/dist/components/accordion.js')
  # require('../bower_components/semantic/dist/components/checkbox.js')
  # require('../bower_components/semantic/dist/components/dimmer.js')
  # require('../bower_components/semantic/dist/components/dropdown.js')
  # require('../bower_components/semantic/dist/components/embed.js')
  # require('../bower_components/semantic/dist/components/modal.js')
  # require('../bower_components/semantic/dist/components/nag.js')
  # require('../bower_components/semantic/dist/components/popup.js')
  # require('../bower_components/semantic/dist/components/progress.js')
  # require('../bower_components/semantic/dist/components/rating.js')
  # require('../bower_components/semantic/dist/components/search.js')
  # require('../bower_components/semantic/dist/components/shape.js')
  # require('../bower_components/semantic/dist/components/sidebar.js')
  # require('../bower_components/semantic/dist/components/sticky.js')
  # require('../bower_components/semantic/dist/components/tab.js')
  # require('../bower_components/semantic/dist/components/transition.js')

  jQuery ->
    $root = Vue.extend(require('./components/$root'))

    $('<div/>', { id: 'app' }).appendTo 'body'
    new $root({ el: '#app' })

    fastclick(document.body)
