<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>中药溯源信息平台</title>
<style>
html, body {
	margin:0;
	padding:0;
	font-size:12px;
	height:1024px;
	overflow:hidden;
	background:#646464;
	}
.container{
	margin:0 auto;
	width:768px;
	height:1024px;
	background:#646464;
}
a {
color:#000000;
text-decoration: none;		
}		
a:visited {
color:#000000;
text-decoration: none;
}
a:hover {
color:#000000;
text-decoration: none;
}
.tablecss tr td{
	background:#a8d2e8;
	height:20px;
}
.tdcss{
	font:bold 40px arial;
	text-align:center;
	color:red;
}

</style>
<script language="javascript" src="<%=request.getContextPath() %>/js/ajaxobj.js" ></script>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">
	function document.oncontextmenu(){event.returnValue=false;}
	
	function closewindow(){
		clearInterval(timeid);
		window.location.href="<%=basePath%>search/searchcode.jsp?mac="+$("#mac").val();
	}

	var timenum=10;
	var timeid;
	function downTime(){		
		timenum--;		
		if(timenum<0){						
			clearInterval(timeid);
			//closewindow();
		}		
	}
	function downTimeStart(){
		timeid=setInterval("downTime()", 1000);
	}	
	downTimeStart();	
</script>
</head>

<body>
<div class="container">
		<input type="hidden" id="mac" name="mac" value="${mac }"/>
		<div style="margin:307px 0 0 125px;width:514px;height:406px;background:url('<%=basePath %>search/images1/sourceerror1.png') no-repeat;">
			<table cellpadding="0" cellspacing="0" width="514" height="406" border="0">
				<tr><td height="60"></td></tr>
				<tr><td height="85" style="font:bold 24px '微软雅黑';color:#ffffff;text-align:center;">
					您查询的溯源码错误！
				</td>
				</tr>
				<tr><td height="201"></td></tr>
				<tr><td height="60" align="right">
					<div style="width:121px;height:45px;background:url('<%=basePath %>search/images1/sourceerror2.png') no-repeat;cursor:hand;" id="clear" name="clear" onclick="return closewindow();">
					</div>
				</td></tr>
			</table>
		</div>

</div>
</body>
</html>

