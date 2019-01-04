<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>中药专业市场追溯子系统${initParam.titlename }</title>
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
    <div id="top" class="mart_logo"><div class="site">${initParam.titlename }</div></div>
    <div id="menu">
    	<div class="m-list">
            <cite>
                <a href="user!findByPerson.shtml" target="MainFrame" class="m-user">个人资料</a>
                <a href="logined!logout.shtml" class="m-out">退出系统</a>
            </cite>
            <div>
            	<c:set var="n" value="${0}" />
            	<c:forEach items="${requestScope.menulist}" var="menu" varStatus="vs">
		    	<c:if test="${menu.menuparentid==0 }">
		    		<c:if test="${menu.menutitle=='库存管理' }">
		    			<a href="javascript:void(0);" tc='card'><span>${menu.menutitle }</span></a>
		    		</c:if>
		    		<c:if test="${menu.menutitle=='检验管理' }">
		    			<a href="javascript:void(0);" tc='card2'><span>${menu.menutitle }</span></a>
		    		</c:if>
		    		<c:if test="${menu.menutitle=='市场管理' }">
		    			<a href="javascript:void(0);" class="act"><span>${menu.menutitle }</span></a>
		    			<c:set var="n" value="${1}" />
		    		</c:if>
		    		<c:if test="${menu.menutitle=='统计分析' }">
		    			<a href="javascript:void(0);" <c:if test='${n==0 }'>class="act"</c:if>><span>${menu.menutitle }</span></a>
		    			<c:if test="${n==0 }">
		    				<c:set var="n" value="${2}" />
		    			</c:if>
		    		</c:if>
		    		<c:if test="${menu.menutitle=='系统管理' }">
		    			<a href="javascript:void(0);" <c:if test='${n==0 }'>class="act"</c:if>><span>${menu.menutitle }</span></a>
		    			<c:if test="${n==0 }">
		    				<c:set var="n" value="${3}" />
		    			</c:if>
		    		</c:if>
                </c:if>
                </c:forEach>
<%--                <a href="javascript:void(0);" tc='card' >库存管理</a>--%>
<%--                <a href="javascript:void(0);" tc='card2' >检验管理</a>--%>
<%--                <a href="javascript:void(0);" class="act">市场管理</a>--%>
<%--                <a href="javascript:void(0);">统计分析</a>--%>
<%--                <a href="javascript:void(0);">系统管理</a>--%>
            </div>
        </div>
    </div>
    <div id="main">
    	<div class="m-left">
        	<ul class="ml-user hide">
              <li>欢迎用户：${sessionScope.comuser.company.corpname }</li>
              <li>CPC: <a href="<%=basePath %>/manage/user/updatePersonCompanyComuser.jsp"  target="MainFrame">${sessionScope.comuser.cpccorp }</a></li>
            </ul>
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
            			<c:if test="${submenu.menumainid>87&&j==0&&k==0}">
		            		<ul class="ml-menu">
		            		<c:set var="k" value="${1}" />
		            		<c:set var="j" value="${1}" />
		            	</c:if>
		            	<c:if test="${j==0}">
		            		<ul class="ml-menu hide">
		            		<c:set var="j" value="${1}" />
		            	</c:if>
            			<c:if test="${submenu.menumainid>87&&submenu.menumainid<152&&i==0 }">
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
            
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a tc='card' href="<%=basePath %>manage/medMarket/medInStorage.jsp" target="MainFrame">&gt;&gt; 药材入库</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>inOutStor!findMedInStor_medMarket.shtml" target="MainFrame">&gt;&gt; 入库查询</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>medMarket!findNotPackList.shtml" target="MainFrame">&gt;&gt; 药材分包</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>medMarket!findPrintCode.shtml" target="MainFrame">&gt;&gt; 打印赋码</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>medMarket!findMedOutStorage.shtml" target="MainFrame">&gt;&gt; 药材出库</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>inOutStor!findMedOutStor_medMarket.shtml" target="MainFrame">&gt;&gt; 出库查询</a></li>--%>
<%--              <!-- <li><a href="med-sale.html" target="MainFrame">&gt;&gt; 零售管理</a></li> -->--%>
<%--              <li><a tc='card' href="<%=basePath %>medMarket!findMedStorage.shtml" target="MainFrame" class="act">&gt;&gt; 库存查询</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>cheng!findChengDataByList.shtml" target="MainFrame" class="act">&gt;&gt; 溯源秤交易查询</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a tc='card' href="<%=basePath %>medStorage!findCheckList.shtml?flag=medmarket" target="MainFrame" class="act">&gt;&gt; 药材检验</a></li>--%>
<%--              <li><a tc='card' href="<%=basePath %>medStorage!findCheckedList.shtml?flag=medmarket" target="MainFrame">&gt;&gt; 已检药材</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu">--%>
<%--              <li><a href="<%=basePath %>medMarket!findByList.shtml" target="MainFrame" class="act">&gt;&gt; 经营户管理</a></li>--%>
<%--              <li><a href="cheng!findByList.shtml" target="MainFrame">&gt;&gt; 溯源秤查询</a></li>--%>
<%--              <li><a href="chengConf!findByList.shtml" target="MainFrame">&gt;&gt; 溯源秤规格配置</a></li> --%>
<%--              <li><a href="cheng!addChengInit.shtml" target="MainFrame">&gt;&gt; 溯源秤添加</a></li>--%>
<%--              <li><a href="cheng!findChengFckByList.shtml" target="MainFrame">&gt;&gt; 快捷键管理</a></li>--%>
<%--              <li><a href="cheng!findChengLockedByList.shtml" target="MainFrame">&gt;&gt; 溯源秤锁定</a></li>--%>
<!--              <li><a href="cheng!findChengModeByList.shtml" target="MainFrame">&gt;&gt; 工作模式管理</a></li>-->
<%--              <li><a href="cheng!findChengCardByList.shtml" target="MainFrame">&gt;&gt; 溯源秤发卡</a></li>--%>
<%--              <li><a href="cheng!findChengDataByList.shtml" target="MainFrame">&gt;&gt; 溯源秤交易查询</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath %>medMarket!findMainMeds.shtml" target="MainFrame" class="act">&gt;&gt; 价格指数</a></li>--%>
<%--              <li><a href="medMarket!findByMedmarketMedStat.shtml" target="MainFrame">&gt;&gt; 药材库存</a></li>--%>
<%--              <li><a href="<%=basePath %>medMarketStat!getMedSellStat.shtml" target="MainFrame">&gt;&gt; 出库统计</a></li>--%>
<%--              <li><a href="org!findByMedmarketUserStat.shtml" target="MainFrame">&gt;&gt; 经营户统计</a></li>--%>
<%--            </ul>--%>
<%--            <ul class="ml-menu hide">--%>
<%--              <li><a href="<%=basePath%>user!findByList_sys.shtml?cpccorp=${User.cpccorp}&orgid=${User.orgid}" target="MainFrame" class="act">&gt;&gt;用户管理</a></li>--%>
<%--            </ul>--%>
        </div>
        <div class="m-right">
        	<iframe frameborder="0" scrolling="no" name="MainFrame" id="MainFrame" src="<%=basePath %>${mainurl }" width="788" height="490"></iframe>
        </div>
    </div>
    <div id="foot">
    	<div class="copy">${initParam.copyright }</div>
    </div>
    
    <%
    	String flag = (String) session.getAttribute("flag");
    %>
    
    <script type="text/javascript">
		if(${flag == 'card'}){
			cMenu(0,0);
			$(".ml-user").eq(0).removeClass("hide");
			$(".ml-user").eq(1).addClass("hide");
		}else if(${flag == 'card2'}){
			cMenu(1,0);
			$(".ml-user").eq(0).removeClass("hide");
			$(".ml-user").eq(1).addClass("hide");
		}else{
			$(".ml-user").eq(1).removeClass("hide");
			$(".ml-user").eq(0).addClass("hide");
		}
		$(".m-list div a").click(function(){
			var mx=$(".m-list div a").index(this);
			if(mx==2||mx==3){
				$(".ml-user").eq(1).removeClass("hide");
				$(".ml-user").eq(0).addClass("hide");
			}
		});

	</script>
</body>
</html>
