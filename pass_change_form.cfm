<html>
  <cfinclude template="includes/header.cfm">

  <body>
    <div class="jumbotron">
      
      <div class="container">
        <h2>Change Password</h2>
      </div> <p></p>

      <div class="container">
        <form class="form-horizontal" action="/security.cfm" method="POST">
          <div class="form-group">
            <label class="control-label col-sm-2">Old Password:</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="old_pass" required="yes" placeholder="password">
              </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-2">New Password:</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="changed_pass" required="yes" placeholder="password">
              </div>
          </div>
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <input type="submit" class="btn btn-success" value="Confirm">
            </div>
          </div>
        </form>
      </div>

      <div class="container">
        <div class="form-group">
          <form action="/security.cfm" method="POST" style="float: right; margin-left: 10px">
              <input type="submit" class="btn btn-default" value="Cancel" name="back">
          </form>
        </div>
      </div>
    
    </div>
  </body>

  <cfinclude template="includes/footer.cfm">
<html>