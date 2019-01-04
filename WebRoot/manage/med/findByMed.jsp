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
    	<title>收获管理</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
  	</head>
  
  	<body>
  	<div id="body">
  		<div class="cur-pos">
			当前位置：种植管理 &gt; 收获管理
		</div>
		<div class="seh-box">
			<cite><a href="<%=basePath %>plant!initHarverstMed.shtml?cpcplant=${cpcplant }" class="btn-a"><span class="new">新建收获操作</span>
			</a> </cite>
			<span>种子种苗植物名：${plant.plantname}&nbsp;种植批次号：${plant.cpcplant}&nbsp种植时间：${plant.plantaddtime}</span>
			<form action="<%=basePath %>med!findByCpcPlant.shtml" method="post" name="myform">
			</form>
		</div>
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>预计产出药材</td>
					<td>预计产量总计(kg)</td>
				</tr>
				<c:forEach items="${requestScope.plantlist}" var="plant">
		  		<tr  class="lb-list">
		  			<td height="30">${plant.harvestmed }</td>
		  			<td>${plant.harvestwei}</td>
		  		</tr>
		  		</c:forEach>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="mt10">
				<tr class="lb-tit">
					<td>采收药材名称</td>
					<td>收获时间</td>
					<td>预计产量(kg)</td>	
					<td>实际产量(kg)</td>	
					<td>采收批次码</td>					
				</tr>
				<c:forEach items="${requestScope.medlist}" var="med">
		  		<tr class="lb-list">
		  			<td height="30">${med.medname }</td>
		  			<td>${med.harvesttime}</td>
					<td>${med.predictweight/10000 }</td>
					<td>${med.medweight/10000 }</td>
					<td>${med.cpcmed }</td>
		  		</tr>
		  		</c:forEach>
		  		<tr>
		  			<td height="40" colspan="5">
		  				<c:if test="${fn:length(medlist)>0}">
			  				若所有药材收获已完成，请
							<input type="button" value="关闭种植任务" onclick="makeSure('${plant.cpcplant}')" class="sbt">
						</c:if>
					</td>
		  		</tr>
			</table>
			<div class="page">
				<cite>
				<pg:pager
			    url="med!findByCpcPlant.shtml"
			    items="${requestScope.pager_count}"
			    index="center"
			    maxPageItems="9"
			    maxIndexPages="5"
			    isOffset="<%= true %>"
			    export="offset,currentPageNumber=pageNumber"
			    scope="request">			
				<pg:param name="index"/>
				<pg:param name="maxPageItems"/>
				<pg:param name="maxIndexPages"/>
				<pg:param name="medname" value="${requestScope.medname }"/>
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
    <script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
  	</body>
 </html>
 