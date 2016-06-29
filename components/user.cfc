<!---
DESCRIPTION: Book Component
CREATED BY: Raphael Saint-Louis
DATE CREATED: 06/03/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:
FUNCTIONS: getID, getUsername, getPasswordHash, get firstName, get lastName, get email
--->

<cfcomponent displayname="user" output="true" hint="Queries for Book Table.">
    
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
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@username" value="#username#">
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
 
     <cffunction name="getUsernameFromUID" access="public" returntype="string" hint="returns a tuple containing username/email">
        <cfargument name="userid" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_GetUsernameFromUID" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@userid" value="#userid#">
            <cfprocresult name="objects">
        </cfstoredproc>
        <cfreturn objects.username>
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

    <cffunction name="getAllUsers" access="public" returntype="query" hint="grabs everyone's information">
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_GetAllUsers" >
            <cfprocresult name="allUsers">
        </cfstoredproc>
        <cfreturn allUsers>
    </cffunction>

    <cffunction name="associateCodeWithEmail" access="public" returntype="void" hint="inserts an email and a code into a table">
        <cfargument name="email" type="string" required="yes" />
        <cfargument name="secure_code" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_AssociateCodeWithEmail" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@secure_code" value="#secure_code#">
            <cfprocresult name="associatedTuples">
        </cfstoredproc>
    </cffunction>

    <cffunction name="verifyCodeEmailCombo" access="public" returntype="query" hint="returns a tuple if an email is associated with a code and returns nothing otherwise">
        <cfargument name="email" type="string" required="yes" />
        <cfargument name="secure_code" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_verifyCodeEmailCombo" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@secure_code" value="#secure_code#">
            <cfprocresult name="associatedTuples">
        </cfstoredproc>.
        <cfreturn associatedTuples>
    </cffunction>

    <cffunction name="deleteEmailCodeEntry" access="public" returntype="void" hint="deletes a code/email entry after the user has successfully reset their password">
        <cfargument name="email" type="string" required="yes" />
        <cfstoredproc datasource="#variables.datasource#" procedure="usp_DeleteEmailCodeEntry" >
            <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@email" value="#email#">
            <cfprocresult name="isthisthingevenneeded[questionmark]">
        </cfstoredproc>
    </cffunction>

    <!--- these getters work with the private function, getUserInformation() --->     
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

    <cffunction name="getUserID" access="public" returntype="string" hint="returns the currently logged in UserID">
        <cfreturn getUserInformation().userID>
    </cffunction>

</cfcomponent>