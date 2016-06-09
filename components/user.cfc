<!---
DESCRIPTION: Book Component
CREATED BY: Raphael Saint-Louis
DATE CREATED: 06/03/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:
FUNCTIONS: getID, getUsername, getPasswordHash, get firstName, get lastName, get email
--->

<cfcomponent displayname="user" output="true" hint="Queries for Book Table.">

    <!--- define the properties that the functions will modify --->
    <!--- ACTUALLY, THIS ISN'T NECESSARY --->
<!---     <cfproperty name="userID_p" type="numeric">
    <cfproperty name="username_p" type="string">
    <cfproperty name="password_p" type="string">
    <cfproperty name="first_name_p" type="string">
    <cfproperty name="last_name_p" type="string">
    <cfproperty name="email_p" type="string"> 
 --->
    <!--- Constructor Function to initialize component --->
    <cffunction name="init" access="public" returntype="void" hint="Constructor creates User object, sets datasouce." output="yes">
        <!--- set datasource and store in cf property--->
        variables.attributes.datasource = "";
        <cfargument name="datasource" type="string" required="yes" />

        <!--- takes username and returns set of all attributes attached to said user in the database--->
        <!--- OR takes their email address (only to be used to retrieving username or password) --->
        <cfargument name="username" type="string" required="no" />
        <cfargument name="email" type="string" required="no" />
        
        <cfset variables.datasource = arguments.datasource />
        <cfset variables.username = arguments.username />
        <cfset variables.email = arguments.email />
    </cffunction>
    
    <cffunction name="getUserInformation" access="private" returntype="query" hint="returns a tuple that contains all of the user's information">
        <!--- query that will fetch user's information --->
        <cfstoredproc datasource="#application.datasource#" procedure="usp_GetUserInfo" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@username" value="#getAuthUser()#">
            <cfprocresult name="userInformation">
        </cfstoredproc>
        <cfreturn userInformation>
    </cffunction>

    <cffunction name="verifyUsernamePasswordCombo" access="public" returntype="query" hint="returns a tuple containing the verified username's information, nor null if verification fails">
        <cfargument name="username" type="string" required="yes" />
        <cfargument name="password" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_VerifyUsernamePassword" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@username" value="#username#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@password" value="#password#">
            <cfprocresult name="usernamePasswordCombo">
        </cfstoredproc>
        <cfreturn usernamePasswordCombo>
    </cffunction>
 
     <cffunction name="recoverUsername" access="public" returntype="query" hint="returns a tuple containing username/email">
        <cfargument name="email" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_RecoverUsername" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocresult name="emailNameTuple">
        </cfstoredproc>
        <cfreturn emailNameTuple>
    </cffunction>

    <cffunction name="recoverPassword" access="public" returntype="query" hint="returns a tuple containing username/email/password">
        <cfargument name="email" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_RecoverPassword" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocresult name="emailPassTuple">
        </cfstoredproc>
        <cfreturn emailPassTuple>
    </cffunction>

    <cffunction name="updatePassword" access="public" returntype="void" hint="updates the user's password">
        <cfargument name="email" type="string" required="yes" />
        <cfargument name="password" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_UpdatePassword" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@new_pass_hash" value="#password#">
            <cfprocresult name="updatePass">
        </cfstoredproc>
    </cffunction>

    <cffunction name="addUserToDatabase" access="public" returntype="void" hint="adds the user to the database">
        <cfargument name="username" type="string" required="yes" />
        <cfargument name="password" type="string" required="yes" />
        <cfargument name="firstname" type="string" required="yes" />
        <cfargument name="lastname" type="string" required="yes" />
        <cfargument name="email" type="string" required="yes" />
        <cfargument name="role" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_CreateUser" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@username" value="#username#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@password" value="#password#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@firstname" value="#firstname#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@lastname" value="#lastname#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@role" value="#role#">
            <cfprocresult name="addUser">
        </cfstoredproc>
    </cffunction>

    <!--- getters; these work with the private function, getUserInformation() --->     
    <cffunction name="getUsername" access="public" returntype="string" hint="returns the user's username">
        <cfreturn getUserInformation().username>
    </cffunction>

    <cffunction name="getPasswordHash" access="public" returntype="string" hint="returns the user's password hash">
        <cfreturn getUserInformation().password>
    </cffunction>

    <cffunction name="getFirstName" access="public" returntype="string" hint="returns the user's first name">
        <cfreturn getUserInformation().firstname>
    </cffunction>

    <cffunction name="getLastName" access="public" returntype="string" hint="returns the user's last name">
        <cfreturn getUserInformation().lastname>
    </cffunction>

    <cffunction name="getEmail" access="public" returntype="string" hint="returns the user's email">
        <cfreturn getUserInformation().email>
    </cffunction>

    <cffunction name="getUserRole" access="public" returntype="string" hint="returns the user's access level/role">
        <cfreturn getUserInformation().userRole>
    </cffunction>


    <!--- end getters --->

</cfcomponent>