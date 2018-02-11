// Example model

var mongoose = require('mongoose'),
  Schema = mongoose.Schema, 
  timeAgo = require('node-time-ago'), 
  CryptoJS = require("crypto-js"),
  slug = require('mongoose-slug-generator');

mongoose.plugin(slug);  

var JobSchema = new Schema({
  email: String,
  title: String,
  company: String,
  description: String,
  imageUrl: String,
  slug: { 
    type: String, 
    slug: ["title", "address"], 
    unique: true,
    index: true 
  },
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
      expires: 3600
  }, 
  deletionKey: { 
    type: String,
    default: "KILL_CODE"
  }, 
  user: { type: Schema.Types.ObjectId, ref: 'User' }
},
{
  timestamps: true
}).index({  
  title: 'text',  
  description: 'text'
});

function stripNumbers(a) {
  if(a != undefined) {
    // removes postal code
    return a.replace(/[0-9]+-[0-9]+/, '').replace(/, [0-9]+/, '');
  }
  return;
}

JobSchema.pre('save', function(next) {
  // generate deletion key
  var baseString = this._id + Date.now();
  this.deletionKey = CryptoJS.SHA256(baseString);

  // slugify
  // var slugBase = this.title + " " + this.company + " " + this.address + " " + this._id;
  // this.slug = slugify(slugBase.toLowerCase());
  next();
});


JobSchema.virtual('date')
  .get(function(){
    return this._id.getTimestamp();
  });

mongoose.model('Job', JobSchema);

