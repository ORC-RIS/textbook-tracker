<!---
DESCRIPTION: Checkout Component
CONTRIBUTORS: David Elliott
DATE CREATED: 06/03/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:
FUNCTIONS: init, createCheckout
MODIFICATION LOG
DATE            CHANGE
================================================
06/28/2016:     createCheckout only sends book and user information, datetime creation is the function of the database
	
--->
<cfcomponent displayname="qry_checkout" output="true" >
	
    <cffunction name="init" access="public" returntype="void" hint="Constructor creates checkout object, sets datasource." output="yes">
      	<!--- set datasource and store in cf property--->
		variables.attributes.datasource = "";
    	<cfargument name="datasource" type="string" required="yes" />
        <cfset variables.datasource = arguments.datasource />
	</cffunction>
    
    <cffunction name="createCheckout" access="public" returntype="boolean">
		<cfargument name="BookID" type="numeric" required="yes">
        <cfargument name="UserID" type="numeric" required="yes">
        <cfset myResult="true">
        
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_BookUserCreate" >
            <cfprocparam cfsqltype="cf_sql_int" dbvarname="@BookID" value="#BookID#">
            <cfprocparam cfsqltype="cf_sql_int" dbvarname="@UserID" value="#UserID#">
		</cfstoredproc>
        <!--- if creation is successful, return true --->
		<cfreturn myResult>
	</cffunction>
</cfcomponent>