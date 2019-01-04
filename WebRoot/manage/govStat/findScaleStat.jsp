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
		<title>设备统计</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>溯源秤号</td>
	            <td>溯源秤规格</td>         
	            <td>添加日期</td> 
	            <td>持有机构</td>  
	            <td>设备状态</td>    
	          </tr>
	          <c:forEach items="${requestScope.govmentstatlist}" var="list">
	          <tr class="lb-list">
	            <td height="30">${list.scalecode }&nbsp;</td>
	            <td>${list.scalenorm }&nbsp;</td>   
	            <td>${fn:substring(list.addtime, 0, 11)}&nbsp;</td>  
	            <td>${list.corpname }&nbsp;</td> 
	            <td>${list.scalestate == 0 ? '可用' : '不可用' }&nbsp;</td>               
	          </tr>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="govmentStat!getScaleStat.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="10"
				    maxIndexPages="10"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="province" value="${requestScope.province }"/>
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
		
		$("#sourceid").val($.trim($("#sourceid").val()));
		if(checkquotmarks($("#sourceid").val())){
			$("#sourceid").focus();
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
		if (parent.closeDG2 != undefined)
		{	
			var PLU = $("#plu_"+obj.value).val();
			parent.closeDG2(selArray,PLU,parent.document.getElementById('backOBJ').value);
		}
		else
		{
			parent.closeDG(selArray);
		}
	});
	</script>
	</body>
</html>

