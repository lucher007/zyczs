<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>" >
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：统计分析 &gt; 流通结构统计</div>
	   <div class="form-box">
	    	<div class="fb-tit">
	        	节点企业分布统计
	        </div>
	        <div class="fb-con">
		    	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		          <tr class="fbc-tit">
		            <td align="center">区域</td>
		            <td align="center">种植/养殖</td>
		            <td align="center">中药材经销</td>
		            <td align="center">中药材流通</td>
		            <td align="center">饮片生产</td>
		            <td align="center">饮片经销</td>
		            <td align="center">医院/药店</td>
		            <td align="center">总计</td>
		          </tr>
		          <c:forEach items="${requestScope.orgmap}" var="org">
		          <c:set var="city" value="0" />
		          <c:set var="med" value="0" />
		          <c:set var="medsell" value="0" />
		          <c:set var="tablet" value="0" />
		          <c:set var="tabletsell" value="0" />
		          <c:set var="market" value="0" />
		          <c:set var="hospital" value="0" />
		          <c:set var="total" value="0" />
		          <c:forEach items="${org.value}" var="list">
		          	<c:if test="${list.zyctype=='10000000'}"><c:set var="med" value="${list.linkman}" /></c:if>
		          	<c:if test="${list.zyctype=='01000000'}"><c:set var="medsell" value="${list.linkman}" /></c:if>
		          	<c:if test="${list.zyctype=='00100000'}"><c:set var="tablet" value="${list.linkman}" /></c:if>
		          	<c:if test="${list.zyctype=='00010000'}"><c:set var="tabletsell" value="${list.linkman}" /></c:if>
		          	<c:if test="${list.zyctype=='00001000'}"><c:set var="market" value="${list.linkman}" /></c:if>
		          	<c:if test="${list.zyctype=='00000100'}"><c:set var="hospital" value="${list.linkman}" /></c:if>
		          	<c:set var="total" value="${total+list.linkman}" />
		          </c:forEach>
		          <tr class="fb-list">
		            <td align="center" height="30">${org.key }</td>
		            <td align="center">${med }</td>
		            <td align="center">${medsell }</td>
		            <td align="center">${tablet }</td>
		            <td align="center">${tabletsell }</td>
		            <td align="center">${market }</td>
		            <td align="center">${hospital }</td>
		            <td align="center">${total }</td>
		          </tr>
		          </c:forEach>
		        </table>
		    </div>
		</div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	</body>
</html>
