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
    <cfinclude template="/includes/header.cfm">
    <cfset user = #getAuthUser()#>
   <!--- <h1 class="text-center"> 
        <cfoutput>
            So you want to rent a book, #user#?
        </cfoutput>
    </h1> --->
    
	<title>RIS Textbook Management</title>


</head>

<body>

<cfset CheckBook = #FORM.CheckoutBook#>
<div class="jumbotron">
	<div class="container">

	</div>

	<div class="container-fluid" >
		<div>
			<h3>Loan Confirmation</h3>
            <!--- <cfdump var="#form#"> --->

<!---             <cfoutput>
                CheckBook is #CheckBook#
                Checkout Book is #FORM.CheckoutBook#
            </cfoutput> --->

             <!--- retrieve datasource from Application.cfc --->
            <cfset datasource = Application.datasource />
            <cfset Book = CreateObject("components/qry_book") />
            <cfset Book.init(datasource) />    
                   
            <!--- if form request is GET --->
            <cfif #request_method# IS "GET">
                <h3 style="color:red">You should not be here.</h3>
            </cfif>

            <!--- if form request is POST --->
            <cfif #request_method# IS "POST">
                <!--- validate --->
           
                <cfif StructKeyExists(FORM, "ConfirmCheckout")>
                    <cfdump var="#form#" label="2nd Form">

                    <!--- <cfdump var="#Int(checkoutbook)#" label="Book ID"> --->

                    <cfset bookID = FORM.CheckoutBook>
                    <cfset thisUser = CreateObject("components/user") />
                    <cfset thisUser.init(datasource, user, "") />

                    <cfset Checkout = CreateObject("components/qry_checkout") />
                    <cfset Checkout.init(datasource) />
                        
                        <cfif Checkout.createCheckout("#Int(checkoutbook)#", "#thisUser.getUserID()#")>
                            <cfdump var="#Checkout#" >
                            
                            <cfelse>
                                <cfdump var="#cgi#" label="failed checkout" >
                        </cfif>

                    <cfelse>


                    <cfdump var="#form#" label="First Form">
                    
                    <cftry>
                        <!--- verify book and print to screen--->
                        <cfset book = Book.getBook(checkoutbook) />
                        <!--- <cfdump var="#book#"> --->
                        <cfoutput>
                            <p>Request to rent: #book.title#</p>
                        </cfoutput>
                        <cfcatch type = "UndefinedElementException">
                            <h3>Book ID not available. You should not be here.</h3>
                            <cfoutput>
                            <p>#cfcatch.message#</p>
                            <p>Caught exception type = #cfcatch.type#</p>
                            </cfoutput> 
                        </cfcatch> 
                    </cftry>


                     <!--- Add button to confirm checkout--->
                    <cfoutput>
                        <form id="checkout-confirm" action="checkout.cfm" method="POST">
                            <input type="hidden" value="#checkoutbook#" name="CheckoutBook">
                            <button name="ConfirmCheckout" value="Back" type="submit" form="checkout-confirm">Confirm</button>
                        </form> 
                    </cfoutput>               

                </cfif>            
                    
    			<!--- </form> --->

                <cfdump var="#DateFormat(Now(), "yyyy-mm-dd")#" />

                    <!--- if button is pressed --->

            
           	 <!--- button to "cancel"--->
             </cfif> <!--- end if POST--->
		</div>
	</div>
</div>	
	<hr>
    <form action="../bookstore.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</body>

</html>

 