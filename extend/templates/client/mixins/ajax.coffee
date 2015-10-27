module.exports =
  methods:
    $ajax: (type, url, data, opt, cb) ->
      self = @

      if typeof data is 'function'
        cb   = data
        data = {}
        opt  = {}

      if typeof opt is 'function'
        cb  = opt
        opt = {}

      ajaxObj =
        type       : type
        url        : url
        dataType   : 'json'
        data       : data
        success    : (res) => cb.call(self, null, res)
        error      : (res) => cb.call(self, res)

      $.ajax $.extend(ajaxObj, opt)
