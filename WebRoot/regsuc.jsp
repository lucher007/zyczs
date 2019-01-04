<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>注册提示 -- 中药材产地追溯系统</title>
<link type="text/css" rel="stylesheet" href="style/login.css">
</head>

<body>
	<div id="regmain">
    	<form action="register.jsp" method="post">
    	<div class="reg_box">
            <div class="rb-tit">温馨提示</div>
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="rb-con">
              <tr>
                <td height="120" width="200" align="right">
                	<c:if test="${returninfo=='注册信息成功,进入备案操作!'}" var="flag">
                		<img src="images/frame/dui.png">
                	</c:if>
                	<c:if test="${!flag}">
                		<img src="images/frame/err.png">
                	</c:if>
                </td>
                <td class="red b">
            		   ${returninfo}
               </td>
              </tr>
              <tr>
                <td colspan="2" height="80" class="rb-btn">
                	<input type="submit" class="gnreg" value="">
                    <a href="login.jsp">返回登录</a>
                </td>
              </tr>
            </table>
            <div class="rb-bom"></div>
        </div>
        <div class="login-copy">${initParam.copyright }</div>
        </form>
    </div>
    <script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript">
    forbg();
	$(window).resize(function() {
		forbg();
	});

	function forbg(){
		var t = (($(window).width()-660)/2)%18;
		if(t!=0){$("body").css("background-position","-"+(t-3)+"px top")};
	}
    </script>
</body>
</html>


