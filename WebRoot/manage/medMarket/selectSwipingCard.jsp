<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("flag", request.getParameter("mt"));
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>选择刷卡页面</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body id="cch-bg">
	<div class="cch-img">
    	<div class="cch-link">
        	<div class="cch-check">
            	<a class="cardnum" href="javascript:void(0);">直接输入卡号</a>
            	<a class="cardcheck" href="checkCard.jsp">刷卡</a>
            </div>
            <a class="cch-back" href="javascript:void(0);">返回系统</a>
        </div>
    </div>
	
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script type="text/javascript">
	forbg();
	
	function forbg(){
	
		var t = (($(window).width()-1044)/2)%18;
		if(t!=0){$("body").css("background-position","-"+(t)+"px top")};
		$(".cch-img").height($(window).height());
		if($(window).height()<816){
			$(".cch-img").css("background-position","center "+($(window).height()-816)/2+"px");
			$(".cch-link").css("top",(408+($(window).height()-816)/2));
		}
		$(".cch-link").css("left",($(window).width()-475)/2+8);
		$(".cch-back").click(function(){
			
			var url="<%=request.getContextPath()%>/login!clearFlag.shtml?rid="+Math.random();
			var data = "";
			$.getJSON(url,data,function(data){
				
			});
				
			$(this).attr("href","<%=basePath %>logined!logined.shtml");
		});
	}
	
	$(".cardnum").click(function(){
		$.dialog({
			title:'请输入经营户CPC',
			id:'tabletChos',
			lock:true,
			content: '请输入经营户CPC：<input maxlength="20" id="cpc" type="text" class="inp w250">',
			padding:50,
			okVal:'确定',
			ok:function(){
				var url="<%=request.getContextPath()%>/login!loginComuser.shtml?rid="+Math.random();
				var data="cpccorp="+$("#cpc").val();
				$.getJSON(url,data,function(data){
					var loginForm = data;
			    	var returninfo = loginForm.model.returninfo;
			    	if(returninfo=="0"){
			    		$.dialog.alert("该经营户不存在!");
			    	}else{
						location="<%=basePath %>logined!logined.shtml";
			    	}
				});
			},
			cancleVal:'取消',
			cancle:true
		});
	});
    </script>
</body>
</html>
