<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
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
		<base href="<%=basePath%>" target="_self">   
		<meta charset="utf-8">
		<title>选择原药材</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    	        	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>           
	            <td>包装规格(g/包)</td>    
	            <td>包数</td>  
	            <td>饮片重量(g)</td>  
	          </tr>
	          <c:forEach items="${requestScope.inStorSuccessCode.childList}" var="childList">
	          <tr class="lb-list">
	            
	            <td height="25">${childList.pname }&nbsp;</td>
	            <td>${childList.batchno }&nbsp;</td>
<%--	            <td>${childList.pcode }&nbsp;</td>--%>
	            <td width="100">${childList.weight }&nbsp;</td>
	            <td width="100">${childList.boxitemnum }&nbsp;</td> 
	            <td>${childList.boxitemnum*childList.weight }&nbsp;</td>         
	          </tr>
	         </c:forEach>     
	        </table>
	        
    	</div>
    </div>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	
	</script>
	</body>
</html>

