define ['jquery'], (jQuery) ->
  window.jQuery = window.$ = jQuery

  jQuery ->
    for n, initFunc of require('./initialize/*.coffee', { mode: 'hash' })
      initFunc.call @
