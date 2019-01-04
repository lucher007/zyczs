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
  		<base href="<%=basePath%>" >    
  		<title></title>
  		<link type="text/css" rel="stylesheet" href="<%=basePath%>style/production.css">     	  
	</head>
  
	<body>  	
  	<div id="body">
  		<div class="cur-pos">当前位置：药材库存 > 药材检验</div>
	  	<div class="form-box">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="../images/frame/dui.png">
	            <b class="green">${requestScope.returninfo}</b>
		  		</div>	
  			</div>
  			<div class="fb-bom">
	        	<cite><input type="button" value="继续检验药材" class="sbt"  onclick="return findByList(0);"></cite>
	        	<input type="button" value="进入已检药材" class="sbt"  onclick="return findByList(1);">
	        </div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script type="text/javascript" language="javascript">    
	    function findByList(type){
	        if(type==0){
				window.location.href="<%=basePath%>medStorage!findCheckList.shtml?flag=tablet";
	        }else{
	    		window.location.href="<%=basePath%>medStorage!findCheckedList.shtml?flag=tablet";
	        }
		}
	</script>   	
	</body>
</html>
 