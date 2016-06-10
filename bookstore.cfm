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
	 	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
	 	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	</cfoutput>

<head>
	<title>RIS Textbook Management</title>
</head>

<body>

	<header>
		<h1>TEXTBOOK TRACKER</h1>

		<!--- test, be sure to remove --->
		<cfoutput>logged in as user: <h4>#getAuthUser()#</h4></cfoutput>
	</header>

	<div class="container-fluid">
		<div class="content">
			<h3>CURRENT INVENTORY:</h3>
			<!--- retrieve datasource from Application.cfc --->
			<cfset datasource = Application.datasource />
            
            <!--- Create a book Object--->
            <cfset Book = CreateObject("components/qry_book") />
            
            <!--- Call the book's constructor and pass in the datasource--->
            <cfset Book.init(datasource) />
            
            <!--- Object to hold return data--->
            <cfset allBooks = Book.getAllBooks() />


				

			<cfif structKeyExists(FORM, "joinWait")>
				<cfset New_WaitList_User = CreateObject("components/inventory") />
		        <cfset New_WaitList_User.init(Application.datasource, "#FORM.username#", "#FORM.bookid#", "#FORM.title#") />

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

			<style>
				td {padding: 5px 15px;}
			</style>
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
									<button name="CheckoutBook" type="button" form="book-actions" value="#BookID#">Checkout</button>
								</form></td>
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
												<p> User: #LoggedUser.getUserName()# <br/>
													Book: #Title#<br/>
													Date: #DateFormat(Now(), "yyyy-mm-dd")#
												</p>
												<div style="text-align:right;">
													<form action="bookstore.cfm" method="POST">
														<input type="hidden" value="#LoggedUser.getUserName()#" name="username">
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