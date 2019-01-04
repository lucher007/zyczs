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
<base href="<%=basePath %>" />
<style>
html, body {
	margin:0;
	padding:0;
	font-size:12px;
	height:1024px;
	overflow:hidden;
	background:#ffffff;
	}
.container{
	margin:0 auto;
	width:768px;
	height:1024px;
	margin-top:-10px;
	background:#ffffff;
}
*{margin:0px;padding:0px}
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
.orgcontent{
	font:bold 40px arial;
	border-bottom:1px solid #01b0f0;
	text-align:center;
	height:75px;
	line-height:75px;
	vertical-align: middle;
	cursor:pointer;
}


</style>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">
	function document.oncontextmenu(){event.returnValue=false;}
	
	var timenum=600;
	var timeid;
	function downTime(){		
		timenum--;		
		if(timenum<0){						
			clearInterval(timeid);
			gohome();
		}		
	}
	function downTimeStart(){
		timeid=setInterval("downTime()", 1000);
	}	
	downTimeStart();
	
	
	function goback(){
		window.location.href="<%=basePath %>search/search.jsp?mac="+$("#mac").val();
	}
	function gohome(){
		window.location.href="<%=basePath %>search/search.jsp?mac="+$("#mac").val();
	}
	$(function(){
		$("#up").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop-151;
		});
	
		$("#down").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop+151;
		});	
		
		$(".orgcontent").click(function(){
			//alert($(this).attr("id"));
			$("#cpc").val($(this).attr("id"));
			//$("#mac").val($(this).attr("name"));
			$("#searchform").attr("action","search!findByList_Kiosks.shtml");
			$("#searchform").submit();
		})
	});
	
</script>
</head>

<body>
<div class="container">	
	<form action="" method="post" name="searchform" id="searchform">
	<input type="hidden" id="cpc" name="cpc"/>
	<input type="hidden" id="mac" name="mac" value="${mac}"/>
	<table cellpadding="0" cellspacing="0" border="0" width="768" height="1024">
		<tr><td width="768" height="94" style="background:url('<%=basePath %>search/images1/child1.png') no-repeat;">&nbsp;</td></tr>
		<tr><td width="768" height="123" style="background:url('<%=basePath %>search/images1/orgchild2.png') no-repeat;">&nbsp;</td></tr>
		<tr>
			<td width="768" height="736" valign="top">
				<table cellpadding="0" cellspacing="" border="0" width="768" height="736">
					<tr>
						<td><div id="up" style="background:url('<%=basePath %>search/images1/orgup.png') no-repeat;cursor:hand;width:768px;height:60px;"></div></td>
					</tr>
					<tr>
						<td height="616" valign="top">
						<div id="div1" style="height:616px;overflow:hidden;">
							<c:forEach items="${list}" var="search">
								<div class="orgcontent" id="${search.cpc}" name="${search.mac}">${search.orgname}</div>
							</c:forEach>
						</div>
						</td>
					</tr>
					<tr>
						<td><div id="down" style="background:url('<%=basePath %>search/images1/orgdown.png') no-repeat;cursor:hand;width:768px;height:60px;"></div></td>
					</tr>
				</table>			
			</td>
		</tr>
		<tr>
			<td width="768" height="71">
				<table cellpadding="0" cellspacing="0" border="0" width="768" height="71" bgcolor="#FFFFFF">
					<tr>
						<td width="204" style="background:url('<%=basePath %>search/images1/orgchild6.png') no-repeat;cursor:hand;" height="71" onclick="goback()"></td>
						<td width="360"></td>
						<td width="204" style="background:url('<%=basePath %>search/images1/orghome.png') no-repeat;cursor:hand;" height="71" onclick="gohome()"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	</form>
</div>
</body>
</html>

