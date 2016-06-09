<!---
DESCRIPTION: Application component
CREATED BY: David Elliott,
            John Lynch,
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED: 
--->
<cfcomponent displayname="Application" output="true" hint="Handle the application.">

<!---Application Metadata. These are not Application-scoped variables! --->
	<cfset this.name="Bookstore">
	<cfset this.datasource="dsTestDatabaseSqlDev1">
    <cfset this.sessionTimeout =  CreateTimeSpan( 0, 0, 30, 0 ) />
	<cfset this.sessionManagement = true>
    <cfset this.setclientcookies = true>
    <cfset role = "not_set">
    
    <cffunction name="onApplicationStart"
    			access="public"
                returntype="boolean"
                output="false"
                hint="Fires when the application is first created.">
        <cfreturn true />
    </cffunction>

	<cffunction name="onSessionStart"
    			access="public"
                returntype="void"
                output="false"
                hint="Fires when the session is first created.">
                <cfreturn />
    </cffunction>
                    
    <cffunction name="onRequestStart"
    			access="public"
                output="true"
                hint="Fires at the first part of page processing.">
        
        <cfargument 
                name="target"
                type="string"
                required="true">

        <!--- datasource variable --->
        <cfset Application.datasource = this.datasource>
		<cfset GLOBAL_DATASOURCE = this.datasource>

        <!--- create components that will be used for verifying login --->
        <cfset User_Verif = CreateObject("components/user") />
        <cfset User_Recov = CreateObject("components/user") />

        <!--- change URLs based on #target# --->
        <!--- maybe I should make an array called 'allowed pages' or something --->

        <!---<cfif "#target#" IS "/registration.cfm">
          <cfinclude template="registration.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/forgotten_name.cfm">
          <cfinclude template="forgotten_name.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/forgotten_pass.cfm">
          <cfinclude template="forgotten_pass.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/user_homepage.cfm">
          <cfinclude template="user_homepage.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/admin_page.cfm">
          <cfinclude template="admin_page.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/users_view.cfm">
          <cfinclude template="users_view.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/pass_change_form.cfm">
          <cfinclude template="pass_change_form.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/action_page.cfm">
          <cfinclude template="action_page.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "/bookstore.cfm">
          <cfinclude template="bookstore.cfm">
          <cfabort>
        </cfif>

        <cfif "#target#" IS "confirmation_un.cfm">
          <cfinclude template="confirmation_un.cfm">
          <cfabort>
        </cfif>

        <!--- if the user has attempted to sign out using a form, sign the user out --->
        <cfif structKeyExists(FORM, 'logout')>
            <cflogout>
        </cfif>

        <!--- check to see if the user is attempting to verify their change password request via GET --->
        <!--- this does not care whether or not the user is logged in --->
        <cfif structKeyExists(URL,'email')>
            <cfif structKeyExists(URL,'code')>
                <!--- generate a new `password` for the user ahead of time --->
                <cfset new_pass = RandRange(10000, 99999)>
                <cfset new_pass_hash = Hash(new_pass, "SHA-512")>

<!--- Probably Delete --->
                <cfset User_Recov.init(Application.datasource, "", "#URL.email#") />
                <cfset resetEmailQuery = User_Recov.recoverPassword("#URL.email#") >

                <cfif "#Hash(resetEmailQuery.password)#" IS URL.code>
                    <cfset sucess_bool = User_Recov.updatePassword("#URL.email#", "#new_pass_hash#") />
                <cfelse>
                        <div class="alert alert-danger">
                            This page has expired.
                        </div>
                    <cfabort>
                </cfif>

                <div class="alert alert-success">
                    Your password has been reset. Your new, temporary password has been sent to your email address.
                </div>

                <cfmail 
                    from="noreply@webdev1.research.ucf.edu" 
                    to="#resetEmailQuery.email#" 
                    subject="Password Reset">Your password has been successfully reset. Your new password is <cfoutput>#new_pass#</cfoutput>. This is only a temporary password and should be changed as soon as possible.
                </cfmail>

                <cfabort>
            </cfif>
        </cfif>

        <!--- checks to see if the user is logged in, if not, attempts to log the user into the system --->
        <cflogin>
            <!--- if the user has NOT sent the login form --->
            <cfif NOT isDefined("cflogin")>
                <cfinclude template="login.cfm" />
                <cfabort>
            <cfelse>
                <cfif cflogin.name IS "" OR cflogin.password IS "">
                    <cfoutput>
                        <div class="alert alert-warning">
                            Username or password missing.
                        </div>  
                    </cfoutput>
                    <cfinclude template="login.cfm" />
                    <cfabort>
                <cfelse>
                    <cfset pass_hash = HASH('#cflogin.password#', 'SHA-512')>
                    
                    <!--- use the component to verify the user's username-password combination --->
                    <cfset User_Verif.init(Application.datasource, "#cflogin.name#", "") />

                    <!--- create the query object --->
                    <cfset loginQuery = User_Verif.verifyUsernamePasswordCombo("#cflogin.name#", "#pass_hash#") >

                    <cfif loginQuery.username NEQ "">
                        <cfloginuser 
                            name="#cflogin.name#" 
                            password="#cflogin.password#"
                            roles=#role#>
                    <cfelse>
                        <cfoutput> 
                            <div class="alert alert-danger">
                                Invalid login information, please try again.
                            </div>
                        </cfoutput>
                        <cfinclude template="login.cfm" />
                        <cfabort>
                    </cfif>
                
                </cfif>
            
            </cfif>
        </cflogin>

        <!--- check to make sure that the user is logged in --->
        <!--- logic for pass_change_form.cfm --->
        <cfif getAuthUser() NEQ "">
            <cfif structKeyExists(FORM, 'change_pass')>
                <cflocation 
                    url="pass_change_form.cfm"
                    addtoken="false">
            <!--- checks to see if the user has attemped to change their password --->
            <cfelseif structKeyExists(FORM, 'changed_pass')>
                <cfset hashed_pass = Hash(FORM.changed_pass, "SHA-512")>
                <cfset old_hashed_pass = Hash(FORM.old_pass, "SHA-512")>
              
                <!--- create new user object/component --->
                <cfset User_Verif_Change_Pass = CreateObject("components/user") />
                <cfset User_Verif_Change_Pass.init(Application.datasource, "#getAuthUser()#", "") />

                <cfset loginQuery2 = User_Verif_Change_Pass.verifyUsernamePasswordCombo("#getAuthUser()#", "#old_hashed_pass#") >
                
                <!--- make sure that their old password is correct before attempting to change it --->

                <cfif #loginQuery2.username# IS "">
                    <cfoutput> 
                        <div class="alert alert-danger">
                            Incorrect password, please try again. For security, the current session will now close.
                        </div>
                        <cfinclude template="login.cfm">
                    </cfoutput>
                    <cflogout>
                    <cfabort>
                </cfif>

                <!--- their old password is correct, allow them to change it at will then --->
                <!--- first, get their email, which should be tied to their username (which we passed to the init function for this object) --->
                <cfset sucess_bool = User_Verif_Change_Pass.updatePassword("#User_Verif_Change_Pass.getEmail()#", "#hashed_pass#") />

                <cfoutput>
                    <div class="alert alert-success">
                        Password changed successfully
                    </div>  
                </cfoutput>
                
                <cflogout>
            </cfif>
        </cfif>

        <!--- logic for sending the logged-in user to their respective dashboard, based on whether or not the user has admin privileges --->
        <cfif getAuthUser() NEQ "">  

            <!--- create new user object/component --->
            <cfset Send_User_to_Dashboard = CreateObject("components/user") />
            <cfset Send_User_to_Dashboard.init (Application.datasource, "#getAuthUser()#", "") />

            <!--- NEEDS TO CHECK THEIR ROLES IN THE FUTURE --->
            <cfset User_Object_Name = Send_User_to_Dashboard.getUsername()>

            <cfif #User_Object_Name# IS 'admin'>
                <!--- if admin is trying to 'view all users' --->
                <cfif structKeyExists(FORM, 'view_users')>
                    <cfinclude template="users_view.cfm">
                    <cfabort>
                </cfif>
                <!--- user = admin; display header --->
                <cflocation 
                    url = "admin_page.cfm" 
                    addToken = "no" />  
            <!--- otheriwse if user's name isn't 'admin' --->
            <cfelse>
                <cflocation 
                    url = "user_homepage.cfm" 
                    addToken = "no" />          
            </cfif>
        </cfif>
                    
		<cfif isDefined("url.init") >
    		<cfset onApplicationStart()>

   		</cfif>--->
            
    </cffunction>
</cfcomponent>