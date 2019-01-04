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
		<div class="cur-pos">当前位置：用户管理 > 添加用户完成</div>
	    <div class="form-box">
    		<div class="fb-tit">操作成功</div>
	       	<div class="fb-con">
		        <div class="fb-msg">
		        	<img src="../images/frame/dui.png">
	            	<b class="green">	
		        		${requestScope.returninfo }
		        	</b>
		        </div>
		    </div>
		    <!-- 
		    <div class="fb-bom">
		        <cite><input type="button" value="其他主体备案" class="sbt" onclick="goAddCompany();"></cite>
		        <input type="button" value="返回备案信息列表" class="sbt" onclick="goFindCompany();">
		    </div>
		     -->
	    </div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	function goFindCompany(){
		$("#searchform").attr("action", "company!findByList.shtml");
		$("#searchform").submit();
	}
	
	function goAddCompany(){
		window.location.href="<%=basePath%>manage/company/addCompany.jsp";
	}
	</script>
	</body>
</html>
