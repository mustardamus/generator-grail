Vue       = require('vue')
VueRouter = require('vue-router')

module.exports = ->
  Vue.use(VueRouter)
  Vue.mixin(require('../mixins/ajax'))

  $root   = Vue.extend(require('../components/$root'))
  $router = new VueRouter({ linkActiveClass: 'active' })

  $('<div/>', { id: 'app' }).appendTo 'body'
  $router.map require('../routes')
  $router.start $root, '#app'
