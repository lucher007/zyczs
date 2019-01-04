<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>市场价格走势</title>	
	   	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	    <script type="text/javascript" language="javascript">
		/**
		*页面加载完毕后查询主要药材的价格走势
		*/
		$(function(){
			//changeVal();此时flash还未加载完毕,调用flash会报错
		});
		
		/**
		*下拉值改变后重新查询价格
		*/
		function changeVal(){
			var medname = $("#sel_mainMeds").val();
			invokeFlexFunctions(medname);
		}
		
		function invokeFlexFunctions(medname){
			var swf = "priceChart";//swf的名称
			var container;
			//alert(navigator.appName); //不加这个测试不通过，不知为何,Firefox 均不通过
			if (navigator.appName.indexOf("Microsoft") >= 0)
			{
				container = document;
			}
			else
			{
				container = window;
			}
			//alert(container[swf]); //在FireFox，这个是undefined
			container[swf].js_getPriceChartByPlantName(medname,${User.orgid},1);
		}
	   </script>    
  </head>
  
  <body>
  	<div id="body">
		<div class="cur-pos">
			当前位置：统计分析 > 市场价格走势
		</div>
		<div class="seh-box">
				<span>请选择品名查询:</span>
  				<select id="sel_mainMeds" onchange="changeVal()" class="inp" >
  						<option value="-1">--请选择--</option>
  					<c:forEach items="${medStatlist}" var="item">
  						<option value="${item.medname }">${item.medname }</option>
  					</c:forEach>
  				</select>
		</div>
		
  		<div style="margin-top: 10px">
  				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
										id="priceChart" width="100%" height="374"
										codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
										<param name="movie" value="<%=basePath%>priceChart.swf" />
										<param name="quality" value="high" />
										<param name="bgcolor" value="#869ca7" />
										<param name="allowScriptAccess" value="always" />
										<param name="wmode" value="opaque" />
										<embed src="<%=basePath%>priceChart.swf" quality="high" bgcolor="#869ca7"
											width="684" height="374" name="priceChart" align="middle"
											play="true"
											loop="false"
											quality="high"
											allowScriptAccess="always"
											type="application/x-shockwave-flash"
											pluginspage="http://www.adobe.com/go/getflashplayer">
										</embed>
				</object>
  			</div>
		 </div>
  
  </body>
 </html>
 