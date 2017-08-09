<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title> iVOD Scheduler</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
	<link rel="shortcut icon" href="favicon.ico" />
	
	<style type="text/css">
	.widget{width: 350px;}	
	.widget > [class*="whead"]{margin-bottom: 45px}
	.widget > [class*="whead"] h6{float: none;text-align: center;padding: 13px 32px}
	
	.widget > .form_footer {
	    border-top: 1px solid #cdcdcd;
	    border-bottom:none;
	    box-shadow: 0 1px 0 #fff;
	    margin-bottom: 1px;
	    margin-top:25px;
	    position: relative;
	    text-shadow: 0 1px #fff;
	}
	
	div.textbox {padding:10px 0;margin-left: 65px; clear: both; display: table;}
	div.textbox > input{width:186px; padding: 4px 26px 4px 11px; border: 1px solid #CDCDCD; height:20px; border-radius: 2px;
    box-shadow: 0 0 4px #d3d3d3; }
	div.textbox > input.submit{width:auto;}
	input[type="checkbox"]{margin:8px 4px 0px 0px}
	
	input.user{background: url(images/username.png) no-repeat 195px 2px #FFFFFF;}
	input.pass{background: url(images/password.png) no-repeat 195px 2px #FFFFFF;}

	.btn {
	    -moz-user-select: none;
	    background-image: none;
	    border: 1px solid transparent;
	    border-radius: 4px;
	    cursor: pointer;
	    display: inline-block;
	    font-size: 14px;
	    font-weight: 400;
	    line-height: 1.42857;
	    margin-bottom: 0;
	    padding: 4px 13px;
	    text-align: center;
	    vertical-align: middle;
	    white-space: nowrap;
	}
	.btn-primary {background-color: #707883;border-color: #5e5f5f;color: #fff;}
	.btn:hover{background-color: #545B65;}
	
	#errorDiv{ border: 2px solid #ee2324;color: #ee2324;display: none;float: left;font-weight: bold;padding: 5px 14px;text-align: center; margin-left: 6px;margin-top: 45px;position: absolute;}
</style>
</head>
<body>
<div id="wrapper">
 	<!---------- header starts here ---------->
 	<jsp:include page="header.jsp"></jsp:include>
	<!---------- header ends here ---------->
	
	<div class="container">
		<div class="widget fluid">
            <div class="whead">
            	<h6>iVOD Scheduler Login</h6>
            	<div class="clear"></div>
            </div>
            
            <div id="errorDiv">Your login attempt was not successful, try again.<br/> Reason: Bad credentials</div>
            
            <form action="" method="post">
	            <div class="textbox">
	           		<input id="username" class="user" type="text" value="" size="25" name="username" placeholder="Username"/>
	           	</div>
	           	<div class="textbox">
	           		<input id="password" class="pass" type="password" value="" size="25" name="password" placeholder="Password"/>
	           	</div>
	           	<div class="textbox" style="width: 225px;">
	           		<div style="float: left">
	           			<input type="checkbox" id="remember"/>
	           			<span style="color: #696969;">Remember</span>
	           		</div>
	           		<div style="float: right;">
	           			<input id="loginbutton" class="btn btn-primary" type="button" value="Login"/>
	           		</div>
	           	</div>
           	</form>
           	<div class="clear"></div>
           	<div class="whead form_footer">
           		<h6 style="font-weight: normal;">Please enter your Active Directory (NT) credentials or <a href="javascropt:void(0);" style="text-decoration: underline;">click here</a> to request access to iVOD Scheduler</h6>
           	</div>
        </div>
	</div>
	
	<!---------- header ends here ---------->
    <!---------- mainnav starts here ---------->
	<div id="mainnav"></div>
	<div id="main">
		<br><br><br><br><br><br>
		<br class="clearall" />
	</div>
	<!---------- main content panel ends here ---------->
	<!---------- Footer Start here ---------->
	<!---------- Footer Start here ---------->
	<div id="footer-container">
		<!--<ul id="footer-share">
		<li id="footer-comcast">
		<a alt="Comcast home page" href="#">
		</li>
		</ul>-->
		<div id="footer-links-container">
			<p><a>Useful links:</a></p>
			<p style="color: #BBBBBB; positive:relative:-30px;"><a href="#" class="nopadd">Contact Us</a> | <a href="#">Sitemap</a> | <a href="#">About US</a> | <a href="#">Sample link</a></p>
			<div>
				<p><a>Comcast&copy 2014</a></p><br/>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var applicationPath = "<%=request.getContextPath()%>";

$(function(){
	$("#loginbutton").click(function(){
		verifyCredentails();
	});
});

function verifyCredentails(){
	var username = $("#username").val();
	var password = $("#password").val();
	
	if(username=="test" && password=="test"){
		window.top.location.href = applicationPath+"/report.jsp";
	}else{
		$("#errorDiv").show();
	}
}
</script>
</body>
</html>