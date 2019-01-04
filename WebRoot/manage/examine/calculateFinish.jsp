<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>绩效考核</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：绩效考核 > 考核结果</div>
	<div class="form-box">
    	<form action="" method="post" id="goform">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/dui.png">
            <b class="green">${requestScope.returninfo}</b>     
    	</div>
    	
    	
    	
    	<div class="fb-bom">
    		<cite><input type="button" value="返 回" class="sbt" onclick="gotoMedOut();"></cite>
    		
    	</div>
        </form>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript">
	
	function gotoMedOut(){
		
		$("#goform").attr("action", "examine!calculateList.shtml");	
		$("#goform").submit();
	}
	
</script>
</body>
</html>
