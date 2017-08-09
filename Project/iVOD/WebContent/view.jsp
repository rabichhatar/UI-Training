<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title> iVOD Scheduler</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/view.js"></script>
	<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/js/css_browser_selector.js" type="text/javascript"></script>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" media="all" />
	<link rel="shortcut icon" href="favicon.ico" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/globFunc.js"></script>
	<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>

<style>
	body{font-family:"Helvetica Neue",Helvetica,Arial,sans-serif}
	div.textbox {padding:10px 0;margin-left: 200px;}
	div.textbox > label {display:inline-block; width:250px !important; text-align:left;vertical-align: top;}
	div.textbox > div{display:inline-block;width:240px;}
	div.textbox > input{width:200px;}
	div.textbox > input.expand_collapse_btn{width:20px;}
	div.textbox > input.submit{width:auto;}
	#search_sbmt_div{clear: both; margin: 30px 0 50px 463px;float: left;}
	.add_btn, .remove_btn {height: 25px;width: 25px;margin-left: 158px;}
	#series_information td,#account_information td,#series_information_account td,#account_information_series td,#market_information_series td{ border: 1px solid #AAAAAA; padding: 10px;width: 185px;}
	#series_information tr.alt,#account_information tr.alt,#series_information_account tr.alt,#market_information_series tr.alt,#account_information_series tr.alt{background-color: #E0E0E0}
	#series_information th,#account_information th,#series_information_account th,#account_information_series th,#market_information_series th{
		border: 1px solid #AAAAAA; padding: 10px; font-weight: bold;
		background: #f8f8f8;
		background: -moz-linear-gradient(top,  #f8f8f8 0%, #e8e8e8 100%);
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f8f8f8), color-stop(100%,#e8e8e8));
		background: -webkit-linear-gradient(top,  #f8f8f8 0%,#e8e8e8 100%);
		background: -o-linear-gradient(top,  #f8f8f8 0%,#e8e8e8 100%);
		background: -ms-linear-gradient(top,  #f8f8f8 0%,#e8e8e8 100%);
		background: linear-gradient(top,  #f8f8f8 0%,#e8e8e8 100%);
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f8f8f8', endColorstr='#e8e8e8',GradientType=0 );
	}
	#market_selector, #account_selector, #series_selector{ display: none;}
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
            	<h6 id="page_title">View Market</h6>
            	<div class="clear"></div>
            </div>
			
			<form>
			
				<div class="textbox" id="account_selector">
					<label for="Account">
						<strong><Span style="color:red">*</Span>Account:</strong>
					</label>
					<div>		
						<select class="search_opt" id="account_list">
							<option>Select Account</option>
						</select>
					</div>
				</div>	
				<div class="textbox" id="market_selector">
					<label for="Market">
						<strong><Span style="color:red">*</Span>Market:</strong>
					</label>
					<div>		
						<select class="search_opt" id="market_list">
							<option>Select Market</option>
						</select>
					</div>
				</div>
				<div class="textbox" id="series_selector">
					<label for="Series">
						<strong><Span style="color:red">*</Span>Series Title:</strong>
					</label>
					<div>		
						<select class="search_opt" id="series_list">
							<option>Select Series title</option>
						</select>
					</div>
				</div>	
				<div id="market_search_value_container" style="display:none">
				<div class="textbox">
					<label for="MarketGroup">
						<strong>Market Group:</strong>
					</label>
					<div>	
						<label for="MarketGroup" id="market_group">
						
						</label>
						</div>
						</div>
					<div class="textbox">	
					<label for="MarketDMAName">
						<strong>Market DMA Name:</strong>
					</label>
					<div>	
						<label for="MarketDMAName" id="market_dma_name">
							
						</label>
						</div>
						</div>
					<div class="textbox">	
					<label for="CdlList">
						<strong>CDL List:</strong>
					</label>
					<div>	
						<label for="CdlList" id="cdl_list">
							
						</label>
						</div>
						</div>
					<div class="textbox">
					<label for="TimeZone">
						<strong>Timezone:</strong>
					</label>
					<div>	
						<label for="TimeZone" id="time_zone">
							
						</label>
						</div>
						</div>
						<div class="textbox">
						<label for="Description">
						<strong>Description:</strong>
					</label>
					<div>	
						<label for="Description" id="description">
							
						</label>
						</div>
						</div>
					<div class="textbox">
						<strong>Series</strong>
						<input id="seriesExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="exandSeries();">		
						<input id="seriesCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeries();" style="display:none;">		
						
					</div>			
					<div id="series_information" style="display:none;" class="textbox">No Series Present</div>
					<div class="textbox">
						<strong>Account</strong>
						<input id="accountExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandAccount();">
						<input id="accountCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseAccount();" style="display:none;">	
						
					</div>			
					<div id="account_information" style="display:none;" class="textbox">No Account Present</div>
						
						
					</div>
					
				<div id="account_search_value_container" style="display:none">
				<div class="textbox">
					<label for="BillingAccountName">
						<strong>Billing Account Name:</strong>
					</label>
					<div>	
						<label for="BillingAccountName" id="billing_account_name">
						
						</label>
						</div>
						</div>
					<div class="textbox">	
					<label for="X1AccountID">
						<strong>X1 Account ID:</strong>
					</label>
					<div>	
						<label for="X1AccountID" id="x1_account_id">
							
						</label>
						</div>
						</div>
					<div class="textbox">	
					<label for="DvrVirtualRecorderId">
						<strong>DvrVirtualRecorderId:</strong>
					</label>
					<div>	
						<label for="DvrVirtualRecorderId" id="dvr_virtual_recorder_id">
							
						</label>
						</div>
						</div>
					<div class="textbox">
					<label for="Market">
						<strong>Market:</strong>
					</label>
					<div>	
						<label for="Market" id="account_market">
							
						</label>
						</div>
						</div>
						<div class="textbox">
						<label for="Description">
						<strong>Description:</strong>
					</label>
					<div>	
						<label for="Description" id="account_description">
							
						</label>
						</div>
						</div>
					<div class="textbox">
						<strong>Series</strong>
						<input id="accountSeriesExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandAccountSeries();">		
						<input id="accountSeriesCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseAccountSeries();" style="display:none;">		
						
					</div>			
					<div id="series_information_account" style="display:none;" class="textbox">No Series Present</div>
					
						
					</div>
					
					
				<div id="series_search_value_container" style="display:none">
					<div class="textbox">
						<label for="SeriesID">
							<strong>Series ID:</strong>
						</label>
						<div>	
							<label for="SeriesID" id="series_id">
							
							</label>
						</div>
					</div>
					
					<div class="textbox">	
						<strong>Market</strong>
						<input id="seiresMarketExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandSeriesMarket();">
						<input id="seiresMarketCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeriesMarket();" style="display:none;">	
					
					</div>	
					<div id="market_information_series" style="display:none;" class="textbox">No Market Present</div>
						
					
					<div class="textbox">
						<strong>Account</strong>
						<input id="seriesAccountExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandSeriesAccount();">
						<input id="seriesAccountCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeriesAccount();" style="display:none;">	
						
					</div>			
					<div id="account_information_series" style="display:none;" class="textbox">No Account Present</div>
						
						
					</div>
						
				</div>	
				</div>		
			</form>
			<div id="responseMsg"></div>
			<div class="responseMsg1"></div>
			<div class="id"></div>
		</div>
		
	</div>
</div>
    <!---------- header ends here ---------->
    <!---------- mainnav starts here ---------->

<div id="mainnav">
  
</div>
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
<!--<div id="footer-general"> </div>-->
</div>
</div>
<div id="market_list" title="List Of Markets Selected"></div>

<%
       session.removeAttribute("queryRsp");
       
       session.removeAttribute("title");
%>
 
<script>
var applicationPath = '<%=request.getContextPath()%>';
var responseType = "<%=(request.getParameter("type")!=null?(String)request.getParameter("type"):"ivodSeries")%>";
var flag = true;
var validSeriesId = false;
var tempSerId = "";

$(function(){
	$(".tabDiv ul li").removeClass("active");
	$("#ivodSeries").addClass("active");
});

</script>
</body>
<!-- InstanceEnd -->
</html>