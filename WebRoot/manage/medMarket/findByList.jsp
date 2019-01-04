<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	session.removeAttribute("flag");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>经营户管理</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：市场管理 &gt; 经营户管理</div>
    <div class="seh-box">
    	<cite><a href="<%=basePath %>manage/medMarket/addUser.jsp" class="btn-a"><span class="new">添加新经营户</span></a></cite>
      	<form id="searchform"  action="" method="post" name="searchform">
       请输入商户名称：
        <input type="text" maxlength="50" value="${requestScope.orgname}" class="inp" size="45" id="orgname" name="orgname">  
        <input type="button" value="查询" class="sch" onclick="return checkForm();">
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>经营户溯源编号</td>
            <td>联系人</td>
            <td>商户名称</td>
            <td>商户市场编号</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${orglist}" var="org">
	          <tr class="lb-list">
	            <td height="30">${org.cpccorp}&nbsp;</td>
	            <td title="${org.linkman }">
	            	<c:choose>
	            		<c:when test="${fn:length(org.linkman) > 8}">
			            	${fn:substring(org.linkman,0,8)}...&nbsp;
	            		</c:when>
	            		<c:otherwise>
	            			${org.linkman}&nbsp;
	            		</c:otherwise>
	            	</c:choose>
	            </td>
	            <td title="${org.orgname }">
	            	<c:choose>
	            		<c:when test="${fn:length(org.orgname) > 20}">
			            	${fn:substring(org.orgname,0,20)}...&nbsp;
	            		</c:when>
	            		<c:otherwise>
			            	${org.orgname}&nbsp;
	            		</c:otherwise>
	            	</c:choose>
	            </td>
	            <td>${org.marketcode}&nbsp;</td>
	            <td>
<!--	            	<c:if test="${org.sendcard == '' || org.sendcard == null}" var="flag">-->
<!--	            		<a href="<%=basePath %>manage/medMarket/sendCard.jsp?cpccorp=${org.cpccorp }&orgid=${org.orgid }" class="btn-card">发卡</a> |-->
<!--	            	</c:if>-->
<!--	            	<c:if test="${!flag}">-->
<!--	            		<a href="<%=basePath %>manage/medMarket/sendCard.jsp?cpccorp=${org.cpccorp }&orgid=${org.orgid }" class="btn-card">重新发卡</a> |-->
<!--	            	</c:if>-->
<!--	            	<a href="scaleAction!addScaleInit.shtml?usercode=${org.cpccorp}&userName=${org.linkman}" class="btn-scal">添加溯源秤</a>|-->
<!--	            	<a href="chengAction!addChengInit.shtml?cpccorp=${org.cpccorp}&cpcname=${org.orgname}" class="btn-scal">添加溯源秤</a>|-->
	            	
	            	<a href="<%=basePath %>org!UpdateMarketUserInit.shtml?cpccorp=${org.cpccorp }&businessnumber=${org.businessnumber }&orgid=${org.orgid }&marketcode=${org.marketcode }" class="btn-scal">详情</a>|
	            </td>
	          </tr>
          </c:forEach>
        </table>
       <div class="page">
	        	<cite>
	            	<pg:pager
					    url="medMarket!findByList.shtml"
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
						<pg:param name="orgname" value="${requestScope.orgname }"/>
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
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
<script type="text/javascript">
		cMenu(2,0);
	function checkForm(){
		$("#orgname").val($.trim($("#orgname").val()));
		if(checkquotmarks($("#orgname").val())){
			$("#orgname").focus();
			$.dialog.tips('名称不能包含~ # *等字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","medMarket!findByList.shtml");
		$("#searchform").submit();
	}
	
</script>
</body>
</html>