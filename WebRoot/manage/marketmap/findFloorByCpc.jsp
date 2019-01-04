<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cpccorp = request.getParameter("cpccorp");
	request.setAttribute("cpccorp",cpccorp);
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>市场全景图</title>
	</head>
	<body>
	<div id="body">
	<c:if test="${list != null && fn:length(list) > 0}" var="bool">
		<c:forEach items="${list}" var="obj" varStatus="i" >
			<div style="width: 230px;height:150px;float: left;border:none;"> 
				<label style="width:50px;font:bold 30px Arial;display:block;margin:50px 0 0 100px;position: fixed; z-index:2;filter:alpha(opacity=50); Opacity:0.5;color:red;">${obj.floor }</label>
		<c:if test="${obj.mapcontent == null || obj.mapcontent == ''}" var="flag">
			<img  style="width: 230px;height: 150px;border: 1px solid green;cursor: pointer; position: relative; z-index:1;" src="<%=basePath%>images/market/nofloormap.jpg">
		</c:if>
		<c:if test="${!flag}">
			<img  style="width: 230px;height: 150px;border: 1px solid green;cursor: pointer; position: relative; z-index:1;" src="<%=basePath%>marketMapImage.shtml?mapcontent=${obj.mapcontent}">
		</c:if>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${!bool}">
		<div style="margin: 30% 20%;color: red">
			请先联系地方监管管理员添加该市场区域楼层后操作!
		</div>
	</c:if>
	</div>
	</body>
</html>

