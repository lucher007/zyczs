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
		<title>选择采购企业</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body style="width:550px; padding:0;" >
	<div id="body">
	    
	    <input type="hidden" name="orgid" value="${requestScope.orgid}">
	    
	    <c:if test="${fn:length(requestScope.otherCompList)>0}">
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td width="60">选择</td>
	            <td>企业名称</td>         
	            <td>联系电话</td> 	            
	            <td>最后采购时间</td>      
	          </tr>
	          <%int key=1; %>
	          <c:forEach items="${requestScope.otherCompList}" var="list">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="<%=key%>">
	            <input type="hidden" id="corpnameother_<%=key%>" value="${list.corpnameother }" >
	            <input type="hidden" id="mobileother_<%=key%>" value="${list.mobileother }" >
	            <input type="hidden" id="addressother_<%=key%>" value="${list.addressother }" >			            		
	            </td>
	            <td>${list.corpnameother }&nbsp;</td>
	            <td width="100">${list.mobileother }&nbsp;</td>
	            <td>${fn:substring(list.opersystime, 0, 19)}&nbsp;</td>                    
	          </tr>
	          <%key++; %>
	         </c:forEach>           
	        </table>
         	<div class="page">
        		<cite>
            		<pg:pager
				    url="tabletSellInOut!companyOtherChoice.shtml"
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
					<pg:param name="orgid" value="${requestScope.orgid }"/>								  			
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
		
		<c:if test="${fn:length(requestScope.otherCompList)<=0}">	
	    	<div class="fb-msg" style="padding:0px; width:100%; text-align:center;">
	     	<img src="<%=basePath%>images/frame/Warning.png">
	     	<b class="green" id="returninfo_lastcheck">没有查询到记录...</b>
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
		var selArray=new Array(4);
		selArray[0]=t;
		selArray[1]=$("#corpnameother_"+t).val();
		selArray[2]=$("#mobileother_"+t).val();
		selArray[3]=$("#addressother_"+t).val();
		parent.closeDG(selArray);
	});
	</script>
	</body>
</html>

