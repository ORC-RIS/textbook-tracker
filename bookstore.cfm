<!---
DESCRIPTION: Textbook Tracker page
CREATED BY: David Elliott,
			John Lynch
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

DATE MODIFIED:
06/21/2016: added Bootstrap 3.3.6, added margins to body. When resizing, table now falls outside body when resizing.
06/22/2016: replaced HTML table with Bootstrap table component. Table now resizes.
--->

<!DOCTYPE html>
<html>
	<cfoutput>
		<link href="../cfapp/styles/bootstrap.3.3.6.modified.css" rel="stylesheet" type="text/css">
		<link href="styles/bookstoreCSS.css" rel="stylesheet" type="text/css">
	</cfoutput>

<head>
	<cfinclude template="/includes/header.cfm">
	<cfset datasource = Application.datasource /> <!--- retrieve datasource from Application.cfc --->
    <cfset Book = CreateObject("components/qry_book") /> <!--- Create a book Object--->
    <cfset Book.init(datasource) /> <!--- Call the book's constructor and pass in the datasource--->
    <cfset allBooks = Book.getAllBooks() /> <!--- Object to hold return data--->	
</head>

<body>
	<cfif structKeyExists(FORM, "joinWait")>
		<cfset New_WaitList_User = CreateObject("components/inventory") />
        <cfset New_WaitList_User.init(Application.datasource,"#FORM.userID#","#FORM.bookid#","#FORM.title#") />
        <cfset ayylmao = New_WaitList_User.addUserToWaitlist("#FORM.date#")>
        <cfset ayylmao = New_WaitList_User.findQueuePosition("#FORM.date#")>
		
		<!--- Show user information regarding waitlist --->
		<script type="text/javascript">
			$(function() {
				$("#queuePos").modal('show');
			})
		</script>
	</cfif>

    <div id="queuePos" class="modal fade">
    	<div class="modal-dialog">
        	<div class="modal-content">
        		<div class="modal-header">
					<button class="close" data-dismiss="modal">&times;</button>
        			<h4>You are now on the waiting list!</h4>
        		</div>
				<div class="modal-body">
					<cfif structKeyExists(FORM, "joinWait")>
						<cfoutput><p>You have succeessfully been added to the waiting list for #New_WaitList_User.Title#</p>
						<p>Your current queue position: #ayylmao.RecordCount#</p></cfoutput>
					</cfif>
				</div>	
        	</div>
    	</div>
    </div>

	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<h3>Current Inventory</h3>
			</div>
		</div>	

		<table class="table table-striped table-bordered">
			<!--- <thead> --->
			<div class="row">
				<div class="col-xs-2" style="text-align:center">
					<h4>ISBN</h4>
				</div>
				<div class="col-xs-8">
					<h4>Title</h4>
				</div>
				<div class="col-xs-2" style="text-align:center">
					<h4>Availability</h4>
				</div>
			</div>
			<!--- </thead> --->

			<!--- <tbody> --->
			<cfoutput query="allBooks" startrow="1">
				<tr>
				<div class="row">
					<td class="col-xs-2" style="text-align:center">#ISBN#</td>
					<td class="col-xs-8">#Title#</td>
					<td class="col-xs-2" style="text-align:center">
						<cfif #DateOut# EQ "">
							<form id="book-actions" action="/checkout.cfm" method="POST">
								<button name="CheckoutBook" type="submit" form="book-actions" value="#BookID#">Checkout</button>
							</form></td>

							<!--- TODO add check if user has book checked out, button should offer CHECK IN option  --->
<!--- 								<cfif #DateIn# EQ NULL AND #UserID# NEQ #FORM.userID#>
								<form id="return-book" action="/checkin.cfm" method="POST">
									<button name="CheckInBook" type="submit" form="return-book" value="#BookID#">Check In</button>
							</cfif>  --->

							<cfelse>
								<button name="Join" class="btn btn-sm" data-toggle="modal"
								data-target="##WaitlistPopup">Join Waitlist</button></td>
							<div id="WaitlistPopup" class="modal fade">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button class="close" data-dismiss="modal">&times;</button>
											<h3>Join Waitlist</h3>
										</div>

										<div class="modal-body">
											<p style="text-align:center;">This book is currently unavailable. Would you like to join the waitlist for:<br> <strong>#Title#</strong>?</p>
											<p> User: #LoggedUser.getUserName()#<br/>
												User ID: #LoggedUser.getUserID()#<br/>
												Book: #Title#<br/>
												Date: #DateFormat(Now(), "yyyy-mm-dd")#
											</p>
											<div style="text-align:right;">
												<form action="bookstore.cfm" method="POST">
													<input type="hidden" value="#LoggedUser.getUserID()#" name="userID">
													<input type="hidden" value="#BookID#" name="bookid">
													<input type="hidden" value="#Title#" name="title">
													<input type="hidden" value="#DateFormat(Now(), "yyyy-mm-dd")#" name="date">
													<button name="joinWait" value="Back" type="submit" class="btn btn-default">Join</button>
												</form>
												<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
											</div>
										</div>
									</div> <!--- End modal-content --->
								</div>
							</div> <!--- End Waitlist Popup --->
						</cfif>

					</td>
				</div>
				</tr>
			</cfoutput>
			<!--- </tbody> --->
		</table>	
	</div>

	<hr>
    <form action="/security.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>

</html>