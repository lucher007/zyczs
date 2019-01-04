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
	<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：生成管理 > 饮片包装</div>
		<div class="form-box">
	    	<form action="tablet-add4.html" method="post">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
		            <img src="<%=basePath%>images/frame/dui.png">
		            <b class="green">${requestScope.returninfo }</b>
	            </div>
	    	</div>
	    	<div class="fb-bom">
	        	<cite><input type="button" value="继续饮片包装" class="sbt"  onclick="location='<%=basePath%>tabletStorage!findByListUnPack.shtml';"></cite>
	        	<input type="button" value="打印赋码" class="sbt"  onclick="location='<%=basePath%>tabletStorage!findPrintUnCode.shtml';">
	        </div>
	        </form>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	</body>
</html>

