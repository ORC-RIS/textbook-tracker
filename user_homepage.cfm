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
      <form action="bookstore.cfm" method="POST">
        <!--- <input type="submit" value="View My Books" class="btn btn-info" name="bookstore_request_mine"> --->
        <input type="submit" value="View Books" class="btn btn-info" name="bookstore_request">
      </form>
    </div>

    <div class="container">
  	  <form action="/security.cfm" method="POST">
  		  <input type="submit" value="Sign Out" class="btn btn-default" name="logout">
  		  <input type="submit" value="Change Password" class="btn btn-default" name="change_pass">
  	  </form>
  	</div>
	   
	 </div>
  </body>

  <cfinclude template="includes/footer.cfm">
</html>