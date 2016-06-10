<!--- if the user has attempted to sign out using a form, sign the user out --->
<!--- NOTE: currently, if the user navigats to index.cfm or login.cfm, it is assumed that they want to logout, so the system logs them out --->
<cfif structKeyExists(FORM, 'logout')>
    <cflogout>
    <cflocation url="/index.cfm" addtoken="false">
</cfif>

<!--- check to see if the user is attempting to verify their change password request via GET --->
<!--- this does not care whether or not the user is logged in --->
<cfdump var="#CGI#">
<cfabort>
<cfset User_Recov = CreateObject("components/user") />
<cfif structKeyExists(URL,'uid')>
    <cfif structKeyExists(URL,'code')>
        <!--- generate a new `password` for the user ahead of time --->
        <cfset new_pass = RandRange(10000, 99999)>
        <cfset new_pass_hash = Hash(new_pass, "SHA-512")>

        <cfset User_Recov.init(Application.datasource, "", "") />
        <cfset username = User_Recov.getUsernameFromUID("#URL.uid#") />

        <!--- now that we have the user's username, we can make construct a new object that will contain the email we need --->
        <cfset Complete_User_Object = CreateObject("components/user") />
        <cfset Complete_User_Object.init(Application.datasource, "#username#", "") />
        
        <cfset email = Complete_User_Object.getEmail() />


        <cfif "#Hash(resetEmailQuery.password)#" IS URL.code>
            <cfset sucess_bool = User_Recov.updatePassword("#email#", "#new_pass_hash#") />
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


<!--- check to make sure that the user is logged in --->
<!--- logic for pass_change_form.cfm --->
<cfif getAuthUser() NEQ "">
    <!--- if user tries to change password, take them to password change form --->
    <cfif structKeyExists(FORM, 'change_pass')>
        <cflocation 
            url="pass_change_form.cfm"
            addtoken="false">
    <!--- checks to see if the user has attemped to change their password (ie, user is coming from password change form) --->
    <cfelseif structKeyExists(FORM, 'changed_pass')>
        <cfset hashed_pass = Hash(FORM.changed_pass, "SHA-512")>
        <cfset old_hashed_pass = Hash(FORM.old_pass, "SHA-512")>
      
        <!--- create new user object/component --->
        <cfset User_Verif_Change_Pass = CreateObject("components/user") />
        <cfset User_Verif_Change_Pass.init(Application.datasource, "#getAuthUser()#", "") />

        <cfset loginQuery2 = User_Verif_Change_Pass.verifyUsernamePasswordCombo("#getAuthUser()#", "#old_hashed_pass#") >
        
        <!--- make sure that their old password is correct before attempting to change it --->

        <cfif #loginQuery2.username# IS "">
            <!--- sec0: incorrect password --->
            <cflocation url="/public/action_page.cfm?sender=sec0" addtoken="false">
            
            <cflogout>
            <cfabort>
        </cfif>

        <!--- first, get their email, which should be tied to their username (which we passed to the init function for this object) --->
        <cfset sucess_bool = User_Verif_Change_Pass.updatePassword("#User_Verif_Change_Pass.getEmail()#", "#hashed_pass#") />

        <cfoutput>
            <!--- secs: correct passwor (doesn't do any queries, simply notifies the user, so it doesn't matter if they manually change their URL) --->
            <cflocation url="/public/action_page.cfm?sender=secs" addtoken="false">
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
    <cfset LoggedUser = CreateObject("components/user") />
    <cfset LoggedUser.init(Application.datasource, "#getAuthUser()#", "") />

    <cfif #LoggedUser.getUserRole()# IS 'admin'>
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
</cfif>