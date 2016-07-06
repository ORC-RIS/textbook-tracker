<cfcomponent displayname="inventory" output="true" hint="Contains the functions needed for handling the current book inventory">
	
	<cfset this.userID="">
	<cfset this.bookID="">
	<cfset this.title="">
	<!--- Initialization function --->
	<cffunction name="init" access="public" returntype="void" output="true" hint="Sets the database for the book inventory">
		<cfargument name="database" type="string" required="true" />
		<cfargument name="userID" type="string" required="true" />
			<cfset variables.database=arguments.database>
			<cfset this.userID=arguments.userID>
	</cffunction>
	
	<cffunction name="addUserToWaitlist" access="public" returntype="void" hint="Adds a user to the waitlist">
		<cfargument name="bookID" type="string" required="true" default="1" />
		<!--- <cfargument name="Date" type="date" required="false" default="#DateFormat(Now(), 'yyyy-mm-dd')#" /> --->

		<cfstoredproc datasource="#variables.database#" procedure="usp_AddUserToWaitList">
			<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@user" value="#this.userID#">
			<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@book" value="#bookID#">
			<!--- <cfprocparam cfsqltype="cf_sql_date" dbvarname="@date" value="#Date#"> --->
		</cfstoredproc>

	</cffunction>

	<cffunction name="findQueuePosition" access="public" returntype="query" hint="Returns a list of the users ahead of the current one">
		<cfargument name="Date" type="date" required="false" default="#DateFormat(Now(), 'yyyy-mm-dd')#" />

		<cfstoredproc datasource="#variables.database#" procedure="usp_FindQueuePosition">
			<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@user" value="#this.userID#">
			<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@book" value="#this.bookID#">
			<cfprocresult name="waitListQueue">

		</cfstoredproc>

		<cfreturn waitListQueue>
	</cffunction>

 	<cffunction name="findAssociatedBooks" access="public" returntype="query" hint="Returns a list of the books associated with the logged in user">
		<cfstoredproc datasource="#variables.database#" procedure="usp_FindAssociatedBooks">
			<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@user" value="#this.userID#">
			<cfprocresult name="bookList">
		</cfstoredproc>

		<cfreturn bookList>	
	</cffunction>

</cfcomponent>