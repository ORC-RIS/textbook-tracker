<html>
  <cfinclude template="includes/header.cfm">
  
  <body>
    <div class="jumbotron">
    <!--- if the user is coming back to this page after sending the form with the submit button named 'register',
    then the form is filled out and we need to process it --->
    
    <!--- otherwise the form is empty, so we can skip all this processing and display the form;
    afterwards, we send them back to this page, then this if statement will run positively  --->
    <cfif structKeyExists(FORM, 'register')>
      <cfif FORM.username IS "" OR FORM.password IS "" OR Form.f_name IS "" OR Form.l_name IS "">
        <cfoutput>
          <div class="alert alert-danger">
            Please fill out all the fields.
          </div>
        </cfoutput>
      <cfelse>
        <!--- if all form fields were filled out --->
        <!--- create password salt, not currently used --->
        <cfset salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 

        <!--- hash password --->
        <cfset hashed_password = Hash(FORM.password, "SHA-512") />
       
        <!--- grabs the set of all entries in the database where the username is the same as the one inputted in our form; 
        since username is a key in the DB, there should only be one --->
      
        <!--- create and initialize user object --->
        <cfset User_Registration_Object = CreateObject("components/user") />
        <cfset User_Registration_Object.init (Application.datasource, "#FORM.username#", "") />

        <cfset retrieved_username = User_Registration_Object.getUsername()>
      
        <!--- if query.username is not empty, then the username already exists in our database, which is a problem, 
        since our key constraint doesn't allow us to have two tuples in the DB with the same username --->

        <cfif retrieved_username NEQ "">
          <cfoutput>
           <div class="alert alert-warning">
              This username has already been taken, please use a different one.
            </div>
          
          <div class="container">
            <form action="registration.cfm" method="POST">
              <div class="col-sm-10">
                <input type="submit" class="btn btn-default" value="Return">
              </div>
            </form>
          </div>

          </cfoutput>
          <cfabort>
        </cfif>

        <!--- if we're here, then that the user has filled out all the forms and that their desired username wasn't taken --->

        <!--- query for checking if the user's inputted email doesn't already exist in the system --->

        <cfset retrieved_email = User_Registration_Object.getEmail()>


        <cfdump var="#retrieved_email#">

        <cfif retrieved_email NEQ "">
          <cfoutput>
           <div class="alert alert-danger">
              This email address is already tied to an account in the system.
            </div>
          
          <div class="container">
            <form action="registration.cfm" method="POST">
              <div class="col-sm-10">
                <input type="submit" class="btn btn-default" value="Back">
              </div>
            </form>
          </div>

          </cfoutput>
          <cfabort>
        </cfif>

        <cfset registration_query = User_Registration_Object.addUserToDatabase('#FORM.username#', '#hashed_password#', '#FORM.f_name#', '#FORM.l_name#', '#FORM.email#', 'user') />
        
        <cflocation url="action_page.cfm?sender=reg" addtoken="false">
        
        </cfif>
    </cfif>

      <div class="container">
        <h2>Registration Form</h2>
        <form class="form-horizontal" role="form" action="registration.cfm" method="POST">
          <div class="form-group">
            <div class="col-sm-10">
              <label class="control-label col-sm-2">Username:</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" name="username" placeholder="username">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-10">
              <label class="control-label col-sm-2">Email:</label>
              <div class="col-sm-10">
                <input type="email" class="form-control" name="email" placeholder="e-mail@provider.domain">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-10">
              <label class="control-label col-sm-2">First Name:</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" name="f_name" placeholder="first name">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-10">
              <label class="control-label col-sm-2">Last Name:</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" name="l_name" placeholder="last name">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-10">
              <label class="control-label col-sm-2">Password:</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="password" placeholder="password">
              </div>
            </div>
          </div>
          <div class="form-group">     
            <div class="col-sm-offset-2 col-sm-10">
               <input type="submit" class="btn btn-success" value="Register" name="register" style="float:left; margin-left:-22px">
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