<html>
  <cfinclude template="includes/header.cfm">
  
  <body>
    <div class="jumbotron">
    
      <div class="container">
        <h2>Administrator Home</h2>  
      </div>

      <div class="container">
        This admin page allows you to view the current users in the database, change your password, or log out.
      </div> <p></p> 
      
      <div class="container">
        <p></p>
      </div>

      <cfif structKeyExists(FORM, 'view_users')>
        <cflocation 
          url = "users_view.cfm" 
          addToken = "no" />
          <cfabort>
      </cfif>

      <div class="container">
        <form action="users_view.cfm" method="POST">
          <div class="banner">
            <input type="submit" value="View Users" class="btn btn-info" name="view_users">
          </div>
        </form>
      </div>

      <div class="container">
        <form action="index.cfm" method="POST">
          <input type="submit" value="Sign Out" class="btn btn-default" name="logout">
          <input type="submit" value="Change Password" class="btn btn-default" name="change_pass">
        </form>
      </div>
 
    </div>
  </body>

  <cfinclude template="includes/footer.cfm">
</html>