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