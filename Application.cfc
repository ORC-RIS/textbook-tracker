<!---
DESCRIPTION: Application component
CREATED BY: David Elliott,
            John Lynch,
            Raphael Saint-Louis
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
            <!--- then the user should ONLY be able to access the pages accessible from the login page --->
            <cfif NOT isDefined("cflogin")>
                <cfif "#CGI.script_name#" contains "public" OR "#CGI.script_name#" IS "/index.cfm">
                    <cfbreak>
                <cfelse>
                    <cfinclude template="index.cfm">
                    <cfabort>
                </cfif>
            <cfelse>
                <cfif cflogin.name IS "" OR cflogin.password IS "">
                    <cfoutput>
                        <div class="alert alert-warning">
                            Username or password missing.
                        </div>  
                    </cfoutput>
                    <cfinclude template="/public/login.cfm" />
                    <cfabort>
                <cfelse>
                    <!--- ADD TO SECURITY.CFM or something --->
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
                        <cfinclude template="/public/login.cfm" />
                        <cfabort>
                    </cfif>
                
                </cfif>
            
            </cfif>
        </cflogin>
            
    </cffunction>
</cfcomponent>