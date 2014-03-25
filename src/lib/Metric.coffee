_ = require 'lodash'

class Metric
  constructor: (options = {}) ->
    _.defaults options,
      name      : "metric"
      type      : "generic"
      client    : null
      intervals : ["hour","day","month","year"]
    {@type,@name,@client,@intervals} = options

    @_metrics =
      hour  : "#{@name}:h:#{@year}:#{@month}:#{@day}:#{@hour}"
      day   : "#{@name}:d:#{@year}:#{@month}:#{@day}"
      month : "#{@name}:m:#{@year}:#{@month}"
      year  : "#{@name}:y:#{@year}"



  key: (namespace...) ->
    if namespace
      @name = @name + ":" + namespace.join(":")
    @name


  hour  : do -> new Date().getHours()
  day   : do -> new Date().getDate()
  month : do -> new Date().getMonth()
  year  : do -> new Date().getFullYear()

  exec: (command,args...,callback) ->
    multi = @client.multi()
    multi[command](@_metrics[int],args...) for int in @intervals
    multi.exec callback


module.exports = Metric
