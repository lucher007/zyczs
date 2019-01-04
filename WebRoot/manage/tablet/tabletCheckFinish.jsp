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
  		<div class="cur-pos">当前位置：饮片生产管理 >饮片检验</div>
	  	<form action="" method="post" name="searchform" id="searchform">
	  		<input type="hidden" name="tabletid" id="tabletid" value="${requestScope.tabletid }" />
	  	</form>
	  	<div class="form-box">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="../images/frame/dui.png">
	            <b class="green">${requestScope.returninfo}</b>
		  		</div>	
  			</div>
  			<div class="fb-bom">
	        	<cite><input type="button" value="继续检验" class="sbt"  onclick="return findByList(0);"></cite>
	        	<input type="button" value="饮片分包" class="sbt"  onclick="return findByList(1);">
	        </div>
		</div>
  	</div>
  	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script type="text/javascript" language="javascript">    
	    function findByList(type){
	        if(type==0){
				document.searchform.action="tablet!findByList_unchecked.shtml"
	        }else{
	    		document.searchform.action="tabletStorage!findByListUnPack.shtml"
	        }
			document.searchform.submit();
		}
	</script>   	
</body>
</html>
 