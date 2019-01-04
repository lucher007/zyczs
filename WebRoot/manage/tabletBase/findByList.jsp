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

	<body>
	<div id="body">
	 	<div class="cur-pos">
			当前位置：饮片生产管理 > 饮片品名列表
		</div>
		<div class="seh-box">
			<cite><a href="tabletBase!findByList_un.shtml" class="btn-a"><span class="new">新增饮片</span></a></cite>
			<form action="" method="post" id="searchform" name="myform">
	    	请输入饮片品名：<input maxlength="20" type="text"  name="mcontent" id="mcontent" value="${requestScope.mcontent}"  class="inp" size="45"> 
	    	<input type="button" value="查询" class="sch" onclick="return checkForm();"> 
	    	</form>
    	</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						饮片中文名称
					</td>
					<td>
						饮片英文名称
					</td>
					<td>
						最近更新时间
					</td>
						
					<td>
						状态
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${requestScope.list}" var="list">
					<tr class="lb-list">
						<td height="30">
							${list.name }&nbsp;
						</td>
						<td>
							${list.keyword }&nbsp;
						</td>
						<td>						
							${fn:substring(list.lasttime, 0, 11)}&nbsp;
						</td>						
						<td>
							<c:if test="${list.enabled==1}">
							可用
							</c:if>
							<c:if test="${list.enabled==0}">
							不可用
							</c:if>&nbsp;
						</td>
						<td>
<%--							<a href="<%=basePath %>tabletBase!findById.shtml?id=${list.id}" class="btn-edit">修改</a>--%>
							<a href="<%=basePath %>tabletBase!deleteObject.shtml?id=${list.id}" onclick="return confirm('确认要删除吗?');" class="btn-del">删除</a>
						</td>
									
					</tr>
				</c:forEach>
			</table>
			
			<div class="page">
				<cite>
				<pg:pager url="tabletBase!findByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="mcontent" value="${requestScope.mcontent }" />
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#mcontent").val($.trim($("#mcontent").val()));
			if(checkquotmarks($("#mcontent").val())){
				$("#mcontent").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletBase!findByList.shtml");
			$("#searchform").submit();
		}
	</script>	
	
	</body>
</html>
