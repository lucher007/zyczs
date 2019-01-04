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
		<meta charset="utf-8">
	    <base href="<%=basePath%>">
	    <title></title>    	
	    <link type="text/css" rel="stylesheet" href="/style/production.css">
  	</head>
  
  	<body>
  	<div id="body">
		<div class="cur-pos">当前位置：药材库存管理 > 库存查询</div>
		<div class="form-box">
	    	<form action="tablet-out2.html">
	    	<div class="fb-tit">药材入库</div>
	        <div class="fb-con">
	        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td height="340" align="center"><input type="button" value="溯源药材入库" class="sbt" onClick="addgrow(0);"></td>
	            	<td align="center"><input type="button" value="非溯源药材入库" class="sbt" onClick="addgrow(1);"></td>
	              </tr>
	            </table>
	        </div>
	        </form>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript">
    	cMenu(0,1);
    	function addgrow(flag){
 			if(flag == "0"){
 				location.href="<%=basePath%>manage/medSellInOutStorage/findInCode.jsp";
 			}else if(flag == "1"){
	    		location.href="<%=basePath%>manage/tabletmed/addNotSourceMed.jsp";
    		} 		
    	}
    </script>    
  	</body>
 </html>
  