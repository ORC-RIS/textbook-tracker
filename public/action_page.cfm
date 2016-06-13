<html>
  <cfinclude template="/includes/header.cfm">

    <body>
      <cfif structKeyExists(URL, 'sender')>
      
      <!--- REGISTRATION.cfm --->
      <cfif #URL.sender# IS "reg">
          <div class="alert alert-success" style="width:800px;margin:auto;">
            Account created successfully.
          </div>

      <!--- FORGOTTEN_NAME.cfm --->
        <cfelseif #URL.sender# IS "fn">
          <div class="alert alert-warning" style="width:800px;margin:auto;">
            Details on how to recover your username have been sent to the supplied email address.
          </div>

      <!--- FORGOTTEN_PASS.cfm --->
        <cfelseif #URL.sender# IS "fp">
          <div class="alert alert-warning" style="width:800px;margin:auto;">
            Details on how to reset your account have been sent to the supplied email address.
          </div>

        <cfelseif #URL.sender# IS "fptransactioninprogress">
          <div class="alert alert-warning" style="width:800px;margin:auto;">
            You have already requested that this password be changed. Please check your spam and/or junk folders in your inbox. 
          </div>  
        
        <!--- SECURITY.CFM --->
        <cfelseif #URL.sender# IS "sec0">
          <div class="alert alert-danger">
            Incorrect password, please try again. For security, the current session will now close.
          </div>
          <cflogout>
        <cfelseif #URL.sender# IS "secs">
          <div class="alert alert-success">
            Password changed successfully.
          </div>
          <div class="container" style="width:830px;margin:auto;">
            <form action="/security.cfm" method="POST">
              <input type="submit" value="Return" class="btn btn-default" name="back">
            </form> 
          </div>
          <cfabort>
        
        <!--- RECOVER_PASSWORD.cfm --->
        <cfelseif #URL.sender# IS "recpass0">
          <div class="alert alert-danger">
            This page has expired.
          </div>
        <cfelseif #URL.sender# IS "recpasssucc">
          <div class="alert alert-success" style="width:800px;margin:auto;">
            Your password has been reset. Your new, temporary password has been sent to your email address.
          </div>
        </cfif>
      
      <cfelse>
        <div class="alert alert-danger" style="width:800px;margin:auto;">
          You shouldn't be here.
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