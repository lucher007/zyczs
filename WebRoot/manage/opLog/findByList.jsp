<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>饮片基础列表</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body onload="initPage();">
	<div id="body">
	 	<div class="cur-pos">
			当前位置：运行状况 > 平台操作日志
		</div>
		<div class="seh-box">      
			<form action="" method="post" id="searchform" name="myform">
	    		<table border="0" width="100%">
                  <tr>
                    <td height="26" width="90" align="right">系统名称：</td>
                    <td width="170">
                    	<select name="sysid" id="sysid" class="w158" onchange="onSysIdChange(this.value);">
                    		<option value="">--全部--</option>
                    		<option value="1" <c:if test="${requestScope.sysid=='1' }">selected='true'</c:if> >中药材产地追溯子系统</option>
                    		<option value="2" <c:if test="${requestScope.sysid=='2' }">selected='true'</c:if> >中药材经营企业追溯子系统</option>
                    		<option value="3" <c:if test="${requestScope.sysid=='3' }">selected='true'</c:if> >中药材专业市场追溯子系统</option>
                    		<option value="4" <c:if test="${requestScope.sysid=='4' }">selected='true'</c:if> >中药饮片生产追溯子系统</option>
                    		<option value="5" <c:if test="${requestScope.sysid=='5' }">selected='true'</c:if> >中药饮片经营企业追溯子系统</option>
                    		<option value="6" <c:if test="${requestScope.sysid=='6' }">selected='true'</c:if> >中药饮片医院环节追溯子系统</option>
                    		<option value="7" <c:if test="${requestScope.sysid=='7' }">selected='true'</c:if> >中药材地方监管子系统</option>
                    	</select>
                    	
                    </td>
                    <td height="26"  align="right">操作方法：</td>
	                 <td>
	                    <select name="method" id="method" class="w158">
	                    	<option value="">--全部--</option>
	                    </select>
	                </td>
                    
                    <td>&nbsp;</td>
                  </tr>
                  
                  <tr>
			        <td align="right" >用户登录账号：</td>
                  	  <td>
	                  	<input type="text" name="loginName" id="loginName" value="${requestScope.loginName }" class="inp w150" />
			        </td>
			        <td align="right" >IP地址：</td> 
                  	  <td>
	                  	<input type="text" name="clientIp" id="clientIp" value="${requestScope.clientIp }" class="inp w150" />
			        </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                  	 <td align="right" >开始时间：</td>
                  	  <td>
                  	  
	                  	<input type="text" name="addTime" id="addTime" value="${fn:substring(addTime,0,19)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'endTime\');}'});"/>
			        </td>
			        <td align="right" >结束时间：</td> 
                  	  <td>
	                  	<input type="text" name="endTime" id="endTime" value="${fn:substring(endTime,0,19)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'addTime\');}'});"/>
			        </td>
                    <td width="200"><input type="button" value="查询" class="sch" onclick="return checkForm();" ></td>
                  </tr>
                </table>
	    	</form>
    	</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						系统名称
					</td>
					<td>
						操作方法
					</td>
					<td>
						登录名
					</td>
						
					<td>
						登录IP
					</td>
					<td>
						操作时间
					</td>
					<td>
						执行内容
					</td>
				</tr>
				
				
				<c:forEach items="${requestScope.list}" var="list">
					<tr class="lb-list">
						<td height="30">
							<c:if test="${list.sysid=='1' }">
							中药材产地追溯子系统
							</c:if>
							<c:if test="${list.sysid=='2' }">
							中药材经营企业追溯子系统
							</c:if>
							<c:if test="${list.sysid=='3' }">
							中药材专业市场追溯子系统
							</c:if>
							<c:if test="${list.sysid=='4' }">
							中药饮片生产追溯子系统
							</c:if>
							<c:if test="${list.sysid=='5' }">
							中药饮片经营企业追溯子系统
							</c:if>
							<c:if test="${list.sysid=='6' }">
							中药饮片医院环节追溯子系统
							</c:if>
							<c:if test="${list.sysid=='7' }">
							中药材地方监管子系统
							</c:if>
						</td>
						<td>
							${list.method }&nbsp;
						</td>
						<td>
							${list.loginName }&nbsp;
						</td>
						<td>
							${list.clientIp }&nbsp;
						</td>
						
						<td>	
				
							${fn:substring(list.addTime, 0, 19)}&nbsp;
						</td>						
						<td>
							${list.content }&nbsp;
						</td>
						
					</tr>
				</c:forEach>
			</table>
			
			<div class="page">
				<cite>
				<pg:pager url="opLog!findByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="sysid" value="${requestScope.sysid }" />
					<pg:param name="method" value="${requestScope.method }" />
					<pg:param name="clientIp" value="${requestScope.clientIp }" />
					<pg:param name="loginName" value="${requestScope.loginName }" />
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
							<a href="<%=pageUrl%>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
							<a href="<%=prevPageUrl%>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
							<%
								if (pageNumber == currentPageNumber) {
							%><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a>
							<%
								} else {
							%><a href="<%=pageUrl%>"><%=pageNumber%></a>
							<%
								}
							%>
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
							<a href="<%=nextPageUrl%>" title="下一页" class="next">&nbsp;</a>
						</pg:next>
						<pg:last>
							<a href="<%=pageUrl%>">末页</a>
						</pg:last>
					</pg:index>
				</pg:pager>
				</cite>
			</div>
		</div>
	</div>	
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	
		<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		function checkForm(){
			$("#mcontent").val($.trim($("#mcontent").val()));
			if(checkquotmarks($("#mcontent").val())){
				$("#mcontent").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","opLog!findByList.shtml");
			$("#searchform").submit();
		}
		
		function initPage(){
			var sysid='${requestScope.sysid }';
			var methodVal='${requestScope.method }';
			var method=document.getElementById("method");
			if(sysid!=""){
				method.length=1;
				for(var i=0;i<codeArray.length;i++){
					if(sysid==codeArray[i][0]){	
						var index=method.length;
						method[index]=new Option(codeArray[i][1],codeArray[i][1]);  						
						if(methodVal!=""&&methodVal==codeArray[i][1]){
							method[index].selected=true;
						}	
					}
				}
			}
			
		}
		
		function onSysIdChange(selValue){
			var method=document.getElementById("method");
			method.length=1;
			
			for(var i=0;i<codeArray.length;i++){
				if(selValue==codeArray[i][0]){	
					method[method.length]=new Option(codeArray[i][1],codeArray[i][1]);  
				}
			}
		}
		
		var codeArray=new Array();	
		codeArray[codeArray.length]=new Array(1,"用户登录");
		codeArray[codeArray.length]=new Array(1,"用户退出");	
		codeArray[codeArray.length]=new Array(1,"药材收获");
		codeArray[codeArray.length]=new Array(1,"药材种植");
		codeArray[codeArray.length]=new Array(1,"药材施肥");
		codeArray[codeArray.length]=new Array(1,"药材农药");		
		codeArray[codeArray.length]=new Array(1,"药材检验");
		codeArray[codeArray.length]=new Array(1,"药材出库");
		codeArray[codeArray.length]=new Array(1,"打印机回收");
		//药材经销
		codeArray[codeArray.length]=new Array(2,"用户登录");
		codeArray[codeArray.length]=new Array(2,"用户退出");	
		codeArray[codeArray.length]=new Array(2,"药材入库");
		codeArray[codeArray.length]=new Array(2,"药材出库");
		codeArray[codeArray.length]=new Array(2,"药材检验");	
		codeArray[codeArray.length]=new Array(2,"打印机回收");
		//市场
		codeArray[codeArray.length]=new Array(3,"用户登录");
		codeArray[codeArray.length]=new Array(3,"用户退出");	
		codeArray[codeArray.length]=new Array(3,"药材入库");
		codeArray[codeArray.length]=new Array(3,"药材出库");
		codeArray[codeArray.length]=new Array(3,"药材检验");
		codeArray[codeArray.length]=new Array(3,"企业备案");
		codeArray[codeArray.length]=new Array(3,"发送IC卡");
		codeArray[codeArray.length]=new Array(3,"发放溯源秤");
		codeArray[codeArray.length]=new Array(3,"回收溯源秤");
		codeArray[codeArray.length]=new Array(3,"回收打印机");
		codeArray[codeArray.length]=new Array(3,"回收IC卡");
		//饮片生产
		codeArray[codeArray.length]=new Array(4,"用户登录");
		codeArray[codeArray.length]=new Array(4,"用户退出");	
		codeArray[codeArray.length]=new Array(4,"药材入库");
		codeArray[codeArray.length]=new Array(4,"药材检验");
		codeArray[codeArray.length]=new Array(4,"饮片出库");
		codeArray[codeArray.length]=new Array(4,"饮片检验");
		codeArray[codeArray.length]=new Array(4,"饮片生产");
		
		//饮片经销
		codeArray[codeArray.length]=new Array(5,"用户登录");
		codeArray[codeArray.length]=new Array(5,"用户退出");	
		codeArray[codeArray.length]=new Array(5,"饮片入库");
		codeArray[codeArray.length]=new Array(5,"饮片出库");
		//医院
		codeArray[codeArray.length]=new Array(6,"用户登录");
		codeArray[codeArray.length]=new Array(6,"用户退出");	
		codeArray[codeArray.length]=new Array(6,"饮片入库");
		//监管
		codeArray[codeArray.length]=new Array(7,"用户登录");
		codeArray[codeArray.length]=new Array(7,"用户退出");	
		codeArray[codeArray.length]=new Array(7,"修改资料");			
		codeArray[codeArray.length]=new Array(7,"新建用户");	
		codeArray[codeArray.length]=new Array(7,"企业备案");
		codeArray[codeArray.length]=new Array(7,"企业审核");
		codeArray[codeArray.length]=new Array(7,"发送IC卡");
		codeArray[codeArray.length]=new Array(7,"发放溯源秤");
		codeArray[codeArray.length]=new Array(7,"回收溯源秤");
		codeArray[codeArray.length]=new Array(7,"打印机回收");
		codeArray[codeArray.length]=new Array(7,"回收IC卡");
			
		codeArray[codeArray.length]=new Array(7,"应急处理");
		codeArray[codeArray.length]=new Array(7,"考核计算");
		codeArray[codeArray.length]=new Array(7,"考核结果保存");
		
		
		
	</script>	
	
	</body>
</html>
