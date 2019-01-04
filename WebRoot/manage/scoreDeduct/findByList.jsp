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
		<title>诚信评价</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：诚信评价 > 扣分详细</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	        	<cite><a class="btn-a" href="javascript:addscorededuct();"><span class="new">新建处罚</span></a></cite>
	        	<input type="hidden" name="orgid" id="orgid" value="${requestScope.orgid }" />
	        	<input type="hidden" name="addtime" id="addtime" value="${requestScope.addtime }" />
				处罚简述： <input maxlength="20" type="text" name="deductreason" id=deductreason value="${requestScope.deductreason }" class="inp w100"/>
				处罚类型：
				<select name="deducttype" id="deducttype">
					<option value="-1" <c:if test="${requestScope.deducttype=='-1' }">selected</c:if>>全部</option>
					<option value="1" <c:if test="${requestScope.deducttype=='1' }">selected</c:if>>投诉</option>
					<option value="2" <c:if test="${requestScope.deducttype=='2' }">selected</c:if>>质量问题</option>
					<option value="3" <c:if test="${requestScope.deducttype=='3' }">selected</c:if>>诚信检查</option>
				</select>
	        	<input type="button" value="查询" class="sch" onclick="checkForm();"/>
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>处罚类型</td>
	            <td>处罚分数</td>
	            <td>处罚简述</td>
	            <td>操作人员</td>
	            <td>处罚时间</td>
	          </tr>
	          <c:forEach items="${requestScope.scoredeductlist}" var="scoredeductlist">
			  	  <tr class="lb-list">
			  		<td height="30">
			  			<c:if test="${scoredeductlist.deducttype==1 }">投诉</c:if>
			  			<c:if test="${scoredeductlist.deducttype==2 }">质量问题</c:if>
			  			<c:if test="${scoredeductlist.deducttype==3 }">诚信检查</c:if>
			  		</td>
			  		<td>${scoredeductlist.score }</td>
			  		<td title="${scoredeductlist.deductreason }">${fn:substring(scoredeductlist.deductreason, 0, 15)}</td>
			  		<td>${scoredeductlist.deductoper }</td>
			  		<td>${fn:substring(scoredeductlist.addtime, 0, 11)}</td>
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="scoreDeduct!findByList.shtml"
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
						<pg:param name="deductreason" value="${requestScope.deductreason }"/>
						<pg:param name="deducttype" value="${requestScope.deducttype }"/>
						<pg:param name="orgid" value="${requestScope.orgid }"/>
						<pg:param name="addtime" value="${requestScope.addtime }"/>
						
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
			$("#deductreason").val($.trim($("#deductreason").val()));
			if(checkquotmarks($("#deductreason").val())){
				$("#deductreason").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","scoreDeduct!findByList.shtml");
			$("#searchform").submit();
		}
		function addscorededuct(){
			$("#searchform").attr("action","scoreDeduct!saveInit.shtml");
			$("#searchform").submit();
		}
    </script>   
	</body>
</html>
 