<html>
  <cfinclude template="includes/header.cfm">

  <body>
    <div class="jumbotron">
      <!--- if the user has passed in their email and they want to recover their username --->
      <cfif structKeyExists(FORM, 'email_provided_name')>
        <cfset User_Recov = CreateObject("components/user") />
        <cfset User_Recov.init(Application.datasource, "", "#FORM.email#") />

        <!--- create the query object --->
        <cfset forgotNameQuery = User_Recov.recoverUsername("#FORM.email#") >

        <cfoutput>
          <!--- TODO: don't send an email if the email doesn't exist in our DB --->
          <cfmail 
            from="noreply@webdev1.research.ucf.edu" 
            to="#FORM.email#" 
            subject="Important Information">Our records state that you've forgotten your username and would like to be reminded of it. Username: <cfoutput>#forgotNameQuery.username#</cfoutput>
          </cfmail> 

          <cflocation url="action_page.cfm?sender=fn" addtoken="false">

        </cfoutput>
      </cfif>
      
      <div class="container">
        <h2>Username Recovery</h2>
        <form class="form-horizontal" role="form" action="forgotten_name.cfm" method="POST">
          <div class="form-group">
            <label class="control-label col-sm-2">Email:</label>
              <div class="col-sm-10">
                <input type="hidden" name="finished_form">
                <input type="email" class="form-control" name ="email" placeholder="e-mail@provider.domain" required="yes">
              </div>
          </div>  
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <input type="submit" class="btn btn-success" value="Send Email" name="email_provided_name">
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