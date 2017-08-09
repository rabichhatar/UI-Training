<style>
span#mktname_error{color:red;display:none;position: absolute;margin: 0px 10px;}
div.textbox1 {padding:10px 0;margin-left: 120px;}
div.textbox1 > label {display:inline-block; width:250px !important; text-align:left;}
div.textbox1 > div{display:inline-block;width:191px;}
div.textbox1 > input{width:200px;}
div.textbox1 > input.submit{width:auto;}
div.mkt_desc {width:auto;}
</style>
<div class="textbox1">
	<label for="Market_name"><Span style="color:red">*</Span><b>Market:</b></label>
	<div>
		<input type="text" id="Market_Name" maxlength="20" name="Market_Name" size="25" value="<%=(String)((session.getAttribute("mkt_name")!=null)?session.getAttribute("mkt_name"):"")%>"/>
		<span class="validation_number">Please enter alphanumeric values only</span>
	</div>
	<span id="mktname_error">Market already exists</span>
</div>
<div class="textbox1">
	<label for="Market group"><Span style="color:red">*</Span><b>Market Group:</b></label>
	<div>
		<!-- <input type="text" id="Market group" name="Market group" size="25"> -->
		<select name="mkt_group" id="mkt_group">
			
		</select>
	</div>
</div>
<div class="textbox1" id="new_market_name_div" style="display: none;">
	<label for="new_market_name"><b>Add new Market Group:</b></label>
	<div>
		<input type="text" id="new_market_name" maxlength="20" name="new_market_name" size="25" value="<%=(String)((session.getAttribute("mkt_group_name")!=null)?session.getAttribute("mkt_group_name"):"")%>"/>
		<span class="validation_number">Please enter alphabets only</span>
	</div>
</div>
<div class="textbox1">
	<label for="Market_DMA"><Span style="color:red">*</Span><b>Market DMA Name:</b></label>
	<div>
		<input type="text" id="Market_DMA" name="Market_DMA" maxlength="20" size="25" value="<%=(String)((session.getAttribute("mkt_dma")!=null)?session.getAttribute("mkt_dma"):"")%>"/>
		<span class="validation_number">Please enter alphabets only</span>
	</div>
</div>

<div class="textbox1" style="padding-bottom: 2px;">
	<label for="CDL"><Span style="color:red">*</Span><b>CDL List:</b></label>
	<div>
		<input type="text" id="CDL" name="CDL" maxlength="25" size="25" value="<%=(String)((session.getAttribute("cdl")!=null)?session.getAttribute("cdl"):"")%>"/>
		<span class="validation_number">Please enter alphanumeric value only</span>
	</div>
</div>
<div class="textbox1" style="padding: 0px;">
       <label></label>
       <div>
               <span style="color:#848484; font-size: 10px;">(Comma Separated List)</span>
       </div>
</div>
<div class="textbox1">
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
<div class="textbox1">
	<label for="mkt_desc" style= "padding-top: 10px;vertical-align: top;"><b>Description :</b></label>
	<div class='mkt_desc'>
	    <textarea rows="3" cols="35" id="mkt_desc" name="mkt_desc" maxlength="100" placeholder="Enter Market Description here!"><%=(String)((session.getAttribute("mkt_desc")!=null)?session.getAttribute("mkt_desc"):"")%></textarea>
	</div>
	<div style="margin-left: 254px; font-size:9px;">
	 <span id="counter">100</span> characters left.
	</div>
</div>
		
<script>
var alphabetReg = /^[a-zA-Z0-9 ]*$/;
var alphaNumReg = /^[a-zA-Z0-9, ]+$/;
var alphabet = /^[a-zA-Z ]*$/;
var validateMkGrp = false;
var validMktName = false;

$(function(){
	initaiteCounter("mkt_desc","counter",100);
	$("#mkt_group").change(function(){
		if($(this).val()=="create_new"){
			$("#new_market_name_div").show();
			validateMkGrp=true;
		}else{
			$("#new_market_name_div").hide();
			validateMkGrp=false;
		}
	});
	
	$("#Market_DMA,#new_market_name").keyup(function(){
       //  $("#mktname_error").css({"display":"none"});
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
	
$("#Market_Name").bind('blur',function(){
		var name = $.trim($(this).val());
		if(name!="")
			validateMarketName(name);
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
			//alert("Success");
			//alert(JSON.stringify(resp));
			prepareMarketGroupList(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
}


var checkList =[];
function prepareMarketGroupList(resp){
	var jsonArr = resp.ivodMarkets;
	var html = '';
	html += '<option hidden="true" value="">Select a market group</option>';
	html += '<option value="create_new">CREATE NEW</option>';
	var mktList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
			return compareStrings(a.marketGroup, b.marketGroup);
			});
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
	if(response=="success"){
		$("#mkt_group").val(mkt_group).attr({"disabled":"disabled"}); 
	}else if(response=="fail"){
		$("#mkt_group").val(mkt_group);
	}
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
	var mktGrpName = $.trim($("#new_market_name").val());
	$("#new_market_name").val(mktGrpName);
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
     }else if(!validMktName){
		alert("Please enter new Market name");
		formflag = false;
	}else if($("#mkt_group").val()==""){
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
	}
	else if(mktDesc.charAt(0)==("'")){
		alert("Description should not start with ' ");
		formflag = false;
	}else if(!(mktDesc.indexOf("\"")== -1)){
		alert("Description should not contain  \" ");
		formflag = false;
	}
	
	return formflag;
	
}
function validateMarketName(mktname){
	   //checkMarketName(respJson);	
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets?market="+mktname,
		type:"GET",
		crossDomain: true,
		dataType: "JSON",
		data:null,
		//data:'',
		success:function(resp){
			checkMarketName(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
}
function checkMarketName(resp){
	var jsonArr = resp.ivodMarkets;
	$("#Market_Name").siblings("span.validation_number").css("display","none");
	if(jsonArr.length>0){
		validMktName = false;
		$("#mktname_error").css({"display":"inline"});
	}else{
		validMktName = true;
		$("#mktname_error").css({"display":"none"});
	}
	
	/* if(checkList.indexOf(resp)>-1){
		validMktName = false;
		$("#mktname_error").css({"display":"inline"});
	}else{
		validMktName = true;
		$("#mktname_error").css({"display":"none"});
	} */
}
 // var respJson = {"ivodMarkets":[{"market":"SoCal","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"SoCal1","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"SoCal2","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"SoCal21","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"SoCal213","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"Bay Area","marketGroup":"West Coast","marketDma":"dma1","cdlList":"LA, TOR, LB","timezone":"PST","description":"South California"},{"market":"Philly","marketGroup":"East Coast","marketDma":"dma3","cdlList":"LA, TOR, LB","timezone":"EST","description":"Philly"},{"market":"Chicago","marketGroup":"Mid West","marketDma":"dma4","cdlList":"CH SC VH","timezone":"CST","description":"Chicago Area"},{"market":"Milwaukee","marketGroup":"Mid West","marketDma":"dma5","cdlList":"MW MD","timezone":"CST","description":"Wisconsin"},{"market":"Houston","marketGroup":"South","marketDma":"dma6","cdlList":"Hou Dal Aus","timezone":"CST","description":"Texas Houston Region"},{"market":"New York","marketGroup":"East Coast","marketDma":"dmaNY","cdlList":"CDL_NY, CDL_NJ, CDL_Manht","timezone":"EST","description":"New York and surrounding areas"},{"market":"New York2","marketGroup":"East Coast","marketDma":"dmaNY2","cdlList":"CDL_NY, CDL_NJ, CDL_Manht2","timezone":"EST","description":"New York and surrounding areas2"},{"market":"NY6","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"sample"},{"market":"NY7","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"sample"},{"market":"NY8","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"sample"},{"market":"NY9","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"sample"},{"market":"NY61","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"desc 1"},{"market":"NY612","marketGroup":"mkt1","marketDma":"dmaNY6","cdlList":"NY, Man, NJ","timezone":"EST","description":"desc 612"},{"market":"NY614","marketGroup":"mkt1","marketDma":"dmaNY613","cdlList":"NY, Man, NJ","timezone":"EST","description":"613"},{"market":"NY615","marketGroup":"mkt1","marketDma":"dmaNY615","cdlList":"NY, Man, NJ","timezone":"EST","description":"615"},{"market":"NY616","marketGroup":"mkt1","marketDma":"dmaNY613","cdlList":"NY, Man, NJ","timezone":"EST","description":"616"},{"market":"NY618","marketGroup":"mkt1","marketDma":"dmaNY618","cdlList":"NY, Man, NJ","timezone":"EST","description":"618"},{"market":"NY619","marketGroup":"mkt1","marketDma":"dmaNY619","cdlList":"NY, Man, NJ","timezone":"EST","description":"619"},{"market":"Test3Mkt","marketGroup":"Test3Group","marketDma":"dmaTest3","cdlList":"NY, Man, NJ","timezone":"EST","description":"test"},{"market":"4Mkt","marketGroup":"4Mktgrp","marketDma":"dmaTest4","cdlList":"NY, Man, NJ","timezone":"EST","description":" "},{"market":"test3mkt","marketGroup":"mkt3","marketDma":"dma3","cdlList":"ny","timezone":"EST","description":" "},{"market":"boston","marketGroup":"northeast","marketDma":"sample","cdlList":"sfo,la,boston","timezone":"EST","description":"des"},{"market":"NYC","marketGroup":"MktGrpNYC","marketDma":"dmaNYC","cdlList":"NY","timezone":"EST","description":" "},{"market":"sample","marketGroup":"asdfg","marketDma":"sample","cdlList":"la,sfo,123456","timezone":"EST","description":"samp desc"},{"market":"bost","marketGroup":"East Coast","marketDma":"bosdma","cdlList":"bos","timezone":"EST","description":" "},{"market":"SampleMktA","marketGroup":"East Coast","marketDma":"dmaNY","cdlList":"NY","timezone":"EST","description":" "},{"market":"san diego","marketGroup":"West Coast","marketDma":"houston","cdlList":"NY,Ny 1234","timezone":"CST","description":"desc"},{"market":"SampleMktB","marketGroup":"SampleGrpB","marketDma":"dmaA","cdlList":"NY","timezone":"EST","description":" "},{"market":"SampleMktC","marketGroup":"SampleMktGrpC","marketDma":"dmaC","cdlList":"NY","timezone":"EST","description":"SampleMktC"},{"market":"SampleMktD","marketGroup":"West Coast","marketDma":"assdfa","cdlList":"12,idjas","timezone":"EST","description":"mnkj"},{"market":"denver","marketGroup":"West Coast","marketDma":"dma","cdlList":"nyc, phil , ","timezone":"CST","description":"descp"},{"market":"philly","marketGroup":"newgroup","marketDma":"dhash","cdlList":"la,sfo,sandiego","timezone":"EST","description":"test descp"},{"market":"philadelphia","marketGroup":"northeast","marketDma":"sample","cdlList":"12345","timezone":"EST","description":"descp"},{"market":"newjersey","marketGroup":"northeast","marketDma":"dmaboston","cdlList":"12345","timezone":"EST","description":"descp"},{"market":"edisonabcd","marketGroup":"East Coast","marketDma":"dmaabcd","cdlList":"phil, nyc,  texas","timezone":"EST","description":"abcd descp"},{"market":"name","marketGroup":"mkt1","marketDma":"dhash","cdlList":"la,sfo,sandiego","timezone":"EST","description":"descp"}]};
</script>