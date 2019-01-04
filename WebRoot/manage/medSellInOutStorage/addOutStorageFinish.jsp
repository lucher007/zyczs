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
<title>药材出库</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：药材库存销售 > 药材出库</div>
	<div class="form-box">
    	<form action="" method="post" id="goform">
    	<c:if test="${requestScope.returninfo==null||requestScope.returninfo==''}">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/dui.png">
            <b class="green">药材出库成功！</b>     
    	</div>
    	</c:if>
    	
    	<c:if test="${requestScope.returninfo!=null&&requestScope.returninfo!=''}">
    	<div class="fb-tit">操作失败</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/err.png">
            <b class="green">${requestScope.returninfo }</b>     
    	</div>
    	</c:if>
    	<div class="fb-bom">
    		<cite><input type="button" value="继续药材出库" class="sbt" onclick="gotoMedOut();"></cite>
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
		//药材种植
		if(zyczstype=="10000000"){
			
		}//药材经销
		else if(zyczstype=="01000000"){
			
		}//药材市场	
		else if(zyczstype=="00001000"){
			
		}//饮片生产	
		else if(zyczstype=="00100000"){
			
		}	
		$("#goform").attr("action", "<%=basePath%>manage/medSellInOutStorage/findOutCode.jsp");	
		$("#goform").submit();
	}
	function gotoOutData(){
		//药材种植
		if(zyczstype=="10000000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findMedOutStor_med.shtml");
		}//药材经销
		else if(zyczstype=="01000000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findMedOutStor_medSell.shtml");
		}//药材市场	
		else if(zyczstype=="00001000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findMedOutStor_medMarket.shtml");
		}//饮片生产	
		else if(zyczstype=="00100000"){
			$("#goform").attr("action", "<%=basePath%>inOutStor!findMedInStor_tablet.shtml");
		}				
		
		$("#goform").submit();
	}
</script>
</body>
</html>
