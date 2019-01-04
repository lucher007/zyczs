<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String mac = request.getParameter("mac");
request.setAttribute("mac",mac);
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
	
	function goOrg(){
		document.getElementById("area").value=${initParam.zyczs_area };
		document.searchform.action="search!findByList.shtml";
		document.searchform.submit();
	}
	function goCode(){
		window.location.href="<%=basePath %>search/searchcode.jsp?mac="+$("#mac").val();
	}
</script>
</head>

<body>
<div class="container">	
	<form action="" method="post" name="searchform" id="searchform">
	<input type="hidden" id="area" name="area"/>
	<input type="hidden" id="mac" name="mac" value="${mac }"/>
	<table cellpadding="0" cellspacing="0" border="0" width="768" height="1024">
		<tr><td width="768" height="94" style="background:url('<%=basePath %>search/images1/child1.png') no-repeat;">&nbsp;</td></tr>
		<tr>
			<td width="768" height="123" style="font:bold 30px arial;color:#1d8c10;text-align:center;">
				<c:if test="${initParam.zyczs_area==1 }">
				四川成都地方平台查询终端
				</c:if>
				<c:if test="${initParam.zyczs_area==2 }">
				河北安国地方平台查询终端
				</c:if>
				<c:if test="${initParam.zyczs_area==3 }">
				广西玉林地方平台查询终端
				</c:if>
				<c:if test="${initParam.zyczs_area==4 }">
				安徽亳州地方平台查询终端
				</c:if>
				<c:if test="${initParam.zyczs_area==5 }">
				吉林地方平台查询终端
				</c:if>
				<c:if test="${initParam.zyczs_area==6 }">
				江西地方平台查询终端
				</c:if>
			</td>
		</tr>
		<tr>
			<td width="768" height="736" valign="top">
				<table cellpadding="0" cellspacing="" border="0" width="768" height="736">
				<tr>
					<td width="384" height="334" style="background:url('<%=basePath %>search/images1/search1.png') no-repeat 53px 0px;height:334px;cursor:pointer;" onclick="goCode();"></td>
					<td width="384" height="334"style="background:url('<%=basePath %>search/images1/search2.png') no-repeat 20px 0px;height:334px;cursor:pointer;" onclick="goOrg();"></td>
				</tr>
				<tr><td colspan="2" style="height:30px;">&nbsp;</td></tr>
				<tr><td colspan="2" style="background:url('<%=basePath %>search/images1/search3.png') no-repeat center;height:46px;"></td></tr>
				<tr><td colspan="2" style="height:10px;">&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
						<div style="width:664px;border:0px solid red;font:normal 14px arial;line-height:25px;text-align:left;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中药材流通追溯系统以发展现代流通方式为基础，借助RFID、传感器等物联网技术和现代信息技术，通过建立中药材流通统一编码管理体系、中药材流通标准、追溯体系、检测检验体系和诚信体系。以第三方服务平台身份对中药材种植、加工、生产、流通、使用等过程关键信息进行处理， 每一个单包装的中药都有全球唯一电子标识，为企业用户提供中药材流通的SAAS（软件即服务）、PAA（平台即服务）、IAAS（基础设施即服务）等服务模式创新。 利用物联网和信息技术建立覆盖中药材研制、生产、流通和使用全过程的安全监管体系， 建立第三方的医药企业诚信体系、监管力量和技术支撑体系，实现中药流通的索证索票、购销台账的电子化， 形成“来源可知、去向可追、质量可查、责任可究”的流通追溯链条，达到药品安全保障能力明显提高， 保障老百姓吃上安全药、放心药、有效药的一项民生工程。 利用中药材流通追溯系统，能改变千百年来中药材传统的管理模式和交易方式，通过中药材流通追溯系统，实现中药材种植、流通、加工、使用管理规范，交易快捷， 增强国际竞争力，促进大中药产业发展。
						<br />
       					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;“运用这套系统，消费者可通过手机、互联网、药店终端信息，在任何时间、地点， 了解到所购买中药材从种植、加工到流通环节的全流程情况。”
       					</div>
					</td>
				</tr>
				<tr><td colspan="2"></td></tr>
				</table>			
			</td>
		</tr>
		<tr>
			<td width="768" height="71">
			</td>
		</tr>
	</table>
	
	</form>
</div>
</body>
</html>

