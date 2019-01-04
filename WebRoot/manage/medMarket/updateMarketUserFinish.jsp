<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>新增经营户信息</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：市场管理 &gt; 更新经营户</div>
	<div class="form-box">
    	<form action="" name="searchform" id="searchform" method="post">
    	<div class="fb-tit">操作</div>
        <div class="fb-con">
        	<div class="fb-msg">
                <img src="../images/frame/dui.png">
                <b class="green">${returninfo }！</b>
                <b class="green">经营户CPC：${org.cpccorp}</b>
            </div>
    	</div>
        <div class="fb-bom">
        	<cite><input type="button" value="返回经营户管理" class="sbt" onclick="goToUrl()"></cite>
          <!--   <input type="button" value="添加溯源秤" class="sbt"> 
            <input type="button" value="发卡" class="sbt">-->
        </div>
        </form>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript" language="javascript">
function goToUrl(){
		$("#searchform").attr("action", "<%=basePath %>medMarket!findByList.shtml");
		$("#searchform").submit();
}
</script>
</body>
</html>