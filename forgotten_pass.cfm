<html>
  <cfinclude template="includes/header.cfm">

  <body>
    <div class="jumbotron">
      <!--- if the user has passed in their email and they want to recover their password --->
      <cfif structKeyExists(FORM, 'email_provided_pass')>
        <cfset User_Recov = CreateObject("components/user") />
        <cfset User_Recov.init(Application.datasource, "", "#FORM.email#") />

        <!--- create the query object --->
        <cfset forgotPassQuery = User_Recov.recoverPassword("#FORM.email#") >

        <cfoutput>
          <!--- TODO: don't send an email if the email doesn't exist in our DB --->
          <cfmail 
            from="noreply@webdev1.research.ucf.edu" 
            to="#FORM.email#" 
            subject="Important Information">Our records state that you've forgotten your password and would like to reset it. If this is the case, then please follow the following link, if this email was sent in error, then you may simply ignore this message. http://vinay.move.webdev1.research.ucf.edu/index.cfm?email=<cfoutput>#FORM.email#</cfoutput>&code=<cfoutput>#Hash(forgotPassQuery.password)#</cfoutput>
          </cfmail> 

          <cflocation url="action_page.cfm?sender=fp" addtoken="false">

        </cfoutput>
      </cfif>

      <div class="container">
        <h2>Password Recovery</h2>
        <form class="form-horizontal" role="form" action="forgotten_pass.cfm" method="POST">
          <div class="form-group">
            <label class="control-label col-sm-2">Email:</label>
              <div class="col-sm-10">
                <input type="email" class="form-control" name ="email" placeholder="e-mail@provider.domain" required="yes">
              </div>
          </div>  
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <input type="submit" class="btn btn-success" value="Send Email" name="email_provided_pass">
            </div>
          </div>
        </form>
      </div>
      
    <div class="container">   
        <form action="index.cfm" align="center" method="POST">
          <input type="submit" class="btn btn-default" value="Back" name="register">
        </form>
    </div>
    
    </div>
  </body>

  <cfinclude template="includes/footer.cfm">
<html>