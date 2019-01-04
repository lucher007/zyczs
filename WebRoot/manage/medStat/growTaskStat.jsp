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
		<title>种植任务统计</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
    	<div class="cur-pos">当前位置：统计分析  &gt; 种植任务统计</div>
    	<div class="seh-box">
        <form action="" method="post" name="searchform" id="searchform">
                         种子植物名： <input maxlength="20" type="text" name="plantname" id="plantname" value="${requestScope.plantname }" class="inp w120"/>
		    状态：<select name="state" id="state" >
			<c:if test="${state == 0}">
				<option value="">全部</option>
				<option value="0" selected="selected">进行中</option>
				<option value="1" >已完成</option>
			</c:if>
			<c:if test="${state == 1}">
				<option value="">全部</option>
				<option value="0" >进行中</option>
				<option value="1" selected="selected">已完成</option>
			</c:if>
			<c:if test="${state != 1 && state != 0}">
				<option value=""  selected="selected">全部</option>
				<option value="0">进行中</option>
				<option value="1" >已完成</option>
			</c:if>
		</select>&nbsp;
		种植时间： 从
		<input type="text" name="plantaddtime" id="plantaddtime" value="${fn:substring(plantaddtime,0,11)}" class="Wdate inp w80" 
		onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'plantendtime\');}'});">
		&nbsp;
		到
		<input type="text" name="plantendtime" id="plantendtime" value="${fn:substring(plantendtime,0,11)}" class="Wdate inp w80" 
		onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'plantaddtime\');}'});">
		&nbsp;
        <input type="button" value="查询" class="sch" onclick="return checkForm();">
        <input type="hidden" name="plantid" id="plantid">
        </form>
    </div>
    
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>种子植物名</td>
            <td>批次码</td>
            <td>种植时间</td>
            <td>完成时间</td>
            <td>种植负责人</td>
            <td>状态</td>
          </tr>
          <c:forEach items="${requestScope.medStatlist}" var="medStatlist">
	  	  <tr class="lb-list">
	  	    <td height="30">${medStatlist.plantname }</td>
	  		<td>
		    	${(medStatlist.plantnumber==null || medStatlist.plantnumber=='')?'无':medStatlist.plantnumber }
		    </td>
		    <td width="10%">${fn:substring(medStatlist.plantaddtime, 0, 11)} </td>
	  		<td>
	  		    <c:if test="${medStatlist.state == 1 }">
			  		${fn:substring(medStatlist.plantendtime, 0, 11)}
  				</c:if>
  				 <c:if test="${medStatlist.state == 0 }">
			  		--
  				</c:if>
	  		</td>
	  		<td> ${medStatlist.plantusername }</td>
	  		<td>
	  		    <c:if test="${medStatlist.state == 0 }">
  					<span class="green">进行中</span>
  				</c:if>
 				<c:if test="${medStatlist.state == 1 }">
  					<span class="gray">已完成</span>
  				</c:if>
            </td>
	  	  </tr>
  		  </c:forEach>
        </table>
        <div class="page">
        	<cite>
				<pg:pager
				    url="medStat!getGrowTaskStat.shtml"
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
					<pg:param name="plantname" value="${requestScope.plantname }"/>
					<pg:param name="state" value="${requestScope.state }"/>
					<pg:param name="plantaddtime" value="${requestScope.plantaddtime }"/>
					<pg:param name="plantendtime" value="${requestScope.plantendtime }"/>
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
			$("#plantname").val($.trim($("#plantname").val()));
			if(checkquotmarks($("#plantname").val())){
				$("#plantname").focus();
				$.dialog.tips('植物名不能包含~ # *等字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medStat!getGrowTaskStat.shtml");
			$("#searchform").submit();
		}
    </script>
</body>
</html>
 