<style>
	body{font-family:"Helvetica Neue",Helvetica,Arial,sans-serif}
	
	div.textbox_popup {padding:10px 0; float:left;clear:both;}
	div.textbox_popup > label {display:inline-block; width:180px !important; text-align:left;vertical-align: top;}
	div.textbox_popup > div{display:inline-block;width:240px;}
	div.textbox_popup > input{width:200px;}
	div.textbox_popup > input.expand_collapse_btn{width:20px;}
	
	.ui-widget{font-size: 11px !important;}
	
	#show_detail_popup{padding: 10px 0px 0px !important;}
	.popup_search_value_container{display:none;max-height: 323px;float:left;display: none;}
	.popup_inner_container{background: none repeat scroll 0 0 #F7F7F7;width: 450px;margin: 0 0 10px 100px;padding:10px 10px 10px 41px;border: 1px solid #C3C3C3;border-radius:15px;float:left;}
	#series_information td,#account_information td,#series_information_account td,#market_information_series td,#account_information_series td{ border: 1px solid #AAAAAA; padding: 10px;width: 185px;}
	#series_information tr.alt,#account_information tr.alt,#series_information_account tr.alt,#market_information_series tr.alt,#account_information_series tr.alt{background-color: #E0E0E0}
	#series_information th,#account_information th,#series_information_account th,#market_information_series th,#account_information_series th{ 
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
	#popup_footer{height: 40px;width: 100%;background-color: #F7F7F7;margin-top: 0px;border-top:1.5px solid #E5E5E5;}
</style>
<div id="market_search_value_container" class="popup_search_value_container">
	<div class="popup_inner_container">
			<div class="textbox_popup">
			<label for="MarketGroup">
				<strong>Market:</strong>
			</label>
			<div>	
				<label for="Market" id="market"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="MarketGroup">
				<strong>Market Group:</strong>
			</label>
			<div>	
				<label for="MarketGroup" id="market_group"></label>
			</div>
		</div>
		
		<div class="textbox_popup">	
			<label for="MarketDMAName">
				<strong>Market DMA Name:</strong>
			</label>
			<div>	
				<label for="MarketDMAName" id="market_dma_name"></label>
			</div>
		</div>
		
		<div class="textbox_popup">	
			<label for="CdlList">
				<strong>CDL List:</strong>
			</label>
			<div>	
				<label for="CdlList" id="cdl_list"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="TimeZone">
				<strong>Timezone:</strong>
			</label>
			<div>	
				<label for="TimeZone" id="time_zone"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="Description">
				<strong>Description:</strong>
			</label>
			<div>	
				<label for="Description" id="description"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<strong>Series</strong>
			<input id="seriesExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="exandSeries();">		
			<input id="seriesCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeries();" style="display:none;">		
		</div>
				
		<div id="series_information" style="display:none;" class="textbox_popup">No Series Present</div>
	
		
		<div class="textbox_popup">
			<strong>Account</strong>
			<input id="accountExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandAccount();">
			<input id="accountCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseAccount();" style="display:none;">	
		</div>
		
		<div id="account_information" style="display:none;" class="textbox_popup">No Account Present</div>
		
	</div>
</div>
<div id="account_search_value_container" class="popup_search_value_container">

	<div class="popup_inner_container">
		
		<div class="textbox_popup">
			<label for="AccountId">
				<strong>Account ID:</strong>
			</label>
			<div>	
				<label for="AccountId" id="account_id"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="AccountName">
				<strong>Account Name:</strong>
			</label>
			<div>	
				<label for="AccountName" id="account_name"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="BillingAccountName">
				<strong>Billing Account Name:</strong>
			</label>
			<div>	
				<label for="BillingAccountName" id="billing_account_name"></label>
			</div>
		</div>
		
		<div class="textbox_popup">	
			<label for="X1AccountID">
				<strong>X1 Account ID:</strong>
			</label>
			<div>	
				<label for="X1AccountID" id="x1_account_id"></label>
			</div>
		</div>
		
		<div class="textbox_popup">	
			<label for="DvrVirtualRecorderId">
				<strong>DvrVirtualRecorderId:</strong>
			</label>
			<div>	
				<label for="DvrVirtualRecorderId" id="dvr_virtual_recorder_id"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="Market">
				<strong>Market:</strong>
			</label>
			<div>	
				<label for="Market" id="account_market"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="Description">
			<strong>Description:</strong>
			</label>
			<div>	
				<label for="Description" id="account_description"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<strong>Series</strong>
			<input id="accountSeriesExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandAccountSeries();">		
			<input id="accountSeriesCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseAccountSeries();" style="display:none;">		
		</div>	
				
		<div id="series_information_account" style="display:none;" class="textbox_popup">No Series Present</div>
		
	</div>		
</div>
<div id="series_search_value_container" class="popup_search_value_container">

	<div class="popup_inner_container">
	
		<div class="textbox_popup">
			<label for="SeriesID">
				<strong>Series ID:</strong>
			</label>
			<div>	
				<label for="SeriesID" id="series_id"></label>
			</div>
		</div>
		
		<div class="textbox_popup">
			<label for="SeriesName">
				<strong>Series Name:</strong>
			</label>
			<div>	
				<label for="SeriesName" id="series_name"></label>
			</div>
		</div>
		
		<div class="textbox_popup">	
			<strong>Market</strong>
			<input id="seiresMarketExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandSeriesMarket();">
			<input id="seiresMarketCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeriesMarket();" style="display:none;">	
		
		</div>	
		<div id="market_information_series" style="display:none;" class="textbox_popup">No Market Present</div>
		
		<div class="textbox_popup">
			<strong>Account</strong>
			<input id="seriesAccountExpandButton" class="expand_collapse_btn" type="button" value="+" onclick="expandSeriesAccount();">
			<input id="seriesAccountCollapseButton" class="expand_collapse_btn" type="button" value="-" onclick="collapseSeriesAccount();" style="display:none;">	
			
		</div>			
		<div id="account_information_series" style="display:none;" class="textbox_popup">No Account Present</div>
						
	</div>		
</div>
<script type="text/javascript">
var popup_market = '<%=request.getParameter("market")%>';
var popup_seriesName = "<%=request.getParameter("seriesName")%>";
var popup_accountName = '<%=request.getParameter("accountName")%>';
var popup_accountId = '<%=request.getParameter("ivodAccountId")%>';

var acc_count = 0;
var accCallCount = 0;

</script>					
<script type="text/javascript" src="js/details_popup.js"></script>