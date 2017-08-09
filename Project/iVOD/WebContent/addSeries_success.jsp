<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>iVOD Scheduler</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1-min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" media="all" />
		<style>
			div.textbox {padding:10px 0;}
			div.textbox > label {display:inline-block; width:250px !important; text-align:left;}
			div.textbox > div{display:inline-block;}
			#responseMsg{display: none;margin:10px 0 46px 348px;display: block;font-family: sans-serif;font-size: 15px;color: green;}
			#responseMsg2{display: none;margin:10px 0 20px 352px; display: block;font-family: sans-serif;font-size: 15px;color: blue;}
			table.details{margin: 0 auto;text-align: left;}
			table.details td{padding: 10px 0px 10px 30px;}
		</style>
		<script>
			var response = '<%=session.getAttribute("queryRsp")%>';
			var title = "<%=session.getAttribute("title")%>";
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
		            	<h6 id="page_title">Schedule Series Success</h6>
		            	<div class="clear"></div>
		            </div>
					<table class="details">
						<tr style="text-align: center;">
							<td colspan=2>
								<strong>You have selected the following details:</strong>
							</td>
						</tr>
						<tr>
							<td><strong>Merlin SeriesID:</strong></td>
							<td id="seriesId"></td>
						</tr>
						<tr>
							<td><strong>Title:</strong></td>
							<td><%=session.getAttribute("title") %></td>
						</tr>
						<tr>
							<td><strong>Markets:</strong></td>
							<td id="market"></td>
						</tr>
						</table>
					
					<div class="clear"></div>
					<div class="textbox" style="padding-top: 30px;margin-left: 460px">
						<input id="save_another" class="submit" value="Submit Another" type="button"/>
					</div>
					<div id="responseMsg"></div>
					<div id="responseMsg2"></div>
				</div>
			</div>
		</div>
		<%
			session.removeAttribute("queryRsp");
			session.removeAttribute("title");
		%>
		
		<script>
		$(function(){
			$(".tabDiv ul li").removeClass("active");
			$("#ivodSeries").addClass("active");
			
			var seriesId = localStorage.getItem("seriesid");
			var markets = localStorage.getItem("markets");
			localStorage.setItem("seriestitle",null);
			if(markets!=null && markets!="null" && seriesId!=null && seriesId!="null"){
				localStorage.setItem("seriesid",null);
				localStorage.setItem("markets",null);
				
				$("#seriesId").html(seriesId);
				$("#market").html(markets);
			}
			
			if(response!=''){
				if(title!=null && title!='null'){
					$("#responseMsg").html("Success! \"" +title+ "\" is scheduled for recording").show();
					}
			}
			else{
				
				$("#responseMsg2").html("No Accounts available to this market. So, nothing to schedule").show();
			}
				
			    $("#save_another").click(function(){
				window.top.location.href="scheduleseries.jsp";
			});
			
		});
		
		</script>
	</body>
</html>