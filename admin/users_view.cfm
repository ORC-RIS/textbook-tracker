<html>
  <cfinclude template="/includes/header.cfm">
  
  <cfset User = CreateObject("components/user") />
  <cfset User.init(Application.datasource, "#getAuthUser()#", "") />

  <cfset allUsersQuery = User.getAllUsers() >

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
                <th><b>role</b></th>
              </tr>
            </thead>
            <tbody>
              <cfoutput query="allUsersQuery" startrow="1">
                <tr>
                  <th>#allUsersQuery.CurrentRow#</th>
                  <td>#allUsersQuery.username#</td>
                  <td>#allUsersQuery.firstname#</td>
                  <td>#allUsersQuery.lastname#</td>
                  <td>#allUsersQuery.email#</td>
                  <td>#allUsersQuery.userrole#</td>
                </tr> 
              </cfoutput>
              </table>
        </div>
        </p>
      </div>
      
      <div class="container">
        <form action="/security.cfm" method="POST">
          <input type="submit" value="Back" class="btn btn-default" name="back">
        </form> 
      </div>

    </div>
  </body>

  <cfinclude template="/includes/footer.cfm">
</html>