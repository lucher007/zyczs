<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>

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
	<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
	<div id="body">
		<div class="cur-pos">
			当前位置：溯源码查询
		</div>
	    <form action="" method="post" name="searchform" id="searchform">
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	          	<td>品名</td>
	          	<td>小包装规格(g/包)</td>
	            <td>溯源码</td>
	            <td>重量(Kg)</td>
	          </tr>
	          <c:forEach items="${requestScope.boxlist}" var="boxlist">
		          <tr class="lb-list">
		          	<td height="30">${boxlist.prodname }</td>
		          	<td height="30">${boxlist.boxweight }</td>
		            <td>${boxlist.boxcode }</td>
		           	<td>
		           	<c:set var="boxweight" value="${boxlist.boxweight}" scope="request" />
			  			<%
	              		Object boxweight=request.getAttribute("boxweight");
	              		 %>
			  		<%=Tools.scienceToString(Tools.division(boxweight.toString(),"10000"))%>
		           	</td>
		          </tr>
	          </c:forEach>           
	        </table>
	        
	        <div class="page">
				<cite>        
	            	<pg:pager
					    url="printCode!findByBox.shtml"
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
						<pg:param name="storageid" value="${storageid}"/>
						<pg:param name="storagetype" value="${storagetype}"/>
						<pg:param name="codetype" value="${codetype}"/>
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
        <div class="fb-bom">
            <input type="button" value="返回上一页" onclick="javascript:goBack();" class="sbt"/>
        </div>
        </form>
    </div>    
    
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	    function goBack(){
	        history.go(-1)
	    }
	</script>
	
</body>
</html>

