module.exports =
  replace : true
  template: require('./template')
  data    : require('./data')

  ready: ->
    @setHomeActiveState()

  methods:
    setHomeActiveState: -> # small hack to remove persistent 'active' class
      homeEl = $('#header a.item.home', @$el)

      if $('#header a.active', @$el).length > 1
        homeEl.removeClass 'active'

      window.onhashchange = ->
        if location.hash isnt '#!/'
          homeEl.removeClass 'active'
