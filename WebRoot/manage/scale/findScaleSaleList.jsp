<%@ page language="java" import="java.util.*,cn.gov.zyczs.cspt.common.Tools" pageEncoding="UTF-8" isELIgnored="false"%>
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
<link type="text/css" rel="stylesheet" href="/style/plant.css">
</head>

<body>
	<div id="body">
	<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤库存查询</div>
    <div class="seh-box">
        <form action="" method="post" id="searchForm">
        	药材名称：<input type="text" name="medname" id="medname" maxlength="20"  class="inp" value="${requestScope.medname }">
        	<input type="button" value="查询" class="sch" onclick="return checkForm();">
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>企业名称</td>
            <td>商品编码</td>
            <td>品名</td>
            <td>原始库存(Kg)</td>
            <td>交易量(Kg)</td>
            <td>交易后库存量(Kg)</td>
            <!-- <td>交易时间</td> -->
          </tr>
          <c:forEach items="${requestScope.mappdataList}" var="dataList">
          <tr class="lb-list">
            <td width="100" height="30">${dataList.corpname }</td>
            <td>${dataList.prodcode }</td>
            <td>${dataList.medname }</td>
			<c:set var="medweight" value="${dataList.medweight }" scope="request" />
			<!-- 原始库存(kg)-->
			<td><%
	            Double medweight = Double.valueOf(request.getAttribute("medweight").toString());%>
				<%=Tools.scienceToString(medweight)%>
			</td>
			
			<c:set var="weight" value="${dataList.weight }" scope="request" />
			<!-- 交易量(kg)-->
			<td><%
	            Double weight = Double.valueOf(request.getAttribute("weight").toString());%>
				<%=Tools.scienceToString(weight)%>
			</td>
			
            <c:set var="newmedweight" value="${dataList.medweight-dataList.weight }" scope="request" />
			<!-- 交易后库存量(kg)-->
			<td>
				<%
	            	Double newmedweight = Double.valueOf(request.getAttribute("newmedweight").toString());%>
				<%=Tools.scienceToString(newmedweight)%>
			</td>
           <!--  <td >${dataList.medweight-dataList.weight }</td> -->
            <!-- <td>${dataList.tradingtime }</td> -->
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scalesbus!findScaleSaleList.shtml"
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
					<pg:param name="medname" value="${requestScope.medname }"/>
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
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
<script type="text/javascript">
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchForm").attr("action","scalesbus!findScaleSaleList.shtml");
			$("#searchForm").submit();
		}
		cMenu(4,4);
</script>
</body>
</html>

