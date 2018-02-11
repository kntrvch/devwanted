{% extends 'layout.swig' %} 
{% block content %}
  <div class="container">
    <div class="row justify-content-md-center">
      <div class="col-md-5"> 
        {% if message %}
        <div class="alert alert-dismissible alert-{{context}}">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>{{ message }}</strong>
        </div>
        {% endif %}
        <form action="/register" method="post">
         <fieldset>
            <legend>Register</legend>
            <div class="form-group">
                <label for="usernameInput">Username</label>
                <input id="usernameInput" type="text" name="username" class="form-control"/>
            </div>
            <div class="form-group">
                <label for="passwordInput">Password</label>
                <input id="passwordInput" type="password" name="password" class="form-control"/>
            </div>
            </fieldset>
            <input type="submit" value="Register" class="btn btn-primary"/>
        </form>
      </div>
    </div>
  </div>
  <script>
function initAutocomplete() {
};
  </script>
{% endblock %}