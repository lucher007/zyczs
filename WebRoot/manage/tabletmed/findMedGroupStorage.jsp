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
		<base href="<%=basePath%>" target="_self">   
		<meta charset="utf-8">
		<title>库存查询</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
    	<div class="cur-pos">
			当前位置：库存管理 &gt; 库存查询
		</div>
		<div class="seh-box">
			<cite><a href="<%=basePath %>manage/tabletmed/medInStorage.jsp" class="btn-a"><span class="new">新建药材库存</span>
			</a> </cite>
			<form action="" method="post" id="searchform" name="searchform">
				请输入药材名称查询：<input maxlength="20" type="text" value="${medname}" class="inp" size="40" id="medname" name="medname">
				<input type="button" value="查询" class="sch" onclick="return checkForm();">
			</form>
		</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						品名
					</td>
					<td>
						批次号
					</td>
					<td>
						批次详情
					</td>
					<td>
						包装规格(Kg/包)
					</td>
					<td>
						库存量(Kg)
					</td>
				</tr>
				<c:forEach items="${list}" var="item">
					<tr class="lb-list">
						<td>
							${item.medname }
						</td>
						<td>
			            	${(item.mednumber==null || item.mednumber =='')?'无':item.mednumber }&nbsp;
			            </td>
						<td height="30">
						    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${item.cpcmed }${initParam.batchcpc_med}');" class="btn-look">查看</a>
						</td>
						<td>
				            <c:if test="${item.mednumweight == null || item.mednumweight == 0.0}" var="flag">
								未包装
							</c:if>
							<c:if test="${!flag}" >
								${item.mednumweight / 10000}&nbsp;
							</c:if>
						</td>   
						<td>
							${item.medweight / 10000 }
						</td>		
<!--						<td>-->
<!--							<a class="btn-look" href="<%=basePath %>medSell!findMedStorage.shtml?batchcpc=${item.cpcmed }">详情</a>-->
<!---->
<!--						</td>-->
					</tr>
				</c:forEach>
			</table>

			<div class="page">
				<cite>
				<pg:pager url="tabletMedStorage!findTabletMedStorage.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
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
		cMenu(0,0);
		
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('品名不能包含~ # *等字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletMedStorage!findTabletMedStorage.shtml");
			$("#searchform").submit();
		}
	</script>
	</body>
</html>
