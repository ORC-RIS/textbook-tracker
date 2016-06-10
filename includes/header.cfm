<cfset GLOBAL_DATASOURCE = 'dsTestDatabaseSqldev1'>

<!--- if the user navigates to the login/index page, then log said user out --->
<cfif #CGI.SCRIPT_NAME# EQ "/login.cfm" OR #CGI.SCRIPT_NAME# EQ "/index.cfm">
	<cflogout>
</cfif>

<!--- create the user object/component --->
<cfset LoggedUser = CreateObject("components/user") />

<!--- check to see if the user is trying to access a page for which he/she doesn't have permission to view --->
<cfif "#CGI.script_name#" contains "admin">
    <cfif #LoggedUser.getUserRole()# NEQ 'admin'>
        <cflocation url="/user_homepage.cfm" addtoken="false">
    </cfif>
</cfif>

<!--- user is logged in but is trying to access admin pages --->
<!--- should check for role, not username --->
<!--- <cfif getAuthUser() NEQ 'admin'>
	<cfif #CGI.SCRIPT_NAME# EQ '/users_view.cfm'>
		<cflocation 
			url="user_homepage.cfm"
			addtoken="false" />
	</cfif>
</cfif> --->

<cfquery name="loginQuery2" datasource="#GLOBAL_DATASOURCE#">
          SELECT *
          FROM Users2
          WHERE username = '#getAuthUser()#'
</cfquery>

<!--- "logged in as" header message --->

<!--- Replaced getAuthUser() with isDefined("LoggedUser") --->
<cfif getAuthUser() NEQ "">
	<cfset LoggedUser.init(Application.datasource, "#getAuthUser()#", "") />
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
	<title>Textbook Tracker</title>
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
				<img src="/images/logo.png" width="140" style="float: left; margin-top:-13px; margin-right: 15px;">
			</a>
	    	<h1>Textbook Tracker</h1>
	    </div>
    </div>
</body>