module.exports =
  replace:  true
  template: require('./template')

  components: {}

  data: ->
    currentPage: ''

  ready: ->
    @$root.$watch 'currentPage', (page) =>
      @$data.currentPage = page
