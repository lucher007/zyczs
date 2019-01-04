<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<title></title>
	<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<form action="" method="post" name="searchform" id="searchform">
		<div class="cur-pos">当前位置：应急处理 > 追溯锁定完成</div>
		<div class="form-box">
		    <div class="reg-box">
		        <div class="fb-msg">
		        	<img src="../images/frame/dui.png">
	            	<b class="green">	
		        		${requestScope.returninfo }
		        	</b>
		        </div>
		    </div>
		    <div class="fb-bom">
		        <cite><input type="button" value="返回应急公示" class="sbt" onclick="goFindFreeze();"></cite>
		        <input type="button" value="继续添加冻结CPC码" class="sbt" onclick="goAddFreeze();"> 
		    </div>
	    </div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	function goFindFreeze(){
		$("#searchform").attr("action","freeze!findByList.shtml");
		$("#searchform").submit();
	}
	function goAddFreeze(){
		window.location.href="<%=basePath%>manage/govStat/addGovFreeze.jsp";
	}
	</script>
	</body>
</html>
