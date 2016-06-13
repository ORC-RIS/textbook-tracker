<!--- if the user has attempted to sign out using a form, sign the user out --->
<!--- NOTE: currently, if the user navigats to index.cfm or login.cfm, it is assumed that they want to logout, so the system logs them out --->
<cfif structKeyExists(FORM, 'logout')>
    <cflogout>
    <cflocation url="/index.cfm" addtoken="false">
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
            url = "/admin/admin_page.cfm" 
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