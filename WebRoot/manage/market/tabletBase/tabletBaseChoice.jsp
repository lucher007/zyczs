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
<base href="<%=basePath%>" target="_self" />   
<meta charset="utf-8">
<title>选择原药材</title>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
<link type="text/css" rel="stylesheet" href="/style/common.css" />
<link type="text/css" rel="stylesheet" href="/style/user.css">

<script type="text/javascript">


function selOK(obj){		
	var selArray=new Array(3);
	selArray[0]=obj.value;
	selArray[1]=$("#name_"+obj.value).val();
	selArray[2]=$("#sourceid_"+obj.value).val();
	window.returnValue=selArray;
    window.close();
}

</script>

</head>

<body>
	
    <div class="seh-box" style="width:580px;">
    	
        <form action="<%=request.getContextPath()%>/tabletBase!tabletBaseChoice.shtml" method="post">
        <table cellpadding="0" cellspacing="0" width="600" border="0">
  			<tr>
  				<td width="80">饮片名称：</td>
  				<td><input type="text" class="inp" name="name"  value="${requestScope.name }" /></td>
  				<td width="80">饮片编码：</td>
  				<td><input type="text" class="inp" name="sourceid"   value="${requestScope.sourceid }" /></td>				
  				<td><input type="submit" value="查询" class="btn"></td>
  				<td></td>
  			</tr>
 			 		
  		</table>
  		     
            
        </form>
    </div>
    
    <div class="lst-box">
    	<table width="600" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td width="60">选择</td>
            <td>饮片名称</td>         
            <td>饮片编码</td> 
            <td>英文名称</td>      
          </tr>
          <c:forEach items="${requestScope.list}" var="list">
          <tr class="lb-list">
            <td width="" height="30">
            <input type="radio"  name="_selKey"  value="${list.id }" onclick="selOK(this)" />
            <input type="hidden" id="name_${list.id }" value="${list.name }" >
            <input type="hidden" id="keyword_${list.id }" value="${list.keyword }" >	
            <input type="hidden" id="sourceid_${list.id }" value="${list.sourceid }" >		
            </td>
            <td>${list.name }</td>
            <td width="100">${list.sourceid }</td>   
            <td>${list.keyword }</td>                 
          </tr>
         </c:forEach>           
         
        </table>
        
        <div class="page">
        	<cite>
            	<pg:pager
				    url="tabletBase!tabletBaseChoice.shtml"
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
					<pg:param name="plantname" value="${requestScope.name }"/>
					<pg:param name="growsyscode" value="${requestScope.sourceid }"/>												  			
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
						<a href="<%=pageUrl %>">首页</a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
					  	<a href="<%= prevPageUrl %>">前一页</a>
					</pg:prev>
					<pg:pages>
		   				<%if (pageNumber == currentPageNumber) { 
					        %><span style="font:bold 16px arial;"><%= pageNumber %></span><%
					      } else { 
					        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
					      }
					    %> 
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
					  	<a href="<%= nextPageUrl %>">下一页</a>
					</pg:next>
					<pg:last>
					  	<a href="<%=pageUrl %>">末页</a>
					</pg:last>
					</pg:index>
			  		</pg:pager>
            </cite>
        </div>
        
        

</body>
</html>

