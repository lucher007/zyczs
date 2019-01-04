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
<title>饮片出库</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：库存管理 > 饮片出库</div>
	<div class="form-box">
    	<form action="" method="post" id="goform">
    	<c:if test="${requestScope.returninfo==null||requestScope.returninfo==''}">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
	            <img src="/images/frame/dui.png">
	            <b class="green">饮片出库成功！</b>     
    		</div>
    	</div>
    	</c:if>
    	<c:if test="${requestScope.returninfo!=null&&requestScope.returninfo!=''}">
    	<div class="fb-tit">操作失败</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/err.png">
            <b class="green">${requestScope.returninfo }</b>   
            </div>  
    	</div>
    	</c:if>
    	<div class="fb-bom">
    		<cite><input type="button" value="继续饮片出库" class="sbt" onclick="gotoMedOut();"></cite>
    		<input type="button" value="查询出库记录" class="sbt" onclick="gotoOutData();">
    	</div>
        </form>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript">
	var zyczstype="${sessionScope.User.org.zyctype}";
	
	function gotoMedOut(){
		//饮片生产
		if(zyczstype=="00100000"){
			
		}//饮片经销
		else if(zyczstype=="00010000"){
			
		}
		$("#goform").attr("action", "<%=basePath%>manage/tabletSellInOutStorage/findOutCode.jsp");
		$("#goform").submit();
	}
	function gotoOutData(){	
		//饮片生产
		if(zyczstype=="00100000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findTabletOutStor_tablet.shtml");
		}//饮片经销
		else if(zyczstype=="00010000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findTabletOutStor_tabletSell.shtml");
		}
		$("#goform").submit();
	}
</script>
</body>
</html>
