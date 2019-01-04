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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="/style/user.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤查询</div>
    <div class="seh-box">
        <form action="scaleAction!findScalesCPC.shtml" method="post" id="searchForm" name="searchForm">
			商户名称：<input type="text" name="userName" value="${requestScope.userName }">
        	<input type="submit" value="查询" class="sch">
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>企业CPC</td>
            <td>商户名称</td>
            <td>溯源秤数量</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.scaleList}" var="dataList">
          <tr class="lb-list">
            <td width="200" height="30">${dataList.usercode }</td>
            <td width="200" height="30">${dataList.userName }</td>
            <td>${dataList.compluver }</td>
            <td>
            	<a class="btn-look" href="scaleAction!findScalesListByCPC.shtml?usercode=${dataList.usercode }">详情</a>
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scaleAction!findScalesCPC.shtml"
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
					<pg:param name="userName" value="${requestScope.userName }"/>
					<pg:param name="scalecode" value="${requestScope.usercode }"/>
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
    </div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script type="text/javascript">
    	//1.js验证只能输入数字.
		function checkNumberChar(ob){
			if(/^\d+$/.test(ob)){
				return true;
			}else{
				return false;
			}
		}
		
		function check_IsNum(value){
			//先把非数字的都替换掉，除了数字
			//value = value.replace(/^\d+$/,"");  
		    //定义正则表达式部分
	        if(!checkNumberChar(value)){
	        	document.getElementById("scalecode").value = "";
	        }
		}
    </script>
</body>
</html>

