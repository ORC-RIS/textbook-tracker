<html> 
  <cfinclude template="includes/header.cfm">

  <body>
    <div class="jumbotron">
      <div class="container">
        <h2>Login</h2>
        <form class="form-horizontal" role="form" action="index.cfm" method="POST">
          <div class="form-group">
            <label class="control-label col-sm-2">Username:</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="username" name ="j_username" placeholder="username">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-2">Password:</label>
            <div class="col-sm-10">          
              <input type="password" class="form-control" id="password" name="j_password" placeholder="password">
            </div>
          </div>
          <div class="form-group">        
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-success" value="Log In">Submit</button>
            </div>
          </div>
        </form>
      </div>
   
      <div class="container">
        <div class="form-group"> 
          <form action="registration.cfm" style="float: left;">
            <input type="submit" class="btn btn-default" value="Register">
          </form>
          <form action="forgotten_pass.cfm" method="POST" style="float: right; margin-left: 10px">
             <input type="submit" class="btn btn-default" value="Forgot Password" name="forgot_pass">
          </form>
          <form action="forgotten_name.cfm" method="POST" style="float: right;">
             <input type="submit" class="btn btn-default" value="Forgot Username" name="forgot_name">
          </form>
        </div>
      </div>

    </div>
  </body>

  <cfinclude template="includes/footer.cfm">
</html>