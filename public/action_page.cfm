<html>
  <cfinclude template="/includes/header.cfm">

    <body>
      <!--- <div class="jumbotron"> --->

      <!--- section deals with forgotten_name & forgotten_pass pages --->
      <cfif structKeyExists(URL, 'sender')>
        <cfif #URL.sender# IS "fn">
          <div class="alert alert-warning" style="width:800px;margin:auto;">
            Details on how to recover your username have been sent to the supplied email address.
          </div>
        <cfelseif #URL.sender# IS "fp">
          <div class="alert alert-warning" style="width:800px;margin:auto;">
            Details on how to reset your account have been sent to the supplied email address.
          </div>
        <cfelseif #URL.sender# IS "reg">
          <div class="alert alert-success" style="width:800px;margin:auto;">
            Account created successfully.
          </div>
        <!--- SECURITY.CFM --->
        <cfelseif #URL.sender# IS "sec0">
          <div class="alert alert-danger">
            Incorrect password, please try again. For security, the current session will now close.
          </div>
          <cflogout>
        <cfelseif #URL.sender# IS "secs">
          <div class="alert alert-danger">
            Password changed successfully.
          </div>
          <div class="container" style="width:830px;margin:auto;">
            <form action="/security.cfm" method="POST">
              <input type="submit" value="Return" class="btn btn-default" name="back">
            </form> 
          </div>
          <cfabort>
        <cfelse>
          <div class="alert alert-danger" style="width:800px;margin:auto;">
            You shouldn't be here.
          </div>
        </cfif>
      <cfelse>
        <div class="alert alert-danger" style="width:800px;margin:auto;">
          You shouldn't be here.
          <cfdump var="#FORM#">
        </div>
      </cfif>

 <br>
      
      <div class="container" style="width:830px;margin:auto;">
        <form action="/index.cfm" method="POST">
          <input type="submit" value="Home" class="btn btn-default" name="back">
        </form> 
      </div>

    <!--- </div> --->
  </body>

  <!--- <cfinclude template="includes/footer.cfm"> --->
</html>