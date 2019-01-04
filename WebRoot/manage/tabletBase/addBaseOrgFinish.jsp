<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>饮片品名管理</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片品名管理</div>
	<div class="form-box">
    	<form action="" method="post" id="goform">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/dui.png">
            <b class="green">${requestScope.returnInfo}</b>
            </div>
    	</div>
    	<div class="fb-bom">
    		<cite><input type="button" value="继续新增饮片" class="sbt" onclick="gotoMedOut();"></cite>
    		<input type="button" value="查询饮片记录" class="sbt" onclick="gotoOutData();">
    	</div>
        </form>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript">
	function gotoMedOut(){
		$("#goform").attr("action", "<%=basePath%>tabletBase!findByList_un.shtml");
		$("#goform").submit();
	}
	function gotoOutData(){
		$("#goform").attr("action", "<%=basePath%>tabletBase!findByList.shtml");
		$("#goform").submit();
	}
</script>
</body>
</html>
