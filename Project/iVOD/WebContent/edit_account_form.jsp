<style>
span#mktname_error{color:red;display:none;position: absolute;margin: 0px 10px;}
div.textbox_popup {padding:10px 0;}
div.textbox_popup > label {display: inline-block;
    float: left;
    margin-left: 52px;
    text-align: left;
    vertical-align: top;
    width: 156px !important;
}
div.textbox_popup > div{display:inline-block;width:240px;}
div.textbox_popup > input{width:200px;}
div.textbox_popup > input.expand_collapse_btn{width:20px;}
div.textbox_popup > input.submit{width:auto;padding:2px 3px;}

</style>
<div class="textbox_popup">
	<label for="Account_Name"><Span style="color:red">*</Span><b>Account Name:</b></label>
	<div>
		<input type="hidden" id="account_id" name="account_id" value=""/>
		<input type="text" id="Account_Name" name="Account_Name" size="25" value=""/>
		<span class="validation_number">Please enter alphanumeric values only</span>
	</div>
</div>
<div class="textbox_popup">
	<label for="Billing_Account_Number"><Span style="color:red">*</Span><b>Billing Account Number:</b></label>
	<div>
		<input type="text" id="Billing_Account_Number" name="Billing_Account_Number" size="25" value=""/>
		<span class="validation_number">Please enter numeric values only</span>
	</div>
</div>
<div class="textbox_popup">
	<label for="X1_Account_Number"><Span style="color:red">*</Span><b>X1 Account ID:</b></label>
	<div>
		<input type="text" id="X1_Account_Number" name="X1_Account_Number" size="25" value=""/>
		<span class="validation_number">Please enter numeric values only</span>
	</div>
</div>
<div class="textbox_popup">
	<label for="X1_Device_Number"><Span style="color:red">*</Span><b>DvrVirtualRecorderId:</b></label>
	<div>
		<input type="text" id="X1_Device_Number" name="X1_Device_Number" size="25" value=""/>
		<span class="validation_number">Please enter numeric values only</span>
	</div>
</div>

	
<div class="textbox_popup">
	<label for="mydropdown"><Span style="color:red">*</Span><b>Market:</b></label>
	<div id="list1" class="dropdown-check-list" style="width:180px;">
        <input type="text" class="anchor" id="search_mkt" placeholder="Select Markets" autocomplete="off" style="width: 166px;"/>
        <input type="hidden" id="mkt_drop" name="mkt_drop"/>
        <ul class="items" style="width: 172px;"></ul>
    </div>
</div>
<div class="textbox_popup">
	<label for="acc_desc"><b>Description:</b></label>
	<div style="width:auto;">
	    <textarea rows="3" cols="35" id="acc_desc" name="acc_desc" maxlength="100" placeholder="Enter Account Description here!" style="width:180px;"></textarea>
	</div>
	<div style="margin-left: 130px;">
	 	<span id="acc_counter">100</span> characters left.
	</div>
</div>

<div class="textbox_popup" style="padding: 30px 0px;">	
	<input id="popup_cancel" class="submit" value="Cancel" type="button">
	<input id="popup_submit" class="submit" value="Submit" type="button"/>
	<input id="popup_reset" class="submit" value="Restore" onclick="populateAccountInformation('<%=request.getParameter("id")%>')" type="button"/>
</div>
					
		
<script>
var alphabetReg = /^[a-zA-Z0-9 ]*$/;
var alphaNumReg = /^[a-zA-Z0-9, ]+$/;
var alphabet = /^[a-zA-Z ]*$/;

var accountId = '<%=request.getParameter("id")%>';
	
var selected_mkt = "";
var mktname = "";
var alphabetReg = /^[a-zA-Z0-9 ]*$/;

$(function(){
	
	populateAccountInformation(accountId);
	
	$("#popup_cancel").click(function () {
		cancelInd = false;
		window.parent.jQuery('#show_detail_popup').dialog('close');
	});
	
	/* $("#popup_reset").click(function(){
		if(response!="success"){
			$("#Billing_Account_Number,#X1_Account_Number,#X1_Device_Number").siblings("span.validation_number").css("display","none");
			$("#new_market_name_div,#market_form,.responseMsg1").hide();
             $("#search_mkt").attr("placeholder","Select Markets");  
				$(".validation_number").hide();
			$("input[type='text'],textarea,select").val("");
               $("#mktname_error").hide(); 
			selected_mkt = "";
		}
	}); */
	
	
	$("#popup_submit").click(function(){
		if(validateForm1()){
			updateAccount();
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
	}/* else if(accdesc.charAt(0)==("'")){
		alert("Description should not start with ' ");
		formflag = false;
	} */
	
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
	
	html += '';
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
	/* $("li.crtnew").click(function(){
		validateMktForm = true;
		$("#market_form").show();
		$("#show_mkt_list").hide();
		$("#list1").removeClass('visible');
		$("#mkt_drop").val("create_new_mkt");
		$("#search_mkt").attr("placeholder","Create New Market");
		selected_mkt = "create_new_mkt";//why did we assign crt_newaccount to selected_mkt. when select a new market, another form shown, so after response of successful message, I have to show the whole form. With new market the whole form is shown.
	}); */
	
	$("#list1 input[type='radio']").click(function(){
		selected_mkt = $(this).val();
		
		$("#search_mkt").attr("placeholder",$(this).val());
		$("#mkt_drop").val($(this).val());
		$("#list1").removeClass('visible');
    });
}

function populateAccountInformation(accountName){
	//populateAccountViewData(accResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?id=" + accountId,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			populateAccountViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateAccountViewData(resp){
	if(resp.ivodAccounts.length> 0) {
		
		$("#account_id").val(resp.ivodAccounts[0].id);
		$("#Account_Name").val(resp.ivodAccounts[0].accountName);
		$("#Billing_Account_Number").val(resp.ivodAccounts[0].billingAccount);
		$("#X1_Account_Number").val(resp.ivodAccounts[0].xAccount);
		$("#X1_Device_Number").val(resp.ivodAccounts[0].xDevice);
		$("#mkt_drop").val(resp.ivodAccounts[0].market);
		selected_mkt = resp.ivodAccounts[0].market;
		$("#search_mkt").attr("placeholder",selected_mkt);
		$("#acc_desc").val(resp.ivodAccounts[0].description);
		
	}	
	initaiteCounter("acc_desc","acc_counter",100);
}
 function updateAccount(){
	var requestData ={
		ivodAccounts: [
        	{
      	   		id: $.trim($("#account_id").val()),
      	   		accountName: $.trim($("#Account_Name").val()),
      	   		billingAccount:$.trim($("#Billing_Account_Number").val()),
      	   		xAccount: $.trim($("#X1_Account_Number").val()),
      	   		xDevice: $.trim($("#X1_Device_Number").val()),
      	   		market:$.trim($("#mkt_drop").val()),
      	   		description:$.trim($("#acc_desc").val())
        	}
      	]
	};
	cancelInd = true;
	editPopupDataAfter = requestData.ivodAccounts[0];
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/insert",
		type:"POST",
		crossDomain: true,
		dataType: "json",
		//contentType:"application/json",
		data: JSON.stringify(requestData),
		success:function(resp){
			window.parent.jQuery('#show_detail_popup').dialog('close');
		},
		error:function(resp){
			//alert("getMarketList(): Error");
			window.parent.jQuery('#show_detail_popup').dialog('close');
		}
	}); 
} 
</script>