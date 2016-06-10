<!---
DESCRIPTION: Textbook Tracker page
CREATED BY: David Elliott,
			John Lynch
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED:
--->

<!DOCTYPE html>
<html>
	<cfoutput>
		<link href="styles/bookstoreCSS.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="../styles/bootstrap.3.3.6.modified.css">
	</cfoutput>

<head>
	<title>RIS Textbook Management</title>
</head>

<body>

	<div>
		<h1>TEXTBOOK TRACKER</h1>

		<!--- test, be sure to remove --->
		<cfoutput>logged in as user: <h4>#getAuthUser()#</h4></cfoutput>
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

			<table width="1000" align="center" cellspacing="0" border="1">
					<th>ISBN</th>
					<th>Title</th>
					<th>Availability</th>
				</tr>
				<cfoutput query="allBooks" startrow="1">
					<tr>
						<td>#ISBN#</td>
						<td>#Title#</td>
						<td align="center">
							<cfif Quantity GTE 1>
								<form id="book-actions" action="checkout.cfm" method="GET">
									<button name="CheckoutBook" type="submit" form="book-actions" value="#BookID#">Checkout</button>
								</form>
								<cfelse>
									<button form="book-actions">Email Waitlist</button>
							</cfif>

						</td>
					</tr>	
				</cfoutput>
			</table>
		</div>
	</div>
<!--- 	<cfform>
		<cfinput name="firstname" type="text" placeholder="First Name">
			
		</cfinput>
	</cfform> --->
	<hr>
    <form action="/security.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>
      
</body>

</html>