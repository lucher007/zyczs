<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>待打印药材列表</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body>
	<form action="" method="post" id="searchform" name="myform">

	</form>
			
	<div id="body">
	 	<div class="cur-pos">
			当前位置：饮片生产管理  &gt; 生产记录&gt; 分包日志
		</div>
		
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						品名
					</td>
					<td>
						批次码
					</td>
					
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
						<td>
							<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStoragelist.cpctablet }${initParam.batchcpc_tablet}');">${tabletStoragelist.cpctablet }</a>
						</td>
						
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
				<pg:pager url="tabletStorage!findTabletPackLog.shtml"
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
			
			<div class="fb-bom">
			     <input type="button" value="返回上一页" class="sbt" onclick="back_go();">
			</div>
		</div>
	</div>	
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function back_go(){
			$("#searchform").attr("action","tabletStorage!findTabletRecord.shtml");
			$("#searchform").submit();
		}
	</script>	
	
	</body>
</html>
