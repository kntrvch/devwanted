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
          <input type="hidden" name="lat" id="latitude">
          <input type="hidden" name="long" id="longitude">
          <input type="hidden" name="address" id="address">
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
            <div class="form-group">
              <label for="company">Company</label>
              <input type="text" class="form-control" name="company" id="company" placeholder="Company">
            </div>
            <div class="form-group">
              <label for="address">Address</label>
              <input placeholder="City, street..." id="autocomplete" type="text" class="form-control" value="">
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
  <script>
    var latitudeInput = document.getElementById('latitude');
    var longitudeInput = document.getElementById('longitude');
    var addressInput = document.getElementById('address');


function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
  (document.getElementById('autocomplete')),
  {types: ['geocode']});
  autocomplete.addListener('place_changed', getAddress);
};

  function getAddress() {
    var place = autocomplete.getPlace();
    console.log(place);
    latitudeInput.value = place.geometry.location.lat();
    longitudeInput.value = place.geometry.location.lng();
    addressInput.value = place.formatted_address;
  }

  </script>
{% endblock %}