{% extends 'layout.swig' %} 
{% block content %}
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-6"> 
        {% if message %}
        <div class="alert alert-dismissible alert-success">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>{{ message }}</strong>
        </div>
        {% endif %}
        <form action="/jobs" method="POST">
        <fieldset>
            <legend>Add new job</legend>
            <div class="form-group">
              <label for="exampleInputEmail1">Email address</label>
              <input type="email" class="form-control" name="email" id="email" aria-describedby="emailHelp" placeholder="Enter email">
            </div>
            <div class="form-group">
              <label for="title">Title</label>
              <input type="text" class="form-control" name="title" id="title" placeholder="Title">
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="lat">Latitude</label>
                  <input type="text" class="form-control" name="lat" id="lat" placeholder="Latitude">
                </div>
                </div>
                <div class="col-md-6">
                <div class="form-group">
                  <label for="long">Longitude</label>
                  <input type="text" class="form-control" name="long" id="long" placeholder="Longitude">
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="description">Description</label>
              <textarea class="form-control" name="description" id="description" rows="5" placeholder="Description"></textarea>
            </div>
          </fieldset>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  </div>
{% endblock %}