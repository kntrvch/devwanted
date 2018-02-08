// Example model

var mongoose = require('mongoose'),
  Schema = mongoose.Schema, 
  timeAgo = require('node-time-ago'), 
  CryptoJS = require("crypto-js");

var JobSchema = new Schema({
  email: String,
  title: String,
  company: String,
  description: String,
  address: {
    type: String,
    get: stripNumbers
  },
  coordinates: {
    type: [Number],
    index: '2dsphere'
  },
  created: {
      type: Date,
      default: Date.now, 
      get: timeAgo, 
      expires: 30*24*3600
  }, 
  deletionKey: { 
    type: String,
    default: "KILL_CODE"
  }
});

function stripNumbers(a) {
  if(a != undefined) {
    // removes postal code
    return a.replace(/[0-9]{2}-[0-9]{3}/, '');
  }
  return;
}

JobSchema.pre('save', function(next) {
  var baseString = this._id + Date.now();
  this.deletionKey = CryptoJS.SHA256(baseString);
  next();
});


JobSchema.virtual('date')
  .get(function(){
    return this._id.getTimestamp();
  });

mongoose.model('Job', JobSchema);

