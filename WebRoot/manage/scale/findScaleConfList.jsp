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
	<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤状态查询</div>
    <div class="seh-box">
    	<cite><a href="/manage/scale/addScaleConf.jsp" class="btn-a"><span class="new">新建溯源秤规格</span></a></cite>
        	
        <form action="scaleConf!findByList.shtml" method="post" id="searchForm" name="searchForm">
			厂商名称：<input type="text" maxlength="40" name="companyname" value="${requestScope.companyname }">
			键数：<input type="text" maxlength="2" onkeyup="check_IsNum(this.value)"  onkeypress="check_IsNum(this.value)" id="keynum" name="keynum" value="${requestScope.keynum }">
			
        	<input type="submit" value="查询" class="sch">
        	
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>编号</td>
            <td>厂商名称</td>
            <td>型号</td>
            <td>行数</td>
            <td>列数</td>
            <td>键数</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.scaleList}" var="dataList">
          <tr class="lb-list">
            <td width="100" height="30">${dataList.scaleid }</td>
            <td>${dataList.companyname }</td>
            <td>${dataList.modelnumber }</td>
            <td>${dataList.rowsnum }&nbsp;行</td>
            <td>${dataList.columnnum }&nbsp;列</td>
            <td>${dataList.keynum }&nbsp;键</td>
            <td width="230">
            		<a href="javascript:update(${dataList.scaleid });">修改
            	</a> 
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scaleConf!findByList.shtml"
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
        	document.getElementById("keynum").value = "";
        }
	}
	
	function update(scaleid){
		$("#searchForm").attr("action", "scaleConf!updateInit.shtml?scaleid="+scaleid);
		$("#searchForm").submit();
	}

</script>
</body>
</html>

