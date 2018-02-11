{% extends 'layout.swig' %} 
{% block content %}
  <div class="container">
    <div class="row">
      <div class="col-md-12"> 
      <h1 class="page-header">My jobs</h1>
      <table class="table table-hover mt-5">
        <thead>
          <tr>
            <th>#</th>
            <th>Title</th>
            <th>Company</th>
            <th>Location</th>
            <th>Date added</th>
          </tr>
        </thead>
        <tbody>
          {% for item in jobs %}
            <tr>
              <td>{{loop.index}}.</td>
              <td><a href="/job/{{item.slug}}" target="_blank">{{item.title}}</a></td>
              <td>{{item.company}}</td>
              <td>{{item.address}}</td>
              <td>{{item.createdAt|date('d-m-Y')}}</td>
            </tr>
          {% endfor %}
        </tbody>
      </table>
      </div>
    </div>
  </div>
  <script>
function initAutocomplete() {
};
  </script>
{% endblock %}