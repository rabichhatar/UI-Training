<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> iVOD Scheduler</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/schedule_series.js"></script>
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/css_browser_selector.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" media="all" />
<link rel="shortcut icon" href="favicon.ico" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/globFunc.js"></script>
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>

<style>
	div.textbox {padding:10px 0;margin-left: 210px;}
	div.textbox > label {display:inline-block; width:250px !important; text-align:left;vertical-align: top;}
	div.textbox > div{display:inline-block;width:240px;}
	div.textbox > input{width:200px;}
	div.textbox > input.submit{width:auto;}
	table tr td{text-align: left;}
	.from_table{border-collapse: collapse;border-spacing: 0;font-size:12px;text-align:left;}
	.from_table td{padding: 5px;vertical-align: baseline;}
	.mkt_div{color: #000000;font-size: 12px;margin-left: 32%;padding: 0;}
	.imgDescpn { position: absolute;background: rgba(29, 106, 154, 0.72);color: #fff;visibility: hidden;opacity: 0;width:234px;padding: 10px 5px;}
    .shw{visibility: visible;opacity: 1;}
	span#serailId_error{color:red;display:inline;position: absolute;margin: 0px 10px;}
	span#serailId_success{color:green;display:inline;position: absolute;margin: 0px 10px;}
	#responseMsg{display: none;margin:10px 200px 20px;color:green;font-size:18px;}
    .responseMsg1{display: none;margin:0px 155px 24px;font-size:15px;color:red;}
	.ui-dialog .ui-dialog-title{font-size: 14px !important;}
	.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front.ui-draggable.ui-resizable{
                                padding:0px;
                                width:470px;
                }
                .ui-dialog-titlebar.ui-widget-header.ui-corner-all.ui-helper-clearfix.ui-draggable-handle{
                                background-image: none; 
                                background:-moz-linear-gradient(center top , #f8f8f8 0%, #e8e8e8 100%) repeat scroll 0 0 rgba(0, 0, 0, 0); 
                                border: medium none;
                                color: #636363;
                                font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
                                font-size:13px;
                                border-radius: 0;
                                height:28px;
                                }
                .ui-dialog-titlebar.ui-widget-header.ui-corner-all.ui-helper-clearfix.ui-draggable-handle .ui-dialog-title{padding-top:3px;}
                #market_list{border-top: 1px solid #cdcdcd;}
     #show_mkt_list{position: absolute;display: none;padding-left: 10px; font-size: 12px;padding-top: 5px font-family:"Helvetica Neue",	Helvetica,​Arial,​sans-serif;}
    
    .ui-tooltip, .arrow:after {background: #0050B9;border: 2px solid white; height:25px;font-size: 11px;color: #FFFFFF;font-weight: normal;}
    
   /*CSS for serach box starts here*/
    .searchBox{display: inline-block;position: relative;width: 234px;}
	span.search{
		background:url("images/magnifying-glass.png") no-repeat scroll 2px 0px rgba(0, 0, 0, 0);
	    border: 0 none;height: 26px;position: absolute; cursor:pointer;right: 0;top: 0;width: 34px;
	}
	#series_search{width: 229px;height: 22px;}
	.webkit #series_search{width: 229px;height: 20px;}
	#resultDiv{
		border:1px solid #F6F6F6;background: none repeat scroll 0 0 #FFF;box-shadow: 2px 3px 7px #888888;height: auto;position: absolute;
		max-height:295px;overflow:auto;font-size: 13px;font-weight: normal;float:right;display: none;z-index:10;
		margin-top: 0px;text-align: left;width: 228px;margin-left: 0px;
	}
	#resultDiv > ul li.searchItem:hover, #resultDiv > ul li.selected{background-color:#E5E5E5;}
	#resultDiv > ul li{list-style-type: none;padding:3px 10px;}
	#resultDiv > ul li.searchItem{cursor:pointer;}
	#resultDiv > ul li.searchItem:hover, #resultDiv > ul li.selected{background-color:#E5E5E5;}
	/*CSS for serach box ends here*/
</style>
<script>
	var response = '<%=session.getAttribute("queryRsp")%>';
	var markets = '<%=session.getAttribute("markets")%>';
<%-- var series_title = '<%=session.getAttribute("title")%>'; --%>
</script>
</head>
<body>
<div id="wrapper">
 	<!---------- header starts here ---------->
 	<jsp:include page="header.jsp"></jsp:include>
	<!---------- header ends here ---------->
	<div class="container">
		<div class="widget fluid">
            <div class="whead">
            	<h6 id="page_title">Add Series</h6>
            	<div class="clear"></div>
            </div>
			
			<form method="post" id="account_form2" name="account_form2" action="${pageContext.request.contextPath}/addSeries">
				<div class="textbox">
					<label for="SeriesSearch">
						<strong>Lookup Series Title:</strong>
					</label>
					
					<div class="searchBox">
						<input type="text" id="series_search" placeholder="Get your Merlin SeriesID here!" autocomplete="off"/>
						<span class="search" id="search_btn"></span>
						<div id="resultDiv" class="resultDiv"></div>						
					</div>
				</div>
				<div class="textbox">
					<label for="SeriesID">
						<strong><Span style="color:red">*</Span>Merlin SeriesID:</strong>
					</label>
					<div>					
						<input type="text" id="SeriesID" name="SeriesID" size="25"style="width:228px;"  value="<%=(String)((session.getAttribute("seriesId")!=null)?session.getAttribute("seriesId"):"")%>"/>
						<span class="validation_number">Please enter numeric values only</span>
					</div>
					<span id="serailId_error"></span>
					<span id="serailId_success"></span>
				</div>
				<div class="textbox">
					<label></label>
					<div style="width:250px;">
						<input type="radio" checked="checked" value="new-only" id="NewRepeat"  name="NewRepeat" /><label style="padding-right: 10px" for="NewRepeat" style="width:auto;">New Only</label>
						<input type="radio" style="margin-left:2px;" value="new-repeat" id="NewRepeat" name="NewRepeat" /><label for="NewRepeat" style="width:auto;">New and Repeats</label>	
					</div>
				</div>
				<div class="textbox">
					<label style="vertical-align:top; margin-right: 0px;">
						<strong><Span style="color:red">*</Span>Record in the following markets:</strong>
					
						<img class="popUp" id="help2" src="images/qbut.gif" title="Please select the markets in which this series or movie will be made available via Ivod"/>
						<div class="imgDescpn" title="Please select the markets in which this series or movie will be made available via Ivod"></div>
					</label>
					<div id="list1" class="dropdown-check-list" style="width:244px;">
				        <input type="text" class="anchor" id="search_mkt" style="width:218px;" placeholder="Select Markets" autocomplete="off"/>
				        <input type="hidden" id="mkt_drop" name="mkt_drop"/>
				        <ul class="items"></ul>
				    </div>
				    <span id="show_mkt_list"><a href="javascript:openMktList();">View Markets</a><a href="javascript:void(0);" id="reset_link" style="margin-left:10px;">Clear Markets</a></span>
				</div>
					 
                <div class="clear"></div>
				<div class="textbox" style="padding: 30px 0px;">
					<input id="save_form2" class="submit" value="Add Series" type="button" disabled="disabled" style="margin-left: 170px;"/>
					<input id="reset_form2" class="submit" value="Reset" type="button"/>
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
<div id="market_list" title="List of markets selected"></div>

<%
       session.removeAttribute("queryRsp");
       
       session.removeAttribute("title");
%>
 
<script>
var applicationPath = '<%=request.getContextPath()%>';
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