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
            <cfdump var="#form#">
			<cfset datasource = Application.datasource />
            <cfset Book = CreateObject("components/qry_book") />
            <cfset Book.init(datasource) />

			<!--- retrieve book component from bookstore --->
            <cfset bookID = #FORM.CheckoutBook# />
            <cfset book = Book.getBook(bookID) />

			<!--- retrieve userID from session --->
			<cfset userID = #getAuthUser()#>
            
			<!--- verify book --->
    		<cfdump var="#getAuthUser()#" >
          
			
            <!--- Add button to confirm checkout--->
            <form id="checkout-confirm" action="bookstore.cfm" method="POST">
            	<input type="hidden" value="#BookID#" name="book">
                
				<button name="ConfirmCheckout" value="Back" type="button" form="checkout-confirm">Confirm</button>
                
			</form>
            <cfdump var="#DateFormat(Now(), "yyyy-mm-dd")#" />

            <!--- if button is pressed --->
            <cfif StructKeyExists(FORM, "ConfirmCheckout")>
            	<!--- Create a Loan Object--->
            	<cfset Checkout = CreateObject("components/qry_checkout").init(datasource) />
          		<cfif Checkout.createCheckout("#userID#", "#FORM.book#")>
 					<cfoutput>#Checkout#</cfoutput>
                    <cfelse>
                    <cfoutput>#cgi#</cfoutput>
                </cfif>
            </cfif>
            
           	 <!--- button to "cancel"--->
		</div>
	</div>
	
	<hr>
    <form action="../bookstore.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>
      
</body>

</html>

 