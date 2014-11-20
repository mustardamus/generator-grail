module.exports =
  replace:  true
  template: require('./template')

  components: {}

  data: ->
    currentPage: ''

  compiled: ->
    @$root.$watch 'currentPage', (page) =>
      @$data.currentPage = page
