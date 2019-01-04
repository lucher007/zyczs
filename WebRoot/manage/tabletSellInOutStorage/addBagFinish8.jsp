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
<title>饮片包装</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片包装</div>
	<div class="form-box">
    	<form action="" method="post" id="searchform" name="searchform">
    	<input type="hidden" name="filename" id="filename" value="" />
		<input type="hidden" name="filenametime" id="filenametime" value="" />
		<input type="hidden" name="cpccode" id="cpccode" value="${requestScope.returninfo }" />
				
				
    	<c:if test="${requestScope.returninfo==null||requestScope.returninfo==''}">
    		<div class="fb-tit">操作失败</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="/images/frame/err.png">
	            <b class="green">没有获取到要包装的数据</b>     
	    	</div>
    	</c:if>
    	
    	<c:if test="${requestScope.returninfo!=null&&requestScope.returninfo!=''}">
    	
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/dui.png">
            <b class="green">${requestScope.returninfo }</b>   
            
							  
    	</div>
    	
    	
    	</c:if>
    	
    	
    	<div class="fb-bom">
    		<cite><input type="button" value="继续饮片包装" class="sbt" onclick="gotoMedOut();"></cite>
<%--    		<input type="button" value="查询入库记录" class="sbt" onclick="gotoOutData();">--%>
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
		$("#searchform").attr("action", "<%=basePath%>manage/tabletSellInOutStorage/findBagCode8.jsp");
		$("#searchform").submit();
	}
	


</script>

</body>
</html>
