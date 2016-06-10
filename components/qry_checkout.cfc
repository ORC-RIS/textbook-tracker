<!---
DESCRIPTION: Checkout Component
CREATED BY: David Elliott
DATE CREATED: 06/03/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:
FUNCTIONS: init, createCheckout
DATE MODIFIED:
	
--->
<cfcomponent displayname="qry_checkout" output="true" >
	
    <cffunction name="init" access="public" returntype="void" hint="Constructor creates checkout object, sets datasource." output="yes">
      	<!--- set datasource and store in cf property--->
		variables.attributes.datasource = "";
    	<cfargument name="datasource" type="string" required="yes" />
        <cfset variables.datasource = arguments.datasource />
	</cffunction>
    
    <cffunction name="createCheckout" access="public" returntype="boolean">
		<cfargument name="BookID" type="int" required="yes">
        <cfargument name="UserID" type="int" required="yes">
        <cfset myResult="true">
        
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_BookUserCreate" >
        	<cfprocparam cfsqltype="cf_sql_int" dbvarname="@UserID" value="#UserID#">
    		<cfprocparam cfsqltype="cf_sql_int" dbvarname="@BookID" value="#BookID#">
    		<cfprocparam cfsqltype="cf_sql_date" dbvarname="@DateOut" value="#Now()#">
		</cfstoredproc>
        <!--- <cfprocresult name="returnName"> --->
        
        <!--- if creation is successful, return true --->
		<cfreturn myResult>
	</cffunction>
</cfcomponent>