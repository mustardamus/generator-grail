define ['jquery'], (jQuery) ->
  window.jQuery = window.$ = jQuery

  require('../bower_components/foundation/js/foundation/foundation.js')
  require('../bower_components/foundation/js/foundation/foundation.reveal.js')

  fastclick = require('fastclick')
  Vue       = require('vue')
  Layout    = Vue.extend(require('./components/layout'))

  jQuery ->
    $(document).foundation()
    fastclick(document.body)

    layoutEl = $('<div/>', { id: 'app' })

    layoutEl.appendTo 'body'
    new Layout({ el: '#app' })
