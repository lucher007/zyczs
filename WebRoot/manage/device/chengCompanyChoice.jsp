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
		<title>选择单位名称</title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    <div class="seh-box">
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/device!chengCompanyChoice.shtml" method="post">
	        <input type="hidden" id="cardtype" name="cardtype" value="${requestScope.cardtype}"/>
	        <table cellpadding="0" cellspacing="0" width="100%" border="0">
	  			<tr>
	  				<td width="80">单位名称：</td>
	  				<td><input type="text" maxlength="20" class="inp" size="45" name="corpname" id="corpname" value="${corpname}" /></td>
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
	            <td>单位名称</td>         
	            <td>单位CPC</td> 
	            <td>所属市场名称</td> 
	            <td>联系电话</td>      
	          </tr>
	          <c:forEach items="${requestScope.orgList}" var="list">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="${list.orgid }">
	            <input type="hidden" id="name_${list.orgid }" value="${list.orgname }" >
	            <input type="hidden" id="cpc_${list.orgid }" value="${list.cpccorp }" >	
	            <input type="hidden" id="marketname_${list.orgid }" value="${list.marketname }" >	
	            <input type="hidden" id="telephone_${list.orgid }" value="${list.telephone }" >		
	            </td>
	            <td>${list.orgname }&nbsp;</td>
	            <td>${list.cpccorp }&nbsp;</td>   
	            <td>${list.marketname }&nbsp;</td> 
	            <td>${list.telephone }&nbsp;</td>                 
	          </tr>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="device!chengCompanyChoice.shtml"
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
					<pg:param name="corpname" value="${requestScope.corpname }"/>											  			
					<pg:param name="cardtype" value="${requestScope.cardtype }"/>	
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
		$("#corpname").val($.trim($("#corpname").val()));
		if(checkquotmarks($("#corpname").val())){
			$("#corpname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").submit();
	}
	
	
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(5);
		selArray[0]=t;
		selArray[1]=$("#name_"+t).val();
		selArray[2]=$("#cpc_"+t).val();
		selArray[3]=$("#marketname_"+t).val();
		selArray[4]=$("#telephone_"+t).val();
		parent.closeChengCompanyDG(selArray);
	});
	</script>
	</body>
</html>

