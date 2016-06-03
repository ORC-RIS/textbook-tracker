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
			<!--- retrieve datasource from Application.cfc --->
			<cfset datasource = Application.datasource />
            
            <!--- Create a book Object--->
            <cfset Book = CreateObject("components/qry_book") />
            
            <!--- Call the book's constructor and pass in the datasource--->
            <cfset Book.init(datasource) />
            
            <!--- Object to hold return data--->
            <cfset allBooks = Book.getAllBooks() />

            <!--- List all books in inventory--->
            <ul>
			<cfoutput query="allBooks" >
				<li>#allBooks.title# #allBooks.ISBN#</li>
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