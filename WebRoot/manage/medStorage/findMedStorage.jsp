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
		<link type="text/css" rel="stylesheet" href="/style/production.css">	
	</head>
	
	<body>
	<div id="body">
    	<div class="cur-pos">
			当前位置：库存管理 &gt; 库存查询
		</div>
<%--		<div class="seh-box">--%>
<%--			<form action="" method="post" id="searchform" name="searchform">--%>
<%--				请输入品名查询：<input maxlength="20" type="text" value="${medname}" class="inp" size="40" id="medname" name="medname">--%>
<%--				<input type="button" value="查询" class="sch" onclick="return checkForm();">--%>
<%--							--%>
<%--			</form>--%>
<%--		</div>--%>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						批次号
					</td>
					<td>
						品名
					</td>
					<td>
						库存量(Kg)
					</td>
					<td>
						入库时间
					</td>
					<td>
						是否检验
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${list}" var="item">
					<tr class="lb-list">
						<td height="30">
						    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${item.cpcmed }${initParam.batchcpc_med}');">${item.cpcmed }</a>
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
								未检验
							</c:if>
							<c:if test="${!flag}" >
								<span class="green">已检验</span>
							</c:if>
						</td>
						<td>
							<c:if test="${flag}">
								<a href="<%=basePath%>manage/check/medCheck.jsp?medstorid=${item.medstorid }&cpcmed=${item.cpcmed}&medname=${item.medname}&medweight=${item.medweight/10000}&flag=2&checkmattype=0&harvesttime=${item.harvesttime }&medstate=1" class="btn-test">进入检验</a>
							</c:if>
							<c:if test="${!flag}" >
								<a href="<%=basePath%>check!findByCheckDetail.shtml?medstorid=${item.medstorid }&type=0&harvesttime=${item.harvesttime }" class="btn-look">查询检验</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>

			<div class="page">
				<cite>
				<pg:pager url="medStorage!findMedStorage.shtml"
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
	
	<div class="form-box">
	<div class="fb-bom">
			<c:if test="${requestScope.totalweight>'0'}">
			<b style="font-size:14px; height:32px;  line-height:32px;  padding-left:10px; font-weight:bold;">	
			该批次溯源秤已销售重量：${requestScope.totalweight/10000} Kg
			</b>
			</c:if>
        	<cite class="gray"><input type="button" value="返回查询" class="sbt" onclick="goBack();"></cite>
    </div>
    </div>
         
	</div>
	
        	
   
    
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		cMenu(2,0);
		function goToCheck (medid,cpcmed,medname,medweight){
			window.location.href = "<%=basePath%>manage/check/medCheck.jsp?medstorid="+medstorid
			+"&cpcmed="+cpcmed+"&medname="+medname+"&medweight="+medweight;
		}
		
		function goToSearch (cpcmed){
			window.location.href = "<%=basePath%>check!findByCheckDetail.shtml?cpcmed="+cpcmed;
		}
		function goBack(){
			window.location.href = "<%=basePath%>medStorage!findMedGroupStorage.shtml";		
		}
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medStorage!findMedStorage.shtml");
			$("#searchform").submit();
		}
	</script>
	</body>
</html>

