<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>未检验饮片查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css"> 	  
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：饮片生产管理 >饮片包装</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	        <input type="hidden" name="cpctablet" id="cpctablet">
	        <input type="hidden" name="tabletstorid" id="tabletstorid">
	        	输入品名：<input type="text" name="tabletname" id="tabletname" size="45" maxlength="50" value="${requestScope.tabletname}" class="inp">
				<input type="button" value="查询" class="sch" onclick="return checkForm();" />
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td>          
	            <td>入库时间</td>
	            <td>生产重量(Kg)</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.tabletStoragelist}" var="tabletStoragelist">
		  	   <tr class="lb-list">
		  		<td height="30">${tabletStoragelist.tabletname }</td>
		  		<td>
	            	${(tabletStoragelist.tablet.tabletnumber==null || tabletStoragelist.tablet.tabletnumber =='')?'无':tabletStoragelist.tablet.tabletnumber }&nbsp;
	            </td>
		  		<td>
		  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStoragelist.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
		  		</td>
		  		<td>${fn:substring(tabletStoragelist.addtime, 0, 11)}</td>
		  		<td>
		  		
		  		<c:set var="tabletweight" value="${tabletStoragelist.tabletweight}" scope="request" />
           		 <%
           		Object tabletweight=request.getAttribute("tabletweight");	
           		 %>   
                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000"))%>                
		  		</td>  		
		  		<td><a href="javascript:findById('${tabletStoragelist.tabletstorid}');" class="btn-bag">分包</a></td>
		  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tabletStorage!findByListUnPack.shtml"
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#tabletname").val($.trim($("#tabletname").val()));
			if(checkquotmarks($("#tabletname").val())){
				$("#tabletname").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletStorage!findByListUnPack.shtml");
			$("#searchform").submit();
		}
		
		function findById(id){		
			$("#tabletstorid").val(id);
			$("#searchform").attr("action","tabletStorage!findById_pack.shtml");
			$("#searchform").submit();
		}
    </script>
	</body>
</html>