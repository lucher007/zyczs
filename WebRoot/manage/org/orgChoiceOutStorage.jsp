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
	
	<body style="width:550px; padding:0;">
	<div id="body">
	        
	    <div class="seh-box">
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/org!chooseOrg.shtml" method="post">
	        <table cellpadding="0" cellspacing="0">
	        <tr>
	        	<td align="right">企业名称：</td><td><input type="text" value="${requestScope.corpname }" class="inp" id="corpname" name="corpname" maxlength="30"></td>
	        	<td>&nbsp;</td>
	        	<td align="right">企业CPC：</td><td><input type="text" value="${requestScope.cpccorp }" class="inp" id="cpccorp" name="cpccorp" maxlength="14" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
	        </tr>
			</table>
	        </form>
	    </div>
	        
	    <c:if test="${fn:length(requestScope.orglist)>0}">
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td width="60">选择</td>
	            <td>单位名称</td>         
	            <td>单位CPC</td> 
	          </tr>
	          <c:forEach items="${requestScope.orglist}" var="list" varStatus="vs">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="${vs.index }">
	            <input type="hidden" id="name_${vs.index }" value="${list.orgname }" >
	            <input type="hidden" id="cpc_${vs.index }" value="${list.cpccorp }" >
	            </td>
	            <td>${list.orgname }&nbsp;</td>
	            <td>${list.cpccorp }&nbsp;</td>   
	          </tr>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="org!chooseOrg.shtml"
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
					<pg:param name="cpccorp" value="${requestScope.cpccorp }"/>
					
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
		</c:if>
		
		<c:if test="${fn:length(requestScope.orglist)<=0}">	
	    	<div class="fb-msg" style="padding:0px; width:100%; text-align:center;">
	     	<img src="<%=basePath%>images/frame/Warning.png">
	     	<b class="green" id="returninfo_lastcheck">${returninfo}</b>
	     	<b>请联系：028-87026099&nbsp;&nbsp;&nbsp;&nbsp;400-0931-981</b>
	    	</div>        
		</c:if>
		
	</div>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(3);
		selArray[0]=t;
		selArray[1]=$("#name_"+t).val();
		selArray[2]=$("#cpc_"+t).val();
		parent.closeDG(selArray);
	});

	function checkForm(){
		$("#corpname").val($.trim($("#corpname").val()));
		if(checkquotmarks($("#corpname").val())){
			$("#corpname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","org!chooseOrg.shtml");
		$("#searchform").submit();
	}

	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	}
	</script>
	</body>
</html>

