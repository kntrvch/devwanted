// Example model

var mongoose = require('mongoose'),
  passportLocalMongoose = require('passport-local-mongoose'),
  Schema = mongoose.Schema, 
  bcrypt = require('bcrypt-nodejs');


var User = new Schema({
  username: String,
  password: String
});

User.plugin(passportLocalMongoose);

module.exports = mongoose.model('User', User);

