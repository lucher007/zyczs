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
		<title>已检验饮片查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css"> 	  
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：饮片生产管理  &gt; 检验查询</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	                         输入品名：<input maxlength="50" type="text" name="tabletname" id="tabletname" value="${requestScope.tabletname}" size="45" class="inp"/>
	        <input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        <input type="hidden" name="tabletid" id="tabletid" />
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td>
	            <td>检验重量(Kg)</td>
	            <td>生产时间</td>
	            <td>详情</td> 
	          </tr>
	          <c:forEach items="${requestScope.tabletlist}" var="tabletlist">
		  	  <tr class="lb-list">
		  		<td height="30">${tabletlist.tabletname }</td>
		  		<td>
	            	${(tabletlist.tabletnumber==null || tabletlist.tabletnumber =='')?'无':tabletlist.tabletnumber }&nbsp;
	            </td>
		  		<td>
		  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletlist.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
		  		</td>
		  		<td>${tabletlist.tabletweight/10000 }</td>
		  		<td>${tabletlist.createtime}</td>
		  		<td><a href="<%=basePath%>check!findTabletByCheckDetail.shtml?tabletid=${tabletlist.tabletid }&type=1" class="btn-look">查看</a></td>
		  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tablet!findCheckedList.shtml"
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
				$("#searchform").attr("action","tablet!findCheckedList.shtml");
				$("#searchform").submit();
			}
			
	    </script>
	</div>        
	</body>
</html>
 