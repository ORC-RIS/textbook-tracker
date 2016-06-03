<!---
DESCRIPTION: Textbook Tracker page
CREATED BY: David Elliott
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED:
--->

<!DOCTYPE html>
<html>
	<cfoutput>
		<link href="bookstoreCSS.css" rel="stylesheet" type="text/css">
		<link href="../styles/bootstrap.3.3.6.modified.css" rel="stylesheet" type="text/css">
	</cfoutput>
<head>
	<title>RIS Textbook Management</title>
</head>

<body>

	<div>
		<h1>TEXTBOOK TRACKER</h1>
	</div>

	<div>
		<div>
			<h3>CURRENT INVENTORY:</h3>
			
			<!--- List all books in inventory--->
			
			<cfif structKeyExists(FORM, 'bookstore_request')>
				<!--- <cfinvoke component="components.qry_book" method="getMyBooks" returnvariable="rsBooks" >
				</cfinvoke> --->

				<cfinvoke component="components.qry_book" method="getAllBooks" returnvariable="rsBooks" >
				</cfinvoke>
			</cfif>
			
			<ul>
			<cfoutput query="rsBooks">
				<li>#rsBooks.title# #rsBooks.ISBN#</li>
			</cfoutput>
			</ul>
		</div>
	</div>
	
	<hr>
    <form action="../index.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>
      
	
</body>

</html>