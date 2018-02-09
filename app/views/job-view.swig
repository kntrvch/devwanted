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
        <h1>{{job.title}}</h1>
        <p class="lead">{{job.address}}</p>
        <p class="mt-5">{{job.description}}</p>
      </div>
    </div>
  </div>
  <script>
function initAutocomplete() {
};
  </script>
{% endblock %}