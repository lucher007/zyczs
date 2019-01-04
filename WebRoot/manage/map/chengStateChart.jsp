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
	
	String chengcode = request.getParameter("chengcode");
	request.setAttribute("chengcode", chengcode);
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>溯源秤前一周状态变化图</title>	
	   	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	   	<link type="text/css" rel="stylesheet" href="/style/plant.css">
  </head>
  
  <body>
  	<div id="body">
		<div class="cur-pos">
			当前位置：溯源秤状态 > 溯源秤前一周状态变化图
		</div>
		<div class="seh-box">
				<b>溯源秤前一周状态变化图</b>
				&nbsp;&nbsp;&nbsp;
			<!-- 	<a href="javascript:void(0)" onclick="aaa()">aaaaa</a> -->
  				<input type="button" value="查看历史状态记录" onclick="findChengStateLogByList_chengCode('${chengcode}')">
		</div>
		
  		<div style="margin-top: 10px">
  			<ul class="swfhide">
	  			<li>交易中</li>
	  			<li>已开机</li>
	  			<li>未连接</li>
  			</ul>
  				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
										id="findWeekStateLog" width="100%" height="374"
										codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
										<param name="movie" value="<%=basePath%>findWeekStateLog.swf" />
										<param name="quality" value="high" />
										<param name="bgcolor" value="#869ca7" />
										<param name="allowScriptAccess" value="always" />
										<param name="wmode" value="opaque" />
										<embed src="<%=basePath%>findWeekStateLog.swf" quality="high" bgcolor="#869ca7"
											width="684" height="374" name="findWeekStateLog" align="middle"
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
    <script type="text/javascript" language="javascript">
		/**
		*页面加载完毕后查询主要药材的价格走势
		*/
		var timer;
		$(function(){
			timer = setTimeout("js_flex()",1000);//设定js_flex函数将在1000毫秒后执行一次
			//invokeFlexFunctions('${chengcode}');
		});
		
		
		function js_flex(){
			invokeFlexFunctions('${chengcode}');
		}
		
		function invokeFlexFunctions(chengcode){
			var swf = "findWeekStateLog";//swf的名称
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
			try{
				container[swf].js_findWeekStateLog(chengcode);
				}catch(e){
					alert("flash加载未完毕,请重新操作")
				}
			clearTimeout(timer); 
		}
		
		function findChengStateLogByList_chengCode(chengcode){
			window.location.href="<%=basePath %>cheng!findChengStateLogByList_chengCode.shtml?chengcode="+chengcode+"&opertype=0";
		}
	</script>    
  </body>
 </html>
 