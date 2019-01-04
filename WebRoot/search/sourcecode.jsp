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
	background:#FBFBFB;
	}
.container{
	margin:0 auto;
	width:768px;
	height:1024px;
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
	width:120px;	
}
.trcss1 td{
	height:25px;
	background:#9fcde4;
	font:bold 12px arial;
	color:#0e569e;
}
.trcss2 td{
	height:20px;
	background:#e2edef;
	font:normal 12px arial;
}
table td{
	height:31px;
}
.mattable td{
	height:31px;
	text-align:left;
}
</style>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/ajaxobj.js" ></script>
<script type="text/javascript">
	function document.oncontextmenu(){event.returnValue=false;}
	function changePrintBt(obj){
		var objstyle = obj.style.backgroundImage; 
		objstyle = objstyle.substring(11,objstyle.length-5);
		if(objstyle=="searchcodeprint1"){
			obj.style.backgroundImage="url(<%=basePath%>images/searchcodeprint2.png)";
		}else if(objstyle=="searchcodeprint2"){
			obj.style.backgroundImage="url(<%=basePath%>images/searchcodeprint1.png)";
		}	
	}
	function changeCloseBt(obj){
		var objstyle = obj.style.backgroundImage; 
		objstyle = objstyle.substring(11,objstyle.length-5);
		if(objstyle=="searchcodeclose1"){
			obj.style.backgroundImage="url(<%=basePath%>images/searchcodeclose2.png)";
		}else if(objstyle=="searchcodeclose2"){
			obj.style.backgroundImage="url(<%=basePath%>images/searchcodeclose1.png)";
		}	
	}
	function closewindow(){
		clearInterval(timeid);
		window.location.href="search/searchcode.jsp?mac="+$("#mac").val();
	}
	//关闭时间
	var timenum=120;
	var timeid;
	function downTime(){
		timenum--;		
		if(timenum<0){						
			clearInterval(timeid);
			closewindow();
		}
	}
	function downTimeStart(){
		timeid=setInterval("downTime()", 1000);
	}	
	downTimeStart();

	function goSearch(){
		window.location.href="<%=basePath %>search/searchcode.jsp?mac="+$("#mac").val();
	}
	function openshowimgdiv(url){
		document.getElementById("showimgdiv").style.display="block";	
		document.getElementById("showimg").src=url;
	}
	function closeshowimgdiv(){
		document.getElementById("showimgdiv").style.display="none";
		document.getElementById("showimg").src="";
	}
</script>
</head>

<body>
<div class="container">
	<input type="hidden" id="mac" name="mac" value="${mac }"/>
	<div style="width:768px;height:92px;background:url('<%=basePath %>search/images1/sourcecode1.png') no-repeat;"></div>
	<br />
	<c:if test="${searchtype==5||searchtype==6}">
	<table cellpadding="0" cellspacing="0" border="0" width="746" style="margin-left:22px;font:normal 14px '微软雅黑';">
		<tr>
			<td style="font:normal 30px '微软雅黑';" colspan="2">饮片信息</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td width="100">名称：</td><td width="273">${piece_name}&nbsp;</td>
			<td width="100">溯源码：</td><td width="273">${piece_sourcecode}</td>
		</tr>
		<tr>
			<td>生产企业：</td><td>${piece_productioncompanies}</td>
			<td>销售企业：</td><td>${piece_salescompanies}</td>
		</tr>
		<tr>
			<td>批次号 ：</td><td>${piece_batchcode }</td>
			<td>生产规格：</td><td>${piece_spec}</td>
		</tr>
		<tr>
			<td>执行标准 ：</td><td>${piece_standard}</td>
			<td>生产流程：</td><td>${piece_processflow}</td>
		</tr>
		<tr>
			<td>生产日期 ：</td><td>${fn:substring(piece_producedate, 0, 11)}</td>
			<td>待包装重量(单位:g)：</td><td>${piece_weight}</td>
		</tr>
		<tr>
			<td>地区 ：</td><td>${piece_areacode}</td>
			<td></td><td></td>
		</tr>
		<tr>
			<td>检验方法：</td><td>${piece_material_checkmethod}</td>
			<td>质量级别</td><td>${piece_material_checkgrade}</td>
		</tr>
		<tr>
			<td>粗加工方法：</td><td>${piece_material_checkthickmethod}</td>
			<td>贮藏条件</td><td>${piece_material_checkcondition}</td>
		</tr>
		<tr>
			<td>检验时间：</td><td>${fn:substring(piece_material_checktime, 0, 11)}</td>
			<td>检验报告：</td>
			<td>
				<c:if test="${fn:length(searchlist_reporttablet)>0}">
					有
				</c:if>
				<c:if test="${fn:length(searchlist_reporttablet)<1}">
					无
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="font:normal 12px arial;">
				<c:if test="${fn:length(searchlist_reporttablet)>0}">
					<c:forEach items="${searchlist_reporttablet}" var="searchlist_reporttablet">
						<div style="width:50px;height:50px;float:left;text-align:center;cursor:pointer;" onclick="openshowimgdiv('${searchlist_reporttablet.piece_report_url}');">
						<div style="background:url('<%=basePath %>search/images1/imgview.png') no-repeat;width:50px;height:50px;"></div>
						${searchlist_reporttablet.piece_report_type}
						</div>
					</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
	<br /><br />
	</c:if>
	
	<table cellpadding="0" cellspacing="0" border="0" width="746" style="margin-left:22px;font:normal 14px '微软雅黑';">
		<tr>
			<td style="font:normal 30px '微软雅黑';" colspan="2">药材信息</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td width="100">药材名称：</td><td width="273">${medicine_medicinename}&nbsp;</td>
			<td width="100">批次号：</td><td width="273">${medicine_medicinecode}</td>
		</tr>
		<tr>
			<td>药材来源：</td><td>${medicine_medicinesource}</td>
			<td>销售企业：</td><td>${medicine_salescompanies}</td>
		</tr>
		<tr>
			<td>收获时间 ：</td><td>${fn:substring(medicine_harvesttime, 0, 11)}</td>
			<td></td><td></td>
		</tr>
		<tr>
			<td>种植企业：</td><td>${plant_corpname}</td>
			<td>植物名称：</td><td>${plant_plantname}</td>
		</tr>
		<tr>
			<td>植物批次码 ：</td><td>${plant_plantcode}</td>
			<td>种子来源：</td><td>${plant_plantsource}</td>
		</tr>
		<tr>
			<td>种植面积(单位:亩)：</td><td>${plant_plantarea}</td>
			<td>种植周期(单位：月）：</td><td>${plant_plantcycle}</td>
		</tr>
		<tr>
			<td>种植时间 ：</td><td>${fn:substring(plant_planttime, 0, 11)}</td>
			<td>田间管理：</td><td>${fieldmanagement_name}</td>
		</tr>
		<tr>
			<td colspan="4" height="75" align="left">
				<div style="width:746px;height:100px;border:0px solid red;overflow-y:scroll;overflow-x:hidden;text-align:left;">
					<c:forEach items="${searchlist_materialmed}" var="searchlist_materialmed">
					<table style="width:746px;height:100px;border-bottom:1px solid #000;" border="0" class="mattable" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100">企业名称：</td><td width="273">${searchlist_materialmed.medicine_material_corpname}</td>
							<td width="100">检验时间：</td><td width="273">${fn:substring(searchlist_materialmed.medicine_material_checktime, 0, 11)}</td>
						</tr>
						<tr>
							<td>检验方法：</td><td>${searchlist_materialmed.medicine_material_checkmethod}</td>
							<td>质量级别：</td><td>${searchlist_materialmed.medicine_material_checkgrade}</td>
						</tr>
						<tr>
							<td>粗加工方法：</td><td>${searchlist_materialmed.medicine_material_checkthickmethod}</td>
							<td>贮藏条件：</td><td>${searchlist_materialmed.medicine_material_checkcondition}</td>
						</tr>
					</table>
					</c:forEach>
				</div>
			</td>
		</tr>
		
		<tr>
			<td colspan="4" style="font:normal 12px arial;">
				<c:if test="${fn:length(searchlist_reportmed)>0}">
					<c:forEach items="${searchlist_reportmed}" var="searchlist_reportmed">
						<div style="width:50px;height:50px;float:left;text-align:center;cursor:pointer;" onclick="openshowimgdiv('${searchlist_reportmed.medicine_report_url}');">
						<div style="background:url('<%=basePath %>search/images1/imgview.png') no-repeat;width:50px;height:50px;"></div>
						${searchlist_reportmed.medicine_report_type}
						</div>
					</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
	<br /><br />
	<div style="width:768px;height:10px;border-top:2px dashed #BDBDBD;"></div>
	
	<table cellpadding="0" cellspacing="5" border="0" width="768">
		<tr>
			<td width="300"></td>
			<td width="204"></td>
			<td style="border-left:2px dashed #BDBDBD;"></td>
			<td><img src="<%=basePath %>search/images1/sourcecode5.png" style="cursor:hand;" width="204" height="59" alt="" onclick="goSearch();"></td>
		</tr>
	</table>
	
	<div style="width:768px;height:1024px;position:absolute;top:0;left:0;display:none;text-align:center;background:#666666;overflow:hidden;" id="showimgdiv">
		<img src="" width="500px" align="left" id="showimg" />
		<div style="position:relative;top:800px;width:163px;height:79px;background:url('<%=basePath%>search/images1/searchcodeclose1.png') no-repeat;cursor:hand;display:inline-block;"  onmousedown="return changeCloseBt(this);" onmouseup="return changeCloseBt(this);" onclick="return closeshowimgdiv();"></div>
	</div>
	
</div>
</body>
</html>

