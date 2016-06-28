<!---
DESCRIPTION: Textbook Tracker page
AUTHORS: David Elliott, John Lynch, Raphael Saint Louis
DATE CREATED: 05/25/2016
INPUT PARAMETERS:
OUTPUT PARAMETERS:

Modification Log:
Date 		Action
=======================================
06/21/2016: added Bootstrap 3.3.6, added margins to body. When resizing, table now falls outside body when resizing.
06/22/2016: replaced HTML table with Bootstrap table component. Table now resizes.
06/23/2016: additional table styling
06/24/2016: Check In button added, Check In and Check Out buttons bootstrap formatting applied
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
        <cfset New_WaitList_User.init(Application.datasource,"#FORM.userID#","#FORM.bookid#","#FORM.title#")>
        <cfset ayylmao = New_WaitList_User.addUserToWaitlist("#FORM.date#")>
       <cfset ayylmao = New_WaitList_User.findQueuePosition("#FORM.date#")>
		
		<!--- Show user information regarding waitlist --->
		<script type="text/javascript">
			$(function() {
				$("#queuePos").modal('show');
			})
		</script>
	</cfif>

<!--- Check in a book --->
	<cfif structKeyExists(FORM, "CheckInBook")>
		<cfset isCheckedIn = Book.checkInBook("#FORM.userID#", "#FORM.bookid#")>
			<cfoutput> 
				<div class="alert alert-success">
					Book successfully returned.
				</div>	
					<hr>
			    <form name="backToList" action="bookstore.cfm" align="center" method="POST">
			    	<button name="affirmCheckin" value="Back" class="btn btn-warning" type="submit">Back</button>
			    </form>
			    <!--- code below will return book without confirmation or additional step --->
				<!--- <cflocation url="bookstore.cfm" addtoken="false"> --->
			<cfabort>
	    </cfoutput>
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

		<div class="container">
		<table class="table table-striped">
			<thead>
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
			</thead>

			<tbody>
			<table class="table table-hover">
			<cfoutput query="allBooks" startrow="1">
				<tr class="warning"> <!--- make the table yellow --->
				<div class="row" >
					<td class="col-xs-2" style="vertical-align:middle" >#ISBN#</td>
					<td class="col-xs-8" style="vertical-align:middle">#Title#</td>
					<td class="col-xs-2" style="text-align:center">
						<cfif LEN(#UserID#) EQ 0>
							<form id="book-actions" action="/checkout.cfm" method="POST">
								<button name="CheckoutBook" class="btn btn-success btn-block" type="submit" form="book-actions" value="#BookID#">Check Out</button>
							</form></td>

							<cfelseif #UserID# EQ "#LoggedUser.getUserID()#">
									<form id="return-book" action="bookstore.cfm" method="POST">
										<input type="hidden" value="#LoggedUser.getUserID()#" name="userID">
										<input type="hidden" value="#BookID#" name="bookid">
										<button name="CheckInBook" class="btn btn-info btn-block" type="submit" form="return-book">Check In</button>
									</form></td>
							
							<cfelse>
								<button name="Join" class="btn btn-sm btn-block" data-toggle="modal"
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
			</tbody>
		</table>
		</div>	
	</div>

	<hr>
    <form action="/security.cfm" align="center" method="POST">
    	<input type="submit" class="btn btn-default" value="Back" name="return_from_books">
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>

</html>