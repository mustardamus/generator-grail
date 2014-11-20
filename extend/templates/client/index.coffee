define ['jquery'], (jQuery) ->
  window.jQuery = window.$ = jQuery

  require('../bower_components/foundation/js/foundation/foundation.js')
  require('../bower_components/foundation/js/foundation/foundation.reveal.js')

  fastclick  = require('fastclick')
  Vue        = require('vue')

  jQuery ->
    $root = Vue.extend(require('./components/$root'))

    $('<div/>', { id: 'app' }).appendTo 'body'
    new $root({ el: '#app' })

    $(document).foundation()
    fastclick(document.body)
    
