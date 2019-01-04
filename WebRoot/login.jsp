<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
		<title>国家中药材流通追溯体系${initParam.titlename }</title>
		<link type="text/css" rel="stylesheet" href="style/login.css">
		<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
		<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="js/login.js"></script>
	</head>
	
	<body onload="reindex();">
		<div id="main">
			<div class="site">${initParam.titlename }</div>
	    	<form action="logined!logined.shtml" method="post" name="loginForm" id="loginForm">
	    	<ul class="login_box">
	          <li><input type="text" name="loginname" id="loginname" class="login-inp w320" onkeypress="onKeyInput2(event)" title="" ></li>
	          <li><input type="password" name="loginpass" id="loginpass" class="login-inp w320" onkeypress="onKeyInput2(event)" ></li>
	          <li class="login-code">
	          	<input type="text" name="authcode" id="authcode" class="login-inp w70" maxlength="4" onkeypress="onKeyInput2(event)" >
	            <img src="<%=request.getContextPath() %>/AuthImgAction.shtml" onclick="changeAuthImg();" width="80" height="27" id="authImg" alt="看不见验证码请点击刷新">
	            <input type="button" value="看不清？点击刷新" onclick="changeAuthImg();" class="refrbtn" >
	          </li>
	          <li class="login-reg">
	          	<input type="button" value="" class="login-btn" onclick="doLoginAjax()">
	          	<a href="<%=basePath %>register.jsp" class="reg-btn">注册</a>
	            <div class="clear"></div>
	          </li>
	          <li class="login-err"><b class="red <c:if test="${requestScope.returncode==0 }">show</c:if><c:if test="${requestScope.returncode==1||requestScope.returncode==null }">hide</c:if>"><c:if test="${requestScope.returncode==0 }">${requestScope.returninfo }</c:if></b></li>
	        </ul>
	        <div class="login-copy">${initParam.copyright }</div>
	        </form>
 	    </div>
	    <script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
		<script type="text/javascript">
		$('#loginname,#loginpass').blur(function(){checkLogin();}).poshytip({
			className: 'tip-yellowsimple',
			showOn: 'none',
			alignTo: 'target',
			alignX: 'right',
			alignY: 'center',
			offsetX: 5
		});
		$('#authcode').poshytip({
			className: 'tip-yellowsimple',
			showOn: 'none',
			alignTo: 'target',
			alignX: 'left',
			alignY: 'center',
			offsetX: 5
		});
		function checkLogin(){        	
			var loginname = $.trim($("#loginname").val());
			var loginpass = $.trim($("#loginpass").val());
			var authcode = $.trim($("#authcode").val());
			if(loginname==""||loginname.length<1||loginname.length>50){
				//$(".red").css("display","block").html("用户不正确！");
				$('#loginname').poshytip('update','<b class="red">'+(loginname==''?'请输入用户名':'用户名不正确！')+'</b>').poshytip('show');
				return false;
			}else{
				$('#loginname').poshytip('hide');
			}
			
			if(loginpass==""||loginpass.length<1||loginpass.length>50){
				//$(".red").css("display","block").html("密码不正确！");
				$('#loginpass').poshytip('update','<b class="red">'+(loginpass==''?'请输入密码':'密码不正确！')+'</b>').poshytip('show');
				return false;
			}else{
				$('#loginpass').poshytip('hide');
			}
			
			if(authcode==""){
				//$(".red").css("display","block").html("请输入验证码！");
				$('#authcode').poshytip('update','<b class="red">请输入验证码！</b>').poshytip('show');
				return false;
			}else{
				$('#authcode').poshytip('hide');
			}
			return true;			
		}
		function doLoginAjax(){
			if(checkLogin()){
				var loginname = $.trim($("#loginname").val());
				var loginpass = $.trim($("#loginpass").val());
				var authcode = $.trim($("#authcode").val());
				var data="";
				data+="loginname="+loginname;
				data+="&loginpass="+loginpass;
				data+="&authcode="+authcode;
				var url="<%=request.getContextPath()%>/login!login.shtml?rid="+Math.random();
				$.getJSON(url,data,function(msg){
					doLoginReturn(msg);
				});
			}
		}
		function doLoginReturn(json){
			if(json.model.returncode==0){
				//$(".red").css("display","block").html(json.model.returninfo);
				if(json.model.returninfo.indexOf('用户')>-1){
					$('#loginname').poshytip('update','<b class="red">'+json.model.returninfo+'</b>').poshytip('show');
				}else if(json.model.returninfo.indexOf('密码')>-1){
					$('#loginpass').poshytip('update','<b class="red">'+json.model.returninfo+'</b>').poshytip('show');
				}else if(json.model.returninfo.indexOf('验证码')>-1){
					$('#authcode').poshytip('update','<b class="red">'+json.model.returninfo+'</b>').poshytip('show');
				}
				changeAuthImg();
			}else if(json.model.returncode==1){
				$("#loginForm").submit();
			}
		}
		function onKeyInput2(e) {
			if (event.keyCode == 13) {
				doLoginAjax();
			}
		}
		function reindex(){ 
			if(window.parent.length>0){
				window.parent.location="<%=basePath%>/login.jsp";     
			}   
		}
		function changeAuthImg(){
			var imgsrc=$("#authImg").attr("src");
			$("#authImg").attr("src",imgsrc+"?requestFlag="+new Date().getTime());
		}
		</script>
	</body>
</html>

