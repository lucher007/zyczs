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
		<title>生产信息录入</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
		<c:if test="${requestScope.returncode=='0'}">
		<div class="cur-pos">当前位置：生产管理 > 生产信息录入完成</div>
		<div class="form-box">
			<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
		        	<img src="<%=basePath%>images/frame/dui.png">
		        	<b class="green" id="returninfo_lastcheck">${requestScope.returninfo }</b>
	        	</div>
	    	</div>
	    	<div class="fb-bom">
	        	<cite><input type="button" value="继续录入" onclick="goOn();" class="sbt"></cite>
	            <input type="button" value="进入饮片检验" onclick="goOnCheck();" class="sbt">
	        </div>
    	</div>
    	</c:if>
    	
    	<c:if test="${requestScope.returncode=='1'}">
		<div class="cur-pos">当前位置：生产管理 > 生产信息录入失败</div>
		<div class="form-box">
			<div class="fb-tit">操作失败</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
		        	<img src="<%=basePath%>images/frame/err.png">
		        	<b class="green" id="returninfo_lastcheck">${requestScope.returninfo }</b>
	        	</div>
	    	</div>
	    	<div class="fb-bom">
	        	<cite><input type="button" value="返回操作" onclick="window.history.back();" class="sbt"></cite>
	           
	        </div>
    	</div>
    	</c:if>
    	
    	
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript">
		function goOn(){
			location.href='/manage/tablet/addTablet.jsp';
		}
		function goOnCheck(){
			location.href='<%=basePath%>tablet!findByList_unchecked.shtml';
		}
	</script>
	</body>
</html>
