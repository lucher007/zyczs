<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
	    <title>新建种植任务完成页</title>
	    <link type="text/css" rel="stylesheet" href="/style/plant.css">
  	</head>
  
  	<body>  
  	<div id="body">
  		<div class="cur-pos">当前位置：种植管理 > 新建种植任务完成</div>
    	<div class="form-box">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="../images/frame/dui.png">
	            <b class="green">
	    			<c:if test="${requestScope.returninfo=='新建种植任务完成！'}">
						${requestScope.returninfo}
					</c:if>
					<c:if test="${requestScope.returninfo=='新建种植任务失败！'}">
						${requestScope.returninfo}
					</c:if>
	        	</b>
         		<b class="green">种植批次号为：${cpcplant}</b> 
	            </div>
	            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10">
	              <tr>
	                <td class="fbc-box" valign="top">
	                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	                      <tr class="fbc-tit b">
	                        <td colspan="4">药材信息</td>
	                      </tr>
	                      <tr>
	                        <td height="30" align="right" class="line-r">种子(种苗)植物名：</td>
	                        <td class="line-r">${requestScope.plantname }</td>
	                        <td class="line-r" align="right">种植面积(亩)：</td>
	                        <td>${requestScope.plantarea }</td>
	                      </tr>
	                      <tr>
	                        <td bgcolor="#EEEEEE" height="30" align="right" class="line-r">企业内部种植批次：</td>
	                        <td bgcolor="#EEEEEE" class="line-r">${requestScope.plantnumber }</td>
	                        <td bgcolor="#EEEEEE" class="line-r" align="right">种子(种苗)重量(Kg)：</td>
	                        <td bgcolor="#EEEEEE">${requestScope.plantweight/10000 }</td>
	                      </tr>
	                      <tr>
	                        <td class="line-r" height="30" align="right">种子(种苗)来源：</td>
	                        <td class="line-r">${requestScope.plantsource }</td>
	                        <td class="line-r" align="right">种植负责人：</td>
	                        <td>${requestScope.plantusername}</td>
	                      </tr>
	                      <tr>
	                        <td bgcolor="#EEEEEE" class="line-r" height="30" align="right">种植时间：</td>
	                        <td bgcolor="#EEEEEE" class="line-r">${requestScope.plantaddtime }</td>
	                        <td bgcolor="#EEEEEE" class="line-r" align="right">种植周期(月)：</td>
	                        <td bgcolor="#EEEEEE">${requestScope.plantcycle }</td>
	                      </tr>
	                    </table>
	                </td>
	                <td width="188" valign="top">
	                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box">
	                      <tr class="fbc-tit b">
	                        <td height="30">二维码</td>
	                      </tr>
	                      <tr>
	                        <td height="150" valign="top" class="dcode"><img src="<%=basePath%>images/qrcode.png" width="150" height="150"></td>
	                      </tr>
	                      <tr>
	                        <td height="30" align="center">${requestScope.gpcode}</td>
	                      </tr>
	                    </table>
	                </td>
	              </tr>
	            </table>
	            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box mt10 ml10">
				<tr class="fbc-tit">
					<td>
						预计产出药材
					</td>
					<td>
						预计产量总计(Kg)
					</td>
				</tr>
				<c:forEach items="${plantlist}" var="plant">
					<tr class="fb-list">
						<td height="30">${plant.harvestmed }</td>
						<td>${plant.harvestwei }</td>
					</tr>
				</c:forEach>
			</table>
	            
	    	</div>
	    	<div class="fb-bom">
	        	<cite><input type="button" value="新建其他种植任务" class="sbt"  onclick="return addplant();">　</cite>
	        	<input type="button" value="返回种植管理" class="sbt"  onclick="return findByList();">
	        </div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" >
	    function findByList(){
			window.location.href="plant!findByList.shtml";
		}  
	    function addplant(){
			window.location.href="<%=basePath%>manage/plant/addPlant.jsp";
		}  
	</script>
	</body>
 </html>
 