<cfinclude template="/includes/header.cfm">

<!--- check to see if the user is attempting to verify their change password request via GET --->
<!--- this does not care whether or not the user is logged in --->
<cfset User_Recov = CreateObject("components/user") />
<cfif structKeyExists(URL,'code')>
    <cfif structKeyExists(URL,'uid')>
        <!--- generate a new `password` for the user ahead of time --->
        <cfset new_pass = RandRange(10000, 99999)>
        <cfset new_pass_hash = Hash(new_pass, "SHA-512")>

        <!--- entire point of this component is to grab one's username from the userid in the URL --->
        <cfset User_Recov.init(Application.datasource, "", "") />
        <cfset username = User_Recov.getUsernameFromUID("#URL.uid#") />

        <!--- now that we have the user's username, we can make construct a new object that will contain the email we need --->
        <cfset Complete_User_Object = CreateObject("components/user") />
        <cfset Complete_User_Object.init(Application.datasource, "#username#", "") />

        <cfset user_email = Complete_User_Object.getEmail() />
        <cfset email_code_combo = "#Complete_User_Object.verifyCodeEmailCombo('#user_email#','#URL.code#')#" />

        <!--- if email/code == empty string, then we know there wasn't a match --->
        <cfif "#email_code_combo.email#" EQ "">
            <cflocation url="/public/action_page.cfm?sender=recpass0" addtoken="false">
        <!--- there was a match, after changing the user's password, we need to delete the tuple in the email/code table --->
        <cfelse>
            <!--- query for chaging the password to new_pass_hash --->
            <cfset Complete_User_Object.updatePassword("#user_email#","#new_pass_hash#") />
            
            <!--- query for deleting the entry, so that a user can request to change their password again at a later date --->
            <cfset Complete_User_Object.deleteEmailCodeEntry("#user_email#") />
            
            <cfmail 
            from="noreply@webdev1.research.ucf.edu" 
            to="#user_email#" 
            subject="Password Reset">Your password has been successfully reset. Your new password is <cfoutput>#new_pass#</cfoutput>. This is only a temporary password and should be changed as soon as possible.
            </cfmail>

            <cflocation url="/public/action_page.cfm?sender=recpasssucc" addtoken="false">
        </cfif>

    </cfif>
</cfif>