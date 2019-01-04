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
		<title>市场平面图管理</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">
			当前位置：市场平面图管理 > 市场平面图列表
		</div>
		<div class="seh-box">
			<cite><a href="<%=basePath %>manage/marketmap/addMarketMap.jsp?cpccorp=${cpccorp }" class="btn-a"><span class="new">新建市场区域</span>
			</a> </cite>
			<form id="searchform"  action="" method="post" name="myform">
				请输入市场区域名查询：<input maxlength="20" type="text" value="${area}" class="inp" size="40" id="area" name="area">
				<input type="hidden" id="cpccorp" name="cpccorp" value="${cpccorp }" />
				<input type="button" value="查询" class="sch" onclick="return checkForm();">
			</form>
		</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						市场名称(楼)
					</td>
					<td>
						市场名称(区)
					</td>
					<!-- 
					<td>
						市场区域楼层编号
					</td>
					 -->
					<td>
						市场cpc
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${list}" var="item">
					<tr class="lb-list">
						<td height="30">
						    ${item.area }
						</td>
						<td>
							${item.floor }
						</td>
						<!-- 
						<td>
							${item.areanum }-${item.floornum}
						</td>
						 -->
						<td>
							${item.cpccorp }
						</td>
						<td>
							<a href="javascript:uploadMarketMap(${item.id },'${item.area }','${item.floor}','${item.cpccorp }');" class="btn-test">设置平面图</a>
							<a href="javascript:delMarketMap(${item.id });" class="btn-test">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>

			<div class="page">
				<cite>
				<pg:pager url="marketMap!findByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="area" value="${requestScope.area }" />
					<pg:param name="cpccorp" value="${requestScope.cpccorp }" />
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
			$("#area").val($.trim($("#area").val()));
			if(checkquotmarks($("#area").val())){
				$("#area").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","marketMap!findByList.shtml");
			$("#searchform").submit();
		}
		
		function uploadMarketMap(id,area,floor,cpccorp){
			window.location.href = "<%=basePath%>manage/marketmap/uploadMarketMap.jsp?id="+id+"&area="+area+"&floor="+floor+"&cpccorp="+cpccorp;
		}
		cMenu(0,0);
		
		
		function delMarketMap(id){
			$.dialog.confirm('确认是否删除？',function(){ 
					$("#searchform").attr("action", "marketMap!delMarketMap.shtml?id="+id);
					$("#searchform").submit();
			}, function(){
						});
		}
	</script>
	</body>
</html>
