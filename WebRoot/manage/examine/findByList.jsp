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
			当前位置：绩效考核 > 地区企业数量列表
		</div>
		<form action=""  method="post" name="searchform" id="searchform">
		<div class="seh-box">
			区县名称：<input type="text" value="${requestScope.areas }" class="inp" id="areas" name="areas" maxlength="40"> 
	        <input type="button" value="查询" class="sch" onclick="return checkForm();">
	        
	        <cite><a href="manage/examine/addexamine.jsp" class="btn-a"><span class="new">新增地区</span></a></cite>
	        
	    	</form>
    	</div>
		</form>
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						地区编号
					</td>
					<td>
						区县名称
					</td>
					<td>
						种植基<br>地数量
					</td>
						
					<td>
						中药材经销<br>企业数量
					</td>
					<td>
						专业市场经<br>营企业数量
					</td>
					<td>
						饮片生产<br>企业数量
					</td>
					<td>
						饮片经销<br>企业数量
					</td>
					<td>
						饮片使用<br>单位数量
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${requestScope.list}" var="list">
					<tr class="lb-list">
						<td height="30">
							${list.areacode }&nbsp;
						</td>
						<td>
							${list.areas }&nbsp;
						</td>
						<td>						
							${list.medcount }&nbsp;
						</td>						
						<td>
							${list.medsellcount }&nbsp;
						</td>
						<td>
							${list.medmarketcount }&nbsp;
						</td>
						<td>
							${list.tabletcount }&nbsp;
						</td>
						<td>
							${list.tabletsellcount }&nbsp;
						</td>
						<td>
							${list.tablethospcount }&nbsp;
						</td>
						<td>
							<a href="<%=basePath %>examine!findById.shtml?id=${list.id}" class="btn-edit">修改</a>
							<a href="<%=basePath %>examine!deleteObject.shtml?id=${list.id}" onclick="return confirm('确认要删除吗?');" class="btn-del">删除</a>
						</td>
									
					</tr>
				</c:forEach>
			</table>
			
			<div class="page">
				<cite>
				<pg:pager url="examine!findByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="areas" value="${requestScope.areas }" />
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
			$("#areas").val($.trim($("#areas").val()));
			if(checkquotmarks($("#areas").val())){
				$("#areas").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","examine!findByList.shtml");
			$("#searchform").submit();
		}
	</script>	
	
	</body>
</html>
