<style>
div.textbox_header {padding:10px 0;margin-left: 65px; clear: both; display: table;}
div.textbox_header > input[type="text"]{width:95px; padding: 4px 13px 2px 30px; height:25px; border-radius: 2px;border: none;float:left }
input.username{background: url(images/username.png) no-repeat 4px 5px #FFFFFF;}
input[type="button"].nt_login {
    background: url("images/lougout-button.png") no-repeat scroll 0 2px rgba(0, 0, 0, 0);
    border: 0 none;
    cursor: pointer;
    height: 32px;
    width: 64px;
}
</style>
<div id="header">
  	<!-- <div class="top-nav-bar" id="navigationplaceholder_0_topNavBar">
		<div class="top-nav-links" id="top-header">
		    <ul>
		        <li><a style="color:#FFF;font-size:10px;" href="scheduleseries.jsp">Home</a></li>
		        <li><a style="color:#FFF;font-size:10px;" href="about.jsp">About</a></li>
		        <li><a style="color:#FFF;font-size:10px;" href="help.jsp">Help</a></li>
		    </ul>
		</div>
	</div> -->

	<!-- <div class="header-secondary-gradient">
		<div class="header">
			<h1>
			<a class="comcast-logo" href="scheduleseries.jsp">Comcast</a>
			</h1>
		</div>
	</div> -->
	<div class="subheader-container">
		<div class="subheader" style="margin-top: 12px;">
			<h2>
				<a class="ivod-logo" href="scheduleseries.jsp">ivod</a>
			</h2>		
			<div style="width: 980px; margin: 0px auto;">
				<%
				if(!(request.getRequestURI().equals(request.getContextPath()+"/")) && request.getRequestURI().indexOf("login.jsp")==-1){
				%>
				<div class="tabDiv">
					<ul>
						<li id="ivodSeries">
							<!-- <a href="view.jsp?type=ivodSeries"> -->
							<a href="javascript:void(0)" class="header_link"><b>Series</b></a>
							<ul> 
							    <li><a href="scheduleseries.jsp">Add Series</a></li>
								<li><a href="report.jsp?type=ivodSeries">Report</a></li> 
								<li><a href="edit_delete.jsp?type=ivodSeries">Edit/Delete</a></li> 
								<li><a href="view.jsp?type=ivodSeries">View</a></li>
							</ul> 
						</li>
		    			<li style="border-color:#ffffff #eaeaea;border-width: 1px 1px 0px;" id="ivodMarkets">
		    				<!-- <a href="view.jsp?type=ivodMarkets"> -->
		    				<a href="javascript:void(0)" class="header_link"><b>Market</b></a>
		    				<ul> 
		    				    <li><a href="newmarket.jsp">Add Market</a></li>
								<li><a href="report.jsp?type=ivodMarkets">Report</a></li> 
								<li><a href="edit_delete.jsp?type=ivodMarkets">Edit/Delete</a></li> 
								<li><a href="view.jsp?type=ivodMarkets">View</a></li>
							</ul>
		    			</li>
		      			<li id="ivodAccounts">
		      				<!-- <a href="view.jsp?type=ivodAccounts"> -->
		      				<a href="javascript:void(0)" class="header_link"><b>Account</b></a>
		      				<ul> 
		      				    <li><a href="newaccount.jsp">Add Account</a></li>
								<li><a href="report.jsp?type=ivodAccounts">Report</a></li> 
								<li><a href="edit_delete.jsp?type=ivodAccounts">Edit/Delete</a></li> 
						        <li><a href="view.jsp?type=ivodAccounts">View</a></li>
							</ul>
		      			</li>
		 			</ul>
				</div>
				<div class="headDiv" style="float: right;margin-top: 5px;">
					<div class="textbox_header" style="display: inline-block;box-shadow: 0 0 1px #d3d3d3 inset;border: 1px solid #CDCDCD;background-color: #fff;padding: 1px 0px;height:32px;">
	           			<input id="nt_login_name" maxlength="25" class="username" type="text"  size="25" name="password" value="${sessionScope.userName}" readonly/>
	           			<input type="button" class="nt_login"></input>
	           		</div>
				</div>
				<%
				}
				%>
				
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	$(".tabDiv ul > li").click(function(){
		
		if(!$(this).hasClass("actv")){
			$(".tabDiv ul > li").removeClass("actv");
			$(this).addClass("actv");
		}else{
			$(this).removeClass("actv");
		}
	});
	
	$(document).click(function(e){
		var obj = e.target;
		if(!$(obj).parents(".tabDiv").hasClass("tabDiv"))
			$(".tabDiv ul > li").removeClass("actv");
	})
});
</script>
