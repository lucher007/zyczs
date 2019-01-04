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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="/style/user.css">
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">

function update(scalecode,comlocked){
	var scale = document.getElementById("scalecode");
	scale.value=scalecode;
	$("#searchForm").attr("action", "scalesstat!update.shtml?comlocked="+comlocked);
	$("#searchForm").submit();
}

</script>
</head>

<body>
	<div class="cur-pos">当前位置：用户注册 > 用户管理</div>
    <div class="seh-box">
        <form action="scalesstat!findByList.shtml" method="post" id="searchForm" name="searchForm">
			组织名称：<input type="text" name="corpname" value="${requestScope.corpname }">
			溯源秤号：<input type="text" name="scalecode" id="scalecode" value="${requestScope.scalecode }">
        	<input type="submit" value="查询" class="sch">
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>溯源秤号</td>
            <td>企业代码</td>
            <td>组织名称</td>
            <td>plu的版本</td>
            <td>是否锁定</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.scalestatList}" var="dataList">
          <tr class="lb-list">
            <td width="100" height="30">${dataList.scalecode }</td>
            <td>${dataList.usercode }</td>
            <td>${dataList.corpname }</td>
            <td>${dataList.pluver }</td>
            <td>
            	<c:if test="${dataList.locked=='0' && dataList.locked==dataList.comlocked}">未锁定</c:if>　
            	<c:if test="${dataList.locked=='1' && dataList.locked==dataList.comlocked}">锁定</c:if>　
            	<c:if test="${dataList.locked=='0' && dataList.comlocked=='1'}">锁定中</c:if>　
            	<c:if test="${dataList.locked=='1' && dataList.comlocked=='0'}">解锁中</c:if>　
            </td>
            <td width="230">
            		<c:if test="${dataList.locked=='0' && dataList.locked==dataList.comlocked}"><a href="javascript:update('${dataList.scalecode }',1);">锁定</c:if>　
            		<c:if test="${dataList.locked=='1' && dataList.locked==dataList.comlocked}"><a href="javascript:update('${dataList.scalecode }',0);">解锁</c:if>　
            	</a> 
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scalesstat!findByList.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="10"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="username" value="${requestScope.username }"/>
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
						<a href="<%=pageUrl %>">首页</a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
					  	<a href="<%= prevPageUrl %>">前一页</a>
					</pg:prev>
					<pg:pages>
		   				<%if (pageNumber == currentPageNumber) { 
					        %><span style="font:bold 16px arial;"><%= pageNumber %></span><%
					      } else { 
					        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
					      }
					    %>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
					  	<a href="<%= nextPageUrl %>">下一页</a>
					</pg:next>
					<pg:last>
					  	<a href="<%=pageUrl %>">末页</a>
					</pg:last>
					</pg:index>
			  		</pg:pager>
            </cite>
        </div>
    </div>
</body>
</html>

