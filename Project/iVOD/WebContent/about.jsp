<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>iVOD Scheduler</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
	<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" media="all" />
	<link rel="shortcut icon" href="favicon.ico" />
		
	<script language="javascript" type="text/javascript"></script>
	<style>
	p {font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;}
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
		<jsp:include page="header.jsp"></jsp:include>
		<!---------- header ends here ---------->
		<div class="container">
			<div class="widget fluid">
	            <div class="whead">
	            	<h6 id="page_title">About</h6>
	            	<div class="clear"></div>
	            </div>
			
				<div style="padding: 0 30px 30px;">   
					 <p><h5> Ver: Beta 0.4</h5></p><br/>
			
			         <p><h5>What&#39s iVOD ?</h5></p><br/>
			
			         <p>The Instant Video On Demand (iVOD) product offers X1 subscribers near real-time access to on demand viewing of 
			            popular linear content. X1 subscribers who join a program after it has started will be able to watch from the beginning by 
			            accessing the content through the iVOD menu. Furthermore, iVOD will eliminate the traditional availability gap between program 
			            airing and next day arrival of the &#39pitched&#39 VOD asset.</p><br/>
			
			         <p><h5> What&#39s this website ?</h5></p><br/>
			            
			         <p>ivodsch stands for iVOD Scheduler. This website allows users to Schedule Series, 
			            Add Markets and Accounts to the iVOD ecosystem. Individual episodes or shows cannot be scheduled at this point in time.</p>
			            
		        </div> 
		   </div>	
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