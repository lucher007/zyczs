<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
    	<base href="<%=basePath%>">    
    	<title>种植任务详情</title>
    	<link type="text/css" rel="stylesheet" href="/style/plant.css">
  	</head>
  
  	<body>
 	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 种植任务详情</div>
    	<div class="form-box">
    		<form action="" method="post" name="searchform" id="searchform"></form>
			<%--<div style="width:535px;height:145px;display:inline-block;border:1px solid #D6D6D6;position:relative;left:18px;top:10px;">
				<div style="width:535px;height:28px;line-height:28px;vertical-align:middle;border-bottom:1px solid #D6D6D6;background:url('images/growfertilizerdivbg.png') repeat-x;">
					&nbsp;&nbsp;传感器数据
				</div>						
				<table cellpadding="0" cellspacing="0" border="0" width="95%" style="position: relative;left:10px;">
					<tr>
						<td width="80" height="30">经度：</td>
						<td>&nbsp;</td>
						<td width="80">纬度：</td>
						<td>&nbsp;</td>
						<td width="80">光照度：</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="30">温度：</td>
						<td>&nbsp;</td>
						<td>湿度：</td>
						<td>&nbsp;</td>
						<td>土壤温度：</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="30">土壤水分：</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>--%>
			<div class="fb-tit">种植任务详细信息</div>
	        <div class="fb-con">
				<table border="0" width="726" class="ml10">
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">植物名：</td>
						<td>${requestScope.plant.plantname }</td>
						<td bgcolor="#EEEEEE" align="right">种植批次号：</td>
						<td>${requestScope.plant.cpcplant }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">企业内部种植批次号：</td>
						<td>${requestScope.plant.plantnumber }</td>
						<td bgcolor="#EEEEEE" align="right">种植面积(亩)：</td>
						<td>${requestScope.plant.plantarea }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">种子(种苗)来源：</td>
						<td>${requestScope.plant.plantsource }</td>
						<td bgcolor="#EEEEEE" align="right">种子(种苗)重量(Kg)：</td>
						<td>${requestScope.plant.plantweight/10000 }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">种植时间：</td>
						<td>${ requestScope.plant.plantaddtime}</td>
						<td bgcolor="#EEEEEE" align="right">种植负责人：</td>
						<td>${requestScope.plant.plantusername }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">田间管理(次)：</td>
						<td colspan="3">
							<span>${requestScope.plant.fieldcare }
<%--								<c:if test="${plant.state == 0}" var="flag">--%>
									<input type="button" class="btn" onclick="return findByFieldCare('${requestScope.plant.cpcplant}');" value="详情"/>
<%--								</c:if>--%>
							</span>
						</td>
					<!-- 
						<td bgcolor="#EEEEEE" align="right">施药次数(次)：</td>
						<td>
							<span>${requestScope.plant.pesticide }
<%--							<c:if test="${plant.state == 0}" var="flag">--%>
								<input type="button" class="btn" onclick="return findByPesticide('${requestScope.plant.cpcplant}');"  value="详情"/>
<%--							</c:if>--%>
							</span>
						</td>
					 -->
					</tr>
				</table>
				
				<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt10">
              		<tr class="fbc-tit">
              			<td height="30">预计产出药材</td>
              			<td>预计产量总计(Kg)</td>
              		</tr>
              		<c:forEach items="${requestScope.plantlist}" var="item" >
              		<tr class="fb-list">
						<td height="30">${item.harvestmed}</td>
						<td>${item.harvestwei}</td>
              		</tr>
              		</c:forEach>
              	</table>
				<div style="padding: 10px"><b>产出药材及产量</b></div>
				<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
              		<tr class="fbc-tit">
              			<td height="30">药材品名</td>
              			<td>采收批次码</td>
              			<td>收获时间</td>
              			<td>实际产量(Kg)</td>
              		</tr>
              		<c:forEach items="${requestScope.medlist}" var="med" >
              		<tr class="fb-list">
						<td height="30">${med.medname}</td>
						<td>${med.cpcmed}</td>
						<td>${med.harvesttime}</td>
						<td>${med.medweight / 10000}</td>
              		</tr>
              		</c:forEach>
              	</table>
			</div>
		</div>
	</div>    	
   	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
   	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
		function findByFertilizer(cpcplant){
			window.location.href="fertilizer!findByList.shtml?cpcplant="+cpcplant+"&oper=${requestScope.oper}";
		}
		function findByPesticide(cpcplant){
			window.location.href="pesticide!findByList.shtml?cpcplant="+cpcplant+"&oper=${requestScope.oper}";
		}
		function findByFieldCare(cpcplant){
			window.location.href="fieldCare!findByList.shtml?cpcplant="+cpcplant+"&oper=${requestScope.oper}";
		}
		cMenu(0,0);
 	</script>
  	</body>
</html>
 