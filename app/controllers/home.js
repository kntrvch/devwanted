var express = require('express'),
  router = express.Router(),
  mongoose = require('mongoose'),
  Job = mongoose.model('Job');

module.exports = function (app) {
  app.use('/', router);
};

router.get('/', function (req, res, next) {
    res.redirect(301, '/jobs');    
  });

router.get('/jobs', function (req, res, next) {
  Job.find().sort({ created: -1 }).limit(10).exec(function (err, jobs) {
    if (err) return next(err);
    res.render('index', {
      title: 'Job board',
      jobs: jobs, 
      lat: -23.54312,
      long: -46.642748
    });
  });
});

router.post('/nearme', function (req, res, next) {
  
      // Setup limit
      var limit = req.body.limit || 10;
  
      // Default max distance to 10 kilometers
      var maxDistance = req.body.distance || 10;
  
      // Setup coords Object = [ <longitude> , <latitude> ]
      var coords = [];
      // Create the array
      coords[0] = req.body.longitude;
      coords[1] = req.body.latitude;
  
      // find a location
      Job.find({
          'coordinates': {
              $near: {
                  $geometry: {
                      type: "Point",
                      coordinates: coords
                  },
                  // distance to radians
                  $maxDistance: maxDistance * 1609.34, spherical: true
              }
          }
      }).limit(limit).exec(function (err, jobs) {
          if (err) {
              return res.status(500).json(err);
          }
  
          //res.status(200).json(stores);
  
          res.render('index', {
              title: 'Jobs',
              jobs: jobs,
              lat: coords[1],
              long: coords[0],
              distance: maxDistance, 
              formattedAddress: req.body.address
          });
      });
  });

router.get('/jobs/add', function (req, res, next) {
  
      res.render('job-add', {
          title: 'Insert Job'
      });
  });

  router.get('/job/:slug', function (req, res, next) {
        var slug = req.params.slug;
        Job.find({
            'slug': slug
        }, function (err, job) {
            if (err) {
                return res.status(404).json(err);
            }
        
            res.render('job-view', {
                title: job[0].title + ", " + job[0].address + " | devwanted.com",
                job: job[0]
            });
        });
    });

router.post('/jobs', function (req, res, next) {
  var j = {
      email: req.body.email,
      company: req.body.company,
      title: req.body.title,
      description: req.body.description,
      address: req.body.address,
      coordinates: [req.body.long, req.body.lat]
  };
  
  var jobs = new Job(j);

  jobs.save(function(error, item) {
      if (error) {
          return res.status(400).send({
              message: error, 
              context: 'danger',
          });
      }

      res.render('job-add', {
          message: '<b>Success!</b>See your job ad <a href="/job/' + item.slug + '" class="alert-link">here</a>',
          context: 'success',
          obj: item
      });

  });

});
