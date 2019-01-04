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
		<title>库存查询</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：库存销售 &gt; 库存查询</div>
	    <div class="seh-box">
	    	<cite><a href="/manage/tabletsell/findInStorage.jsp" class="btn-a"><span class="out">新建饮片入库</span></a></cite>
	    	<form action="?" method="post" name="searchform">
	    	饮片批次码或品名:
	    	<input type="text"  name="mcontent" id="mcontent" value="${requestScope.mcontent}"  class="inp" size="45"> 
	    	<input type="submit" value="查询" class="sch">
	 		</form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>饮片品名</td>
	            <td>生产企业</td>
	            <td>生产批次号</td>
	            <td>包装规格(g/包)</td>
	            <td>库存量(Kg)</td>
	            <td>包数</td>
	            <td>每箱包数</td>
	            <td>箱数</td>
	          </tr>
	           
	  		  <c:forEach items="${requestScope.tabletStoragelist}" var="tabletStoragelist">
	          <tr class="lb-list">
	            <td height="30">${tabletStoragelist.tabletname }</td>
	            <td>${tabletStoragelist.org.orgname }</td>
	            <td>${tabletStoragelist.cpctablet }</td>
	            <td>${tabletStoragelist.tabletnumweight/10 }</td>
	            <td>${tabletStoragelist.tabletweight/10000 }</td>	            
	            <td>${tabletStoragelist.tabletnum }</td>
	            <td>${tabletStoragelist.tabletboxitemnum }</td>
	            <td>${tabletStoragelist.tabletboxnum }</td>
	          </tr>
	         </c:forEach>
	         
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tabletSell!findTabletStorage.shtml"
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
						<pg:param name="mcontent" value="${requestScope.mcontent }"/>
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
							<a href="<%=pageUrl %>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
						  	<a href="<%= prevPageUrl %>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
			   				<%if (pageNumber == currentPageNumber) { 
						        %><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a><%
						      } else { 
						        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
						      }
						    %>  
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
						  	<a href="<%= nextPageUrl %>" title="下一页" class="next">&nbsp;</a>
						</pg:next>
						<pg:last>
						  	<a href="<%=pageUrl %>">末页</a>
						</pg:last>
						</pg:index>
				  	</pg:pager>
			  	</cite>
	        </div>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	//控制搜索词效果
	//inp(".seh-box .inp",'请输入饮片批次码或品名查询');
	
	function findByList()
	{
		$("#searchform").attr("action","tabletSell!findTabletStorage.shtml");
		$("#searchform").submit();
	}
	</script>
	</body>
</html>