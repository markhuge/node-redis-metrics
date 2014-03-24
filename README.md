node-redis-metrics [![Build Status](https://secure.travis-ci.org/markhuge/node-redis-metrics.png)](http://travis-ci.org/markhuge/node-redis-metrics)
==================

> Abstraction library for time-series metrics in Node.js JS applications.


## Abstract

This is a collection of redis patterns I've been using in prod. I'm moving them
into their own module for community sharing and collaboration.

Initially the feature set is geared towards my production use cases. I'm happy
to accept issues/PRs for changes that allow for a broader range of use cases.

If you'd like to improve this module, please see the
[contributing](#contributing) section.

## Installation

`npm install redis-metrics`

## Usage

Each abstraction accepts a configuration object at instantiation.

**Options**

- *name* - Base namespace
- *client* - a redis client instance

**Default Values**
```javascript
{
  name  : "metric",
  client: null
}

```

**Example:**

*Multiple instances sharing one redis client*

```coffeescript
redis  = require 'redis'
client = redis.createClient()


{Leaderboard,Counter} = require 'redis-metrics'

postRankings = new Leaderboard
  name: "post_rankings"
  client: client

pageVisits = new Counter
  name: "visits"
  client: client

```


## Metric Types

#### Metric

Metric base class. Provides sugar for date and key namespace


**Methods**

- *key([namespace...])* - returns current namespace. Accepts an optional array
  of namespace tags to update the current namespace.
- *hour()* - returns hour
- *day()* - returns day
- *month()* - returns month
- *year()* - returns year

---

#### BitMap

Extends [Metric](#metric). Provides bitmap metrics, where each item represents a unique offset.

**Methods**

- *set(offset,[callback])* - Set bit at offset
- *unset(offset,[callback])* - Unset bit at offset
- *count(key)* - return population count for key
- *size(key)* - return size for key
- *key([namespace...])* - return namespace based off `this.name`

*Example*:

```coffeescript

foo = new BitMap "page_visits"

app.get '/post/:id', (req,res) ->
  getPostFromDB (err,record) ->
    foo.set record.id
    ...
    res.render 'post', record

```

*Result (assuming record has an ID of '3'):*

```
page_visits:2013:10:01:18 001000
page_visits:2013:10:01    001000
page_visits:2013:10:      001000
page_visits:2013          001000

```

---


#### Counter

Extends [Metric](#metric). Provides a simple counter

---


#### Leaderboard

Extends [Metric](#metric). Provides a named leaderboard


## Contributing

### Conventions

- Each metric abstraction should live in its own file in `src/lib/`
- The file name should match the class name (*ex 'BitMap.coffee'*)
- New abstractions should extend the 'Metric' base class.

### Tests

Pull requests are checked by TravisCI, with a 100% code coverage requirement.

#### Writing Tests

- Tests are located in the `test/` folder.  
- All tests should be in coffeescript
- Tests use [mocha](http://visionmedia.github.io/mocha/) and [chai](http://chaijs.com/)

#### Running Tests

`make test`
