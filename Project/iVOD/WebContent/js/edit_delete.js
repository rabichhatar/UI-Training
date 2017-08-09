//Regular Expression for validation
//var alphabetReg = /^[a-zA-Z0-9 ]*$/;
var alphaNumeric = /^[a-zA-Z0-9, ]+$/;
var alphabet = /^[a-zA-Z ]*$/;
var numberic = /^[0-9]*$/;

var indxCount = 0;
var search_fields = [ 0 ];
var select_options = '<option>Select</option>';
var serviceURL = "";
var metadataURL = "";
var id_counter = 0;
var global_pageNo = 1;
var global_pageSize = 20;
var editPopupDataBefore = {};
var editPopupDataAfter = {};

var validationMap = {
	"id" : "numberic",
	"seriesId" : "numberic",
	"seriesName" : "alphaNumeric",
	"market" : "alphaNumeric",
	"ivodAccountId" : "numberic",
	"createDate" : "alphaNumeric",
	"createdBy" : "alphaNumeric",
	"modifyDate" : "alphaNumeric",
	"modifiedBy" : "alphaNumeric",
	"marketGroup" : "alphabet",
	"marketDma" : "alphabet",
	"cdlList" : "alphaNumeric",
	"timezone" : "alphaNumeric",
	"description" : "alphaNumeric"
}

var link_map = {
	"market" : "marketLink",
	"seriesName" : "seriesLink",
	"accountName" : "accountLink",
	"ivodAccountId" : "accountIdLink"
};

var search_query = "";

var temp_avl_list = [];
var temp_sel_list = [];

var name_indx = {};
var sort_col = "";
var key_col = "";
var select_col_key = "";
var avilable_col_key = "";

var default_avl_cols = [];
var default_sel_cols = [];
var selected_cols = [];
var avilable_cols = [];

var col_headers = [];
var colModel = [];

var sel_value = null;

var settingHtml = "<div class='setting' onclick='openSettingMenu()' title='Click Here to open settings'><ul><li onclick='resetTableView()'>Default View</li><li onclick='openAviliableColumns()'>Add/Remove Columns</li></ul></button>";

// function to be called when document is ready
$(function() {
	$(".tabDiv ul li").removeClass("active");
	$("#" + responceType).addClass("active");

	// By default values setting
	$("#add_btn_0,#search_txt_0").removeAttr("disabled");
	$("#select_field_0,#search_txt_0").val("");
	$("#search_sbmt_div > input[type='button']").attr("disabled", "disabled");

	if (responceType == "ivodSeries") {
		// $(".searchBox").show();
		$("#page_title").html("Edit/Delete Series");
		sort_col = "seriesId";
		serviceURL = "http://162.150.162.102:9001/ivodquery/select/ivodSeries";
		metadataURL = "http://162.150.162.102:9001/ivodquery/show/ivodSeries";
		select_col_key = "series_selcted_cols";
		avilable_col_key = "series_avilable_cols";
	} else if (responceType == "ivodMarkets") {
		$("#page_title").html("Edit/Delete Markets");
		sort_col = "market";
		serviceURL = "http://162.150.162.102:9001/ivodquery/select/ivodMarkets";
		metadataURL = "http://162.150.162.102:9001/ivodquery/show/ivodMarkets";
		select_col_key = "market_selcted_cols";
		avilable_col_key = "market_avilable_cols";
	} else if (responceType == "ivodAccounts") {
		$("#page_title").html("Edit/Delete Accounts");
		sort_col = "id";
		serviceURL = "http://162.150.162.102:9001/ivodquery/select/ivodAccounts";
		metadataURL = "http://162.150.162.102:9001/ivodquery/show/ivodAccounts";
		select_col_key = "account_selcted_cols";
		avilable_col_key = "account_avilable_cols";
	}

	$("#select_field_0").change(
			function() {

				if ($(this).val() == "Select") {
					$("#add_btn_0,#search_txt_0").removeAttr("disabled");
					$("#search_sbmt_div > input[type='button']").attr(
							"disabled", "disabled");
				} else if ($(this).val() == "all") {
					$("#search_txt_0").val("");
					$("#add_btn_0,#search_txt_0").attr("disabled", "disabled");
					$("#search_sbmt_div > input[type='button']").removeAttr(
							"disabled");
				} else if ($(this).val() != "Select") {
					$("#add_btn_0,#search_txt_0").removeAttr("disabled");
					$("#search_sbmt_div > input[type='button']").removeAttr(
							"disabled");
				}
			});

	// Retriving data from local storage
	if (localStorage.getItem(select_col_key) != null
			&& localStorage.getItem(select_col_key) != null) {
		selected_cols = localStorage.getItem(select_col_key).split(',');
		avilable_cols = localStorage.getItem(avilable_col_key).split(',');
	}

	// Pasting date value formatter
	$(".search_key").on("input propertychange", function() {
		var val = $.trim($(this).val());
		var date = new Date(val);
		if (date != "Invalid Date" && date != null) {
			val = val.substring(0, 10);
			$(this).val(val);
		}
	});

	bulidTableMetaData();
});

// Adding a search option when "+" is clicked
function addSearchOption() {

	indxCount++;

	var html = '<div id="serach_option_' + indxCount
			+ '" style="padding-bottom: 10px;">';
	html += '	<select class="search_opt" id="select_field_' + indxCount
			+ '" onkeypress="submitSeriesSerachKeyPress(event);">';
	// html += ' <option value="all">Display All</option>';
	html += select_options;
	html += '	</select>';
	html += '	<input type="text" class="search_key" id="search_txt_'
			+ indxCount
			+ '" onkeypress="submitSeriesSerachKeyPress(event);" />';
	html += '	<input type="button" class="add_btn" id="add_btn_' + indxCount
			+ '" onclick="addSearchOption();"  value="+"/>';
	html += '	<input type="button" class="remove_btn" id="remove_btn_'
			+ indxCount + '" onclick="removeSearchOption(' + indxCount
			+ ');" value="-"/>';
	html += '</div>';

	search_fields.push(indxCount);
	$("#serach_option_main").append(html);
	$(".add_btn").hide();
	$(".remove_btn,#add_btn_" + indxCount).show();

}
// function that allows enter key
function submitSeriesSerachKeyPress(event) {
	var keycode = event.keyCode ? event.keyCode : event.which;
	if (keycode == '13') {
		submitSeriesSerach();
		event.stopImmediatePropagation();
		event.preventDefault();
	}
}

function openSettingMenu() {
	if (!$(".setting > ul").hasClass("actv"))
		$(".setting > ul").addClass("actv");
	else
		$(".setting > ul").removeClass("actv");

	$(document).click(function(e) {
		var target = e.target;
		if (!$(target).hasClass("setting"))
			$(".setting > ul").removeClass("actv");
	});
}

// Removing the search option when "-" is clicked
function removeSearchOption(indx) {
	var lastIndx = search_fields[search_fields.length - 1];

	removeFromList(indx, search_fields);
	$("#serach_option_" + indx).remove();

	if (search_fields.length == 1) {
		$(".add_btn").show();
		$(".remove_btn").hide();
	} else if (indx == lastIndx) {
		var reqIndx = search_fields[search_fields.length - 1];
		$("#add_btn_" + reqIndx).show();
		$("#remove_btn_" + reqIndx).show();
	}

}

// function to load table metadata from server
function bulidTableMetaData() {
	sel_value = $("#select_field_0").val();
	// $("#select_field_0").html("<option>loading...</option>");

	//prepareTableMetaData(colData);

	$buildTableMetadataAjax = $.ajax({
		url : metadataURL,
		type : "GET",
		crossDomain : true,
		dataType : "JSON",
		data : null,
		timeout : 8000,
		// data:'',
		beforeSend : function() {
			if ($("#select_field_0").find("option").length == 2) {
				$("#select_field_0").html("<option>loading...</option>");
			}
		},
		success : function(resp) {
			prepareTableMetaData(resp);
		},
		error : function(resp, t) {
			if (t === "timeout") {
				bulidTableMetaDataRetry();
			}
		}
	});
}

function bulidTableMetaDataRetry() {
	if (confirm("Failed to retrieve search by options error. Retry?")) {
		bulidTableMetaData();
	}

}
// function to prepare all the table related metadata for creating table
function prepareTableMetaData(resp) {
	var table = resp.tables[0];
	name_indx = table.columns;

	key_col = table.keys[0];

	var sel_html = '';
	var keys = Object.keys(name_indx);
	// var option_keys = Object.keys(name_indx);
	var default_no_cols = 4;

	var link_keys = Object.keys(link_map);
	/*
	 * option_keys.sort(function(a, b) { if (a.toLowerCase() < b.toLowerCase())
	 * return -1; if (a.toLowerCase() > b.toLowerCase()) return 1; return 0; });
	 */

	if (responceType == "ivodAccounts") {
		var temp = keys[4];
		keys[4] = keys[5];
		keys[5] = temp;
		default_no_cols = 5;
	}

	col_headers.push("No");
	colModel.push({
		name : "",
		search : false,
		index : "",
		width : 20,
		align : "center",
		sortable : false
	});

	if (selected_cols.length == 0 && avilable_cols.length == 0) {

		for (var i = 0; i < keys.length; i++) {
			// col_headers.push(name_indx[keys[i]]);
			col_headers.push(ColumnHeadingMap[keys[i]]);

			if (i < default_no_cols) {
				selected_cols.push(keys[i]);
				default_sel_cols.push(keys[i]);

				/*
				 * if(keys[i]=="createDate")
				 * colModel.push({name:keys[i],index:keys[i],
				 * width:"100%",align:"center",formatter:dateFormatter}); else
				 */

				if (link_keys.indexOf(keys[i]) != -1)
					colModel.push({
						name : keys[i],
						index : keys[i],
						width : "100%",
						align : "center",
						formatter : eval(link_map[keys[i]])
					});
				else
					colModel.push({
						name : keys[i],
						index : keys[i],
						width : "100%",
						align : "center"
					});

			} else {
				avilable_cols.push(keys[i]);
				default_avl_cols.push(keys[i]);

				/*
				 * if(keys[i]=="createDate")
				 * colModel.push({name:keys[i],index:keys[i],
				 * width:"100%",align:"center",hidden:true,formatter:dateFormatter});
				 * else
				 */

				if (link_keys.indexOf(keys[i]) != -1)
					colModel.push({
						name : keys[i],
						index : keys[i],
						width : "100%",
						align : "center",
						hidden : true,
						formatter : eval(link_map[keys[i]])
					});
				else
					colModel.push({
						name : keys[i],
						index : keys[i],
						width : "100%",
						align : "center",
						hidden : true
					});
			}

			// sel_html += '<option
			// value="'+option_keys[i]+'">'+ColumnHeadingMap[option_keys[i]]/*
			// name_indx[keys[i]] */+'</option>';
			sel_html += '<option value="' + keys[i] + '">'
					+ ColumnHeadingMap[keys[i]]/* name_indx[keys[i]] */
					+ '</option>';
		}

	} else {

		for (var i = 0; i < keys.length; i++) {
			// col_headers.push(name_indx[keys[i]]);
			col_headers.push(ColumnHeadingMap[keys[i]]);

			if (i < default_no_cols)
				default_sel_cols.push(keys[i]);
			else
				default_avl_cols.push(keys[i]);

			// sel_html += '<option
			// value="'+option_keys[i]+'">'+ColumnHeadingMap[option_keys[i]]/*
			// name_indx[keys[i]] */+'</option>';
			sel_html += '<option value="' + keys[i] + '">'
					+ ColumnHeadingMap[keys[i]]/* name_indx[keys[i]] */
					+ '</option>';
		}

		for (var j = 0; j < col_headers.length; j++) {
			var sel_col_indx = selected_cols
					.indexOf(keys[j]/* col_headers[j] */);
			var avl_col_indx = avilable_cols
					.indexOf(keys[j]/* col_headers[j] */);

			if (sel_col_indx != -1) {
				/*
				 * if(selected_cols[sel_col_indx]=="createDate")
				 * colModel.push({name:selected_cols[sel_col_indx],index:selected_cols[sel_col_indx],
				 * width:"100%",align:"center",formatter:dateFormatter}); else
				 */

				if (link_keys.indexOf(selected_cols[sel_col_indx]) != -1)
					colModel.push({
						name : selected_cols[sel_col_indx],
						index : selected_cols[sel_col_indx],
						width : "100%",
						align : "center",
						formatter : eval(link_map[selected_cols[sel_col_indx]])
					});
				else
					colModel.push({
						name : selected_cols[sel_col_indx],
						index : selected_cols[sel_col_indx],
						width : "100%",
						align : "center"
					});
			} else if (avl_col_indx != -1) {
				/*
				 * if(avilable_cols[avl_col_indx]=="createDate")
				 * colModel.push({name:avilable_cols[avl_col_indx],index:avilable_cols[avl_col_indx],
				 * width:"100%",align:"center",hidden:true,formatter:dateFormatter});
				 * else
				 */

				if (link_keys.indexOf(avilable_cols[avl_col_indx]) != -1)
					colModel.push({
						name : avilable_cols[avl_col_indx],
						index : avilable_cols[avl_col_indx],
						width : "100%",
						align : "center",
						hidden : true,
						formatter : eval(link_map[avilable_cols[avl_col_indx]])
					});
				else
					colModel.push({
						name : avilable_cols[avl_col_indx],
						index : avilable_cols[avl_col_indx],
						width : "100%",
						align : "center",
						hidden : true
					});
			}
		}
	}

	// col_headers.push("Edit/Delete");
	// colModel.push({name:"",search:false,index:"",width:80,align:"center",sortable:
	// false,formatter: editLink});

	select_options = '<option>Select</option><option value="all">Show all Records</option>';
	select_options += sel_html;

	$("#select_field_0").html(select_options);

	if (sel_value != null && sel_value != "null")
		$("#select_field_0").val(sel_value);

	for (i in search_fields) {
		var field = $.trim($("#select_field_" + search_fields[i]).val());

		if (field != "Select" && field != "undefined" && field != "all"
				&& field != "loading...") {

			var heading = ColumnHeadingMap[field];

			if (typeof (heading) != undefined && heading != 'undefined') {
				var indx = col_headers.indexOf(heading);

				if (link_keys.indexOf(field) != -1)
					colModel[indx] = {
						name : field,
						search : false,
						index : field,
						width : "100%",
						align : "center",
						sortable : true,
						formatter : eval(link_map[field])
					};
				else
					colModel[indx] = {
						name : field,
						search : false,
						index : field,
						width : "100%",
						align : "center",
						sortable : true
					};

				// adding column to selected list which are there in selected by
				// search condition
				selected_cols.push(field);
				removeFromList(field, avilable_cols);
			}
		}
	}
}

function marketLink(cellValue, options, rowData, action) {
	id_counter++;
	return "<a href='javascript:openDetailPopup(\"market\",\""
			+ rowData.market
			+ "\",\""
			+ id_counter
			+ "_popup_market\");' id='"
			+ id_counter
			+ "_popup_market' style='text-decoration:none;border-bottom: 1px dashed #999; moz-text-decoration-line: underline;moz-text-decoration-style: dashed;'>"
			+ rowData.market + "</a>";
}

function seriesLink(cellValue, options, rowData, action) {
	return "<a href='javascript:openDetailPopup(\"series\",\""
			+ rowData.seriesName
			+ "\",\""
			+ rowData.id
			+ "_popup_series\");' id='"
			+ rowData.id
			+ "_popup_series' style='text-decoration:none;border-bottom: 1px dashed #999; moz-text-decoration-line: underline;moz-text-decoration-style: dashed;'>"
			+ rowData.seriesName + "</a>";
}

function accountLink(cellValue, options, rowData, action) {
	return "<a href='javascript:openDetailPopup(\"account\",\""
			+ rowData.accountName
			+ "\",\""
			+ rowData.id
			+ "_popup_account\");' id='"
			+ rowData.id
			+ "_popup_account' style='text-decoration:none;border-bottom: 1px dashed #999; moz-text-decoration-line: underline;moz-text-decoration-style: dashed;'>"
			+ rowData.accountName + "</a>";
}

function accountIdLink(cellValue, options, rowData, action) {
	return "<a href='javascript:openDetailPopup(\"accountId\",\""
			+ rowData.ivodAccountId
			+ "\",\""
			+ rowData.id
			+ "_popup_accountId\");' id='"
			+ rowData.id
			+ "_popup_account' style='text-decoration:none;border-bottom: 1px dashed #999; moz-text-decoration-line: underline;moz-text-decoration-style: dashed;'>"
			+ rowData.ivodAccountId + "</a>";
}

// function to format date
function dateFormatter(cellValue, options, rowData, action) {
	var date = new Date(rowData.createDate);
	if (date != null && $.trim(date) != "")
		return date.format("mm-dd-yyyy");
	else
		return date;
}

/*// function to return edit button to jQgrid table row
function editLink(cellValue, options, rowdata, action) {
	return '<input type="button" class="tbl_btn" onclick="editRecord(\''
			+ rowdata[key_col]
			+ '\')" value="Edit"/><input type="button" class="tbl_btn" onclick="deleteRecord(\''
			+ rowdata[key_col] + '\')" value="Delete"/>';
}

// function to return delete button to jQgrid table row
function deleteLink(cellValue, options, rowdata, action) {
	return '<input type="button" class="tbl_btn" onclick="deleteRecord(\''
			+ rowdata[key_col] + '\')" value="Delete"/>';
}

// function to edit respective record from table
function editRecord(recordId) {
	
	 * if(responceType=="ivodSeries"){ window.top.location.href=
	 * applicationContext+"/editseries.jsp?"+key_col+"="+recordId; }else
	 * if(responceType=="ivodMarkets"){ window.top.location.href=
	 * applicationContext+"/editmarket.jsp?"+key_col+"="+recordId; }
	 
}

// function to delete respective record from table
function deleteRecord(recordId) {
	// alert(recordId);
}
*/
// function to delete selected records from table
function deleteSelectedRecords() {
	var selectedRows = $('#list2').jqGrid('getGridParam', 'selarrrow');
}

// function to submit search form after validating the data
function submitSeriesSerach() {
	temp_avl_list = [];
	temp_sel_list = [];

	name_indx = {};

	default_avl_cols = [];
	default_sel_cols = [];
	selected_cols = [];
	avilable_cols = [];

	col_headers = [];
	colModel = [];

	// Retriving data from local storage
	if (localStorage.getItem(select_col_key) != null
			&& localStorage.getItem(select_col_key) != null) {
		selected_cols = localStorage.getItem(select_col_key).split(',');
		avilable_cols = localStorage.getItem(avilable_col_key).split(',');
	}

	bulidTableMetaData();

	if (validateSearchFields())
		buildTableData();
}

// function to validate search fields of the forms before sumitting to server
function validateSearchFields() {
	var validation_flag = true;
	var count = 0;
	search_query = "";

	for (i in search_fields) {

		var field = $.trim($("#select_field_" + search_fields[i]).val());

		if (field != "Select" && field != "undefined" && field != "all"
				&& field != "loading...") {
			var reqVal = $.trim($("#search_txt_" + search_fields[i]).val());

			if (reqVal == "") {
				alert("Please enter value for \'" + ColumnHeadingMap[field]/* name_indx[field] */
						+ "\'");
				validation_flag = false;
				break;
			}/*
				 * else if(!eval(validationMap[field]).test(reqVal)){
				 * alert("Please enter valid value for
				 * \'"+fieldname_indx[field]+"\'"); validation_flag = false;
				 * break; }
				 */else {
				if (count == 0)
					search_query += "?" + field + "=" + reqVal;
				else
					search_query += "&" + field + "=" + reqVal;
				count++;
			}
		}

	}
	return validation_flag;
}

// function to call webservice and get the repsonse to prepare table
function buildTableData(pageNo, pageSize) {
	if (typeof (pageNo) == "undefined")
		pageNo = 1;
	if (typeof (pageSize) == "undefined")
		pageSize = 20;

	global_pageNo = pageNo;
	global_pageSize = pageSize;
	
	//prepareTable(myData[responceType]);

	$buildTableDataAjax = $.ajax({
		url : serviceURL + search_query,
		type : "GET",
		crossDomain : true,
		dataType : "JSON",
		data : null,
		timeout : 8000,
		// data:'',
		beforeSend : function() {
			$("#search_sbmt_loading").show();
		},
		success : function(resp) {
			//alert(JSON.stringify(resp));
			$.when($buildTableMetadataAjax).done(
					function() {
						prepareTable(resp[responceType]);
						if (hghtInd) {
							$("tr#" + rowId).addClass("highlight");
							setTimeout(function() {
								$("tr#" + rowId).removeClass("highlight");
							},10000);

							
							hghtInd = false;
						}
					});
		},
		error : function(resp, t) {
			//alert("alert");
			$("#message_div").html( "Unable to show the records due to an error").show()
			
			if (t === "timeout") {
				buildTableDataRetry();
			}
		},
		complete : function() {
			$("#search_sbmt_loading").hide();

		}
	});

}
function buildTableDataRetry() {
	if (confirm("Failed to retrieve search information error. Retry?")) {
		buildTableData();
	}
}

// function to build table using jQGrid
function prepareTable(resp) {
	$('#list2').jqGrid('GridUnload');

	if (resp != "undefined" && resp.length > 0) {
		$("#noResult").hide();

		/*
		 * var hght = 470; if(resp.length<20)
		 */
		hght = "auto";

		$("#list2")
				.jqGrid(
						{
							datatype : "local",
							data : resp,
							colNames : col_headers,
							colModel : colModel,
							rowNum : global_pageSize,
							rowList : [ 10, 20, 30, 40, 50, resp.length ],
							pager : '#pager2',
							sortname : sort_col,
							viewrecords : true,
							sortorder : "asc",
							ignoreCase : true,
							/*
							 * shrinkToFit:true, maxWidth: 700,
							 */
							multiselect : true,
							page : global_pageNo,
							height : hght,
							caption : $("#page_title").html(),
							sortable : true,
							loadComplete : function() {
								$("option[value=" + resp.length + "]").text(
										'View All');
								$(".ui-pg-selbox").val(global_pageSize);
								$("tr.jqgrow:odd").addClass('myAltRowClass');
								var pageno = $(".ui-pg-input").val();
								var pagesize = $(".ui-pg-selbox").val();
								$('#list2 tr').each(
								   function(i) {
									    if (i != 0)
												$(this).children("td:eq(1)").html(
												(pageno - 1)* pagesize+ i);
												});
								if (pagesize == 10) {
									$("#list2").jqGrid('setGridHeight', "auto");
								} else {
									$("#list2").jqGrid('setGridHeight', hght);
								}
								if (responceType == "ivodMarkets" || responceType == "ivodAccounts")
									ShowEditDeleteOnHover();
							}
						});
		$("#list2").jqGrid('navGrid', '#pager2', {
			edit : false,
			add : false,
			del : false,
			search : false,
			refresh : false
		});
		$('.ui-jqgrid-title').before(settingHtml);

		$(".setting").tooltip(
				{
					position : {
						my : "center bottom-20",
						at : "center top",
						extraClass : "abc",
						using : function(position, feedback) {
							$(this).css(position);
							$("<div>").addClass("arrow").addClass(
									feedback.vertical).addClass(
									feedback.horizontal).appendTo(this);
						}
					}
				});

		$("#list2").jqGrid("setGridWidth", 900);
		$("#list2").jqGrid('gridResize', {
			minWidth : 800,
			maxWidth : 900,
			minHeight : 80,
			maxHeight : 600
		});

		$("#table_resultDiv,#resetDiv").show();
	} else {
		$("#table_resultDiv,#noResult").show();
		$("#resetDiv").hide();
	}
}

// function to reset table view to default
function resetTableView() {
	selected_cols = [];
	avilable_cols = [];

	for (i in default_avl_cols)
		addToList(default_avl_cols[i], avilable_cols);

	for (j in default_sel_cols)
		addToList(default_sel_cols[j], selected_cols);

	updateTable();
}

// Opening the add/remove popup showing avilable and selected column names
function openAviliableColumns() {
	temp_avl_list = [];
	for (var i = 0; i < avilable_cols.length; i++)
		temp_avl_list.push(avilable_cols[i]);

	temp_sel_list = [];
	for (var j = 0; j < selected_cols.length; j++)
		temp_sel_list.push(selected_cols[j]);

	var avail_html = '';
	var selected_html = '';

	if (avilable_cols.length > 0) {
		avail_html += '<li col="SelectAll"><input type="checkbox" value="SelectAll" class="clmn_list_cb">Select All</li>';
	}
	for (var i = 0; i < avilable_cols.length; i++) {
		// avail_html +='<li
		// col="'+avilable_cols[i]+'">'+name_indx[avilable_cols[i]]+'</li>';
		avail_html += '<li col="' + avilable_cols[i]
				+ '"><input type="checkbox" value="' + avilable_cols[i]
				+ '" class="clmn_list_cb">'
				+ ColumnHeadingMap[avilable_cols[i]] + '</li>';
	}
	$("#aviliable_column_list").html(avail_html);

	for (var i = 0; i < selected_cols.length; i++) {
		// selected_html +='<li
		// col="'+selected_cols[i]+'">'+name_indx[selected_cols[i]]+'</li>';
		selected_html += '<li col="' + selected_cols[i]
				+ '"><input type="checkbox" value="' + selected_cols[i]
				+ '" class="clmn_list_cb">'
				+ ColumnHeadingMap[selected_cols[i]] + '</li>';
	}
	$("#selected_column_list").html(selected_html);

	$("#select_columns_popup").dialog({
		width : 540,
		maxHeight : 500,
		modal : true
	});

	initiatePopupFunctionality();
}

// function to initiate popup functionality
function initiatePopupFunctionality() {

	// $(".clmn_list > li").click(function(){
	$(".clmn_list input[type='checkbox']").click(function() {
		if ($(this).is(':checked')) {
			$(this).addClass("checked");
			$(this).prop('checked', true);
			$(this).parent("li").addClass("selected");
		} else {
			$(this).removeClass("checked");
			$(this).prop('checked', false);
			$(this).parent("li").removeClass("selected");
		}
	});
	$(".clmn_list input[type='checkbox'][value='SelectAll']").off('click');
	$(".clmn_list input[type='checkbox'][value='SelectAll']")
			.on(
					'click',
					function() {
						if ($(
								"#aviliable_column_list input[type='checkbox'][value='SelectAll']")
								.is(':checked')) {
							$("#aviliable_column_list input[type='checkbox']")
									.addClass("checked");
							$("#aviliable_column_list input[type='checkbox']")
									.prop('checked', true);
							$("#aviliable_column_list input[type='checkbox']")
									.parent("li").addClass("selected");
						} else {
							$("#aviliable_column_list input[type='checkbox']")
									.removeClass("checked");
							$("#aviliable_column_list input[type='checkbox']")
									.prop('checked', false);
							$("#aviliable_column_list input[type='checkbox']")
									.parent("li").removeClass("selected");
						}
					});
	$(".clmn_list input[type='checkbox']").keypress(function(event) {
		var keycode = event.keyCode ? event.keyCode : event.which;
		if (keycode == '13') {
			$(this).trigger("click");
		} else if (keycode == '40') {
			event.preventDefault();
			$(this).parent().next().find("input").focus();
			// $(this).next().focus();
			// $(this).trigger({type: 'keypress',which: 9});
		} else if (keycode == '38') {
			event.preventDefault();
			$(this).parent().prev().find("input").focus();
		}
	});
	$(".clmn_list input[type='checkbox']").focus(function() {
		$(".clmn_list > li").removeClass("active");
		$(this).parent("li").addClass("active");
	});

}

// function to update table after clicking ok button in Add/Remove column popup
function updateTable() {

	for (var i = 0; i < selected_cols.length; i++) {
		$("#list2").showCol(selected_cols[i]);
	}

	for (var i = 0; i < avilable_cols.length; i++) {
		$("#list2").hideCol(avilable_cols[i]);
	}
	$("#list2").jqGrid("setGridWidth", 800);

	// setting the selected columns to local storage
	localStorage.setItem(avilable_col_key, avilable_cols);
	localStorage.setItem(select_col_key, selected_cols);

	$("#select_columns_popup").dialog('close');

}

// function to be executed when clicking cancel button in Add/Remove column
// popup
function resetToPrev() {
	avilable_cols = [];
	for (var i = 0; i < temp_avl_list.length; i++)
		avilable_cols.push(temp_avl_list[i]);

	selected_cols = [];
	for (var j = 0; j < temp_sel_list.length; j++)
		selected_cols.push(temp_sel_list[j]);

	$("#select_columns_popup").dialog('close');
}

// function to move the element from available list to selected list in popup
function movetoselected() {
	// var col = $(".clmn_list > li.active").attr("col");

	// var flag = removeFromList(col,avilable_cols);
	// if(flag)
	var cols = [];
	$("#aviliable_column_list > li > input.clmn_list_cb:checked").each(
			function() {
				cols.push($(this).parent().attr("col"))
			});
	if (cols.length > 0) {
		// removing select all item as it should not be copied to right hand
		// side
		cols = $.grep(cols, function(value) {
			return value != "SelectAll"
		});
		avilable_cols = removeArrayFromList(cols, avilable_cols);
		addArrayToList(cols, selected_cols);
		// addToList(col,selected_cols);

		updateColumnList();
	}
}

// function to move the element from selected list to availiable list in popup
function movetoaviliable() {
	if (selected_cols.length > 1) {
		// var col = $(".clmn_list > li.active").attr("col");

		var cols = [];
		$("#selected_column_list > li > input.clmn_list_cb:checked").each(
				function() {
					cols.push($(this).parent().attr("col"))
				});
		if (cols.length > 0) {
			if (cols.length == selected_cols.length) {
				alert("You should have at least one column selected.");
			} else {
				selected_cols = removeArrayFromList(cols, selected_cols);
				addArrayToList(cols, avilable_cols);
				// var flag = removeFromList(col,selected_cols);
				// if(flag)
				// addToList(col,avilable_cols);
				updateColumnList();
			}
		}
	}
}
function addArrayToList(values, array_list) {
	$.merge(array_list, values);
	// array_list.push(value);
}

function removeArrayFromList(values, array_list) {
	var array_list_new = [];
	if (values.length > 0) {
		array_list_new = $.grep(array_list, function(value) {
			return !(values.indexOf(value) > -1);
		});
	}
	return array_list_new;
}
// Update column list after "move left"/"move right" i.e >/< button is clicked
function updateColumnList() {
	var avail_html = '';
	var selected_html = '';

	if (avilable_cols.length > 0) {
		avail_html += '<li col="SelectAll"><input type="checkbox" value="SelectAll" class="clmn_list_cb">Select All</li>';
	}
	for (var i = 0; i < avilable_cols.length; i++) {
		// avail_html +='<li
		// col="'+avilable_cols[i]+'">'+name_indx[avilable_cols[i]]+'</li>';
		avail_html += '<li col="' + avilable_cols[i]
				+ '"><input type="checkbox" value="' + avilable_cols[i]
				+ '" class="clmn_list_cb">'
				+ ColumnHeadingMap[avilable_cols[i]] + '</li>';
	}
	$("#aviliable_column_list").html(avail_html);

	for (var i = 0; i < selected_cols.length; i++) {
		// selected_html +='<li
		// col="'+selected_cols[i]+'">'+name_indx[selected_cols[i]]+'</li>';
		selected_html += '<li col="' + selected_cols[i]
				+ '"><input type="checkbox" value="' + selected_cols[i]
				+ '" class="clmn_list_cb">'
				+ ColumnHeadingMap[selected_cols[i]] + '</li>';
	}
	$("#selected_column_list").html(selected_html);

	initiatePopupFunctionality();
}

// method to add element to list
function addToList(value, array_list) {
	array_list.push(value);
}

// method to remove value from list
function removeFromList(value, array_list) {
	var index = array_list.indexOf(value);
	var removedFlag = false;
	if (index > -1) {
		array_list.splice(index, 1);
		removedFlag = true;
	}

	return removedFlag;
}

// method to pop up after clicking on the underlined record
function openDetailPopup(type, value, id) {
	var url;

	if (type == "market") {
		url = "detail_popup.jsp?market=" + encodeURI(value);
		$("#show_detail_popup").attr("title",
				"Edit/Delete Series > Market Details");
	} else if (type == "series") {
		url = "detail_popup.jsp?seriesName=" + encodeURI(value);
		$("#show_detail_popup").attr("title",
				"Edit/Delete Series > Series Details");
	} else if (type == "account") {
		url = "detail_popup.jsp?accountName=" + encodeURI(value);
		$("#show_detail_popup").attr("title",
				"Edit/Delete Series > Account Details");
	} else if (type == "accountId") {
		url = "detail_popup.jsp?ivodAccountId=" + encodeURI(value);
		$("#show_detail_popup").attr("title",
				"Edit/Delete Series > Account Details");
	}

	$("#show_detail_popup").load(url,function() {
						$("#show_detail_popup").dialog({
											// resizable: false,
											open : function() {
												$("#" + id).parent("td")
														.addClass("clckd");
											},
											close : function() {
												$("#" + id).parent("td")
														.removeClass("clckd");
												$("#show_detail_popup").dialog('destroy');
												$("#show_detail_popup").hide();
											},
											width : 700,
											modal : true
										}).parent().append('<div id="popup_footer" style="clear: both;float: left;"></div>');
					});
}

function ShowEditDeleteOnHover() {
	$(".ui-widget-content.jqgrow.ui-row-ltr").hover(function() {
		$(this).append("<div class='hover-element'><a class='edit' href='javascript:;' title='Edit Row'></a><a class='delete' href='javascript:;' title='Delete Row'></a></div>");
		var rowid = $(this).attr('id');
		var rowData = $('#list2').jqGrid('getRowData', rowid);

		$(this).find(".hover-element .edit").click(function() {
			//console.log("performing edit for row = "+ JSON.stringify(rowData));
			ShowEditDialog(rowData, rowid);
		});
		
		$(this).find(".hover-element .delete").click(function() {
			//console.log("performing delete for row = "+ JSON.stringify(rowData));
			deleteConfirmation(rowData, rowid);
		});
		
	}, function() {
		$(this).find("div.hover-element").remove();
	});
}
var rowId = 0;
var hghtInd = false;
var cancelInd = false;

function ShowEditDialog(rowData, rowid) {
	rowId = rowid;
	var url = "";
	if(responceType == "ivodMarkets"){
		url = "edit_market_form.jsp?market="+ encodeURI($(rowData.market).text());
		$("#show_detail_popup").attr("title", "Edit/Delete Market");
	}else if(responceType == "ivodAccounts"){
		var acId =JSON.stringify(rowData.id).replace(/"/g, '');
		url = "edit_account_form.jsp?id="+acId;
		$("#show_detail_popup").attr("title", "Edit/Delete Account");
	}
	
	$("#show_detail_popup").load(url,function() {
	
		$("#show_detail_popup").dialog({
			width : 540,
			maxHeight : 540,
			modal : true,
			close : function() {
				if(cancelInd){
					if (responceType == "ivodMarkets" && typeof (editPopupDataAfter.market) != 'undefined'){
						hghtInd = true;
						for (i in search_fields) {
							var field = $.trim($("#select_field_"+ search_fields[i]).val());
	
							if (field != "all") {
								var reqVal = $.trim($("#search_txt_"+ search_fields[i]).val());
								if (reqVal != eval("editPopupDataAfter."+ field)) {
									hghtInd = false;
									$("#message_div").html("Unable to show updated record with the given criteria").show();
									setTimeout(function() {
										$("#message_div").hide();
									},10000);
									break;
								}
							}
						}
					}else if(responceType == "ivodAccounts" && typeof (editPopupDataAfter.id) != 'undefined') {
						hghtInd = true;
						for (i in search_fields) {
							var field = $.trim($("#select_field_"+ search_fields[i]).val());
	
							if (field != "all") {
								var reqVal = $.trim($("#search_txt_"+ search_fields[i]).val());
								if (reqVal != eval("editPopupDataAfter."+ field)) {
									hghtInd = false;
									$("#message_div").html("Unable to show updated record with the given criteria").show();
									setTimeout(function() {
										$("#message_div").hide();
									},10000);
									break;
								}
							}
						}
					}
					cancelInd = false;
					editPopupDataAfter = {};
					buildTableData($(".ui-pg-input").val(),$(".ui-pg-selbox").val());
	
					$("#show_detail_popup").dialog('destroy');
					$("#show_detail_popup").html("");
					$("#show_detail_popup").hide();
				}
			}
		});
	});

}
function deleteConfirmation(rowData, rowid) {
	var acId =JSON.stringify(rowData.id).replace(/"/g, '');
	var html = "";
	if(responceType == "ivodMarkets"){
		html = '<br/>Do you want to delete the market \"'+$(rowData.market).text()+'\"<br/><br/><br/><input type="button" value="OK" id="del_cnf_ok" class="popupBtn" /><input type="button" value="Cancel" id="del_cnf_close" style="margin-left:20px;"class="popupBtn" />';
	}else if(responceType == "ivodAccounts"){
		html = '<br/>Do you want to delete the Account \"'+$(rowData.accountName).text()+'\"<br/><br/><br/><input type="button" value="OK" id="del_cnf_ok" class="popupBtn" /><input type="button" value="Cancel" id="del_cnf_close" style="margin-left:20px;"class="popupBtn" />';
	}
	
	$("#delete_conf_popup").html(html);
	$("#delete_conf_popup").dialog({
		width : 400,
		modal : true
	});
	
	var deleteUrl = "";
	
	if(responceType == "ivodMarkets"){
		deleteUrl = "http://162.150.162.102:9001/ivodquery/delete/ivodMarkets?market="+ encodeURI($(rowData.market).text());
	}else if(responceType == "ivodAccounts"){
		deleteUrl = "http://162.150.162.102:9001/ivodquery/delete/ivodAccounts?id="+acId;
	}
	
	$("#del_cnf_close").click(function() {
		$("#delete_conf_popup").dialog("close");
		$("#delete_conf_popup").html("");
	});

	$("#del_cnf_ok").click(function() {

		$.ajax({
           url : deleteUrl,
		   type : "GET",
		   crossDomain : true,
		   dataType : "JSON",
		   data : null,
		   success : function(resp) {
                //alert("success");
		   },
		   error : function() {
				/*$("#message_div").html(" Error! " +$(rowData.market).text()+ " cannot be deleted.").show();
				setTimeout(function() {
					$("#message_div").hide();
				}, 15000);*/
		   }
		});
		
		$("#delete_conf_popup").dialog("close");
		$("#delete_conf_popup").html("");
		if(responceType == "ivodMarkets"){
			$("#message_div").html($(rowData.market).text()+ " has been successfully deleted.").show();
		}else if(responceType == "ivodAccounts"){
			$("#message_div").html($(rowData.accountName).text()+ " has been successfully deleted.").show();
		}
		setTimeout(function() {$("#message_div").hide();}, 15000);

		buildTableData($(".ui-pg-input").val(), $(".ui-pg-selbox").val());
	});	
}