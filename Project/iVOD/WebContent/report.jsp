<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title> iVOD Scheduler</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
	<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/js/css_browser_selector.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/grid.locale-en.js"></script>
	<script type="text/javascript" src="js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="js/dateformatter.js"></script>
	<script type="text/javascript" src="js/download.js"></script>
	<script type="text/javascript" src="js/report.js"></script>
	<script type="text/javascript" src="js/gvar.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" media="all" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/ui.jqgrid.css" />
	<link rel="shortcut icon" href="favicon.ico" />
	
	<style>
	   	/*CSS for search forms*/
	   	 #serach_option_main{float: left;height: 100%;margin-left:63px;}
	   	 #search_lbl_div{float:left;height: 100%;padding-left: 5px;padding: 3px 10px 0 0;margin-left: 260px;}
	   	 #search_sbmt_div{clear: both; margin: 30px 0 50px 463px;float: left;}
	   	 #search_sbmt_loading{background:url("images/spinner40.gif")no-repeat 4px 0px transparent;border: medium none;height: 20px; width: 25px; margin-left:13px; background-size:20px;cursor: pointer; display: none;}
	    .search_key{width: 150px;height: 21px;}
	    .add_btn,.remove_btn{width:25px;height:25px}
	    .remove_btn{display: none;}
	   	
	    /*CSS for jQuery UI dailog box*/
	    /*.ui-dialog, .ui-widget-content{padding: 0px !important;}
	    .ui-dialog-title {display:none;height: 0px !important;}
		.ui-dialog-titlebar {background:transparent;border:none;padding: 0px !important;}
		.ui-widget-content{background: #EBEDFC;}
		.ui-dialog .ui-dialog-titlebar-close {display: none;}*/
		
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
	    
	    /*CSS for jQuery UI dailog box elements*/
	    .popupBtn{font-size: 12px !important;margin-left: 0px;text-align: center;min-width: 70px;}
	    .moveBtn{width: 60px;}
	    ul.clmn_list{background:url("images/ul_bg.png")no-repeat 9px 9px transparent;float: left;height: 85%;list-style-type: none;margin: 0;padding: 10px;width: 90%;overflow:auto;}
	    ul.clmn_list > li{cursor: pointer;font-size: 11px;line-height: 18px;padding: 0 3px;text-align: left;}
	    ul.clmn_list > li.active{background: #C8DCFF;}
	    ul.clmn_list > li:hover{background: #C8DCFF;}	    
	    ul.clmn_list > li.selected{background: #C8DCFF;}
	    #show_market_popup,#export_csv_popup{display: none;}
	    #select_columns_popup{text-align:center;display: none;background: #F0F0F0 !important;}
	    #available_div, #selected_div{float:left;width:193px;height:200px;border:1px solid #CCCCCC;background: #E7E7E7;border-radius:2px;-webkit-box-shadow: inset 2px 2px 13px -11px rgba(0,0,0,0.75);-moz-box-shadow: inset 2px 2px 13px -11px rgba(0,0,0,0.75);box-shadow: inset 2px 2px 13px -11px rgba(0,0,0,0.75);	    }
	    #move_btn_div{float:left;width:60px;margin:60px 10px 0px;}
	    .option_label{width:100%;float:left;background: #c6e0b3}
	    #moveleft{background:url("images/add-button.png")no-repeat 4px 0px transparent;border: medium none;height: 23px;cursor: pointer;}
	    #moveright{background:url("images/remove-button.png")no-repeat 6px 0px transparent;border: medium none;height: 23px;cursor: pointer;}
	    #closebtn{background:url("images/close-button.png")no-repeat -1px 0px transparent;border: medium none;height: 27px;min-width: 27px;margin-left: 158px;position:absolute;margin-top: -7px;cursor: pointer;}
	   
	    /*CSS for jQGrid table*/
	    #gbox_list2{margin: 0 auto;}
	    .ui-jqgrid tr.jqgrow td {white-space: normal !important;vertical-align: middle;}
	    .ui-jqgrid .ui-jqgrid-sortable{padding-top:4px;}
	    .ui-pg-selbox{min-width: 70px;max-width: 70px;}
	    .ui-widget-content .ui-state-default{background: none repeat scroll 0 0 #0050B9;border: 1px solid #647f98;color: #FFFFFF;font-weight: bold;}
		tr.ui-widget-content {background: white none repeat scroll 0 0;}
		tr.ui-widget-content.ui-state-hover{background: #FFFFFF;}
		tr.ui-widget-content.myAltRowClass{background: #E0E0E0;}
		tr.ui-widget-content.ui-state-highlight{background: none repeat scroll 0 0 #FFFFFF;}
		tr.ui-widget-content.ui-state-highlight.myAltRowClass{background: none repeat scroll 0 0 #FFFFFF;}
		tr.ui-widget-content.ui-state-hover.myAltRowClass{background: #FFFFFF;}
		td.clckd{background-color: #FFB81C !important;}
		
		/*CSS for jqGrid table setting functionality*/
		.ui-jqgrid .ui-jqgrid-titlebar-close{display: none;}
		.setting{width: 20px;height:15px; float: left;background: url("images/setting-icon.png") no-repeat 8px 6px transparent;right:0;position:absolute;cursor: pointer;padding: 5px;margin-top: -4px;border-left: 1px solid #9A9797;}
		.setting ul{display:none; list-style-type: none;padding:0px;float: left;margin: 20px -136px 0;position: absolute;width: 160px;}
		.setting ul li{list-style-type: none;position:relative;padding: 5px;float: left;font-size: 12px;z-index: 2;width: 94%;}
		.setting ul li:hover{background: lightblue;cursor: pointer;} 
		.setting ul li a{text-decoration: none;color:black;padding: 16px 20px;}
		.setting ul.actv{ display:block; background:white; height:auto;border-width: 1px;border-style: solid;border-color: #9A9797;z-index: 2;}
		
		#resetDiv{margin:30px auto 20px;display: none;text-align: center;width: 800px;}
		#noResult{font-weight: bold;text-align: center;width: 100%;display: none;margin-top:20px;color:red;clear:both;float:left}
		.ui-tooltip, .arrow:after {background: #0050B9;border: 2px solid white;}
		.ui-tooltip.ui-widget-content.ui-widget.ui-corner-all .ui-tooltip-content{padding: 10px 10px 10px 10px;}
	
		
		/*CSS for serach box starts here*/
	    .searchBox{display: inline-block;position: relative;width: 234px;margin-left:10px;}
		span.search{
			background:url("images/magnifying-glass.png") no-repeat scroll 7px 0px rgba(0, 0, 0, 0);
		    border: 0 none;height: 26px;position: absolute;right: 0;top: 0;width: 38px;
		}
		#series_search{width: 229px;height: 22px;}
		.webkit #series_search{width: 229px;height: 20px;}
		#resultDiv{
			border:1px solid #F6F6F6;background: none repeat scroll 0 0 #FFF;box-shadow: 2px 3px 7px #888888;height: auto;position: absolute;
			max-height:295px;overflow:auto;font-size: 13px;font-weight: normal;float:right;display: none;z-index:10;
			margin-top: 0px;text-align: left;width: 228px;margin-left: 0px;
		}
		#resultDiv > ul {padding:5px 0px;margin:0px;}
		#resultDiv > ul li{list-style-type: none;padding:3px 10px;}
		#resultDiv > ul li.searchItem{cursor:pointer;}
		#resultDiv > ul li.searchItem:hover, #resultDiv > ul li.selected{background-color:#E5E5E5;}
		/*CSS for serach box ends here*/
	</style>
</head>
<body>
<div id="wrapper">
 	<!---------- header starts here ---------->
 	<jsp:include page="header.jsp"></jsp:include>
	<!---------- header ends here ---------->
	<div class="container">
		<!-- <div class="page_title_div">
			<h3 id="page_title"></h3>
		</div> -->
		 <div class="widget fluid">
            <div class="whead">
            	<h6 id="page_title"></h6>
            	<div class="clear"></div>
            </div>
            <form> 
          	  	<%
          	  		String path = (String) request.getParameter("type")!=null?(String)request.getParameter("type"):"ivodSeries";
					if("ivodSeries".equals(path)){
          	  	%>
            	<div id="search_lbl_div" style="margin-bottom: 15px;">
					<label for="SeriesSearch">
						<strong>Lookup Series Title:</strong>
					</label>
					<div class="searchBox">
						<input type="text" id="series_search" placeholder="Get your Merlin SeriesID here!" autocomplete="off"/>
						<span class="search" id="search_btn"></span>
						<div id="resultDiv" class="resultDiv"></div>						
					</div>
				</div>
				<div class="clear"></div>
				<%} %>
				<div id="search_lbl_div">
					<label><b>Search by:</b></label>
				</div>
				<div id="serach_option_main">
					<div id="serach_option_0" style="padding-bottom: 10px;">
						<select class="search_opt" id="select_field_0" onkeypress="submitSeriesSerachKeyPress(event);">
							<option>Select</option>
							<option value="all">Show all Records</option>
						</select>
						<input type="text" class="search_key" id="search_txt_0" onkeypress="submitSeriesSerachKeyPress(event);"/>
						<input type="button" class="add_btn" id="add_btn_0" onclick="addSearchOption();" value="+"/>
						<input type="button" class="remove_btn" id="remove_btn_0'" onclick="removeSearchOption(0);" value="-"/>
					</div>
				</div>
				<!-- <div id="table_resultDiv" style="clear:both;">
				<table id="list2"></table>
				<div id="pager2"></div>
				<div id="noResult">Results not found</div>
				<div id="resetDiv">
					<input type="button" id="default_view" value="Default View" onclick="resetTableView()" title="Click to reset view"/> 
				</div>
			</div> -->
			<div id="noResult">Results not found</div>
			
			<div id="search_sbmt_div">
			         <div id="search_sbmt_loading"></div>
					<input type="button" value="Search" onclick="submitSeriesSerach()" disabled="disabled"/>
				</div>
				
			</form>
		<div id="table_resultDiv" style="clear:both;">
				<table id="list2"></table>
				<div id="pager2"></div>
				
				<div id="resetDiv">
					<!-- <input type="button" id="default_view" value="Default View" onclick="resetTableView()" title="Click to reset view"/>--> 
				</div>
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
		</div>
	</div>
</div>
<div id="select_columns_popup" style="box-shadow:blue;" title="Add/Remove Columns">
	<!-- <div style="border-bottom: 1px solid #CECECE;padding: 10px 0px;">
		Add/Remove Columns
		<input type="button" id="closebtn" class="popupBtn" onclick="resetToPrev()"/>
	</div> -->
	<div style="float: left;clear: both;margin: 25px 23px 0px;">
		<label>Available</label>
		<label style="margin-left: 218px;">Selected</label>
	</div>
	<div style="width: 95%;clear:both;margin: 5px 23px 25px;float: left;">
		<!-- <label class="option_label">Available</label> -->
		<div id="available_div">
			<ul id="aviliable_column_list" class="clmn_list"></ul>
		</div>
		<div id="move_btn_div">
			<input type="button" id="moveleft" class="moveBtn" onclick="movetoselected();"/>
			<input type="button" id="moveright" class="moveBtn" onclick="movetoaviliable();" style="margin-top:10px"/>
		</div>
		<!-- <label class="option_label">Selected</label> -->
		<div id="selected_div">
			<ul id="selected_column_list" class="clmn_list"></ul>
		</div>
	</div>
	<div style="clear: both;margin-bottom: 30px;">
		<input type="button" value="OK" class="popupBtn" onclick="updateTable()"/>
		<input style="margin-left:60px;"class="popupBtn" type="button" onclick="resetToPrev()" value="Cancel">
	</div>
</div>

<div id="export_csv_popup" title="Select Data to Export">
	<p><strong></strong></p>
	<div>
		<input type="radio" name="export_data_type" value="false" checked style="font-size:10px;"/>Export only the columns in the table view<br/>
		<input type="radio" name="export_data_type" value="true"/>Export all the columns 
	</div>
	<br/>
	<input type="button" class="okBtn" value="OK">
	<input type="button" class="cancelBtn" value="Cancel">
</div>

<div id="show_detail_popup" title="View Series > Market Details">

</div>

<script>
var responceType = "<%=(request.getParameter("type")!=null?(String)request.getParameter("type"):"ivodSeries")%>";
var applicationPath = "<%=request.getContextPath()%>";
</script>
</body>