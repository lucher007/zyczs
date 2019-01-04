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
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>溯源码查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：药材库存  &gt; 入库查询</div>
		<div class="form-box">
	    	<form action="" method="post" name="searchform" id="searchform">
	    	<input type="hidden" name="inoutstorid" id="inoutstorid" value="${requestScope.inoutstorid }"/>
	    	<div class="fb-tit">溯源码清单</div>
	        <div class="fb-con">
<!--	            <table cellpadding="0" cellspacing="0" border="0" width="100%">-->
<!--	                 <tr>-->
<!--	                    <td height="40" >销售企业：${requestScope.inoutstorage.sellcorpname }</td>-->
<!--	                    <td>入库时间：${fn:substring(requestScope.inoutstorage.opertime, 0, 11) }</td>-->
<!--	                    <td>总重量(kg)：<b class="red">${requestScope.inoutstorage.strtotalweight }</b></td>-->
<!--	                </tr>-->
<!--	 			</table>-->
                <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		          <tr class="fbc-tit">
		            <td>溯源码</td>
		            <td>重量(Kg)</td>
		          </tr>
		          <c:forEach items="${requestScope.boxitemlist}" var="boxitem">
			  	  <tr class="fb-list">
			  		<td width="60%" height="30">${boxitem.boxcode }&nbsp;</td>
			  		<td width="40%">${boxitem.boxweight/10000 }&nbsp;</td>
			  	  </tr>
		  		  </c:forEach>
		        </table>
		        <div class="page">
					<cite>
					<pg:pager url="inOutStorBox!findMedInStorItem_tablet.shtml"
						items="${requestScope.pager_count}" index="center" maxPageItems="10"
						maxIndexPages="5" isOffset="<%=true%>"
						export="offset,currentPageNumber=pageNumber" scope="request">
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="inoutstorid" value="${requestScope.inoutstorid }" />
						<pg:param name="inoutstorboxid" value="${requestScope.inoutstorboxid }" />
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
								<a href="<%=pageUrl%>">首页</a>
							</pg:first>
							<pg:prev export="prevPageUrl=pageUrl">
								<a href="<%=prevPageUrl%>" title="上一页" class="prev">&nbsp;</a>
							</pg:prev>
							<pg:pages>
								<%
									if (pageNumber == currentPageNumber) {
								%><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a>
								<%
									} else {
								%><a href="<%=pageUrl%>"><%=pageNumber%></a>
								<%
									}
								%>
							</pg:pages>
							<pg:next export="nextPageUrl=pageUrl">
								<a href="<%=nextPageUrl%>" title="下一页" class="next">&nbsp;</a>
							</pg:next>
							<pg:last>
								<a href="<%=pageUrl%>">末页</a>
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
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	    function goBack(){
	        $("#searchform").attr("action","inOutStorBox!findMedInStorBox_tablet.shtml");
			$("#searchform").submit();
	    }
	</script>
	</body>
</html>
 