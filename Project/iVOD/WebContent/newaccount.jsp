<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>iVOD Scheduler</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" media="all" />
	<link rel="shortcut icon" href="favicon.ico" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/globFunc.js"></script>
	<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
	<style>
	
		input[placeholder],textarea[placeholder]{color:light grey !important;font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;}
		div.textbox {padding:10px 0;margin-left: 250px;}
		div.textbox > label {display:inline-block; width:250px !important; text-align:left;}
		div.textbox > div{display:inline-block;width:191px;}
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
		#responseMsg{display: none;margin:10px 320px 20px;color:color: green;font-size:15px;}
	    .responseMsg1{display: none;margin:10px 0 20px;font-size:15px;color:red;}
	    #resultDiv{
	    	border:1px solid #F6F6F6;background: none repeat scroll 0 0 #FFF;box-shadow: 2px 3px 7px #888888;height: auto;position: absolute;
	    	width: 260px;margin-top: 27px;max-height:295px;overflow:auto;font-size: 13px;font-weight: normal;float:right;display: none;z-index:10;
	    }
	    #resultDiv > ul {padding:5px 0px;margin:0px;}
	    #resultDiv > ul li{list-style-type: none;padding:3px 10px;}
	    #resultDiv > ul li.searchItem{cursor:pointer;}
	    #resultDiv > ul li.searchItem:hover{background-color:#E5E5E5;}
	    #show_mkt_list{position: absolute;display: none;padding-left: 10px; font-size: 10px;padding-top: 14px;}
	    ul.items{width: 161px !important; margin-left:0px !improtant}
	</style>
	
	<script>
	var response = '<%=(String)((session.getAttribute("queryRsp")!=null)?session.getAttribute("queryRsp"):"")%>';
	
var acc_name = localStorage.getItem("accountName");
	var bill_acc_name = localStorage.getItem("billAccName");
	var x1_acc_no = localStorage.getItem("x1AccNo");
	var x1_device_no = localStorage.getItem("x1DeviceNo");
	var acc_desc = localStorage.getItem("accDesc");
	var mkt_drop = localStorage.getItem("mktDrop");
		 
	var mkt_name =  localStorage.getItem("mktName");
	var mkt_group = localStorage.getItem("mktGrp");
	var timezone = localStorage.getItem("timezone");
	var new_mkt_name = localStorage.getItem("newmktName");
	var mktDMA = localStorage.getItem("marketDMA");
	var mktDesc = localStorage.getItem("mktDesc");
	var cdlVal = localStorage.getItem("CDL");
	
	$(function(){
		
		localStorage.setItem("accountName","");
		localStorage.setItem("billAccName","");
		localStorage.setItem("x1AccNo","");
		localStorage.setItem("x1DeviceNo","");
		localStorage.setItem("accDesc","");
		localStorage.setItem("mktDrop","");
		
		localStorage.setItem("mktName","");
		localStorage.setItem("mktGrp","");
		localStorage.setItem("newmktName","");
		localStorage.setItem("marketDMA","");
		localStorage.setItem("CDL","");
		localStorage.setItem("timezone","");
		localStorage.setItem("mktDesc","");
		
		$("#Account_Name").val(acc_name);
		$("#Billing_Account_Number").val(bill_acc_name);
		$("#X1_Account_Number").val(x1_acc_no);
		$("#X1_Device_Number").val(x1_device_no);
		$("#acc_desc").val(acc_desc);
		
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
<%session.removeAttribute("queryRsp"); %>
  	<!---------- header starts here ---------->
 	<jsp:include page="header.jsp"></jsp:include>
	<!---------- header ends here ---------->

	<div class="container">
		<div class="widget fluid">
            <div class="whead">
            	<h6 id="page_title">Add Account</h6>
            	<div class="clear"></div>
            </div>
			<form method="post" id="account_form1" name="account_form1" action="${pageContext.request.contextPath}/AddAccount">
					
				<div class="textbox">
					<label for="Account_Name"><Span style="color:red">*</Span><b>Account Name:</b></label>
					<div>
						<input type="text" id="Account_Name" name="Account_Name" maxlength="25"size="25" value="<%=(String)((session.getAttribute("acc_name")!=null)?session.getAttribute("acc_name"):"")%>"/>
						<span class="validation_number">Please enter alphanumeric values only</span>
					</div>
				</div>
				<div class="textbox">
					<label for="Billing_Account_Number"><Span style="color:red">*</Span><b>Billing Account Number:</b></label>
					<div>
						<input type="text" id="Billing_Account_Number" maxlength="25" name="Billing_Account_Number" size="25" value="<%=(String)((session.getAttribute("bill_acc_no")!=null)?session.getAttribute("bill_acc_no"):"")%>"/>
						<span class="validation_number">Please enter numeric values only</span>
					</div>
				</div>
				<div class="textbox">
					<label for="X1_Account_Number"><Span style="color:red">*</Span><b>X1 Account ID:</b></label>
					<div>
						<input type="text" id="X1_Account_Number" maxlength="25" name="X1_Account_Number" size="25" value="<%=(String)((session.getAttribute("x1_acc_no")!=null)?session.getAttribute("x1_acc_no"):"")%>"/>
						<span class="validation_number">Please enter numeric values only</span>
					</div>
				</div>
				<div class="textbox">
					<label for="X1_Device_Number"><Span style="color:red">*</Span><b>DvrVirtualRecorderId:</b></label>
					<div>
						<input type="text" id="X1_Device_Number"  maxlength="25" name="X1_Device_Number" size="25" value="<%=(String)((session.getAttribute("x1_dvs_no")!=null)?session.getAttribute("x1_dvs_no"):"")%>"/>
						<span class="validation_number">Please enter numeric values only</span>
					</div>
				</div>
				
					
				<div class="textbox">
					<label for="mydropdown"><Span style="color:red">*</Span><b>Market:</b></label>
					 <div id="list1" class="dropdown-check-list" style="width:170px;">
				        <input type="text" class="anchor" id="search_mkt" placeholder="Select Markets" autocomplete="off"/>
				        <input type="hidden" id="mkt_drop" name="mkt_drop"/>
				        <ul class="items"></ul>
				    </div>
				   <!--  <span id="show_mkt_list"><a href="javascript:openMktList();">Review</a><a href="javascript:void(0);" id="reset_link" style="margin-left:10px;">Reset</a></span> -->
				</div>
				
				<div id="market_form" style="display: none;">
				     <fieldset style="border-color:#D0D0D0 ; width: 720px; border-style:solid; border-width:2px;text-align: left;">
				     <legend style="color:#0000FF;">Add Market</legend>
					 <jsp:include page="market_form.jsp"></jsp:include>
					 </fieldset>
				</div>
				<div class="textbox">
					<label for="acc_desc" style= "padding-top: 10px;vertical-align: top;"><b>Description:</b></label>
					<div style="width:auto;">
					    <textarea rows="3" cols="35" id="acc_desc" name="acc_desc" maxlength="100" placeholder="Enter Account Description here!"><%=(String)((session.getAttribute("acc_desc")!=null)?session.getAttribute("acc_desc"):"")%></textarea>
					</div>
					<div style="margin-left: 254px;">
	                     <span id="acc_counter">100</span> characters left.
	                 </div>
				</div>
				
				<div class="textbox" style="padding: 30px 0px;margin-left: 412px;">
					<input id="save_form1" class="submit" value="Add Account" type="button">
					<input id="submit_another" class="submit" value="Submit Another" type="button" style="display:none;"/>
					<input id="reset_form" class="submit" value="Reset" type="button"/>
				</div>
				<div id="responseMsg" style= "color: green;"></div>
				
				<div class="responseMsg1"></div>	
			</form>
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
<!--<ul id="footer-share">
<li id="footer-comcast">
<a alt="Comcast home page" href="#">
</li>
</ul>-->
<div id="footer-links-container">
<p><a>Useful links:</a></p>
    <p style="color: #BBBBBB; positive:relative:-30px;"><a href="#" class="nopadd">Contact Us</a> | <a href="#">Sitemap</a> | <a href="#">About US</a> | <a href="#">Sample link</a></p>
	<div>
		<p><a>Comcast&copy 2014</a></p><br />
	</div>
<!--<div id="footer-general"> </div>-->
</div>
</div>
<div id="market_list" title="List of markets selected"></div>
<%
	
	
	session.removeAttribute("queryRsp");
	session.removeAttribute("result");
	
%>
<script>
var selected_mkt = "";
var mktname = "";
var alphabetReg = /^[a-zA-Z0-9 ]*$/;
var validateMktForm = false;	

$(function(){
	/* $("#mkt_Name").change(function(){
		if($(this).val()=="create_new"){
			$("#market_form").show();
		}else{
			$("#market_form").hide();
		}
	}); */
	initaiteCounter("acc_desc","acc_counter",100);
	$(".tabDiv ul li").removeClass("active");
	$("#ivodAccounts").addClass("active");
	
	if(mkt_group=="create_new")
		$("#new_market_name_div").show();
	
	if(mkt_drop=="create_new_mkt"){
		$("#market_form").show();
		$("#search_mkt").attr("placeholder","Create New Market");
	}else if(mkt_drop!=""){
		selected_mkt = mkt_drop;
		//$("#show_mkt_list").show();
		$("#search_mkt").attr("placeholder",mkt_drop);
	}
	
	if(response=="success"){
		if(mkt_drop!="create_new_mkt")
			$("#responseMsg").html("Success! Added Account: \""+acc_name+"\" ").show();
		else
			$("#responseMsg").html("Success! Added Account \""+acc_name+"\" and Market \""+mkt_name+"\" ").show();
		$("#save_form1").hide();
		$("#submit_another").show();
		$("#reset_form").hide();
			$("#timezone").val(timezone).attr({"disabled":"disabled"});
		$("input[type='text'],textarea").attr({"disabled":"disabled"});
	}else if(response=="fail"){
		if(mkt_drop!="create_new_mkt")
			$(".responseMsg1").html("Failed to add account \""+acc_name+"\" ").show();
		else
			$(".responseMsg1").html("Failed to add account \""+acc_name+"\" and market \""+mkt_name+"\" ").show();
		$("#reset_form").show();
		
		$("#timezone").val(timezone);
	}
	
	
	$("#reset_form").click(function(){
		if(response!="success"){
			$("#Billing_Account_Number,#X1_Account_Number,#X1_Device_Number").siblings("span.validation_number").css("display","none");
			$("#new_market_name_div,#market_form,.responseMsg1").hide();
             $("#search_mkt").attr("placeholder","Select Markets");  
				$(".validation_number").hide();
			//$("input[type='text'],textarea,select").val("");
			$("#Account_Name").val("");
			
		     $("#Billing_Account_Number").val("");
		      $("#X1_Account_Number").val("");
			$("#X1_Device_Number").val("");
			$("#acc_desc").val("");
			$("#mkt_drop").val("");
			
			$("#Market_Name").val("");
			$("#mkt_group").val("");
			$("#new_market_name").val("");
			$("#Market_DMA").val("");
			$("#CDL").val("");
			$("#timezone").val("");
			$("#mkt_desc").val("");
			
               $("#mktname_error").hide(); 
               initaiteCounter("acc_desc","acc_counter",100);
			selected_mkt = "";
			//	$("#show_mkt_list").hide();
		}
	});
	
	$("#submit_another").click(function(){
		window.top.location.href="newaccount.jsp";
	});
	
	$("#save_form1").click(function(){
		if(validateForm1()){
			localStorage.setItem("accountName",$("#Account_Name").val());
			localStorage.setItem("billAccName",$("#Billing_Account_Number").val());
			localStorage.setItem("x1AccNo",$("#X1_Account_Number").val());
			localStorage.setItem("x1DeviceNo",$("#X1_Device_Number").val());
			localStorage.setItem("accDesc",$("#acc_desc").val());
			localStorage.setItem("mktDrop",$("#mkt_drop").val());
			
			localStorage.setItem("mktName",$("#Market_Name").val());
			localStorage.setItem("mktGrp",$("#mkt_group").val());
			localStorage.setItem("newmktName",$("#new_market_name").val());
			localStorage.setItem("marketDMA",$("#Market_DMA").val());
			localStorage.setItem("CDL",$("#CDL").val());
			localStorage.setItem("timezone",$("#timezone").val());
			localStorage.setItem("mktDesc",$("#mkt_desc").val());
			$("#account_form1").submit();
		}
	});
	
	$("#list1 input[type='text']").click(function(e){
    	
    	if($("#list1").hasClass('visible')){
    		$("#list1").removeClass('visible');
    	}else{
    		mktname = $.trim($(this).val());
    		
    		getMarketList();
    		$("#list1").addClass('visible');
    	}
    	
    });
	
	$("#search_mkt").keyup(function(e){
		mktname = $.trim($(this).val());
		getMarketList();
	});
	
	$(document).click(function(e){
		var obj = e.target;
		
		if(!$(obj).parents().hasClass("dropdown-check-list")){
			$("#list1").removeClass('visible');
		}	
	});
	
	$("#Billing_Account_Number,#X1_Account_Number,#X1_Device_Number").keyup(function(){
		if(isNaN($(this).val()))
			$(this).siblings("span.validation_number").css("display","inline");
		else
			$(this).siblings("span.validation_number").css("display","none");
	});
	
	$("#Account_Name").keyup(function(){
		if(!(alphabetReg.test($(this).val())))
			$(this).siblings("span.validation_number").css("display","inline");
		else
			$(this).siblings("span.validation_number").css("display","none");
	});
});

function initaiteCounter(fieldId,counterId,count){
	
	var reqVal = $("#"+fieldId).val();
	var remaining_count = count-reqVal.length;
	$("#"+counterId).text(remaining_count);
	
	$("#"+fieldId).bind("input propertychange",function(){
		
		reqVal = $(this).val();
		remaining_count = count-reqVal.length;
		$("#"+counterId).text(remaining_count);
		
	});
}

function validateForm1(){
	var form1flag = true;
	var accName = $.trim($("#Account_Name").val());
	$("#Account_Name").val(accName);
	var billAccno=$.trim($("#Billing_Account_Number").val());
	$("#Billing_Account_Number").val(billAccno);
	var x1accid = $.trim($("#X1_Account_Number").val());
	$("#X1_Account_Number").val(x1accid);
	var x1deviceNo=$.trim($("#X1_Device_Number").val());
	$("#X1_Device_Number").val(x1deviceNo);
	var accdesc=$.trim($("#acc_desc").val());
	$("#acc_desc").val(accdesc);
    if(accdesc!=""){
            accdesc = accdesc.replace(/\n|\r/g, " ");
            $("#acc_desc").val(accdesc);
    }
	if(accName==""){
		alert("Account Name Cannot be blank");
		form1flag = false;
	}else if(!(alphabetReg.test(accName))){
		alert("Please enter only alpanumeric values");
		form1flag = false;
	}else if(billAccno==""){
		alert("Billing Account Number Cannot be blank");
		form1flag = false;
	}else if(isNaN(billAccno)){
		alert("Please enter valid Account Number");
		form1flag = false;
	}else if(x1accid==""){
		alert("X1 Account ID Cannot be blank");
		form1flag = false;
	}else if(isNaN(x1accid)){
		alert("Please enter valid X1 Account ID Number");
		form1flag = false;
	}else if(x1deviceNo==""){
		alert("DvrVirtualRecorderId Cannot be blank");
		form1flag = false;
	}else if(isNaN(x1deviceNo)){
		alert("Please enter valid QamIpStbId Number");
		form1flag = false;
	}else if($("#mkt_drop").val()==""){
		alert("Please select market");
		form1flag = false;
	}else if(accdesc.charAt(0)==("'")){
		alert("Description should not start with ' ");
		formflag = false;
	}
	/*else if(accdesc==""){
        alert("Account Description Cannot be blank");
        form1flag = false;
    }*/
	else if(validateMktForm){
		if(!validateMarketForm())
			form1flag = false;
	}
	
	return form1flag;
}

function getMarketList(){
	//prepareMarketList(respJson);
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets",
		type:"GET",
		crossDomain: true,
		dataType: "JSON",
		data:null,
		//data:'',
		success:function(resp){
			prepareMarketList(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
}

function prepareMarketList(resp){
	var jsonArr = resp.ivodMarkets;
	var html = '';
	
	html += '<li class="crtnew">Create New Market</li>';
	var mktList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
			return compareStrings(a.market, b.market);
			});
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i];
			if(mktList.indexOf(item.market)==-1){
				mktList.push(item.market);
				if(mktname!="" && mktname!='undefined' && typeof(mktname)!=undefined && mktname!=undefined){
					
					if(item.market.toLowerCase().indexOf(mktname.toLowerCase())==0){
						if(selected_mkt==item.market)
							html += '<li><input type="radio" name="mktList" value=\"'+item.market+'\" checked="true"/>'+item.market+'</li>';
						else
						
							html += '<li><input type="radio" name="mktList" value=\"'+item.market+'\"/>'+item.market+'</li>';
					}
				}else{
					if(selected_mkt==item.market)
						html += '<li><input type="radio" name="mktList" value=\"'+item.market+'\" checked="true"/>'+item.market+'</li>';
					else
						
						html += '<li><input type="radio" name="mktList" value=\"'+item.market+'\"/>'+item.market+'</li>';
				}
			}
		}
	}else{
		html += '<li>No markets found</li>';
	}
	
	$("#list1 ul.items").html(html);
	$("#list1").addClass('visible');
	$("li.crtnew").click(function(){
		validateMktForm = true;
		$("#market_form").show();
		$("#show_mkt_list").hide();
		$("#list1").removeClass('visible');
		$("#mkt_drop").val("create_new_mkt");
		$("#search_mkt").attr("placeholder","Create New Market");
		selected_mkt = "create_new_mkt";//why did we assign crt_newaccount to selected_mkt. when select a new market, another form shown, so after response of successful message, I have to show the whole form. With new market the whole form is shown.
	});
	
	$("#list1 input[type='radio']").click(function(){
		validateMktForm = false;
		$("#market_form").hide();
		selected_mkt = $(this).val();
		
		/* if("input[@name='mktList']:checked")
			$("#show_mkt_list").css({"display":"inline"});
		else
			$("#show_mkt_list").hide(); */
		$("#search_mkt").attr("placeholder",$(this).val());
		//$("#search_mkt").attr($(this).val());
		$("#mkt_drop").val($(this).val());
		$("#list1").removeClass('visible');
    });
	
	/* $("#reset_link").click(function(){
		$("input[type='radio']").attr('checked', false);
		$("#show_mkt_list").hide();
		selected_mkt = "";
	}); */
}

/* function openMktList(){
	 var html = '<p>You have selected the following market </p>';
	 html +='<ul class="selectedMarkets">';
	 html +='<li>'+selected_mkt+'</li>';
	 html +='</ul>';
	 html +='<input type="button" value="OK" class="okBtn"/>';
	 $( "#market_list" ).html(html);
	 $( "#market_list" ).dialog({width: 500,maxHeight:500,modal: true});
	 
	 $(".okBtn").click(function () {
         $("#market_list").dialog('close');
     });
} */

</script>
</body>
</html>