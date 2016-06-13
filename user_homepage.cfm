<html>
  <cfinclude template="includes/header.cfm">
  
  <body>
	 <div class="jumbotron">
	  
	  <div class="container">
		  <h2>Home Page</h2>  
	  </div>    

  	<div class="container">
  	  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque, ante et pharetra blandit, nunc metus ullamcorper arcu, ut placerat diam augue eget purus. Maecenas semper turpis eu fermentum venenatis. Sed nibh nulla, finibus sed eleifend nec, cursus imperdiet erat. Nam ut nibh a dui porttitor pretium a sit amet urna. Maecenas et leo consequat orci porttitor maximus at at erat. Nam sit amet fermentum lectus, a vehicula dolor. Nunc ante ante, interdum vel pharetra vitae, rhoncus eu ex. Nam venenatis sapien vitae neque malesuada imperdiet. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut nec libero nulla. Quisque venenatis scelerisque elit, vitae tincidunt dolor porttitor in. Suspendisse euismod efficitur leo, at ultrices ipsum egestas sit amet. Curabitur vulputate eros turpis, vel luctus tellus gravida et. Nullam vitae justo gravida, ultrices eros vel, cursus ligula.
  	</div> <p></p>
  	
    <div class="container">
      <div class="dropdown">
          <a href="./bookstore.cfm" class="btn btn-primary" id="pgChoice">View Books</a><button id="viewPages" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><span class="caret"></span>
          </button>
          <ul class="dropdown-menu">
            <li><a href="##">View Books</a></li>
            <li><a href="##">View/Return My Books</a></li>
          </ul>
      </div>
    </div><p></p>

    <div class="container">
  	  <form action="/security.cfm" method="POST">
  		  <input type="submit" value="Sign Out" class="btn btn-default" name="logout">
  		  <input type="submit" value="Change Password" class="btn btn-default" name="change_pass">
  	  </form>
  	</div>
	   
	 </div>
  </body>

  <style type="text/css">
    #viewPages,
    #pgChoice {height: 34px;}

    #viewPages {
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
    }
    #pgChoice {
      color:white;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
    }
    /*#goToLink a{ color: white; }*/

  </style>
  <script type="text/javascript">
    $(function() {
      $(".dropdown .dropdown-menu li").click(function() {
        console.log($(this).text());
        $("#pgChoice").text($(this).text());
        if ($(this).text() == "View Books")
          $("#pgChoice").attr("href", "./bookstore.cfm")
        else if ($(this).text() == "View/Return My Books")
          $("#pgChoice").attr("href", "./mybooks.cfm")
      })
    });
  </script>

  <cfinclude template="includes/footer.cfm">
</html>