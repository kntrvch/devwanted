// Example model

var mongoose = require('mongoose'),
  passportLocalMongoose = require('passport-local-mongoose'),
  Schema = mongoose.Schema;
  
  
  var User = new Schema({
      username: String,
      password: String
  });
  
  User.plugin(passportLocalMongoose);

  User.methods.validPassword = function(pwd) {
    // EXAMPLE CODE!
    return (this.password === pwd);
  };
  
  module.exports = mongoose.model('User', User);

