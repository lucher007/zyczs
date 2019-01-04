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
<base href="<%=basePath%>" target="_self" />   
<meta charset="utf-8">
<title>待分包药材列表</title>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="/style/common.css" />
<link type="text/css" rel="stylesheet" href="/style/plant.css">

<script type="text/javascript">



</script>

</head>

<body>
	
    <div class="cur-pos">
			当前位置：库存销售 > 已包药材列表
		</div>
		<div class="seh-box">
			<form action="<%=basePath %>medStorage!findPackList.shtml" method="post" name="myform">
				请输入药材名称查询:<input type="text" value="${medname}" class="inp" size="40" id="medname" name="medname">
				<input type="submit" value="查询" class="btn">
			</form>
		</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td width="130">
						药材批次号
					</td>
					<td width="150">
						品名
					</td>
					<td width="109">
						库存量(Kg)
					</td>
					<td width="100">
						入库时间
					</td>
					<td width="81">
						是否检验
					</td>
					<td width="81">
						操作
					</td>
				</tr>
				<c:forEach items="${list}" var="item">
					<tr class="lb-list">
						<td>
							${item.cpcmed }
						</td>
						<td>
							${item.medname }
						</td>
						<td>
							${item.medweight / 10000 }
						</td>
						<td>
							${item.addtime }
						</td>
						<td>
							<c:if test="${item.checkstate == 0}" var="flag">
								否
							</c:if>
							<c:if test="${!flag}" >
								是
							</c:if>
						</td>
						<td>
							<a href="<%=basePath%>medStorage!findPackedByCpcMed.shtml?cpcmed=${item.cpcmed }&medstorid=${item.medstorid}">拆包</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			
			<div style="text-align: right; height: 26px;">
				<pg:pager url="medStorage!findPackList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="9"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="medname" value="${requestScope.medname }" />
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
							<a href="<%=pageUrl%>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
							<a href="<%=prevPageUrl%>">前一页</a>
						</pg:prev>
						<pg:pages>
							<%
								if (pageNumber == currentPageNumber) {
							%><span style="font: bold 16px arial;"><%=pageNumber%></span>
							<%
								} else {
							%><a href="<%=pageUrl%>"><%=pageNumber%></a>
							<%
								}
							%>
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
							<a href="<%=nextPageUrl%>">下一页</a>
						</pg:next>
						<pg:last>
							<a href="<%=pageUrl%>">末页</a>
						</pg:last>
					</pg:index>
				</pg:pager>
			</div>
			
			<script type="text/javascript" language="javascript"
				src="/js/common/jquery.js"></script>
			<script type="text/javascript" language="javascript"
				src="/js/form.js"></script>
</body>
</html>

