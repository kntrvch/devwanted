var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: 'jobboard'
    },
    port: process.env.PORT || 3000,
    db: 'mongodb://localhost/jobboard-development'
  },

  test: {
    root: rootPath,
    app: {
      name: 'jobboard'
    },
    port: process.env.PORT || 3000,
    db: 'mongodb://localhost/jobboard-test'
  },

  production: {
    root: rootPath,
    app: {
      name: 'jobboard'
    },
    port: process.env.PORT || 3000,
    db: 'mongodb://user1:password1@ds115749.mlab.com:15749/jobboard'
  }
};

module.exports = config[env];
