<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>重复提交</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos"></div>
	<div class="form-box">
    	<div class="fb-tit">请勿重复提交</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/Warning.png">
            <b class="red">请勿重复提交！</b>
            </div>
    	</div>
    	<div class="fb-bom">
        	<cite><input type="submit" value="返回上一步" class="sbt" onclick="history.go(-2)"></cite>
        </div>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
</body>
</html>
