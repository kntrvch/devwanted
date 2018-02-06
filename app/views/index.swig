{% extends 'layout.swig' %}

{% block content %}
  <div class="container-fluid">
    <div class="row">
<div class="col-md-12">
                <form action="/nearme" method="POST" class="form-inline filter">

                <label for="address" class="sr-only">Address</label>
                            <input placeholder="City, street..." name="address" id="address" type="text" class="form-control-lg mb-2 mr-sm-2" value="">
                   

              <label for="latitude" class="sr-only">Latitude</label>
                            <input placeholder="Insert latitude" name="latitude" id="latitude" type="hidden" class="form-control-lg mb-2 mr-sm-2" value="">
                            
           <label for="longitude" class="sr-only">Longitude</label>
                            <input placeholder="Insert Longitude" name="longitude" id="longitude" type="hidden" class="form-control-lg mb-2 mr-sm-2" value="">
                            
           <!--<label for="distance" class="sr-only">Distance</label>
                            <select name="distance" id="distance" class="form-control mb-2 mr-sm-2">
                                <option value="" disabled selected>Distance</option>
                                <option value="0.2">200 m</option>
                                <option value="2">2 Km</option>
                                <option value="3">3 km</option>
                                <option value="9">9 km</option>
                            </select>-->
                            <div class="col-md-3">
                              <input type="text" name="distance" id="distance" value="">
                            </div>
                        <div class="input-group">
                          <button class="btn-lg btn-primary mb-2" type="submit" name="action">Search</button>
                          <div class="input-group-append ml-2 mb-2">
                            <div class="loader-inline">
                              <span>/</span><span>/</span>
                            </div>
                          </div>
                        </div>
                </form>
                <br>
            </div>
    </div>
    <div class="row">
      <div class="col-lg-4">
        <div class="bs-component">
          <div id="jobs" class="nano">
            <div class="nano-content">
              <div class="list-group">
                {% for item in jobs %}
                  <a href="#" class="pan-to-marker list-group-item list-group-item-action flex-column align-items-start" data-marker-index="{{loop.index}}">
                    <div class="d-flex w-100 justify-content-between">
                      <h5 class="mb-1">{{item.title}}</h5>
                      <small class="text-muted">{{item.created}}</small>
                    </div>
                    <strong>{{item.company}}</strong>
                    <p class="mb-1">{{item.description}}</p>
                      <small class="text-muted">Donec id elit non mi porta.</small>
                  </a>
                {% endfor %}
              </div>
              <div id="source-button" class="btn btn-primary btn-xs" style="display: none;">&lt; &gt;</div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-8">
        <div id="map" style="height: 600px; width: 100%; margin-bottom: 20px">
          <div class="loader">
            <span>/</span><span>/</span>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
            <div id="job-info" class="bs-component p-3">
              <h2 id="job-title">Example body text</h2>
              <div id="job-description">Nullam quis risus eget <a href="#">urna mollis ornare</a> vel eu leo. 
              Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam id dolor id nibh ultricies vehicula.</div>
    
            </div>

          </div>
    </div>
  </div>
  <script type="text/javascript">
    var userLatitude, userLongitude;
    var latitudeInput = document.getElementById('latitude');
    var longitudeInput = document.getElementById('longitude');

  var geocoder = new google.maps.Geocoder();

  document.getElementById('address').addEventListener('keyup', function() {
    geocodeAddress(geocoder);
  });


function geocodeAddress(geocoder) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === 'OK') {
      console.log(results[0]);
      latitudeInput.value = results[0].geometry.location.lat();
      longitudeInput.value = results[0].geometry.location.lng();
      console.log(latitudeInput.value + " | " +longitudeInput.value);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

    function getCurrentPosition() {
        // Check boreswer/navigator support       
        if (navigator.geolocation) {
            var options = {
                enableHighAccuracy: true,
                timeout: Infinity,
                maximumAge: 0
            };
            navigator.geolocation.watchPosition(getUserPosition, trackError, options);
        } else {
            alert('Ops; Geolocation is not supported');
        }
        // Get user position and place a icon on map       
        function getUserPosition(position) {
            // Check longitude and latitude    
            latitudeInput.value = userLatitude = position.coords.latitude;
            longitudeInput.value = userLongitude = position.coords.longitude;
        }
        // Setup a error function         
        function trackError(error) {
            var err = document.getElementById('map');
            switch (error.code) {
                case error.PERMISSION_DENIED:
                    err.innerHTML = "User denied Geolocation.";
                    break;
                case error.POSITION_UNAVAILABLE:
                    err.innerHTML = "Information is unavailable.";
                    break;
                case error.TIMEOUT:
                    err.innerHTML = "Location timed out.";
                    break;
                case error.UNKNOWN_ERROR:
                    err.innerHTML = "An unknown error.";
                    break;
            }
        }
    }
    getCurrentPosition();

    var loadMap = function () {
        // Center map with current lat and long (Simulated with fixed point for this example)
        var googlePos = new google.maps.LatLng(userLatitude, userLongitude);
        // Setup map options
        var mapOptions = {
            zoom: 12,
            center: googlePos,
            mapTypeId: google.maps.MapTypeId.ROADMAP, 
            styles: [
              {
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#f5f5f5"
                  }
                ]
              },
              {
                "elementType": "labels.icon",
                "stylers": [
                  {
                    "visibility": "off"
                  }
                ]
              },
              {
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#616161"
                  }
                ]
              },
              {
                "elementType": "labels.text.stroke",
                "stylers": [
                  {
                    "color": "#f5f5f5"
                  }
                ]
              },
              {
                "featureType": "administrative.land_parcel",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#bdbdbd"
                  }
                ]
              },
              {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#eeeeee"
                  }
                ]
              },
              {
                "featureType": "poi",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#757575"
                  }
                ]
              },
              {
                "featureType": "poi.business",
                "stylers": [
                  {
                    "visibility": "off"
                  }
                ]
              },
              {
                "featureType": "poi.park",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#e5e5e5"
                  }
                ]
              },
              {
                "featureType": "poi.park",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              },
              {
                "featureType": "road",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#ffffff"
                  }
                ]
              },
              {
                "featureType": "road.arterial",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#757575"
                  }
                ]
              },
              {
                "featureType": "road.highway",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#dadada"
                  }
                ]
              },
              {
                "featureType": "road.highway",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#616161"
                  }
                ]
              },
              {
                "featureType": "road.local",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              },
              {
                "featureType": "transit.line",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#e5e5e5"
                  }
                ]
              },
              {
                "featureType": "transit.station",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#eeeeee"
                  }
                ]
              },
              {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#c9c9c9"
                  }
                ]
              },
              {
                "featureType": "water",
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#9e9e9e"
                  }
                ]
              }
            ]
        };
        // Set a variable to get the HTML div
        var mapObj = document.getElementById('map');
        var googleMap = new google.maps.Map(mapObj, mapOptions);
        // Create markers array to hold all markers on map
        var markers = [];
        var bounds = new google.maps.LatLngBounds();
        // Using the Swig loop to get all data from location variable
        {% for item in jobs %}
        // Setup a lat long object
        var latLng = new google.maps.LatLng({{ item.coordinates[1] }}, {{ item.coordinates[0] }});
        // Create a marker
        var marker = new google.maps.Marker({
            map: googleMap,
            zoom: 13,
            position: latLng,
            animation: google.maps.Animation.DROP
        });

        bounds.extend(marker.getPosition());
        markers.push(marker);
        // Setup the info window
        var infowindow = new google.maps.InfoWindow();
        // Add an event listener to click on each marker and show an info window
        google.maps.event.addListener(marker, 'click', function () {
            // using the tittle from the Swig looping
            infowindow.setContent('<p>' + " {{ item.title }} " + '</p>');
            infowindow.open(googleMap, this);
        });
        google.maps.event.addListener(marker, 'click', function () {
            markers.forEach(function (element) {
                element.setAnimation(null);
            }, this);
            if (this.getAnimation() !== null) {
                this.setAnimation(null);
            } else {
                this.setAnimation(google.maps.Animation.BOUNCE);
            }
        });

    {% endfor %}
    googleMap.fitBounds(bounds);
    // get all the pan-to-marker class
    var els = document.querySelectorAll(".pan-to-marker");
    // looping over all list elements
    
    for (var i = 0, len = els.length; i < len; i++) {
        els[i].addEventListener("click", function (e) {
            [].forEach.call(els, function(el) {
                el.classList.remove("active");
            });
            this.className += " active";
            e.preventDefault();
            // Use -1 for index because loop.index from swig starts on 1
            var attr = this.getAttribute('data-marker-index') - 1;
            // get longitude and latitude of the marker
            var latitude = markers[attr].getPosition().lat();
            var longitude = markers[attr].getPosition().lng();
            // Center map and apply zoom
            googleMap.setCenter({ lat: latitude, lng: longitude });
            googleMap.setZoom(18);
            markers.forEach(function (element) {
                element.setAnimation(null);
            }, this);
            markers[attr].setAnimation(google.maps.Animation.BOUNCE);

        });
    }
    };
    // load the map function
    window.onload = loadMap;

</script>
{% endblock %}
