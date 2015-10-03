module.exports =
  replace:  true
  template: require('./template')
  data:     require('./data')

  components:
    layout: require('../$layout')
    router: require('../$router')

  compiled: ->
    window.data   = @$data  # to inspect the current state in the browser
    forwardEvents = [       # events that should be broadcasted to all components
      'event:name'
    ]

    for eventName in forwardEvents
      @forwardEvent eventName

  methods:
    forwardEvent: (eventName) ->
      @$on eventName, (data) ->
        @$broadcast eventName, data
