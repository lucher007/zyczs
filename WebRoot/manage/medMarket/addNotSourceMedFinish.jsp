<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<base href="<%=basePath%>" />
		<title>非溯源药材入库完成</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css"/>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：药材库存 > 非溯源药材入库</div>
		<div class="form-box">
	    	<div class="fb-tit">操作成功</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="../images/frame/dui.png">
	            <b class="green">${requestScope.returninfo}</b>
		  		</div>	
  			</div>
  			<div class="fb-bom">
	        	<cite><input type="button" value="药材检验" class="sbt"  onclick="return findByList('${medstorid}','${cpcmed}','${medname}','${medweight / 10000}','${harvesttime}');"></cite>
	        	<cite><input type="button" value="药材分包" class="sbt"  onclick="goToUrl()"></cite>
	        </div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
		<script type="text/javascript" language="javascript">
			/**
			*药材检验
			*/
			function findByList(medstorid,cpcmed,medname,medweight,harvesttime){
				window.location.href="<%=basePath%>manage/check/medCheck.jsp?medstorid="+medstorid+"&cpcmed="+cpcmed+"&medname="+encodeURI(medname)+"&medweight="+medweight+"&harvesttime="+harvesttime+"&flag=4&checkmattype=0";
				cMenu(1,0);
			}
			/**
			*药材分包
			*/
			function goToUrl(){
				window.location.href = "<%=basePath %>medMarket!findNotPackList.shtml";
				cMenu(0,3);
			}
  		</script>
	</body>
</html>