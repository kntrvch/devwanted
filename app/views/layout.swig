<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <title>{{ title }}</title>
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.3/flatly/bootstrap.min.css" rel="stylesheet" integrity="sha384-+lmTKXkS+c9d34U9obDdGOZT7zqFicJDkhckYYsW7oenXR37T2OEV4uqfUO45M87" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.nanoscroller/0.8.7/css/nanoscroller.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.2.0/css/ion.rangeSlider.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.2.0/css/ion.rangeSlider.skinHTML5.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/font/css/open-iconic.min.css" />
  <link rel="stylesheet" href="/css/style.css">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>

  <script src="/js/map-style.js"></script>

  {% if ENV_DEVELOPMENT %}
    <script src="http://localhost:35729/livereload.js"></script>
  {% endif %}
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
  <a class="navbar-brand" href="/"><b>// dev wanted</b></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav ml-auto mr-5">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/jobs">Jobs</a>
      </li>
    </ul>
    <div class="my-2 my-lg-0">
       <a class="btn btn-success my-2 my-sm-0" href="/jobs/add">Add job</a>
    </div>
  </div>
</nav>
  {% block content %}
  {% endblock %}
<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">© 2017-2018 Company Name</p>
        <ul class="list-inline">
          <li class="list-inline-item"><a href="#">Privacy</a></li>
          <li class="list-inline-item"><a href="#">Terms</a></li>
          <li class="list-inline-item"><a href="#">Support</a></li>
        </ul>
      </footer>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAeSC88-apO9P8jhGfxAUqHj9kjJ5Mp6BQ&libraries=places&callback=initAutocomplete&language=en&region=US" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nanoscroller/0.8.7/javascripts/jquery.nanoscroller.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.2.0/js/ion.rangeSlider.min.js"></script>
<script>
  $(function(){
    $(".nano").nanoScroller();
  });
</script>
</body>
</html>
