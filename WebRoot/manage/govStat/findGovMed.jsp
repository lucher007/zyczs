<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>种植管理</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">
			当前位置：种植管理 > 种植管理
		</div>
		<div class="seh-box">
			<cite><a href="<%=basePath %>manage/plant/addPlant.jsp" class="btn-a"><span class="new">新建种植任务</span>
			</a> </cite>
			<form id="searchform"  action="" method="post" name="myform">
				请输入种子种苗植物名查询：<input maxlength="20" type="text" value="${plantname}" class="inp" size="40" id="plantname" name="plantname">
				<input type="button" value="查询" class="sch" onclick="return checkForm();">
			</form>
		</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						种植批次号
					</td>
					<td>
						种子种苗植物名
					</td>
					<td>
						种植面积 (亩)
					</td>
					<td>
						种植时间
					</td>
					<td>
						肥料管理
					</td>
					<td>
						农药管理
					</td>
					<td>
						收获管理
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${plantlist}" var="plant">
					<tr class="lb-list">
						<td height="30">
							${plant.cpcplant }
						</td>
						<td>
							${plant.plantname }
						</td>
						<td>
							${plant.plantarea }
						</td>
						<td>
							${plant.plantaddtime }
						</td>
						<td>
							<a href="<%=basePath %>fertilizer!findByList.shtml?cpcplant=${plant.cpcplant}&oper=details">施肥 ${plant.fertilizer }</a>
						</td>
						<td>
							<a href="<%=basePath %>pesticide!findByList.shtml?cpcplant=${plant.cpcplant}&oper=details">农药 ${plant.pesticide }</a>
						</td>
						<td>
							<a href="<%=basePath %>med!findByCpcPlant.shtml?cpcplant=${plant.cpcplant}">收获 ${plant.med }</a>
						</td>
						<td>
							<c:if
								test="${plant.fertilizer == 0 && plant.pesticide == 0 && plant.med == 0 }"
								var="flag">
								<a href="<%=basePath %>plant!updateInit.shtml?cpcplant=${plant.cpcplant}" class="btn-edit">更新</a>
							</c:if>
							<c:if test="${!flag}">
								<a href="<%=basePath %>plant!findDetails.shtml?cpcplant=${plant.cpcplant}&oper=details" class="btn-look">详细</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>

			<div class="page">
				<cite>
				<pg:pager url="plant!findByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="plantname" value="${requestScope.plantname }" />
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
			$("#plantname").val($.trim($("#plantname").val()));
			if(checkquotmarks($("#plantname").val())){
				$("#plantname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","plant!findByList.shtml");
			$("#searchform").submit();
		}
		cMenu(0,0);
	</script>
	</body>
</html>
