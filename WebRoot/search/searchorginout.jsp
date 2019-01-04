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
.orgtable{
	height:616px;
	min-height: 616px;
}
.orgtable td{
	border-bottom:1px solid #01b0f0;
	font:bold 25px arial;
	text-align:center;
	height:60px;
	
	 
}

</style>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
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
		history.go(-1);
	}
	function gohome(){
		window.location.href="<%=basePath %>search/search.jsp?mac="+$("#mac").val();;
	}
	$(function(){
		//alert('${mac}');
		$("#up").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop-151;
		});
	
		$("#down").click(function(){
			document.getElementById('div1').scrollTop = document.getElementById('div1').scrollTop+151;
		});	
		
	});

</script>
</head>

<body>
<div class="container">	
	<form action="" method="post" name="searchform" id="searchform">
	<input type="hidden" id="mac" name="mac" value="${mac}"/>
	<table cellpadding="0" cellspacing="0" border="0" width="768" height="1024">
		<tr><td width="768" height="94" style="background:url('<%=basePath %>search/images1/child1.png') no-repeat;">&nbsp;</td></tr>
		<tr><td width="768" height="123" style="background:url('<%=basePath %>search/images1/orgchild4.png') no-repeat;">&nbsp;</td></tr>
		<tr>
			<td width="768" height="736" valign="top">
				<table cellpadding="0" cellspacing="" border="0" width="768" height="736">
					<tr>
						<td><div id="up" style="background:url('<%=basePath %>search/images1/orgup.png') no-repeat;cursor:hand;width:768px;height:60px;"></div></td>
					</tr>
					<tr>
						<td height="616" valign="top">
						<div id="div1" style="height:616px;overflow:hidden;">
								<table width="100%" cellspacing="0" cellpadding="0" border="0" class="orgtable">
								   <c:if test="${fn:length(Inoutstorlist)>0}">
					          	   <tr>
					          	   		<td height="30">品名</td>
						          	  	<td>批次号</td>
						          	    <td>入库时间</td>
							            <td>总重量(Kg)</td>
						            </tr>
									<c:forEach items="${Inoutstorlist}" var="inout">
									   <tr onclick="openCpc('${initParam.batchcpc_url }${inout.batchcpc }${initParam.batchcpc_tablet}');" style="cursor:pointer;">
									   		<td>${inout.prodname }&nbsp;</td>
									   		<td>
			  									${inout.batchcpc }
			  								</td>
									  		<td>${fn:substring(inout.opertime, 0, 11)}&nbsp;</td>
									  		<td>${inout.strtotalweight }&nbsp;</td>
									   </tr>
									</c:forEach>
									<tr><td colspan="4" style="border:none;height:616px;">&nbsp;</td></tr>
									</c:if>
									<c:if test="${fn:length(Inoutstorlist)<1}">
										<tr>
											<td colspan="4" style="height:616px;font:bold 35px arial;">所选企业近期没有该溯源品种入库！</td>
										</tr>
									</c:if>
								</table>
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
						<td width="360">&nbsp;</td>
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

