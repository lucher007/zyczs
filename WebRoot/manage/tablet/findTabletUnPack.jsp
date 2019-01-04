<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">		
<head>
<base href="<%=basePath%>" />    
<title>未检验饮片查询</title>   
<link type="text/css" rel="stylesheet" href="/style/user.css"/> 	  
</head>
<body>
    <div class="cur-pos">当前位置：饮片生产管理 >饮片检验</div>
    <div class="seh-box">
        <form action="" method="post" name="searchform" id="searchform">
        <input type="hidden" name="cpctablet" id="cpctablet" />
        <input type="hidden" name="tabletid" id="tabletid" />
        
        <table cellpadding="0" cellspacing="0" width="700" >
  			<tr>
  				<td width="110">输入品名或批次号：</td>
  				<td><input type="text" name="tabletname" id="tabletname" size="45" maxlength="50" value="${requestScope.tabletname}" class="inp"/></td>				
  				<td>&nbsp;</td>
  				<td><input type="button" value="查询" class="btn" onclick="return findByList();"/></td>
  				<td></td>
  			</tr> 				 		
  		</table>
        </form>
    </div>
    
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>饮片品名</td>
            <td>生产批次号</td>
            <td>内部批次号</td>          
            <td>生产时间</td>
            <td>生产重量(Kg)</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.tabletlist}" var="tabletlist">
	  	  <tr class="lb-list">
	  		<td width="10%">${tabletlist.tabletname }</td>
	  		<td width="30%">
	  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletlist.cpctablet }${initParam.batchcpc_tablet}');">${tabletlist.cpctablet }</a>
	  		</td>
	  		<td width="20%">${tabletlist.tabletnumber }</td>
	  		<td width="20%">${fn:substring(tabletlist.createtime, 0, 11)}</td>
	  		<td width="10%">${tabletlist.tabletweight/1000 }</td>  		
	  		<td width="10%"><input type="button" value="分包" onclick="return findById('${tabletlist.tabletid}');"/></td>
	  	  </tr>
  		  </c:forEach>
        </table>
        <div class="page">
        	<cite>
				<pg:pager
				    url="tablet!findByListPack.shtml"
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
					<pg:param name="tabletname" value="${requestScope.tabletname }"/>
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
        
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript">
        function findByList(){
			document.searchform.action="tablet!findByListPack.shtml"
			document.searchform.submit();
		}	
		
		function findById(id){		
			$("#tabletid").val(id);
			document.searchform.action="tablet!findById_pack.shtml"
			document.searchform.submit();
		}
    </script>
        
</body>
</html>