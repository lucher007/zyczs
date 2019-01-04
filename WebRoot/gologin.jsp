<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>" />
    <title>登录失效</title>
    <style type="text/css">
    	html,body{
    		margin: 0;
    		padding:0;
    		height:300px;
    	}
    	.container{
    		margin: 0 auto;
    		height: 300px;
    		padding-top:10px;
    		text-indent:10px;
    	}
    </style>
    <script type="text/javascript">     
	function countDown(secs,surl){     
	 	/*jumpTo.innerText=secs;     
	 	if(--secs>0){     
	     	setTimeout("countDown("+secs+",'"+surl+"')",1000);     
	    }else{       
	     	window.top.location.href=surl;     
	    } */ 
	 	window.top.location.href=surl;    
	}     
	</script> 
  </head>
  <body>
  	<div class="container">
<%--    	你的登录已经失效 或 有其他人登录了你的账户 被迫下线 <span id="jumpTo">5</span>秒后自动跳转到登陆页面  --%>
		<script type="text/javascript">countDown(5,'/login.jsp');</script>
	</div>
  </body>
</html>
