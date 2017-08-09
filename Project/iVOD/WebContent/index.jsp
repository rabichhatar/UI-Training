<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>iVOD Scheduler</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %> media="screen" />
<link rel="shortcut icon" href="favicon.ico" />

	
<script language="javascript" type="text/javascript">
</script>
<style>
p.textbox label {
	display: inline-block;
	width: 250px;
}

p .textbox input {
	width: 200px;
}
#details{
 margin-top:50px;
}


</style>

</head>

<body>

<form method="post" action="scheduleseries.jsp">
	<div id="wrapper">
		<!---------- header starts here ---------->
		<div id="header">
			<div class="top-nav-bar" id="navigationplaceholder_0_topNavBar">
				<div class="top-nav-links" id="top-header">
					<ul>
						<li><a style="color: #FFF; font-size: 10px;" target="_blank"
							href="#">About</a></li>
						<li><a style="color: #FFF; font-size: 10px;" href="#">ivodsch</a></li>
					</ul>
				</div>
			</div>

			<div class="header-secondary-gradient">
				<div class="header">
					<h1>
						<a class="comcast-logo" href="http://www.comcast.com/customer-home" target="_blank">Comcast</a>
					</h1>
				</div>
			</div>
			<div class="subheader-container">	</div>
			<div id="details" style="text-align: center">
				<fieldset>
				<!--  <legend style="color:blue" "float:right">User Credentials</legend>-->
					<p class="textbox">
						<label for="User Name"><b>User Name:</b></label> <input
							type="text" name="name" size="25"></br>
						</br>
					</p>
					<p class="textbox">
						<label for="Password"><b>Password:</b></label> <input type="password" name="password"
							size="25"></br>
						</br>
					</p>
				
					<p class="textbox">
						<label for="mydropdown""><b>User Type:</b></label> <select name="usertype">
							<option hidden="true">Please select a User Type</option>
							<option value="admin">admin</option>
							<option value="user">user</option>
							
						</select></br>
						</br> <input class="submit" type="submit" value="submit">
						</p>
					
				</fieldset>
				
			</div>
	
		<div id="mainnav"></div>
		<div id="main" style="min-height:100px; max-height:70%">
			
			
		</div>
		<!---------- main content panel ends here ---------->
		<!---------- Footer Start here ---------->
		<div id="footer-container">
			
			<div id="footer-links-container">
				<p>
					<a>Useful links:</a>
				</p>
				<p style="color: #BBBBBB; positive: relative:-30px;">
					<a href="#" class="nopadd">Contact Us</a> | <a href="#">Sitemap</a>
					| <a href="#">About US</a> | <a href="#">Sample link</a>
				</p>
				<div>
					<p>
						<a>Comcast &copy 2014</a>
					</p>
					<br />
				</div>
				
			</div>
		</div>

	</div>
	</form>
</body>
<!-- InstanceEnd -->
</html>