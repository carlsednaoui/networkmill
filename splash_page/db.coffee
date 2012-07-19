mongo = require 'mongodb'

# full production url
# -------------------
# mongodb://nodejitsu:6d24d538466ddfe74238f15b2ccac68f@staff.mongohq.com:10092/nodejitsudb984036870057

db = new mongo.Db 'nodejitsudb984036870057', new mongo.Server('staff.mongohq.com', 10092, {auto_reconnect: true}), {}
db.open (err, client) ->
  db.authenticate 'nodejitsu', '6d24d538466ddfe74238f15b2ccac68f', (err) ->
    throw err if err
    collection = new mongo.Collection db, 'emails'

# test development database setup
# -------------------------------
# db = new mongo.Db 'networkmill', new mongo.Server('127.0.0.1', 27017, {})
# db.open (err, client) ->
#   throw err if (err)
#   collection = new mongo.Collection client, 'emails'

exports.db = db