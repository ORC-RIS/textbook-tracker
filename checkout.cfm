<!---
DESCRIPTION: Textbook Tracker page
CREATED BY: David Elliott, Raphael Saint Louis
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED:
--->

<!DOCTYPE html>
<html>
	<cfoutput>
		<link href="../cfapp/textbook-tracker/bookstoreCSS.css" rel="stylesheet" type="text/css">
		<link href="../cfapp/styles/bootstrap.3.3.6.modified.css" rel="stylesheet" type="text/css">
	</cfoutput>

<head>
	<title>RIS Textbook Management</title>
</head>

<body>

	<div>
		<h1>Textbook Tracker</h1>
	</div>

	<div>
		<div>
			<h3>Loan Confirmation:</h3>
            <!--- retrieve datasource from Application.cfc --->
			<cfset datasource = Application.datasource />
            <cfset Book = CreateObject("components/qry_book") />
            <cfset Book.init(datasource) />

			
			<cfset bookID = #url.CheckoutBook# />
			<cfset book = Book.getBook(bookID) />

    		<cfdump var="#book#" >
          
			<!--- retrieve book component from bookstore --->
			
			<!--- retrieve user component from bookstore --->
            
            <!--- Create a Loan Object--->
            <cfset Checkout = CreateObject("components/qry_checkout") />

            <!--- Call the Checkout's constructor and pass in the datasource--->
            <cfset Checkout.init(datasource) />
            
			<!--- verify Loan object--->
            
            <!--- button to "ok"--->


		</div>
	</div>
	
	<hr>
    <form action="../bookstore.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>
      
</body>

</html>