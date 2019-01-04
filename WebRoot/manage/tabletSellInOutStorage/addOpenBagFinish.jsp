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
<title>饮片拆包</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片拆包</div>
	
	<div class="form-box">
    	<form action="" method="post" id="goform">
    	<c:if test="${requestScope.returninfo==null||requestScope.returninfo==''}">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
	            <img src="/images/frame/dui.png">
	            <b class="green">饮片拆包成功！</b>     
    		</div>
    	</div>
    	</c:if>
    	<c:if test="${requestScope.returninfo!=null&&requestScope.returninfo!=''}">
    	<div class="fb-tit">操作失败</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/err.png">
            <b class="green">没有获取到要拆包的数据</b>   
            </div>  
    	</div>
    	</c:if>
    	<div class="fb-bom">
    		<cite><input type="button" value="继续饮片拆包" class="sbt" onclick="gotoMedOut();"></cite>
    	</div>
        </form>
    </div>
    
	
</div>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" src="/js/comtools.js"></script>


<script type="text/javascript">
	var zyczstype="${sessionScope.User.org.zyctype}";
	
	function gotoMedOut(){
		$("#searchform").attr("action", "<%=basePath%>manage/tabletSellInOutStorage/findOpenBagCode.jsp");
		$("#searchform").submit();
	}
	
</script>

</body>
</html>
