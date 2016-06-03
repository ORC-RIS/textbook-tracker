<!---
DESCRIPTION: Book Component
CREATED BY: David Elliott
DATE CREATED: 05/27/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:
FUNCTIONS: init, createBook, getAllBooks
DATE MODIFIED:
	06/01/2016 - datasource variable now stored in Application.cfc
	
--->

<cfcomponent displayname="qry_book" output="true" hint="Queries for Book Table.">
		
        <!--- 
		LEAVE COMMENTED OUT 
		<cfproperty name="ISBN" type="string" required="yes" hint="ISBN or other identifying number on back cover of textbook" >
        <cfproperty name="Title" type="string" required="yes" hint="Title of textbook" >
        <cfproperty name="Quantity" type="numeric" required="yes" hint="number of copies of textbook" > 
		--->
        
        <!--- Constructor Function to initialize component --->
		
        <cffunction name="init" access="public" returntype="void" hint="Constructor that creates Book object." output="yes">
        	<!--- TODO connect to database and store in cf property--->
        </cffunction>

        <!--- Function to create a book object using a stored procedure --->
        <cffunction name="createBook" access="public" returntype="boolean" hint="Add a book to the Book table">
    		<cfargument name="ISBN" type="string" required="yes" hint="ISBN or other number string on back cover of text">
    		<cfargument name="Title" type="string" required="yes" hint="Title of text">
    		<cfargument name="Quantity" type="string" required="yes" hint="Number of copies">

        		<cfstoredproc procedure="usp_BookCreate" >
                       	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@ISBN" value="#ISBN#">
    					<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@Title" value="#Title#">
    					<cfprocparam cfsqltype="cf_sql_int" dbvarname="@Quantity" value="#Quantity#">

            		<!--- <cfprocresult name="returnName"> --->
        		</cfstoredproc>
        	<!--- <cfreturn returnName>	 --->
	
		</cffunction>
        
        <!--- Function to call stored procedure to return all book objects --->
        <cffunction name="getAllBooks" access="public" returntype="query" hint="Returns a result set of all Books.">
         		<cfstoredproc procedure="usp_AllBooks">
                    		<cfprocresult name="rsBookList">
        		</cfstoredproc>
        	<cfreturn rsBookList>
    	</cffunction>

        <!--- in progress :^) --->
        <cffunction name="getMyBooks" access="public" returntype="query" hint="Returns a result set of all Books belonging to the current user.">
                <cfquery name="rsBookList">
                        SELECT U.title, U.ISBN
                        FROM Users2 AS U
                </cfquery>
            <cfreturn rsBookList>
        </cffunction>
        
        
</cfcomponent>