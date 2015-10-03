module.exports =
  replace:  true
  template: require('./template')

  components:
    'page-home': require('../page-home')

  data: ->
    currentPage: ''

  compiled: ->
    @$root.$watch 'currentPage', (page) =>
      @$data.currentPage = page

  ready: ->
