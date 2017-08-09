<style>
span#mktname_error{color:red;display:none;position: absolute;margin: 0px 10px;}
div.textbox_popup {padding:10px 0;}
div.textbox_popup > label {display:inline-block; width:180px !important; text-align:left;vertical-align: top;}
div.textbox_popup > div{display:inline-block;width:240px;}
div.textbox_popup > input{width:200px;}
div.textbox_popup > input.expand_collapse_btn{width:20px;}
div.textbox_popup > input.submit{width:auto;padding:2px 3px;}

select#mkt_group,select#timezone{min-width: 191px;}
</style>

<div class="textbox_popup">
	<span id="webservice_error" style="color:red">No data returned from webservice for selected Market</span><br>
	<label for="Market_name"><Span style="color:red">*</Span><b>Market:</b></label>
	<div>
		<input type="text" maxlength="20" id="Market_Name" name="Market_Name" disabled="true" size="25" value="<%=(String)((session.getAttribute("mkt_name")!=null)?session.getAttribute("mkt_name"):"")%>"/>
		<span class="validation_number">Please enter alphanumeric values only</span>
	</div>
<span id="mktname_error">Market already exists</span>
</div>
<div class="textbox_popup">
	<label for="Market group"><Span style="color:red">*</Span><b>Market Group:</b></label>
	<div>
		<!-- <input type="text" id="Market group" name="Market group" size="25"> -->
		<select name="mkt_group" id="mkt_group">
			
		</select>
	</div>
</div>
<div class="textbox_popup" id="new_market_name_div" style="display: none;">
	<label for="new_market_name"><b>Add new Market Group:</b></label>
	<div>
		<input type="text" id="new_market_name" maxlength="25" name="new_market_name" size="25" value="<%=(String)((session.getAttribute("mkt_group_name")!=null)?session.getAttribute("mkt_group_name"):"")%>"/>
		<span class="validation_number">Please enter alphabets only</span>
	</div>
</div>
<div class="textbox_popup">
	<label for="Market_DMA"><Span style="color:red">*</Span><b>Market DMA Name:</b></label>
	<div>
		<input type="text" id="Market_DMA" maxlength="20" name="Market_DMA" size="25" value="<%=(String)((session.getAttribute("mkt_dma")!=null)?session.getAttribute("mkt_dma"):"")%>"/>
		<span class="validation_number">Please enter alphabets only</span>
	</div>
</div>

<div class="textbox_popup" style="padding-bottom: 2px;">
	<label for="CDL"><Span style="color:red">*</Span><b>CDL List:</b></label>
	<div>
		<input type="text" id="CDL" maxlength="25" name="CDL" size="25" value="<%=(String)((session.getAttribute("cdl")!=null)?session.getAttribute("cdl"):"")%>"/>
		<span class="validation_number">Please enter alphanumeric value only</span>
	</div>
</div>
<div class="textbox_popup" style="padding: 0px;">
       <label></label>
       <div>
           <span style="color:#848484; font-size: 10px;">(Comma Separated List)</span>
       </div>
</div>
<div class="textbox_popup">
	<label for="Timezone_dropdown"><Span style="color:red">*</Span><b>Select your TimeZone:</b></label>
	<div>
		<select name="timezone" id="timezone">
		    <option hidden="true" value="">Select a Timezone</option>
			<option value="EST">Eastern Standard Time</option>
			<option value="CST">Central Standard Time</option>
			<option value="MST">Mountain Standard Time</option>
			<option value="PST">Pacific Standard Time</option>
		</select>
	</div>
</div>
<div class="textbox_popup">
	<label for="mkt_desc" maxlength="80" style= "margin-left: 0px; padding-top: 10px;vertical-align: top;"><b>Description :</b></label>
	<div>
	    <textarea rows="3" cols="35" style="width: 191px;" id="mkt_desc" name="mkt_desc" maxlength="100" placeholder="Enter Market Description here!"><%=(String)((session.getAttribute("mkt_desc")!=null)?session.getAttribute("mkt_desc"):"")%></textarea>
	</div>
	<div style="margin-left: 130px; font-size:9px;">
	 <span id="counter">100</span> characters left.
	</div>
</div>
<div class="textbox_popup">
	<input id="popup_cancel" class="submit" value="Cancel" type="button">
	<input id="popup_submit" class="submit" value="Submit" onclick="updateMarket()" type="button"/>
	<input id="popup_reset" class="submit" value="Restore" onclick="populateMarketInformation('<%=request.getParameter("market")%>')" type="button"/>
</div>
		
<script>
var alphabetReg = /^[a-zA-Z0-9 ]*$/;
var alphaNumReg = /^[a-zA-Z0-9, ]+$/;
var alphabet = /^[a-zA-Z ]*$/;
var validateMkGrp = false;
var validMktName = false;

var market = '<%=request.getParameter("market")%>';

var mktGroup = '';

$("#popup_cancel").click(function () {
	cancelInd = false;
	window.parent.jQuery('#show_detail_popup').dialog('close');
	//$('#show_detail_popup').dialog('close');
});
	
 $(function(){
	 $("#Market_Name").val("");
		$("#mkt_group").val("");
		$("#Market_DMA").val("");
		$("#CDL").val("");
		$("#timezone").val("");
		$("#mkt_desc").val("");
	populateMarketInformation(market);
	
	initaiteCounter("mkt_desc","counter",100);
	
	/* $("#mkt_group").change(function(){
		if($(this).val()=="create_new"){
			$("#new_market_name_div").show();
			validateMkGrp=true;
		}else{
			$("#new_market_name_div").hide();
			validateMkGrp=false;
		}
	}); */
	
	$("#Market_DMA,#new_market_name").keyup(function(){
         $("#mktname_error").css({"display":"none"});
		if(!(alphabet.test($(this).val())))
			$(this).siblings("span.validation_number").css("display","inline");
		else
			$(this).siblings("span.validation_number").css("display","none");
	});
    $("#Market_Name").keyup(function(){	
		$("#mktname_error").css({"display":"none"});
		if($(this).val()=="")
			$(this).siblings("span.validation_number").css("display","none");
		else if(!(alphabetReg.test($(this).val())))
			$(this).siblings("span.validation_number").css("display","inline");
		else
			$(this).siblings("span.validation_number").css("display","none");
		
	});	
	
	$("#CDL").keyup(function(){
		if($(this).val()=="")
			$(this).siblings("span.validation_number").css("display","none");
		else if(!(alphaNumReg.test($(this).val())))
			$(this).siblings("span.validation_number").css("display","inline");
		else
			$(this).siblings("span.validation_number").css("display","none");
	});
	
	getMarketGroupList();
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

function getMarketGroupList(){
	//prepareMarketGroupList(respJson);
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets",
		type:"GET",
		crossDomain: true,
		dataType: "JSON",
		data:null,
		//data:'',
		success:function(resp){
			prepareMarketGroupList(resp);
		},
		error:function(resp){
		}
	});
}


var checkList =[];
function prepareMarketGroupList(resp){
	var jsonArr = resp.ivodMarkets;
	var html = '';
	html += '<option hidden="true" value="">Select a market group</option>';
	//html += '<option value="create_new">CREATE NEW</option>';
	var mktList=[];
	if(jsonArr.length>0){
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i]; 
			if(mktList.indexOf(item.marketGroup)==-1){//If item.mkt group is already available it gives 1 otherwise it gives -1
				mktList.push(item.marketGroup);//adding mkt group to the list
                  checkList.push(item.market);
				html += '<option value=\"'+item.marketGroup+'\">'+item.marketGroup+'</option>';
				//html += '<option value='+i+'>'+item.marketGroup+'</option>';
			}
		}
	}
	$("#mkt_group").html(html);//this displays drop down list
	
	$("#mkt_group").val(mktGroup);
}

function validateMarketForm(){
	
	var formflag = true;
	var mktName = $.trim($("#Market_Name").val());
	$("#Market_Name").val(mktName);
	var mktDMA=$.trim($("#Market_DMA").val());
	$("#Market_DMA").val(mktDMA);
	var CDL = $.trim($("#CDL").val());
	$("#CDL").val(CDL);
	var mktDesc=$.trim($("#mkt_desc").val());
	$("#mkt_desc").val(mktDesc);
	/* var mktGrpName = $.trim($("#new_market_name").val());
	$("#new_market_name").val(mktGrpName); */
	if(mktDesc!=""){
         mktDesc = mktDesc.replace(/\n|\r/g, " ");
         $("#mkt_desc").val(mktDesc);
	}
	
	if(mktName==""){
		alert("Market Name Cannot be blank");
		formflag = false;
	}else if(!(alphabetReg.test(mktName))){
		alert("Please enter alpahbets for Market name");
		formflag = false;
     }/* else if(!validMktName){
		alert("Please enter new Market name");
		formflag = false;
	} */else if($("#mkt_group").val()==""){
		alert("Please select Market group");
		formflag = false;
	}else if(validateMkGrp && mktGrpName==""){
		alert("Market Group Name Cannot be blank");
		formflag = false;
	}else if(validateMkGrp && !(alphabetReg.test(mktGrpName))){
		alert("Please enter alpahbets for Market Group name");
		formflag = false;
	}else if(mktDMA==""){
		alert("Market DMA Cannot be blank");
		formflag = false;
	}else if(!(alphabetReg.test(mktDMA))){
		alert("Please enter alpahbets for Market DMA");
		formflag = false;
	}else if(CDL==""){
		alert("CDL Cannot be blank");
		formflag = false;
	}else if(!(alphaNumReg.test(CDL))){
		alert("Please enter alphanumeric value for CDL");
		formflag = false;
	}else if($("#timezone").val()==""){
		alert("Please select timezone");
		formflag = false;
	}else if(mktDesc.charAt(0)==("'")){
		alert("Description should not start with ' ");
		formflag = false;
	}else if(!(mktDesc.indexOf("\"")== -1)){
		alert("Description should not contain  \" ");
		formflag = false;
	}
	
	return formflag;
	
}

function populateMarketInformation(market){
	
	//populateMarketViewData(popup_mktResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets?market=" + market,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			populateMarketViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateMarketViewData(resp){
	webservice_error.style.display = 'none';
	if(resp.ivodMarkets.length> 0) {
		editPopupDataBefore = resp.ivodMarkets[0];
		
		$("#Market_Name").val(resp.ivodMarkets[0].market);
		mktGroup = resp.ivodMarkets[0].marketGroup;
		$("#Market_DMA").val(resp.ivodMarkets[0].marketDma);
		$("#CDL").val(resp.ivodMarkets[0].cdlList);
		$("#timezone").val(resp.ivodMarkets[0].timezone);
		$("#mkt_desc").val(resp.ivodMarkets[0].description);
	
	}else{
		webservice_error.style.display = 'block';;
	}
	
}

function updateMarket(){
	if(validateMarketForm()){
	var requestData = {
		ivodMarkets : [{
			market:($.trim($("#Market_Name").val())),
			marketGroup:($.trim($("#mkt_group").val())),
			marketDma: ($.trim($("#Market_DMA").val())),
			cdlList: ($.trim($("#CDL").val())),
			timezone: ($.trim($("#timezone").val())),
			description: ($.trim($("#mkt_desc").val()))
		}]
	};
	cancelInd = true;
	editPopupDataAfter = requestData.ivodMarkets[0];
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
}
</script>