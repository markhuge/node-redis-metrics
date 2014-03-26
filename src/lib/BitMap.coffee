Metric = require './Metric'
_      = require 'lodash'

class BitMap extends Metric
  constructor: (options = {}) ->
    _.defaults options,
      type: "BitMap"
    super options

  _setbit: (offset, value, callback) ->
    @exec "setbit", offset, value, callback

  set: (offset, callback) ->
    @_setbit offset, 1, callback

  unset: (offset, callback) ->
    @_setbit offset, 0, callback

  count: (namespace...) ->
    key = namespace.join(":")
    @client.bitcount key
  #
  # size: (namespace...) ->
  #   key = namespace.join(":")
  #   @client.get key

module.exports = BitMap
