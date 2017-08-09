
var chk_list =[];
var mktname = "";
var $listItems = $('li');
$(function(){
	getMarketList();
     markets = localStorage.getItem("markets");
	var ser_id = localStorage.getItem("seriesid");
	var ser_title = localStorage.getItem("seriestitle");
	//alert(ser_id);
	if(ser_title!="null" && ser_title!=null){
		localStorage.setItem("seriestitle",null);
		$("#series_search").val(ser_title);
	} else {
		$("#series_search").val('');
	}
	 
	if(ser_id!="null" && ser_id!=null){
		localStorage.setItem("seriesid",null);
		$("#SeriesID").val(ser_id);
	} else {
		$("#SeriesID").val('');
	}
    
	if(markets!="null" && markets!="" && markets!=null){
         localStorage.setItem("markets",null);  
		var mkts=markets.split(",");
		for(var i=0;i<mkts.length;i++)
			chk_list.push(mkts[i]);
		$("#search_mkt").attr("placeholder",chk_list.length+" markets selected");
		$("#show_mkt_list").css({"display":"inline"});
	}
	
	if(response=='invalid'){
		 $(".responseMsg1").html("An unexpected error occurred, possibly due to invalid data. Please check your inputs and try again").show();
		 //$("#save_form2").removeAttr("disabled");
		 $("#save_form2").prop("disabled",false);
		 
		 validateSerialId($("#SeriesID").val());//when form is submitted in order to show the validated title(Both valid and invalid)
	}
    
	$("#save_form2").click(function(){
		$("#mkt_drop").val(chk_list);
		if(validateForm2())
			  localStorage.setItem("seriestitle", $("#series_search").val());
              localStorage.setItem("seriesid",$("#SeriesID").val());
			  localStorage.setItem("markets",chk_list);
              $("#account_form2").submit();
	});
	
	$("#reset_form2").click(function(){
		validSeriesId = false;
		chk_list =[];
		$("#search_mkt").attr("placeholder","Select Markets");
		$("#SeriesID").val('');
		$("#series_search").val('');
		$(".validation_number,#serailId_error,#serailId_success,.responseMsg1,#show_mkt_list").hide();
		$("#save_form2").attr("disabled","disabled");
	});
	
//	function compareStrings(a, b) {
//	    // Assuming you want case-insensitive comparison
//	    a = a.toLowerCase();
//	    b = b.toLowerCase();
//
//	    return (a < b) ? -1 : (a > b) ? 1 : 0;
//	  }
	
	$("#SeriesID").bind('input propertychange', function(){
	
        var ser_val = $.trim($(this).val());
        if(ser_val.length<19){
                $("#serailId_error").hide();
                $("#serailId_success").hide();
                $("span.validation_number").hide();
                if(isNaN(ser_val))
                        $(this).siblings("span.validation_number").css("display","inline");
                else{
                        $(this).siblings("span.validation_number").css("display","none");
                        $("#serailId_success").hide();
        				$("#serailId_error").css({"display":"inline"});
                }
                
        }else{
                validateSerId(ser_val);
        }
	});
	
	$("#SeriesID").blur(function(){
		
        var ser_val = $.trim($(this).val());
        if(ser_val.length<19){
                $("#serailId_error").hide();
                $("#serailId_success").hide();
                $("span.validation_number").hide();
                if(isNaN(ser_val))
                        $(this).siblings("span.validation_number").css("display","inline");
                else
                        $(this).siblings("span.validation_number").css("display","none");
        }else{
                validateSerId(ser_val);
        }
	});
	
	/*var that = null;
	
	$("#help2,#help1").hover(function(){
		$(".imgDescpn").removeClass("shw");
		that = $(this);
		$(this).siblings(".imgDescpn").addClass("shw");
	},function(){
		setTimeout(function(){
			that.siblings(".imgDescpn").removeClass("shw");
		},2000);
	});*/
	
	$("#help2").tooltip({
		 position: {
			 my: "center bottom-20",
			 at: "center top",
		 	 using: function( position, feedback ) {
		 		 $( this ).css( position );
		 		 $( "<div>" ).addClass( "arrow" ).addClass( feedback.vertical ).addClass( feedback.horizontal ).appendTo( this );
		 	 }
		 }
	});
	
	$("#series_search").keyup(function(e){
		var key = $.trim($(this).val());
		
        if(e.keyCode==38 || e.keyCode==40){
			$selected = $listItems.filter('.selected');
			
		    $current = null;
			 
			$listItems.removeClass('selected');
             if ( e.keyCode == 40 ) // Down key
		    {
		        if ( ! $selected.length || $selected.is(':last-child') ) {
		            $current = $listItems.eq(0);
		        }
		        else {
		            $current = $selected.next();
		        }
		    }
            else if ( e.keyCode == 38 ) // Up key
		    {
		        if ( ! $selected.length || $selected.is(':first-child') ) {
		            $current = $listItems.last();
		        }
		        else {
		            $current = $selected.prev();
		        }
		    }
             
            var pos = $current.position();
 		    if(pos.top<=10 || pos.top >= $("#resultDiv").height()-10)
 		    	$("#resultDiv").scrollTop(pos.top);
 		    
            $current.addClass('selected').focus();
		}else if(e.keyCode==13){
			$selected = $listItems.filter('.selected');
			$("#series_search").val($selected.text());
			$("#SeriesID").val(($selected.attr("serid"))).blur();
			$("#resultDiv").hide(); 
             }else if(key!="" && key.length>=2){
			$("#resultDiv").html("Loading...").show();
			key = key.split(' ').join('+');
			seriesSearch(key);
		}else if(key==""){
			$("#resultDiv").html("").hide();
		}
	});
		
$("#search_btn").click(function(){
		var key = $.trim($("#series_search").val());
		$("#resultDiv").html("Loading...").show();
		key = key.split(' ').join('+');
		seriesSearch(key);
	});
	
	$(document).click(function(e){
		var obj = e.target;
		if($(obj).attr("id")=="series_search"){
			if($("#series_search").val()=="")
				$("#resultDiv").html("").hide();
			else
				$("#resultDiv").show();
		}else if(!($(obj).parents().hasClass("searchBox"))){
			$("#resultDiv").hide();
		}
		
		if(!$(obj).parents().hasClass("dropdown-check-list")){
			$("#list1").removeClass('visible');
		}	
	});
	$("ul.items").keypress(function(e){
		// enter key press on selecting markets
		var code = e.keyCode || e.which;
		if(code == 13){
		$("#list1").removeClass('visible');
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
	
	$("#search_mkt").keyup(function(){
		mktname = $.trim($(this).val());
		getMarketList();
	});
    
});

function validateSerId(sid){
	
	if(!isNaN(sid)){
		if(tempSerId!=sid){
			$("#serailId_error").hide();
			$("#serailId_success").hide();
			tempSerId=sid;//to avoid multiple times validation of same series id.
			if(flag && $.trim(sid)!=""){
				flag = false;
				validateSerialId(sid);
			}
		}else{
			if(validSeriesId){
				$("#serailId_error").hide();
			    $("#serailId_success").css({"display":"inline"});
			}else{
				$("#serailId_success").hide();
				$("#serailId_error").css({"display":"inline"});
			}
			checkSubmitButton();
		}
	}else{
		validSeriesId = false;
		$("#serailId_error").hide();
		$("#serailId_success").hide();
		$("span.validation_number").hide();
		$("#SeriesID").siblings("span.validation_number").css("display","inline");
		checkSubmitButton();
	}
	
}

function checkSubmitButton(){
	
	if(!validSeriesId || chk_list.length==0){
		$("#save_form2").attr("disabled","disabled");
	}else{
		
		/*if(chk_list.indexOf(item.market)!=-1){
			$("#save_form2").attr("disabled","disabled");
		}*/
		//$("#save_form2").removeAttr("disabled");
		$("#save_form2").prop("disabled",false);
	}
	
}


function validateForm2(){
	var form2flag = true;
	var serId = $.trim($("#SeriesID").val());
	
	if(serId==""){
		alert("SeriesID Cannot be blank");
		form2flag = false;
	}else if(!validSeriesId){
		alert("Please enter valid SeriesID");
		form2flag = false;
	}else if(chk_list.length==0){
		alert("Please select markets");
		form2flag = false;
	}
	
	return form2flag;
}

function validateSerialId(serialId){
	//checkResponse(dtt);
	if(!isNaN(serialId)){
		$.ajax({
			url: "http://mwsprod.ccp.xcal.tv:9002/entityDataService/data/Program?schema=1.5.8&form=cjson&pretty=true&byType=SeriesMaster&byId="+serialId,
			type:"GET",
			crossDomain: true,
			dataType: "JSON",
			data:null,
			success:function(resp){
				checkResponse(resp);
			},
			error:function(resp){
				$("#save_form2").attr("disabled","disabled");
				$("#serailId_success").hide();
				$("#serailId_error").html("Invalid Series ID").css({"display":"inline"});
				flag = true;
				checkSubmitButton();
			}
		});
	}else{
		$("#save_form2").attr("disabled","disabled");
		$("#serailId_success").hide();
		$("#serailId_error").html("Invalid Series ID").css({"display":"inline"});
	}
}

function checkResponse(resp){
	var entries = resp.entries;
	
	if(entries!=undefined && typeof(entries)!=undefined && entries!="undefined"){
		if(entries.length>0){
			var title = entries[0].title;
			
			if(title!='undefined' && typeof(title)!='undefined'){
				validSeriesId = true;
				$("#serailId_error").hide();
				$("#serailId_success").html("<span  style='font-weight:bold;'>Title: </span>"+title).css({"display":"inline"});
			}else{
				validSeriesId = false;
				$("#serailId_success").hide();
				$("#serailId_error").html("Invalid Series ID").css({"display":"inline"});
			}
		}else{
			validSeriesId = false;
			$("#serailId_success").hide();
			$("#serailId_error").html("Invalid Series ID").css({"display":"inline"});
		}
	
	}else{
		validSeriesId = false;
		$("#serailId_success").hide();
		$("#serailId_error").html("Invalid Series ID").css({"display":"inline"});
	}
	
	flag = true;
	checkSubmitButton();
}

function seriesSearch(searchKey){
	//prepareSearchResponse(resp)
	var request = {"searchKey":searchKey};
	
	$.ajax({
		url: applicationPath+"/search",
		type:"GET",
		dataType: "json",
		data:{json:JSON.stringify(request)},
		//contentType:"application/json",
		success:function(resp){
			prepareSearchResponse(resp);
		},
		error:function(resp){
			//alert("Error");
		}
	});
	
}

function prepareSearchResponse(response){
	var html = '<ul>';
	if(response.count>0){
		var respArr = response.entities;
		for(var i=0;i<respArr.length;i++){
			var items = respArr[i];
			var ids = items.id;
			var merlinId = ids[0].merlin;
			var titlelist = items.title;
			var title = titlelist[1].highlighted;
			if (i==0)
				html +=		'<li class="searchItem selected" serid="'+merlinId+'">'+title+'</li>';
			else
				html +=		'<li class="searchItem" serid="'+merlinId+'">'+title+'</li>';
		}
	}else{
		html +='<li style="text-align:center;">No result found</li>';
		$("#resultDiv").html(html);
	}
	html += '</ul>';
	
	$("#resultDiv").html(html);
	
	$(document).click(function(e){
		var obj = e.target;
		if($(obj).attr("id")=="series_search"){
			if($("#series_search").val()=="")
				$("#resultDiv").html("").hide();
			else
				$("#resultDiv").show();
		}else if($(obj).hasClass("searchItem")){
			$("#series_search").val($(obj).text());
			$("#SeriesID").val(($(obj).attr("serid"))).blur();
			$("#resultDiv").hide();
		}else if(!($(obj).parents().hasClass("searchBox"))){
			$("#resultDiv").hide();
		}
			
	});
	
    $listItems = $('li.searchItem');
	
	$listItems.hover(function(){
		$listItems.removeClass("selected");
		$(this).addClass("selected");
	});
}

function getMarketList(){
	
	//prepareMarketList(respJson);
	$.ajax({
		url: "http://162.150.162.102:9001/ivodquery/select/ivodMarkets",
		type:"GET",
		crossDomain: true,
		dataType: "json",
		data:null,
		//contentType:"application/json",
		//data:'',
		success:function(resp){
			//alert("Success");
			//alert(JSON.stringify(resp));
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
	var mktList=[];
	if(jsonArr.length>0){
		jsonArr.sort(function(a, b) {
            return compareStrings(a.market, b.market);
   });

		html +='<li><input type="checkbox" value="All" id="all"/>Select All</li>';
		for(var i=0;i<jsonArr.length;i++){
			var item = jsonArr[i];
			if(mktList.indexOf(item.market)==-1){
				mktList.push(item.market);
				//$("#save_form2").prop("disabled",false);
				if(mktname!="" && mktname!='undefined' && typeof(mktname)!=undefined && mktname!=undefined){
						if(item.market.toLowerCase().indexOf(mktname.toLowerCase())==0){
						if(chk_list.indexOf(item.market)!=-1)
							html += '<li><input type="checkbox" class="mkt checked" value=\"'+item.market+'\" checked="true"/>'+item.market+'</li>';
						else
							html += '<li><input type="checkbox" class="mkt" value=\"'+item.market+'\"/>'+item.market+'</li>';
					}
				}else{
					if(chk_list.indexOf(item.market)!=-1)
						html += '<li><input type="checkbox" class="mkt checked" value=\"'+item.market+'\" checked="true"/>'+item.market+'</li>';
					else
						html += '<li><input type="checkbox" class="mkt" value=\"'+item.market+'\"/>'+item.market+'</li>';
				}
			}	
		}
	}else{
		html += '<li>No markets found</li>';
	}
	
	$("#list1 ul.items").html(html);
	//$("#list1").addClass('visible');
	var mkts_no = $("input.mkt").length;
	if(mkts_no==$("input.checked").length)
		$("input#all").prop('checked', true);
	
	$("#list1 input[type='checkbox']").click(function(){
		if($(this).attr("id")=="all"){
			chk_list =[];
			if($(this).is(':checked')){
				$("input.mkt").addClass("checked");
				$("input.mkt").prop('checked', true);
				$("input.mkt").each(function(){
					chk_list.push($(this).val());
					
					
				});
			}else{
				$("input.mkt").removeClass("checked");
				$("input.mkt").prop('checked', false);
			}
		}else{
			if($(this).is(':checked')){
				$(this).addClass("checked");
				chk_list.push($(this).val());
				if(chk_list.length==mkts_no)
					$("input#all").prop('checked', true);
			}else{
				removeFromList($(this).val());
				$(this).removeClass("checked");
				$("input#all").prop('checked', false);
			}
		}
		
		if(chk_list.length>0){
			$("#show_mkt_list").css({"display":"inline"});
			$("#search_mkt").attr("placeholder",chk_list.length+" markets selected");
		}else{
			$("#search_mkt").attr("placeholder","Select Markets");
			$("#show_mkt_list").hide();
		}
        checkSubmitButton();  
    });
	
	$("#reset_link").click(function(){
		chk_list =[];
		$("#search_mkt").attr("placeholder","Select Markets");
		$("#show_mkt_list").hide();
        checkSubmitButton(); 
	});
	
}

function removeFromList(elem){
	var index = chk_list.indexOf(elem);
	if (index > -1) {  
		chk_list.splice(index, 1);
	}
}

function openMktList(){
	 var html = '<p><strong>You have selected the following markets: </strong></p>';
	 html +='<ul class="selectedMarkets">';
	 for(var i=0;i<chk_list.length;i++){
		 html +='<li>'+chk_list[i]+'</li>';
	 }
	 html +='</ul>';
	 html +='<input type="button" value="OK" class="okBtn"/>';
	 $( "#market_list" ).html(html);
	 $( "#market_list" ).dialog({width: 500,maxHeight: 500,modal: true});
	 
	 $(".okBtn").click(function () {
         $("#market_list").dialog('close');
     });
}
