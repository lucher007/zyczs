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
		<title>选择原药材</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/tabletStorage!showBoxList.shtml" method="post">
	        <input type="hidden" name="packcode" value="${requestScope.packcode }"/>
	        </form>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>包装规格(g/包)</td>    
	            <td>包数</td>  
	            <td>饮片重量(g)</td>  
	          </tr>
	          <c:forEach items="${requestScope.tabletStoragelist}" var="storlist">
	          <tr class="lb-list">
	            
	            <td height="25">${storlist.tabletname }&nbsp;</td>
	            <td>${storlist.cpctablet }&nbsp;</td>
	            <td width="100">${storlist.tabletnumweight/10 }&nbsp;</td> 
	            <td>${storlist.boxitemnum }&nbsp;</td>  
	            <td width="100">${storlist.boxweight/10 }&nbsp;</td>     
	          </tr>
	         </c:forEach>     
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
				    url="tabletStorage!showBoxList.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="8"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="packcode" value="${requestScope.packcode }"/>									  			
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	
	</script>
	</body>
</html>

