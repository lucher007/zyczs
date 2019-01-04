<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>" target="_self">   
		<meta charset="utf-8">
		<title>设备统计</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
		<script language="javascript" type="text/javascript" src="/commaps/Scripts/swfobject_modified.js" ></script>
	    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	   
	</head>
	
    <body style="width:650px; padding:0;">
      <div id="body">
		<object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="600" height="500">
			  <param name="movie" value="/commaps/dealerMap.swf" />
			  <param name="quality" value="high" />
			  <param name="wmode" value="opaque" />
			  <param name="swfversion" value="9.0.45.0" />
			  <!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
			  <param name="expressinstall" value="/commaps/Scripts/expressInstall.swf" />
			  <!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
			  <!--[if !IE]>-->
			  <object type="application/x-shockwave-flash" data="/commaps/dealerMap.swf" width="600" height="500">
			    <!--<![endif]-->
				    <param name="quality" value="high" />
				    <param name="wmode" value="opaque" />
				    <param name="swfversion" value="9.0.45.0" />
				    <param name="expressinstall" value="/commaps/Scripts/expressInstall.swf" />
				    <!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
				    <div>
				      <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
				      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" width="112" height="33" /></a></p>
				    </div>
			    <!--[if !IE]>-->
			  </object>
		  <!--<![endif]-->
		</object>
		<script type="text/javascript">
			swfobject.registerObject("FlashID");
			function showCom(s){
				t1 = $.dialog({
					title:'设备统计(' + s + ')',
					id:'scaleid',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="380" src="<%=basePath%>govmentStat!getScaleStat.shtml?province='+s+'&ischoice='+Math.random()+'"></iframe>',
					max:false,
					min:false
				});	
			}
			
			function closeDGS(s){
				t1.close();
			}
			
		</script>
		</div>
	</body>
</html>

