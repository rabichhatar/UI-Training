$(function(){
	if(popup_market!="null")
		populateMarketInformation(popup_market);
	else if(popup_accountName!="null")
		populateAccountInformation(popup_accountName);
	else if(popup_seriesName!="null")
		populateSeriesInformation(popup_seriesName);
	else if(popup_accountId!="null")
		populateAccountInformation_id(popup_accountId);
});

function populateMarketInformation(market){
	
	//populateMarketViewData(mktResp);
	
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
	
	if(resp.ivodMarkets.length> 0) {
		$("#market_search_value_container").show();
		$("#market").html(resp.ivodMarkets[0].market);
		$("#market_group").html(resp.ivodMarkets[0].marketGroup);
		$("#market_dma_name").html(resp.ivodMarkets[0].marketDma);
		$("#cdl_list").html(resp.ivodMarkets[0].cdlList);
		$("#time_zone").html(resp.ivodMarkets[0].timezone);
		$("#description").html(resp.ivodMarkets[0].description);
		
		populateMarketSeriesInformation(resp.ivodMarkets[0].market);
		populateMarketAccountInformation(resp.ivodMarkets[0].market);
		
	} else {
		$("#market_search_value_container").hide();		
	}
	collapseSeries();
	collapseAccount();
}

function populateMarketSeriesInformation(market){
	//populateMarketSeriesViewData(seriesResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?market=" + market,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
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
				if(index%2==0)
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

function populateMarketAccountInformation(market){
	//populateMarketAccountViewData(accResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?market=" + market,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
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
			if(index%2==0)
				html+=("<tr><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
			else
				html+=("<tr class='alt'><td>"+resp.ivodAccounts[index].accountName+"</td><td>"+resp.ivodAccounts[index].xAccount+"</td></tr>");
		}
		html += "</table>";
		$("#account_information").html(html);
	} else {
		$("#account_information").html("No Account Present");
	}
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

/*================== Account ====================*/

function populateAccountInformation(accountName){
	//populateAccountViewData(accResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?accountName=" + accountName,
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

function populateAccountInformation_id(accountId){
	//populateAccountViewData(accResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?xAccount=" + accountId,
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
		$("#account_search_value_container").show();
		$("#account_id").html(resp.ivodAccounts[0].id);
		$("#account_name").html(resp.ivodAccounts[0].accountName);
		$("#billing_account_name").html(resp.ivodAccounts[0].billingAccount);
		$("#x1_account_id").html(resp.ivodAccounts[0].xAccount);
		$("#dvr_virtual_recorder_id").html(resp.ivodAccounts[0].xDevice);
		$("#account_market").html(resp.ivodAccounts[0].market);
		$("#account_description").html(resp.ivodAccounts[0].description);
		
		populateAccountSeriesInformation(resp.ivodAccounts[0].xAccount);
		
	} else {
		$("#account_search_value_container").html("No Account exists").show();		
	}
	
	collapseAccountSeries();
}

function populateAccountSeriesInformation(xAccount){
	//populateAccountSeriesViewData(seriesResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?ivodAccountId=" + xAccount,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
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
				if(index%2==0)
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

/*================== Series ====================*/

function populateSeriesInformation(series){
	//populateSeriesViewData(multiresp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodSeries?seriesName="+series,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			populateSeriesViewData(resp);
		},
		error:function(resp){
			//alert("getMarketList(): Error");
		}
	});
	
}

function populateSeriesViewData(resp){
	
	accCallCount = 0;
	//$("#account_information_series").html("");
	
	if(resp.ivodSeries.length> 0) {
		$("#series_search_value_container").show();
		$("#series_id").html(resp.ivodSeries[0].seriesId);
		$("#series_name").html(resp.ivodSeries[0].seriesName);
		
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
	var mkt_list = [];
	if(resp.ivodSeries.length> 0) {
		html = "<table id='ser_mkt_tbl'><tr><th>Market Name</th></tr>";
		for(var index=0; index< resp.ivodSeries.length; index++){
			if(mkt_list.indexOf(resp.ivodSeries[index].market)==-1){
				mkt_list.push(resp.ivodSeries[index].market);
				if(index%2 == 0)
					html+=("<tr><td>"+resp.ivodSeries[index].market+"</td></tr>");
				else
					html+=("<tr class='alt'><td>"+resp.ivodSeries[index].market+"</td></tr>");
			}

		}
		html += "</table>";
		$("#market_information_series").html(html);
	} else {
		$("#market_information_series").html("No Market Present");
	}
}

function populateSeriesAccountInformation(accountId){
	//populateSeriesAccountViewData(accResp);
	
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodAccounts?xAccount=" + accountId,
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
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