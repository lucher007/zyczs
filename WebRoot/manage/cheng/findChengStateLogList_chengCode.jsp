<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head> 
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>状态变化详情</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
		<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
			<div class="cur-pos">当前位置：市场管理 > 溯源秤管理</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤管理</div>
		</c:if>
		<div class="form-box">
	    	<form action="" method="post" name="searchform" id="searchform">
	    	<div class="fb-tit">状态变化详情</div>
	        <div class="fb-con">
                <table id="source" width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		           <tr class="lb-tit">
		            <td>溯源秤编号</td>
		            <td>时间</td>
		            <td>状态</td>
		          </tr>
		          <c:forEach items="${requestScope.chengList}" var="dataList">
		          <tr class="lb-list">
		            <td width="100" height="30">${dataList.chengcode }&nbsp;</td>
		            <td >${fn:substring(dataList.addtime, 0, 19)}&nbsp;</td>
		            <td>
		            	<c:if test="${dataList.state=='1'}">已开机</c:if>
		            	<c:if test="${dataList.state=='2'}">交易中</c:if>
		            	<c:if test="${dataList.state=='3'}">未连接</c:if>
					</td>
		          </tr>
		          </c:forEach>
		        </table>
		        
		        <div class="page">
					<cite>
					<pg:pager url="cheng!findChengStateLogByList_chengCode.shtml"
						items="${requestScope.pager_count}" index="center" maxPageItems="10"
						maxIndexPages="5" isOffset="<%=true%>"
						export="offset,currentPageNumber=pageNumber" scope="request">
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="chengcode" value="${requestScope.chengcode }" />
						<pg:param name="opertype" value="${requestScope.opertype }" />
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
	            <input type="button" value="返回上一页" onclick="javascript:goBack();" class="sbt"/>
	        </div>
	        </form>
	     </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	    function goBack(){
	   		if(0=='${opertype}'){
	    		window.location.href="<%=basePath%>manage/map/findOrgCheng.jsp";
	    	}else{
		        $("#searchform").attr("action","cheng!findByList.shtml");
				$("#searchform").submit();
			}
	    }
	</script>
	</body>
</html>
 