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
		<title>经营户统计</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css"/>
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析 > 经营户统计</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	              经营户市场编号、溯源编号或名称： <input maxlength="20" type="text" name="mcontent" id="mcontent" value="${requestScope.mcontent }" class="inp" size="40"/>
				&nbsp;
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>经营户市场编号</td>
	            <td>溯源编号</td>
	            <td>经营户名称</td>
	            <td>法人</td>
	            <td>进货量(Kg)</td>
	            <td>销售量(Kg)</td>
	           
	          </tr>
	          <c:forEach items="${requestScope.orglist}" var="orglist">
			  	  <tr class="lb-list">
			  		<td width="15%" height="30">${orglist.businessnumber }&nbsp;</td>
			  		<td width="15%">${orglist.cpccorp }&nbsp;</td>
			  		<td width="25%">${orglist.orgname}&nbsp;</td>
			  		<td width="10%">${orglist.masterman}&nbsp;</td>
			  		<c:choose>
			  			<c:when test="${orglist.intotalweight == null}">
			  				<td>--</td>
			  			</c:when>
			  			<c:otherwise>
					  		<td width="10%">${orglist.intotalweight }</td>
			  			</c:otherwise>
			  		</c:choose>
			  		<c:choose>
			  			<c:when test="${orglist.outtotalweight == null}">
			  				<td>--</td>
			  			</c:when>
			  			<c:otherwise>
					  		<td width="10%">${orglist.outtotalweight }</td>
			  			</c:otherwise>
			  		</c:choose>
			  		
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="org!findByMedmarketUserStat.shtml"
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
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#mcontent").val($.trim($("#mcontent").val()));
			if(checkquotmarks($("#mcontent").val())){
				$("#mcontent").focus();
				$.dialog.tips('不能包含~ # *等字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","org!findByMedmarketUserStat.shtml");
			$("#searchform").submit();
		}
    </script>   
	</body>
</html>
 