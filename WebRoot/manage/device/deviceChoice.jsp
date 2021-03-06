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
		<title>选择设备</title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
		<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    <div class="seh-box">
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/device!deviceChoice.shtml" method="post">
	        <input type="hidden" id="devicetype" name="devicetype" value="${devicetype}"/>
	        <input type="hidden" id="cpccorp" name="cpccorp" value="${cpccorp}"/>
	        <table cellpadding="0" cellspacing="0" width="100%" border="0">
	  			<tr>
	  				<td width="80">设备编号：</td>
	  				<td><input type="text" maxlength="20" class="inp" size="45" name="devicecode" id="devicecode" value="${devicecode}" /></td>
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
	            <td>设备编号</td>
	            <td>规格名称</td>
	            <td>发放原因</td>
	            <td>备注信息</td>
	          </tr>
	          <c:forEach items="${requestScope.deviceList}" var="list">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="${list.deviceid }">
	            <input type="hidden" id="code_${list.deviceid }" value="${list.devicecode }" >
	            <input type="hidden" id="normname_${list.deviceid }" value="${list.normname }" >	
	            </td>
	            <td>${list.devicecode }&nbsp;</td>
	            <td class="remarkClass" title="${list.normname }">${fn:substring(list.normname, 0, 10)}&nbsp;</td>
	            <td>
	            	<c:if test="${list.reason=='1'}">初次发放</c:if>
	            	<c:if test="${list.reason=='2'}">维修</c:if>
	            	<c:if test="${list.reason=='3'}">更换</c:if>
	            	<c:if test="${list.reason=='4'}">回收</c:if>
				</td>  
	            <td class="remarkClass" title="${list.remark }">${fn:substring(list.remark, 0, 10)}&nbsp;</td>                
	          </tr>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="device!deviceChoice.shtml"
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
					<pg:param name="devicetype" value="${requestScope.devicetype }"/>
					<pg:param name="cpccorp" value="${requestScope.cpccorp }"/>
					<pg:param name="devicecode" value="${requestScope.devicecode }"/>											  			
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script type="text/javascript">
	function checkForm(){
		$("#devicecode").val($.trim($("#devicecode").val()));
		if(checkquotmarks($("#devicecode").val())){
			$("#devicecode").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").submit();
	}
	
	
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(3);
		selArray[0]=t;
		selArray[1]=$("#code_"+t).val();
		selArray[2]=$("#normname_"+t).val();
		parent.closeDeviceDG(selArray);
	});
	</script>
	</body>
</html>

