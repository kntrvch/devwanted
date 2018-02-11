{% extends 'layout.swig' %} 
{% block content %}
  <div class="container">
    <div class="row">
      <div class="col-md-12"> 
        {% if message %}
        <div class="alert alert-dismissible alert-success">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>{{ message }}</strong>
        </div>
        {% endif %}
        <div class="row">
          <div class="col-md-9">
            <h1 class="mb-3">{{job.title}}</h1>
          </div>
          <div class="col-md-3" style="background-image:url({{job.imageUrl}});background-position:center;background-size:contain;background-repeat:no-repeat;"></div>
        </div>
        <p class="lead">{{job.company}}</p>
        <strong>{{job.address}}</strong>
        <p class="mt-5">{{job.description | raw}}</p>
        <p class="mt-5"><a href="/jobs" class="card-link btn btn-primary btn-sm">back</a></p>
      </div>
    </div>
  </div>
  <script>
function initAutocomplete() {
};
  </script>
{% endblock %}