<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>中药材产地追溯子系统${initParam.titlename }</title>
<link type="text/css" rel="stylesheet" href="/style/frame.css">
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/frame.js"></script>
<script type="text/javascript">
var returncode = "${requestScope.returncode}";
if(returncode==111||returncode==""||returncode==null){
	window.location.href="<%=request.getContextPath() %>login.jsp";
}
</script>
</head>

<body>
    <div id="top" class="plant_logo"><div class="site">${initParam.titlename }</div></div>
    <div id="menu">
    	<div class="m-list">
            <cite>
                <a href="user!findByPerson.shtml" class="m-user" target="MainFrame">个人资料</a>
                <a href="logined!logout.shtml" class="m-out">退出系统</a>
            </cite>
            <div>
            	<c:forEach items="${requestScope.menulist}" var="menu" varStatus="vs">
		    	<c:if test="${menu.menuparentid==0 }">
		    		<c:if test="${vs.index==0}">
                		<a href="javascript:void(0);" class="act"><span>${menu.menutitle }</span></a>
                	</c:if>
                	<c:if test="${vs.index!=0}">
                		<a href="javascript:void(0);"><span>${menu.menutitle }</span></a>
                	</c:if>
                </c:if>
                </c:forEach>
            </div>
        </div>
        
<%--        <div class="m-list">--%>
<%--            <cite>--%>
<%--                <a href="user!findByPerson.shtml" target="MainFrame" class="m-user">个人资料</a>--%>
<%--                <a href="logined!logout.shtml" class="m-out">退出系统</a>--%>
<%--            </cite>--%>
<%--            <div>--%>
<%--                <a href="javascript:void(0);" class="act">库存管理</a>--%>
<%--                <a href="javascript:void(0);">检验管理</a>--%>
<%--                <a href="javascript:void(0);">统计分析</a>--%>
<%--				<a href="javascript:void(0);">系统管理</a>--%>
<%--            </div>--%>
<%--        </div>--%>

    </div>
    <div id="main">
    	<div class="m-left">
        	<ul class="ml-user">
              <li>欢迎用户：${sessionScope.User.loginname }</li>
              <li>CPC: <a href="<%=basePath %>/manage/user/updatePersonCompany.jsp"  target="MainFrame">${sessionScope.User.cpccorp }</a></li>
            </ul>
			<c:set var="mainurl" />
            <c:set var="i" value="${0}" />
            <c:set var="k" value="${0}" />
            <c:forEach items="${requestScope.menulist}" var="menu" varStatus="vs">
            	<c:set var="j" value="${0}" />
            	<c:set var="m" value="${0}" />
            	<c:forEach items="${requestScope.menulist}" var="submenu">
            		<c:if test="${submenu.menuparentid==menu.menumainid }">
            			<c:if test="${j==0&&k==0}">
		            		<ul class="ml-menu">
		            		<c:set var="k" value="${1}" />
		            		<c:set var="j" value="${1}" />
		            	</c:if>
		            	<c:if test="${j==0&&k!=0}">
		            		<ul class="ml-menu hide">
		            		<c:set var="j" value="${1}" />
		            	</c:if>
            			<c:if test="${vs.index==0&&i==0}">
	            			<c:set var="mainurl" value="${submenu.menuurl}" />
	            			<c:set var="i" value="${1}" />
	            		</c:if>
	            		
			            <c:if test="${m!=0}">
			            	<li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame">&gt;&gt; ${submenu.menutitle }</a></li>
			            </c:if>
			            <c:if test="${m==0}">
	            			<c:set var="m" value="${1}" />
				            <li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame" class="act">&gt;&gt; ${submenu.menutitle }</a></li>
			            </c:if>
            		</c:if>
            	</c:forEach>
            	<c:if test="${j==1}">
            		</ul>
            	</c:if>
            </c:forEach>



<%--            --%>
<%--            <ul class="ml-menu">--%>
<%--              <li><a href="<%=basePath %>plant!findByList.shtml" target="MainFrame" class="act">&gt;&gt; 种植管理</a></li>--%>
<%--              <li><a href="<%=basePath %>plant!findPlantHistory.shtml" target="MainFrame">&gt;&gt; 种植历史</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath %>medStorage!findCheckList.shtml?flag=med" target="MainFrame" class="act">&gt;&gt; 检验管理</a></li>--%>
<%--              <li><a href="<%=basePath %>medStorage!findCheckedList.shtml?flag=med" target="MainFrame" >&gt;&gt; 已检药材</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath%>medStorage!findMedStorage.shtml" target="MainFrame" class="act">&gt;&gt; 库存查询</a></li>--%>
<%--              <li><a href="<%=basePath%>inOutStor!findMedInStor_med.shtml" target="MainFrame">&gt;&gt; 入库查询</a></li>--%>
<%--              <li><a href="<%=basePath%>medStorage!findNotPackList.shtml" target="MainFrame">&gt;&gt; 药材分包</a></li>--%>
<%--              <!-- <li><a href="<%=basePath%>medStorage!findPackedList.shtml" target="MainFrame">&gt;&gt; 药材拆包</a></li> -->--%>
<%--              <li><a href="<%=basePath%>medStorage!findPrintCode.shtml" target="MainFrame">&gt;&gt; 打印赋码</a></li>--%>
<%--              <li><a href="<%=basePath%>medStorage!findMedOutStorage.shtml" target="MainFrame">&gt;&gt; 药材出库</a></li>--%>
<%--              <li><a href="<%=basePath%>inOutStor!findMedOutStor_med.shtml" target="MainFrame">&gt;&gt; 出库查询</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath%>medStat!findMainMeds.shtml" target="MainFrame" class="act">&gt;&gt; 市场价格走势</a></li>--%>
<%--              <li><a href="medStat!getGrowTaskStat.shtml" target="MainFrame">&gt;&gt; 种植任务统计</a></li>--%>
<%--              <li><a href="medStat!getMedStorageStat.shtml" target="MainFrame">&gt;&gt; 药材库存统计</a></li>--%>
<%--              <li><a href="medStat!getMedSellStat.shtml" target="MainFrame">&gt;&gt; 药材出库统计</a></li>--%>
<%--            </ul>--%>
<%--           <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath%>user!findByList_sys.shtml?cpccorp=${User.cpccorp}&orgid=${User.orgid}" target="MainFrame" class="act">&gt;&gt;用户管理</a></li>--%>
<%--           </ul>--%>
        </div>
        <div class="m-right">
        	<iframe frameborder="0" scrolling="no" name="MainFrame" id="MainFrame" src="<%=basePath %>${mainurl }" width="788" height="490"></iframe>
        </div>
    </div>
    <div id="foot">
    	<div class="copy">${initParam.copyright }</div>
    </div>
</body>
</html>

