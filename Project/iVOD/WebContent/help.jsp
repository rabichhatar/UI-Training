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
	            	<h6 id="page_title">Help</h6>
	            	<div class="clear"></div>
	            </div>
				<div style="padding: 0 30px 30px;">
				<p><h5 style="text-align:left" >Overview</h5></p><br/>
				<p style="text-align:left">iVOD Scheduler (ivodsch) helps comcast operators to schedule the recording of all future episodes of a series. 
				At this point, it doesn&#39t allow scheduling non-series type programs or single shows. iVOD scheduling is allowed at a Market level. 
				Multiple Markets can be selected for a single scheduling request. </p>&nbsp;
				
				<p style="text-align:left">A Market is a logical entity comprising of a group of CDLs. Each CDL represents a geographic region(usually a city).</p> &nbsp;
				
				<p style="text-align:left">One or more accounts can be tied to a market. When a market is selected on a scheduling request, all accounts belonging to the market are processed.</p>&nbsp; 
				
				<p style="text-align:left">This website allows users to add new Markets and Accounts to the iVOD ecosystem. A brief note on each of the website pages follows:</p>&nbsp;
				
				<p style="text-align:left"><h5 style="text-align:left">Schedule Series</h5></p><br/>
				
				<p style="text-align:left"><b>Merlin Series ID Search Box:</b> This dynamic search box is located at the top right side of the page. User can enter a partial series title to dynamically pull up all relevant matches. Each character that is typed or deleted causes the results to update on the fly. Selecting an entry from the results will automatically populate the Merlin SeriesID field.</p>&nbsp; 
				
				<p style="text-align:left"><b>Merlin SeriesID or MovieID:</b> User shall enter the SeriesID here - a numeric ID assigned to each series. If the user doesn&#39t know the SeriesID, then he could use the Series ID search box to search the series by title and populate this field automatically.</p>&nbsp;
				
				<p style="text-align:left"><b>&#34New Only&#34 or &#34New and Repeats&#34:</b> This is a Radio button option where user shall specify if only &#34New&#34 series should be scheduled or the repeats as well. By default, &#34New Only&#34 is selected.</p>&nbsp;
				
				<p style="text-align:left"><b>Record in the following markets:</b> This is a drop-down list of all the markets available for scheduling the series. User can select the required markets and click on the &#34Review selection&#34 link to review his selection. &#34Review Selection&#34 and &#34Reset Selection&#34 appears once a market is selected. Clicking on &#34Reset Selection&#34 will clear selected markets.</p>&nbsp; 
				
				<p style="text-align:left"><b>Submit Button:</b> Once all the required fields are filled with valid data, the submit button will be enabled. On clicking Submit button, the scheduling request is sent to the CDVR and if the request is valid and accepted, then a success confirmation message is displayed on the next page. If the submit fails, then an appropriate error message will appear and user will have a chance to update the data and re-submit.</p>&nbsp; 
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