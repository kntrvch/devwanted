var express = require('express');
var glob = require('glob');

var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var compress = require('compression');
var methodOverride = require('method-override');
var session = require('express-session');
var swig = require('swig');
var passport = require('passport'),
  User = require('../app/models/user'),
  LocalStrategy = require('passport-local').Strategy,
  flash = require('connect-flash');

module.exports = function (app, config) {
  var env = process.env.NODE_ENV || 'development';
  app.locals.ENV = env;
  app.locals.ENV_DEVELOPMENT = env == 'development';

  app.engine('swig', swig.renderFile);
  if (env == 'development') {
    app.set('view cache', false);
    swig.setDefaults({ cache: false });
  }
  app.set('views', config.root + '/app/views');
  app.set('view engine', 'swig');

  // app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use(logger('dev'));
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use(cookieParser());
  app.use(compress());
  app.use(express.static(config.root + '/public'));
  app.use(methodOverride());
  app.use(session({
    secret: 'abcdefg',
    resave: true,
    saveUninitialized: false
  }));
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(flash());

  app.use(function (req, res, next) {
    if (req.user) {
      res.locals.username = req.user.username;
      res.locals.loggedIn = true;
    } else {
      res.locals.loggedIn = false;
    }
    next();
  });

  var controllers = glob.sync(config.root + '/app/controllers/*.js');
  controllers.forEach(function (controller) {
    require(controller)(app);
  });

  app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
  });

  if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
      res.status(err.status || 500);
      res.render('error', {
        message: err.message,
        error: err,
        title: 'error'
      });
    });
  }

  app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: {},
      title: 'error'
    });
  });

  // passport config


  passport.serializeUser(User.serializeUser());
  passport.deserializeUser(User.deserializeUser());

  passport.use('local-register', new LocalStrategy({
    // by default, local strategy uses username and password, we will override with email
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true // allows us to pass back the entire request to the callback
  },
    function (req, username, password, done) {

      // find a user whose email is the same as the forms email
      // we are checking to see if the user trying to login already exists
      User.findOne({ 'username': username }, function (err, user) {
        // if there are any errors, return the error

        if (err)
          return done(err);

        // check to see if theres already a user with that email
        if (user) {
          return done(null, false, req.flash('error', 'That email is already taken.'));
        } else {

          User.register(new User({ username: username }), password, function (err, user) {
            if (err)
              throw err;
            return done(null, user);
          });
        }

      });

    }));

  passport.use('local-login', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
  }, function (req, username, password, done) {
    var authenticate = User.authenticate();
    authenticate(username, password, function (err, authenticated) {
      if (!authenticated) {
        return done(null, false, {
          message: 'Incorrect username or password.'
        });
      } else {
        return done(null, authenticated);
      }

    });
  }));

};
