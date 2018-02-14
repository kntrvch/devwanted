{% extends 'layout.swig' %} 
{% block content %}
  <div class="container">
    <div class="row justify-content-md-center">
      <div class="col-md-5"> 
        {% if messageInfo.length > 0 %}
        <div class="alert alert-dismissible alert-info">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>{{ messageInfo }}</strong>
        </div>
        {% endif %}
        {% if messageError.length > 0 %}
        <div class="alert alert-dismissible alert-danger">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>{{ messageError }}</strong>
        </div>
        {% endif %}
        <form action="/login" method="post">
         <fieldset>
            <legend>Log In</legend>
            <div class="form-group">
                <label for="emailInput">Email</label>
                <input id="emailInput" type="text" name="email" class="form-control"/>
            </div>
            <div class="form-group">
                <label for="passwordInput">Password</label>
                <input id="passwordInput" type="password" name="password" class="form-control"/>
            </div>
            </fieldset>
            <input type="submit" value="Log In" class="btn btn-primary"/>
        </form>
      </div>
      <div class="col-md-12">
        <p class="text-center mt-5">Don't have an account? Register <a href="/register">here</a></p>
      </div>
    </div>
  </div>
  <script>
function initAutocomplete() {
};
  </script>
{% endblock %}