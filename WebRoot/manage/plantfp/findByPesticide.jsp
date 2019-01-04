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
    	<base href="<%=basePath%>" >    
    	<title>农药管理</title>    	
     	<link type="text/css" rel="stylesheet" href="/style/plant.css">
  	</head>
  
  	<body>
  	<div id="body">
  		<div class="cur-pos">
			当前位置：种植管理 > 农药管理
		</div>
		<span>种子种苗植物名：${plant.plantname}&nbsp; &nbsp;种植批次号：${plant.cpcplant}&nbsp;&nbsp;种植时间：${plant.plantaddtime}</span>
		<div class="seh-box">
			<c:if test="${requestScope.oper=='details'}">
			<cite><a href="<%=basePath %>pesticide!saveInit.shtml?cpcplant=${plant.cpcplant }&oper=details" class="btn-a"><span class="new">新建农药操作</span>
			</a> </cite>
			</c:if>
			<form action="" method="post" id="searchform" name="myform">
				<input type="hidden" name="oper" id="oper" value="${requestScope.oper }"/>
				请输入农药种类查询：<input type="text" value="${pesticidename}" class="inp" size="40" id="pesticidename" name="pesticidename">
				<input type="button" value="查询" class="sch" onclick="return checkForm();">
				<input type="hidden"  value="${plant.cpcplant}" name="cpcplant"/> 
			</form>
		</div>
		
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>农药种类</td>
					<td>施药时间</td>
					<td>农药重量(Kg)</td>					
				</tr>
				<c:forEach items="${requestScope.pesticidelist}" var="pesticide">
		  		<tr  class="lb-list">
		  			<td>${pesticide.pesticidename }&nbsp;</td>
		  			<td height="30">${pesticide.pesticidetime}&nbsp;</td>
					<td>${pesticide.pesticideweight/10000}&nbsp;</td>
		  		</tr>
		  		</c:forEach>
			</table>
			<div class="page">
				<cite>
				<pg:pager
			    url="pesticide!findByList.shtml"
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
				<pg:param name="pesticidename" value="${requestScope.pesticidename }"/>
				<pg:param name="cpcplant" value="${plant.cpcplant }"/>
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
  		cMenu(0,0);
		function checkForm(){
			$("#pesticidename").val($.trim($("#pesticidename").val()));
			if(checkquotmarks($("#pesticidename").val())){
				$("#pesticidename").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","pesticide!findByList.shtml");
			$("#searchform").submit();
		}
    </script>
  	</body>
</html>
 