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
	    <div class="seh-box">
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/tabletBase!tabletBaseChoice.shtml" method="post">
	        <table cellpadding="0" cellspacing="0" width="100%" border="0">
	  			<tr>
	  				<td width="80">饮片名称：</td>
	  				<td><input type="text" maxlength="20" class="inp" size="45" name="mcontent" id="mcontent" value="${mcontent}" /></td>
	  				<td width="80">&nbsp;</td>
	  						
	  				<td><input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
	  				<td></td>
	  			</tr>
	 			 		
	  		</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td width="60">选择</td>
	            <td>饮片名称</td>         
	            <td>饮片编码</td> 
	            <td>英文名称</td>      
	          </tr>
	          <c:forEach items="${requestScope.list}" var="list">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="${list.id }">
	            <input type="hidden" id="name_${list.id }" value="${list.name }" >
	            <input type="hidden" id="keyword_${list.id }" value="${list.keyword }" >	
	            <input type="hidden" id="sourceid_${list.id }" value="${list.sourceid }" >		
	            </td>
	            <td>${list.name }&nbsp;</td>
	            <td width="100">${list.sourceid }&nbsp;</td>   
	            <td>${list.keyword }&nbsp;</td>                 
	          </tr>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="tabletBase!tabletBaseChoice.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="5"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="plantname" value="${requestScope.name }"/>											  			
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
	function checkForm(){
		$("#mcontent").val($.trim($("#mcontent").val()));
		if(checkquotmarks($("#mcontent").val())){
			$("#mcontent").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").submit();
	}
	
	
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(3);
		selArray[0]=t;
		selArray[1]=$("#name_"+t).val();
		selArray[2]=$("#sourceid_"+t).val();
		parent.closeDG(selArray);
	});
	</script>
	</body>
</html>

