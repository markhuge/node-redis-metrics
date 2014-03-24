_ = require 'lodash'

class Metric
  constructor: (options = {}) ->
    _.defaults options,
      name  : "metric"
      type  : "generic"
      client: null
    {@type,@name,@client} = options


  key: (namespace...) ->
    if namespace
     @name + ":" + namespace.join(":")
    else
     @name + ":"

  hour  : do -> new Date().getHours()
  day   : do -> new Date().getDate()
  month : do -> new Date().getMonth()
  year  : do -> new Date().getFullYear()

module.exports = Metric
