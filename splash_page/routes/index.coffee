# This is the controller

db = require('../db').db.collection('emails')

exports.index = (req, res) -> 
  res.render 'index', { title: 'NetworkMill' }

exports.add = (req, res) ->
  db.update req.body, req.body, upsert: true
  res.send 'success!'

# console.log 'running locally' if process.env.USER == 'jeff'
# exports.list = (req, res) ->
#   db.find().toArray (err, docs) ->
#     res.render 'list', { title: 'Email List', records: docs }