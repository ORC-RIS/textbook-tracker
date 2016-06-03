<!---
DESCRIPTION: Application component
CREATED BY: David Elliott
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED:
--->
<cfcomponent displayname="Application" output="true" hint="Handle the application.">

	<!---Application Variables --->
	<cfset this.name="Bookstore">
	<cfset this.datasource="dsTestDatabaseSqlDev1">
    <cfset this.applicationTimeout = CreateTimeSpan( 0, 0, 1, 0 ) />
	<cfset this.sessionManagement = true>
    <cfset this.clientManagement = false>
    <cfset this.setclientcookies = false>
    
    <cffunction name="onApplicationStart"
    			access="public"
                returntype="boolean"
                output="false"
                hint="Fires when the application is first created.">
                
    	<cfset application.baseHref = "/"> <!--- insert root directory of app --->
        <cfset application.cssHref = "/">	<!--- insert css directory of app --->
        <cfreturn true />
        
     </cffunction>

	<cffunction name="onSessionStart"
    			access="public"
                returntype="void"
                output="false"
                hint="Fires when the session is first created.">
                
                <!--- return out --->
                <cfreturn />
     </cffunction>
                    
    <cffunction name="onRequestStart"
    			access="public"
                returntype="boolean"
                output="true"
                hint="Fires at the first part of page processing.">
        
		<!--- define arguments --->
    	<cfargument name="targetpage" 
        			required="true" 
                    type="string" />
			
			<cfif isDefined("url.init") >
    			<cfset onApplicationStart()>
   			</cfif>
            
        <!--- Return out. --->    
            <cfreturn true />
            
    </cffunction>
    
</cfcomponent>