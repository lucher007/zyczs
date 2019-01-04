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
<%--<base href="<%=basePath %>" />--%>
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
	overflow:hidden;
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
}
.letterdiv{
	font:bold 25px arial;
	width:98px;
	height:28px;
	text-align:center;
	background:#e5e5e5;
}
.cont1{
	width:668px;
	height:616px;
	overflow:hidden;
}
.cont2{
	width:668px;
	height:30px;
	font:bold 25px arial;
	border-bottom:1px solid #01b0f0;
	clear: both;
}
.cont3{
	width:132px;
	height:43px;
	padding-top:7px;
	text-align:center;
	font:bold 25px arial;
	float: left;
	overflow:hidden;
	background:#dddddd;
	margin:0 1px 1px 0;
	cursor:pointer;
}
.cont4{
	width:132px;
	height:43px;
	padding-top:7px;
	text-align:center;
	font:bold 17px arial; 
	float: left;
	overflow:hidden;
	background:#dddddd;
	margin:0 1px 1px 0;
	cursor:pointer;
}

.a2style{
	display:inline-block;width:98px;height:30px;cursor:pointer;
}
</style>
<script type="text/javascript" language="javascript" src="<%=basePath %>js/common/jquery.js"></script>
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
		document.getElementById("area").value=${initParam.zyczs_area };
		document.searchform.action="search!findByList.shtml";
		document.searchform.submit();
	}
	function gohome(){
		window.location.href="<%=basePath %>search/search.jsp?mac="+$("#mac").val();;
	}
	
	$(function(){
		$("#up").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop-500;
		});
	
		$("#down").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop+500;
		});	
		
		$(".cont3").click(function(){
			$("#prodname").val($(this).html());
			$("#searchform").attr("action","search!findByList_Search.shtml");
			$("#searchform").submit();
		});
		
		$(".cont4").click(function(){
			$("#prodname").val($(this).html());
			$("#searchform").attr("action","search!findByList_Search.shtml");
			$("#searchform").submit();
		});
	});
</script>
</head>

<body>
<div class="container">	
	<form action="" method="post" name="searchform" id="searchform">
	<input type="hidden" id="area" name="area"/>
	<input type="hidden" id="cpc" name="cpc" value="${cpc}"/> 
	<input type="hidden" id="mac" name="mac" value="${mac}"/>
	<input type="hidden" id="prodname" name="prodname"/>
	<table cellpadding="0" cellspacing="0" border="0" width="768" height="1024">
		<tr><td width="768" height="94" style="background:url('<%=basePath %>search/images1/child1.png') no-repeat;">&nbsp;</td></tr>
		<tr><td width="768" height="123" style="background:url('<%=basePath %>search/images1/orgchild3.png') no-repeat;">&nbsp;</td></tr>
		<tr>
			<td width="768" height="736" valign="top">
				<table cellpadding="0" cellspacing="" border="0" width="768" height="736">
					<tr>
						<td width="668" valign="top">
						<div id="up" style="background:url('<%=basePath %>search/images1/orgup.png') no-repeat -60px 0px;cursor:hand;width:668px;height:60px;"></div>
						<div class="cont1" id="div1">
							<c:set var="temp" value="" />
							<c:forEach items="${tabletbaselist}" var="tabletbase">
									<c:if test="${fn:substring(tabletbase.keyword,0,1)!=temp}">
										<div class="cont2">
											<a id="${fn:substring(tabletbase.keyword,0,1)}" name="${fn:substring(tabletbase.keyword,0,1)}">${fn:toUpperCase(fn:substring(tabletbase.keyword,0,1))}</a>
										</div>
										<c:set var="temp" value="${fn:substring(tabletbase.keyword,0,1)}" />
									</c:if>
									
									<c:if test="${fn:length(tabletbase.name)>4}" var="flag">
										<div class="cont4">${tabletbase.name}</div>
									</c:if>
									<c:if test="${!flag}">
										<div class="cont3">${tabletbase.name}</div>
									</c:if>
									
							</c:forEach>
							
						</div>
						<div id="down" style="background:url('<%=basePath %>search/images1/orgdown.png') no-repeat -60px 0px;cursor:hand;width:668px;height:60px;"></div>
						</td>
						<td width="100" valign="top" style="background:#e5e5e5;" >
							<script type="text/javascript">
							for(var i=1;i<=26;i++){
								str3 = String.fromCharCode(0x60+i);
								document.write("<div class='letterdiv'><a href='#"+str3+"' class='a2style'>"+str3+"</a></div>");
							}
							</script>
						</td>
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

