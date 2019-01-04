<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<base href="<%=basePath%>" />
		<title>发卡完成</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css"/>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：市场管理 &gt; 经营户发卡 </div>
		<div class="form-box">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="../images/frame/dui.png">
	            <b class="green"><%=request.getParameter("returninfo") %></b>
		  		</div>	
  			</div>
  			<div class="fb-bom">
	        	<cite><input type="button" value="经营户管理" class="sbt"  onclick="findByList()"></cite>
	        </div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
		<script type="text/javascript" language="javascript">
			function findByList(){
				window.location.href = "<%=basePath %>medMarket!findByList.shtml";
			}
  		</script>
	</body>
</html>