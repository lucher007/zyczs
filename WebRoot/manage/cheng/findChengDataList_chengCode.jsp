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
		<title>交易查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/user.css">
		<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
	</head>
	
	<body>
	<div id="body">
		<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
			<div class="cur-pos">当前位置：市场管理 > 溯源秤管理</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤管理</div>
		</c:if>
		<div class="form-box">
	    	<form action="" method="post" name="searchform" id="searchform">
	    	<div class="fb-tit">交易查询详情</div>
	        <div class="fb-con">
	            <table cellpadding="0" cellspacing="0" border="0" width="100%">
	                <tr>
	                    <td height="30" width="30%">溯源秤编号：${requestScope.cheng.chengcode }</td>
	                    <td width="25%">规格名称：${requestScope.cheng.normname }</td>
	                </tr>
	                <tr>
	                    <td height="30" width="30%">管理者：${requestScope.cheng.corpname }</td>
	                    <td width="25%">发放日期：${fn:substring(requestScope.cheng.addtime, 0, 11) }</td>
	                </tr>
	 			</table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
		           <tr class="lb-tit">
		            <td>卖方企业</td>
		            <td>药材名称</td>
		            <td>单价(元/Kg)</td>
		            <td>重量(Kg)</td>
		            <td>总价(元)</td>
		            <td>交易时间</td>
		          </tr>
		          <c:forEach items="${requestScope.chengdatalist}" var="dataList">
		          <tr class="lb-list">
		            <td height="30" class="remarkClass" title="${dataList.sellcorpname }">${fn:substring(dataList.sellcorpname, 0, 20)}&nbsp;</td>
		            <td>${dataList.medname }&nbsp;</td>
		            <td>${dataList.unitprice }&nbsp;</td>
		            <td>${dataList.weight }&nbsp;</td>
		            <td>${dataList.totalprice }&nbsp;</td>
		            <td>${fn:substring(dataList.tradetime, 0, 19)}&nbsp;</td>
		          </tr>
		          </c:forEach>
		        </table>
		        
		        <div class="page">
					<cite>
					<pg:pager url="cheng!findChengDataByList_chengCode.shtml"
						items="${requestScope.pager_count}" index="center" maxPageItems="10"
						maxIndexPages="5" isOffset="<%=true%>"
						export="offset,currentPageNumber=pageNumber" scope="request">
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="chengcode" value="${requestScope.chengcode }" />
						<pg:param name="opertype" value="${requestScope.opertype }" />
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
	<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript">
	    function goBack(){
	    	if(0=='${opertype}'){
	    		window.location.href="<%=basePath%>manage/map/findOrgCheng.jsp";
	    	}else{
		        $("#searchform").attr("action","cheng!findByList.shtml");
				$("#searchform").submit();
			}
	    }
	</script>
	</body>
</html>
 