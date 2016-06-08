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

			<style type="text/css">
				table {border-collapse: collapse;}
				table tr:nth-child(even) {background-color: #f2f2f2;}
			</style>

			<table width="1000" cellspacing="0" border="1">
				<tr bgcolor="#d0d0d0">
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
								<form id="book-actions" action="../checkout.cfm" method="GET">
									<button name="CheckoutBook" type="submit" form="book-actions" value="#ISBN#">Checkout</button>
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
    <form action="../index.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>
      
</body>

</html>