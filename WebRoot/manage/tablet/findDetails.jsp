<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
    	<base href="<%=basePath%>">    
    	<title>生产任务详情</title>
    	<link type="text/css" rel="stylesheet" href="/style/production.css">
  	</head>
  
  	<body>
 	<div id="body">
		<div class="cur-pos">当前位置：生产记录  &gt; 生产任务详情</div>
    	<div class="form-box">
    		<form action="" method="post" name="searchform" id="searchform"></form>
			
			<div class="fb-tit">饮片基本信息
			
			</div>
	        <div class="fb-con">
				<table border="0" width="726" class="ml10">
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right" width="150">饮片品名：</td>
						<td width="30%">${requestScope.vo.tabletname }</td>
						<td bgcolor="#EEEEEE" align="right" width="150">饮片批次号：</td>
						<td>${requestScope.vo.cpctablet }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">内部批次号：</td>
						<td>${requestScope.vo.tabletnumber }</td>
						<td bgcolor="#EEEEEE" align="right">生产规格：</td>
						<td>${requestScope.vo.tabletspec }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">原药材名：</td>
						<td>${requestScope.vo.medname }</td>
						<td bgcolor="#EEEEEE" align="right">原药材批次号：</td>
						<td>${requestScope.vo.cpcmed }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">原药材总重量(Kg)：</td>
						<td>${requestScope.vo.medweight/10000 } &nbsp;</td>
						<td bgcolor="#EEEEEE" align="right">原药材使用重量(Kg)：</td>
						<td>${requestScope.vo.meduseweight/10000 }&nbsp;</td>
					</tr>
					
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">原药材产地：</td>
						<td colspan="3">${ requestScope.vo.medaddress}</td>
						
					</tr>					
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">工艺流程：</td>
						<td colspan="3">${ requestScope.vo.processflow}</td>
						
					</tr>				
				</table>
				
				
				<c:if test="${fn:length(requestScope.assList)>0}">	
				<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt10">
              		<tr class="fbc-tit" >
              			<td height="30" align="center">辅料品名</td>
              			<td align="center">辅料编号</td>
              			<td align="center">辅料产地</td>
              			<td align="center">辅料重量(g)</td>
              			<td align="center">使用比列</td>
              			<td align="center">净药材</td>
              		</tr>
              		<c:forEach items="${requestScope.assList}" var="assList" >
              		<tr class="fb-list">
						<td height="30" align="center">${assList.assistplantname}</td>
						<td align="center">${assList.assistgpcode}</td>
						<td align="center">${assList.assistcity}</td>
						<td align="center">${assList.assistweight/10}</td>
						<td align="center" >${assList.assistusecount}</td>
						<td align="center">${assList.assistmaterial}</td>
              		</tr>
              		</c:forEach>
              	</table>
              	</c:if>
			</div>
			<div class="fb-tit tpline">饮片生产任务信息</div>
	        <div class="fb-con">
				<table border="0" width="726" class="ml10">
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right" width="150">工艺员：</td>
						<td width="30%">${requestScope.vo.operator }</td>
						<td bgcolor="#EEEEEE" align="right" width="150">生产部经理：</td>
						<td>${requestScope.vo.manager }</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">QA：</td>
						<td>${requestScope.vo.qa }</td>
						<td bgcolor="#EEEEEE" align="right">生产日期：</td>
						<td>${fn:substring(requestScope.vo.createtime, 0, 11)}</td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">备注：</td>
						<td colspan="3">${requestScope.vo.remark }</td>
						
					</tr>
              	</table>
			</div>
			<div class="fb-tit tpline">饮片分包日志</div>
	        <div class="fb-con">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						品名
					</td>
<!--					<td>-->
<!--						批次码-->
<!--					</td>-->
<!--					-->
					<td>
						饮片重量(Kg)
					</td>
					<td>
						生产日期
					</td>
					<td>
						小包装规格(g/包)
					</td>
					<td>
						小包数
					</td>				
					
				</tr>
				<c:forEach items="${requestScope.PackLogList}" var="tabletStoragelist" >
					<tr class="lb-list">
						<td height="30">
							${tabletStoragelist.tabletname }&nbsp;
						</td>
<!--						<td>-->
<!--							<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStoragelist.cpctablet }${initParam.batchcpc_tablet}');">${tabletStoragelist.cpctablet }</a>-->
<!--						</td>-->
						
						<td>	
							<c:set var="tabletweight" value="${tabletStoragelist.tabletweight}" scope="request" />
			           		 <%
			           		Object tabletweight=request.getAttribute("tabletweight");	
			           		 %> 
			           		 <c:if test="${tabletStoragelist.tabletweight==''||tabletStoragelist.tabletweight==null }">
								--
							</c:if>
							<c:if test="${tabletStoragelist.tabletweight!=''&&tabletStoragelist.tabletweight!=null }">
								<%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000"))%>  
							</c:if>
							  
			                 
                			&nbsp;
						</td>
						<td>						
							${fn:substring(tabletStoragelist.addtime, 0, 11)}&nbsp;
						</td>
						<td>
							<c:set var="tabletnumweight" value="${tabletStoragelist.tabletnumweight}" scope="request" />
			           		 <%
			           		Object tabletnumweight=request.getAttribute("tabletnumweight");	
			           		 %>  
			           		 <%if(tabletnumweight!=null&&!tabletnumweight.equals("")){ %> 
			                <%=Tools.scienceToString(Tools.division(tabletnumweight.toString(),"10"))%>  
			                <%}else{ %> 
			                --
			                <%} %>
                			&nbsp;
                			
							
						</td>
						<td>
							<c:if test="${tabletStoragelist.tabletnum==''||tabletStoragelist.tabletnum==null }">
							--
							</c:if>
							<c:if test="${tabletStoragelist.tabletnum!=''&&tabletStoragelist.tabletnum!=null }">
							${tabletStoragelist.tabletnum }
							</c:if>
							&nbsp;
						</td>

					</tr>
				</c:forEach>
			</table>
			<div class="page">
				<cite>
				<pg:pager url="tablet!findDetails.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="9"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="tabletid" value="${requestScope.tabletid }" />
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
			
			<div class="fb-bom">
			     <input type="button" value="返回上一页" class="sbt" onclick="history.go(-1);">
			</div>
		</div>
	</div> 
   	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
   	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
		function findByFertilizer(cpcplant){
			window.location.href="fertilizer!findByList.shtml?cpcplant="+cpcplant;
		}
		function findByPesticide(cpcplant){
			window.location.href="pesticide!findByList.shtml?cpcplant="+cpcplant;
		}
 	</script>
  	</body>
</html>
 