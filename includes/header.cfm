<cfset GLOBAL_DATASOURCE = 'dsTestDatabaseSqldev1'>

<!--- if the user navigates to the login/index page, then log said user out --->
<cfif #CGI.SCRIPT_NAME# EQ "/login.cfm" OR #CGI.SCRIPT_NAME# EQ "/index.cfm">
	<cflogout>
</cfif>

<!--- I can just add all of these to an array called, "allowed pages" or something --->
<cfif getAuthUser() EQ "">
	<cfif #CGI.SCRIPT_NAME# NEQ "/login.cfm" AND #CGI.SCRIPT_NAME# NEQ "/index.cfm" AND #CGI.SCRIPT_NAME# NEQ "/registration.cfm" 
	AND #CGI.SCRIPT_NAME# NEQ "/forgotten_name.cfm" AND #CGI.SCRIPT_NAME# NEQ "/forgotten_pass.cfm" AND #CGI.SCRIPT_NAME# NEQ "/action_page.cfm" AND #CGI.SCRIPT_NAME# NEQ "/checkout.cfm">
		<cfif NOT isDefined("cflogin")>
			<cflocation 
				url="login.cfm"
				addtoken="false" />
		</cfif>
	</cfif>
</cfif>

<!--- user is logged in but is trying to access admin pages --->
<cfif getAuthUser() NEQ 'admin'>
	<cfif #CGI.SCRIPT_NAME# EQ '/users_view.cfm'>
		<cflocation 
			url="user_homepage.cfm"
			addtoken="false" />
	</cfif>
</cfif>

<cfquery name="loginQuery2" datasource="#GLOBAL_DATASOURCE#">
          SELECT *
          FROM Users2
          WHERE username = '#getAuthUser()#'
</cfquery>

<!--- "logged in as" header message --->

<!--- Replaced getAuthUser() with isDefined("LoggedUser") --->
<cfif getAuthUser() NEQ "">
    <div class="container">
      <div class="row-fluid">
        <div class="span6 pull-right" style="text-align:right">
        	<cfoutput>
        		Logged in as #LoggedUser.getFirstName()# #LoggedUser.getLastName()#<br/>
        		Role: #LoggedUser.getUserRole()#
        	</cfoutput>
        </div>
      </div>
    </div>
</cfif>

<head>
	<title>ColdFusion Demo Pages</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../styles/bootstrap.3.3.6.modified.css">
	<!--- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> --->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>

<body>
	<div class="container">
		<div class="page-header" style="page-break-inside: avoid;">
			<a href="/login.cfm">
				<img src="images/logo.png" width="140" style="float: left; margin-top:-13px; margin-right: 15px;">
			</a>
	    	<h1>ColdFusion Demo Pages</h1>
	    </div>
    </div>
</body>