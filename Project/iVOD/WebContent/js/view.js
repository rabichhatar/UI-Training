
var chk_list =[];
var mktname = "";
var $listItems = $('li');
var acc_count=0;
$(function(){

	switch(responseType){
	
		case "ivodMarkets": 
			$("#page_title").html("View Market");
			populateList("http://162.150.162.102:9001/ivodquery/select/ivodMarkets", prepareMarketList);
			break;
		case "ivodAccounts": 
			$("#page_title").html("View Account");
			populateList("http://162.150.162.102:9001/ivodquery/select/ivodAccounts", prepareAccountList);
			break;
		case "ivodSeries":
			$("#page_title").html("View Series");
			populateList("http://162.150.162.102:9001/ivodquery/select/ivodSeries", prepareSeriesList);
			break;
			
	}
	//getMarketList();
    //markets = localStorage.getItem("markets");
	
    
});

function populateList(url, callback){
	
	//prepareAccountList(respJson);
	//prepareSeriesList(seriesResp);
	
	$.ajax({
		url: url,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			callback(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
}


function prepareAccountList(resp){
	$("#account_selector").show();
	
	var jsonArr = resp.ivodAccounts;
	
	var html = '';
	var mktList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
            return compareStrings(a.market, b.market);
   });

		html +='<option value=\'-1\'>Select Account</option>';
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i];
			if(mktList.indexOf(item.accountName)==-1){
				mktList.push(item.accountName);
				html +='<option value=\"'+item.accountName+'\">'+item.accountName+'</option>';
			}	
		}
	}else{
		html += '<option value=\'-1\'>No accounts found</option>';
		
	}
	
	$("#account_list").html(html);
	
	$("#account_list").off('change');
	$("#account_list").on('change', function(){
		populateAccountInformation();
		//populateAccountSeriesInformation();
	});
	
}

function populateAccountInformation(){
	//populateAccountViewData(respJson);
	
	var selectedAccount = $("#account_list option:selected").val();
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?accountName=" + selectedAccount,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateAccountViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateAccountViewData(resp){
	
	if(resp.ivodAccounts.length> 0) {
		$("#account_search_value_container").show();
		$("#billing_account_name").html(resp.ivodAccounts[0].billingAccount);
		$("#x1_account_id").html(resp.ivodAccounts[0].xAccount);
		$("#dvr_virtual_recorder_id").html(resp.ivodAccounts[0].xDevice);
		$("#account_market").html(resp.ivodAccounts[0].market);
		$("#account_description").html(resp.ivodAccounts[0].description);
		
		populateAccountSeriesInformation(resp.ivodAccounts[0].xAccount);
	} else {
		$("#account_search_value_container").hide();		
	}
	collapseAccountSeries();
	
}

//function to populate accounts in which the series are scheduled for recording
function populateAccountSeriesInformation(xAccount){
	//populateAccountSeriesViewData(seriesResp);
	
	var selectedMarket = $("#account_list option:selected").val();
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?ivodAccountId=" + xAccount,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateAccountSeriesViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateAccountSeriesViewData(resp){
	var html = "";
	var accList = [];
	if(resp.ivodSeries.length> 0) {
		html = "<table><tr><th>Series Id</th><th>Series Name</th></tr>";
		for(var index=0; index< resp.ivodSeries.length; index++){
			if(accList.indexOf(resp.ivodSeries[index].seriesId)==-1){
				accList.push(resp.ivodSeries[index].seriesId);
				if(index%2 == 0)
					html += ("<tr><td>"+resp.ivodSeries[index].seriesId+"</td><td>"+resp.ivodSeries[index].seriesName+"</td></tr>");
				else
					html += ("<tr class='alt'><td>"+resp.ivodSeries[index].seriesId+"</td><td>"+resp.ivodSeries[index].seriesName+"</td></tr>");
			}
		}
		html += "</table>";
		$("#series_information_account").html(html);
	} else {
		$("#series_information_account").html("No Series Present");
	}
	
}

function expandAccountSeries(){
	$("#series_information_account").show();
	$("#accountSeriesCollapseButton").show();
	$("#accountSeriesExpandButton").hide();
}
function collapseAccountSeries(){
	$("#series_information_account").hide();
	$("#accountSeriesCollapseButton").hide();
	$("#accountSeriesExpandButton").show();
}


function prepareMarketList(resp){
	$("#market_selector").show();
	var jsonArr = resp.ivodMarkets;
	var html = '';
	var mktList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
            return compareStrings(a.market, b.market);
   });

		html +='<option value=\'-1\'>Select Market</option>';
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i];
			if(mktList.indexOf(item.market)==-1){
				mktList.push(item.market);
				html +='<option value=\"'+item.market+'\">'+item.market+'</option>';
			}	
		}
	}else{
		html += '<option value=\'-1\'>No markets found</option>';
		
	}
	
	$("#market_list").html(html);
	
	$("#market_list").off('change');
	$("#market_list").on('change', function(){
		populateMarketInformation();
		populateMarketSeriesInformation();
		populateMarketAccountInformation();
	});
	
}


function populateMarketAccountInformation(){
	
	var selectedMarket = $("#market_list option:selected").val();
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?market=" + selectedMarket,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateMarketAccountViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateMarketAccountViewData(resp){
	var html = "";
	if(resp.ivodAccounts.length> 0) {
		html = "<table><tr><th>Account Name</th><th>xAccount</th></tr>";
		for(var index=0; index< resp.ivodAccounts.length; index++){
			if(index%2 == 0)
				html+=("<tr><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
			else
				html+=("<tr class='alt'><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
		}
		html += "</table>";
		$("#account_information").html(html);
		//alert(html);
	} else {
		$("#account_information").html("No Account Present");
	}
}

function populateMarketSeriesInformation(){
	var selectedMarket = $("#market_list option:selected").val();
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?market=" + selectedMarket,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateMarketSeriesViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateMarketSeriesViewData(resp){
    var html = "";
	var seriesList = [];
	if(resp.ivodSeries.length> 0) {
		html = "<table><tr><th>Series Id</th><th>Series Name</th></tr>";
		for(var index=0; index< resp.ivodSeries.length; index++){
			if(seriesList.indexOf(resp.ivodSeries[index].seriesId)==-1){
				seriesList.push(resp.ivodSeries[index].seriesId);
				if(index%2 == 0)
					html += ("<tr><td>"+resp.ivodSeries[index].seriesId+"</td><td>"+resp.ivodSeries[index].seriesName+"</td></tr>");
				else
					html += ("<tr class='alt'><td>"+resp.ivodSeries[index].seriesId+"</td><td>"+resp.ivodSeries[index].seriesName+"</td></tr>");
			}
		}
		html += "</table>";
		$("#series_information").html(html);
	} else {
		$("#series_information").html("No Series Present");
	}
}

function populateMarketInformation(){
	var selectedMarket = $("#market_list option:selected").val();
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets?market=" + selectedMarket,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateMarketViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateMarketViewData(resp){
	
	if(resp.ivodMarkets.length> 0) {
		$("#market_search_value_container").show();
		$("#market_group").html(resp.ivodMarkets[0].marketGroup);
		$("#market_dma_name").html(resp.ivodMarkets[0].marketDma);
		$("#cdl_list").html(resp.ivodMarkets[0].cdlList);
		$("#time_zone").html(resp.ivodMarkets[0].timezone);
		$("#description").html(resp.ivodMarkets[0].description);
	} else {
		$("#market_search_value_container").hide();		
	}
	collapseSeries();
	collapseAccount();
}

function exandSeries(){
	$("#series_information").show();
	$("#seriesCollapseButton").show();
	$("#seriesExpandButton").hide();
}
function collapseSeries(){
	$("#series_information").hide();
	$("#seriesCollapseButton").hide();
	$("#seriesExpandButton").show();
}

function expandAccount(){
	$("#account_information").show();
	$("#accountCollapseButton").show();
	$("#accountExpandButton").hide();
}
function collapseAccount(){
	$("#account_information").hide();
	$("#accountCollapseButton").hide();
	$("#accountExpandButton").show();
}

/*function addSearchOption(){
	
	indxCount ++;
	
	var html = '<div id="serach_option_'+indxCount+'" style="padding-bottom: 10px;">';
	html += '	<select class="search_opt" id="select_field_'+indxCount+'" onkeypress="submitSeriesSerachKeyPress(event);">';
	//html += '		<option value="all">Display All</option>';
	html += 		select_options;
	html += '	</select>';
	html += '	<input type="text" class="search_key" id="search_txt_'+indxCount+'" onkeypress="submitSeriesSerachKeyPress(event);" />';
	html += '	<input type="button" class="add_btn" id="add_btn_'+indxCount+'" onclick="addSearchOption();"  value="+"/>';
	html += '	<input type="button" class="remove_btn" id="remove_btn_'+indxCount+'" onclick="removeSearchOption('+indxCount+');" value="-"/>';
	html += '</div>';
	
	search_fields.push(indxCount);
	$("#serach_option_main").append(html);
	$(".add_btn").hide();
	$(".remove_btn,#add_btn_"+indxCount).show();
	
}*/

function prepareSeriesList(resp){
	$("#series_selector").show();
	
	var jsonArr = resp.ivodSeries;
	
	var html = '';
	var seriesList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
            return compareStrings(a.seriesName, b.seriesName);
   });

		html +='<option value=\'-1\'>Select Series</option>';
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i];
			if(seriesList.indexOf(item.seriesName)==-1){
				seriesList.push(item.seriesName);
				html +='<option value=\"'+item.seriesName+'\">'+item.seriesName+'</option>';
			}	
		}
	}else{
		html += '<option value=\'-1\'>No series found</option>';
		
	}
	
	$("#series_list").html(html);
	
	$("#series_list").off('change');
	$("#series_list").on('change', function(){
		populateSeriesInformation();
	});
}

function populateSeriesInformation(){
	//populateSeriesViewData(multiresp);
	
	var selectedSeries = $("#series_list option:selected").val();
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?seriesName=" + selectedSeries,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateSeriesViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

var mktCallCount = 0;
var accCallCount = 0;

function populateSeriesViewData(resp){
	
	mktCallCount = 0;
	accCallCount = 0;
	
	$("#market_information_series,#account_information_series").html("");
	
	if(resp.ivodSeries.length> 0) {
		$("#series_search_value_container").show();
		$("#series_id").html(resp.ivodSeries[0].seriesId);
		
		populateSeriesMarketViewData(resp);
		
		for(var i=0;i<resp.ivodSeries.length;i++){
			populateSeriesAccountInformation(resp.ivodSeries[i].ivodAccountId);
		}
		
	} else {
		$("#series_search_value_container").hide();		
	}
	collapseSeriesAccount();
	collapseSeriesMarket();
}

function populateSeriesMarketViewData(resp){
	
	var html = "";
	var mktList=[];
	if(resp.ivodSeries.length> 0) {
		html = "<table id='ser_mkt_tbl'><tr><th>Market Name</th></tr>";
		for(var index=0; index< resp.ivodSeries.length; index++){
			if(mktList.indexOf(resp.ivodSeries[index].market)==-1){
				mktList.push(resp.ivodSeries[index].market);
				if(index%2 == 0)
					html+=("<tr><td>"+resp.ivodSeries[index].market+"</td></tr>");
				else
					html+=("<tr class='alt'><td>"+resp.ivodSeries[index].market+"</td></tr>");
			}
		}
		html += "</table>";
		$("#market_information_series").html(html);
	} else {
		$("#market_information_series").html("No Account Present");
	}
	
}

function populateSeriesAccountInformation(accountId){
	//populateSeriesAccountViewData(respJson);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?xAccount=" + accountId,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
			populateSeriesAccountViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateSeriesAccountViewData(resp){
	var html = "";
	if(resp.ivodAccounts.length> 0) {
		if(accCallCount==0)
			html = "<table id='ser_acc_tbl'><tr><th>Account Name</th><th>xAccount</th></tr>";
		for(var index=0; index< resp.ivodAccounts.length; index++){
			if(acc_count%2 == 0)
				html+=("<tr><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
			else
				html+=("<tr class='alt'><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
		
			acc_count++;
		}
		html += "</table>";
		
		if(accCallCount==0)
			$("#account_information_series").html(html);
		else
			$("#ser_acc_tbl").append(html);
	} else {
		if(accCallCount==0)
			$("#account_information_series").html("No Account Present");
	}
	accCallCount++;
}

function expandSeriesAccount(){
	$("#account_information_series").show();
	$("#seriesAccountCollapseButton").show();
	$("#seriesAccountExpandButton").hide();
}
function collapseSeriesAccount(){
	$("#account_information_series").hide();
	$("#seriesAccountCollapseButton").hide();
	$("#seriesAccountExpandButton").show();
}

function expandSeriesMarket(){
	$("#market_information_series").show();
	$("#seiresMarketCollapseButton").show();
	$("#seiresMarketExpandButton").hide();
}
function collapseSeriesMarket(){
	$("#market_information_series").hide();
	$("#seiresMarketCollapseButton").hide();
	$("#seiresMarketExpandButton").show();
}