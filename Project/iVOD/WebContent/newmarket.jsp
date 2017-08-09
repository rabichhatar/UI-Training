<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>iVOD Scheduler</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/globFunc.js"></script>
<link rel="shortcut icon" href="favicon.ico" />
<style>
	div.textbox {padding:10px 0;margin-left: 250px;}
	div.textbox > label {display:inline-block; width:250px !important; text-align:left;}
	div.textbox > div{display:inline-block;width:191px;}
	div.textbox > input{width:200px;}
	div.textbox > input.submit{width:auto;}
</style>
<script>
var response = '<%=(String)((session.getAttribute("result")!=null)?session.getAttribute("result"):"")%>';
var mkt_name =  localStorage.getItem("mktName");
var mkt_group = localStorage.getItem("mktGrp");
var timezone = localStorage.getItem("timezone");
var new_mkt_name = localStorage.getItem("newmktName");
var mktDMA = localStorage.getItem("marketDMA");
var mktDesc = localStorage.getItem("mktDesc");
var cdlVal = localStorage.getItem("CDL");

$(function(){
	
	localStorage.setItem("mktName","");
	localStorage.setItem("mktGrp","");
	localStorage.setItem("newmktName","");
	localStorage.setItem("marketDMA","");
	localStorage.setItem("CDL","");
	localStorage.setItem("timezone","");
	localStorage.setItem("mktDesc","");
	
	$("#Market_Name").val(mkt_name);
	//$("#mkt_group").val(mkt_group);
	$("#new_market_name").val(new_mkt_name);
	$("#Market_DMA").val(mktDMA);
	$("#CDL").val(cdlVal);
	$("#timezone").val(timezone);
	$("#mkt_desc").val(mktDesc);

});
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
            	<h6 id="page_title">Add Market</h6>
            	<div class="clear"></div>
            </div>
			<form method="post" id="addMarket1" name="addMarket1" action="<%=request.getContextPath()%>/AddMarket">
				<!-- <div class="textbox">
					<div style="width: 400px;">
						<input type="radio" value="newmarket" name="market_sel" class="mkt_radio" style="padding:10px;"/>Add Market
						<input type="radio" value="modifymarket" name="market_sel" class="mkt_radio sel" checked="checked"/>Modify/Delete Market
					</div>
				</div> -->
				<div style="margin-left: 130px;">
					<jsp:include page="market_form.jsp"></jsp:include>
				</div>
				<div class="clear"></div>
				<div class="textbox" style="padding: 30px 0px;margin-left: 418px;">
					<input id="save_form3" class="submit" value="Add Market" type="button"/>
					<input id="submit_another" class="submit" value="Submit Another" type="button" style="display:none;"/>
					<input id="reset_form" class="submit" value="Reset" type="button"/>
				</div>
				<div id="responseMsg" style= "color: green;"></div>
				<div class="responseMsg1"></div>
			</form>
		</div>
	</div>
</div>
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

<div id="footer-links-container">
<p><a>Useful links:</a></p>
    <p style="color: #BBBBBB; positive:relative:-30px;"><a href="#" class="nopadd">Contact Us</a> | <a href="#">Sitemap</a> | <a href="#">About US</a> | <a href="#">Sample link</a></p>
	<div>
		<p><a>Comcast&copy 2014</a></p><br />
	</div>
<!--<div id="footer-general"> </div>-->
</div>

<%
	session.removeAttribute("result");
	
%>
</div>
<script>



$(function(){
	$(".tabDiv ul li").removeClass("active");
	$("#ivodMarkets").addClass("active");
	
	if(mkt_group=="create_new")
		$("#new_market_name_div").show();
	
	if(response=="success"){
		$("#responseMsg").html("Success! Added market \""+mkt_name+"\" ").show();
		$("#save_form3").hide();
		$("#submit_another").show();
		$("#reset_form").hide();
		//$("#mkt_group").val(mkt_group).attr({"disabled":"disabled"});
		$("#timezone").val(timezone).attr({"disabled":"disabled"});
		$("input[type='text'],textarea").attr({"disabled":"disabled"});
	}else if(response=="fail"){
		$(".responseMsg1").html("Failed to add market \""+mkt_name+"\" ").show();
		$("#reset_form").show();
		//$("#mkt_group").val(mkt_group);
		$("#timezone").val(timezone);
	}
	
	$("#reset_form").click(function(){
		if(response!="success"){
			$("#Market_DMA,#new_market_name,#CDL,#Market_Name").siblings("span.validation_number").css("display","none");
			$("#new_market_name_div,.responseMsg1").hide();
			//$("input[type='text'],textarea,select").val("");
			$("#Market_Name").val("");
	$("#mkt_group").val("");
	$("#new_market_name").val("");
	$("#Market_DMA").val("");
	$("#CDL").val("");
	$("#timezone").val("");
	$("#mkt_desc").val("");
    $("#mktname_error").hide();
    initaiteCounter("mkt_desc","counter",100);
		}
	});
	
	$("#submit_another").click(function(){
		window.top.location.href="newmarket.jsp";
	});
	
	$("#save_form3").click(function(){
		if(validateMarketForm()){
			localStorage.setItem("mktName",$("#Market_Name").val());
			localStorage.setItem("mktGrp",$("#mkt_group").val());
			localStorage.setItem("newmktName",$("#new_market_name").val());
			localStorage.setItem("marketDMA",$("#Market_DMA").val());
			localStorage.setItem("CDL",$("#CDL").val());
			localStorage.setItem("timezone",$("#timezone").val());
			localStorage.setItem("mktDesc",$("#mkt_desc").val());
			$("#addMarket1").submit();
		}
	});
	
	/* $(".mkt_radio").click(function(){
		if(!$(this).hasClass("sel"))
			window.top.location.href=$(this).val()+".jsp";
	}); */
	
});
</script>
</body>
</html>