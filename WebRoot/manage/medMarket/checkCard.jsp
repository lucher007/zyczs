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
<title>刷卡页面</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body id="cardbg">
	<div class="cardimg">
		<a class="cch-back" href="javascript:void(0);">返回系统</a>
	</div>
	
	<div id="cardObj"></div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script type="text/javascript">
	forbg();
	setTimeout(function(){ReadRFID2_();},1000); 
	//ReadRFID2();
	
	$(window).resize(function() {
		forbg();
	});
	
	/*$.dialog.confirm('确认模拟刷卡?',function(){
		var url="<%=request.getContextPath()%>/login!loginComuser.shtml?rid="+Math.random();
		var data="cpccorp=10127300007902";
		$.getJSON(url,data,function(data){
			var loginForm = data;
	    	var returninfo = loginForm.model.returninfo;
	    	if(returninfo=="该经营户不存在!"){
	    		$.dialog.alert(returninfo);
	    	}else{
				location="<%=basePath %>logined!logined.shtml";
	    	}
		});
	},function(){
		var url="<%=request.getContextPath()%>/login!clearFlag.shtml?rid="+Math.random();
		var data = "";
		$.getJSON(url,data,function(data){
			
		});
	});*/
	
	/*function ReadRFID2(){
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
	}*/
	
	
	function forbg(){
		var t = (($(window).width()-1044)/2)%18;
		if(t!=0){$("body").css("background-position","-"+(t)+"px top")};
		$(".cardimg").height($(window).height());
		if($(window).height()<816){
			$(".cardimg").css("background-position","center "+($(window).height()-816)/2+"px");
			$(".cardimg a").css("top",(580+($(window).height()-816)/2));
		}
		$(".cardimg a").css("left",($(window).width()-206)/2+8).click(function(){
			
			var url="<%=request.getContextPath()%>/login!clearFlag.shtml?rid="+Math.random();
			var data = "";
			$.getJSON(url,data,function(data){
				
			});
				
			$(".cardimg a").attr("href","<%=basePath %>logined!logined.shtml");
		});
		
		$(".cch-back").click(function(){
			var url="<%=request.getContextPath()%>/login!clearFlag.shtml?rid="+Math.random();
			var data = "";
			$.getJSON(url,data,function(data){
				
			});
			$(this).attr("href","<%=basePath %>logined!logined.shtml");
		});
	}
	
	//如果5秒内没刷卡, 等待5秒后重新读卡.
	function ReadRFID2_(){
		$("#cardObj").html('<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>');
		code = neowerPrinter.ReadRFID2(5); //参数为等待秒数
		if(code != ""){
			var url="<%=request.getContextPath()%>/login!loginComuser.shtml?rid="+Math.random();
			var data = "cpccorp="+code.split("|")[1];
			$.getJSON(url,data,function(data){
				var loginForm = data;
		    	var returninfo = loginForm.model.returninfo;
		    	if(returninfo=="0"){
		    		$.dialog.alert("该经营户不存在!");
		    	}else{
					location="<%=basePath %>logined!logined.shtml";
		    	}
			});
		}else if(code == ""){
			$.dialog({
			    title: '警告',
			    content: '<div style="padding:20px 0; color:#F30;">刷卡等待超时，如需再次刷卡请点击“重新刷卡”按钮，点击“返回系统”按钮取消刷卡。</div>',
			    lock:true,
			    button: [
			        {
			            name: '重新刷卡',
			            callback: function(){
			                location.reload();
			            },
			            focus: true
			        },
			        {
			            name: '返回系统',
			            callback: function(){
			                var url="<%=request.getContextPath()%>/login!clearFlag.shtml?rid="+Math.random();
							var data = "";
							$.getJSON(url,data,function(data){
								
							});
			                location='<%=basePath %>logined!logined.shtml';
			            }
			        }
			    ]
			});
		}
	}
	
    </script>
</body>
</html>
