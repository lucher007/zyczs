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
		<title>入库详情查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：饮片库存销售  &gt; 入库查询</div>
		<div class="form-box">
	    	<form action="" method="post" name="searchform" id="searchform">
	    	<input type="hidden" name="inoutstorid" id="inoutstorid" value="${requestScope.inoutstorid }"/>
	    	<div class="fb-tit">入库详情</div>
	        <div class="fb-con">
                <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		          <tr class="fbc-tit">
		            <td width="20%">品名</td>
		            <td width="30%">批次号</td>
<!--		            <td width="15%">规格(g/包)</td>-->
<!--		            <td width="10%">包数</td>-->
<!--		            <td width="10%">箱数</td>-->
		            <td width="15%">总重量(Kg)</td>
		          </tr>
		          <c:forEach items="${requestScope.inoutstorboxlist}" var="inoutstorbox">
			  	  <tr class="fb-list">
			  		<td height="30">
			  		${(inoutstorbox.prodname==null || inoutstorbox.prodname == '')?'--大包装--':inoutstorbox.prodname }&nbsp;
			  		</td>
			  		<td>${inoutstorbox.batchcpc }&nbsp;</td>
<!--			  		<td>${inoutstorbox.boxnumweight/10 }&nbsp;</td>-->
<!--			  		<td>${inoutstorbox.boxitemnum }&nbsp;</td>-->
<!--			  		<td><a href="<%=basePath %>inOutStorBox!findTabletInStorItem_tablet.shtml?inoutstorboxid=${inoutstorbox.inoutstorboxid }&inoutstorid=${requestScope.inoutstorid }" class="btn-bag">${inoutstorbox.boxnum }&nbsp;</a></td>-->
			  		<td>${inoutstorbox.strtotalweight }&nbsp;</td>
			  	  </tr>
		  		  </c:forEach>
		        </table>
		        <div class="page">
					<cite>
					<pg:pager url="inOutStorBox!findTabletInStorBox_tablet.shtml"
						items="${requestScope.pager_count}" index="center" maxPageItems="10"
						maxIndexPages="5" isOffset="<%=true%>"
						export="offset,currentPageNumber=pageNumber" scope="request">
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="inoutstorid" value="${requestScope.inoutstorid }" />
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
	        $("#searchform").attr("action","inOutStor!findTabletInStor_tablet.shtml");
			$("#searchform").submit();
	    }
	</script>
	</body>
</html>
 