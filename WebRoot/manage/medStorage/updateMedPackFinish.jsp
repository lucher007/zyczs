<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>饮片出库</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">当前位置：生成管理 &gt; 药材分包</div>
			<div class="form-box">
		    	<div class="fb-tit"></div>
		        <div class="fb-con">
		        	<div class="fb-msg">
		        		<img src="../images/frame/dui.png">
		            	<b class="green">${requestScope.returninfo }</b>
		            </div>
		    	</div>
		    	<div class="fb-bom">
		        	<cite><input type="button" value="继续药材分包" class="sbt"  onclick="location='<%=basePath%>medStorage!findNotPackList.shtml';"></cite>
		        	<a href="<%=basePath %>medStorage!findPrintCode.shtml" class="btn-a"><span class="new">打印赋码</span></a>
	        	</div>
		  	</div>
		</div>
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	</body>
</html>

