{expect} = require 'chai'

redis  = require 'redis'
client = redis.createClient()


{ BitMap
  Counter
  Metric
  Leaderboard } = require '../build/'

before (done) ->
  client.flushdb (err) ->
    if err then done err
    done()

describe "Metric", ->
  it "Handles variable arguments in Metric.exec()", (done) ->
    metric = new Metric
      client    : client
      name      : "test:variable:args"
      intervals : ["day"]
    metric.exec "zincrby", 1, "foo", (err,res)->
      expect(err).to.equal null
      expect(res).to.be.an 'array'
      expect(res).to.have.length 1
      done()

  it "Changes namespace with Metric.key()", ->
    metric = new Metric
      client : client
      name   : "basename"
    key = metric.key "new:name"
    expect(key).to.equal "basename:new:name"
    

describe "BitMap", ->
  it "Sets item in bitmap", (done) ->
    bitmap = new BitMap
      client: client
      name  : "test"
    bitmap.set 5, (err,res) ->
      if err then done err
      expect(err).to.equal null
      expect(res).to.be.an 'array'
      expect(res).to.have.length 4
      done()

  it "Unsets item in bitmap", (done) ->
    bitmap = new BitMap
      client: client
      name  : "test"
    bitmap.unset 5, (err,res) ->
      if err then done err
      expect(err).to.equal null
      expect(res).to.be.an 'array'
      expect(res).to.have.length 4
      done()


describe "Counter", ->
  it "Creates a new counter", (done) ->
    done()

describe "Leaderboard", ->
  it "Creates a new leaderboard", (done) ->
    done()
