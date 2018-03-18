{% extends 'layout.swig' %} 
{% block content %}
  <div class="container">
    <div class="row">
      <div class="col-md-6"> 
        {% if message %}
        <div class="alert alert-dismissible alert-{{context}}">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          {{ message | raw }}
        </div>
        {% endif %}
        <form action="/jobs" method="POST">
          <input type="hidden" name="lat" id="latitude">
          <input type="hidden" name="long" id="longitude">
          <input type="hidden" name="address" id="address">
          <input type="hidden" name="thumbnailUrl" id="thumbnailUrl">
          <input type="hidden" name="imageUrl" id="imageUrl">
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
                <label class="control-label" for="www">Website</label>
                <div class="form-group">
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text">http(s)://</span>
                    </div>
                    <input type="text" name="www" id="www" class="form-control" aria-label="Website" placeholder="Website">
                  </div>
                </div>
              </div>
            <div class="form-group row">
                    <label for="logo" class="col-sm-2 col-form-label">Logo</label>
                    <div class="col-sm-10">
                      <button id="logoButton" type="button" class="btn btn-secondary">Select</button>
                      <div id="logoWrapper" class="float-right ml-3"></div>
                    </div>
                  </div>
            <div class="form-group">
              <label for="address">Address</label>
              <input placeholder="City, street..." id="autocomplete" type="text" class="form-control" value="">
            </div>
            <div class="form-group">
              <label for="description">Description</label>
              <textarea class="form-control summernote" name="description" id="description" rows="5" placeholder="Description"></textarea>
            </div>
          </fieldset>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  </div>
  <script src="https://widget.cloudinary.com/global/all.js" type="text/javascript"/>

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
    latitudeInput.value = place.geometry.location.lat();
    longitudeInput.value = place.geometry.location.lng();
    addressInput.value = place.formatted_address;
  }

  $(function() {
    $('.summernote').summernote({
        placeholder: 'Job description...',
        tabsize: 2,
        height: 200,
        toolbar: [
          ['style', ['bold', 'italic', 'underline']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['codeview'],
          ['fullscreen']
        ]
      });

      $("#logoButton").click(function() {
        self = this;
        cloudinary.openUploadWidget({ 
          cloud_name: 'dmhmw9a8k', 
          upload_preset: 'zf8tl0pf'
          }, function(error, result) {
            var thumbnailUrl = result[0].thumbnail_url || '';
            var imageUrl = result[0].secure_url || '';
            $(self).text("Change");
            $("#thumbnailUrl").val(thumbnailUrl);
            $("#imageUrl").val(imageUrl);
            $("#logoWrapper").html("<img src='" + thumbnailUrl + "' alt=''>");;
          });
      });
  });

  </script>
{% endblock %}