node-redis-metrics
==================

> Redis metrics toolkit for Node.js

This module contains abstractions for time-series metrics in Node.js JS applications. 


### Metric Types

#### Metric

Metric base class. Provides sugar for date and key namespace

---

#### Counter

Extends [Metric](#metric). Provides a simple counter

---

#### BitMap

Extends [Metric](#metric). Provides bitmap metrics, where each item represents a unique offset.

*Example*:

```coffeescript

foo = new BitMap "page_visits"

app.get '/post/:id', (req,res) ->
  getPostFromDB (err,record) ->
    foo.set record.id
    res.render 'post', record

```

*Result (assuming record has an ID of '3'):*

```
metric:page_visits:2013:10:01:18 001000
metric:page_visits:2013:10:01    001000
metric:page_visits:2013:10:      001000
metric:page_visits:2013          001000

```

---

#### Leaderboard

Extends [Metric](#metric). Provides a named leaderboard


