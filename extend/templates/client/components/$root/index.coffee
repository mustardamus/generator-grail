module.exports =
  replace : true
  template: require('./template')
  data    : require('./data')

  ready: ->
    # small hack to remove persistent 'active' class on home link
    window.onhashchange = ->
      if location.hash isnt '#!/'
        $('#header a.home', @$el).removeClass 'active'
