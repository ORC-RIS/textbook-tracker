<html>
  <cfinclude template="includes/header.cfm">
  
  <cfquery name="allUsersQuery" datasource="#GLOBAL_DATASOURCE#" result="tmpResult">
        SELECT username, first_name, last_name, email
        FROM Users2
        WHERE username <>
          <cfqueryparam cfsqltype ="cf_sql_varchar" value="admin">
  </cfquery>

  <cfset tuple_position = 1>

  <body>
    <div class ="jumbotron">

      <div class="container">
        <h2>Users Table</h2>
      </div>

      <div class="container">
        <p>
        <div class="table-responsive">

          <table class="table table-striped table-bordered">
            <thead class="thead-inverse">
              <tr>
                <th>#</th>
                <th><b>username</b></th>
                <th><b>first name</b></th>
                <th><b>last name</b></th>
                <th><b>email address</b></th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="allUsersQuery">
                <tr>
                  <th scope="row"><cfoutput>#tuple_position#</cfoutput><cfset tuple_position = tuple_position + 1></th>
                  <cfoutput><td>#allUsersQuery.username#</td></cfoutput>
                  <cfoutput><td>#allUsersQuery.first_name#</td></cfoutput>
                  <cfoutput><td>#allUsersQuery.last_name#</td></cfoutput>
                  <cfoutput><td>#allUsersQuery.email#</td></cfoutput>
                </tr>
              </cfloop>
            </tbody>
          </table>
        
        </div>
        </p>
      </div>
      
      <div class="container">
        <form action="index.cfm" method="POST">
          <input type="submit" value="Back" class="btn btn-default" name="back">
        </form> 
      </div>

    </div>
  </body>

  <cfinclude template="includes/footer.cfm">
</html>