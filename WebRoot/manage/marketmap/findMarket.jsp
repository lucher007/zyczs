<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
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
		<base href="<%=basePath%>">
		<title>查看楼层图</title>
   		<link type="text/css" rel="stylesheet" href="/style/user.css">
   		<link type="text/css" rel="stylesheet" href="/js/plugin/imgzoom/cvi_tip.css">
		<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" src="/js/plugin/jquery.ba-resize.min.js"></script>
		<script type="text/javascript" src="/js/plugin/imgzoom/shiftzoom.js"></script>
		<script type="text/javascript" src="/js/plugin/imgzoom/cvi_tip_lib.js"></script>
		<script language="javascript" type="text/javascript" src="/js/form.js"></script>
		<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
		<script type="text/javascript" language="javascript">
		if(document.images&&document.createElement&&document.getElementById){
		    document.writeln('<style type="text/css">'); 
		    document.writeln('img.shiftzoom { visibility: hidden; }'); 
		    document.writeln('<\/style>'); 
		}
		shiftzoom.defaultCurpath = '/js/plugin/imgzoom/images/cursors/';
		var timeid;
    	$(function(){
    		var area = $(".mapbox-area").find('li[class="current"]').attr("areaid")+"";
    		findMarketFloor(area.split("@")[0]);
    	});
    	
    	/**********根据区级联改变楼层查询对应楼层**************/
    	function changeArea(value){
    		var area = value.split("@")[0];
    		findMarketFloor(area);
    	}
    	
    	function findMarketFloor(area){
    		var param = "";
	    	param += "area="+encodeURIComponent(area)+"&cpccorp="+$("#cpccorp").val();
	    	//alert(param);			
			var url="<%=request.getContextPath()%>/marketMapAjax!findMarketFloorByCpc.shtml?rid="+Math.random();
			$.getJSON(url,param,function(data){
				var floor= $(".mapbox-bodl");
				floor.html("");
				var list = data.model.floorlist;
				//alert(list);
				for(var i = 0 ; i < list.length ; i++){
					var obj = list[i];
					$(".mapbox-tit").html(obj.orgname);
					floor.append('<li '+(i==0?'class="current" ':'')+' fid="' + obj.floor+'@'+obj.floornum + '">' + obj.floor + '</li>');
			    	var aw = $(".mapbox-top").width()-$(".mapbox-tit").width()-40;
			    	$(".mapbox-area").width(aw);
				}
				changeFloor();
			});
    	}
    	
    	/*****************查询对应的楼层图***************/
    	function changeFloor(){
    		if($(".mapbox-area").find('li[class="current"]').length == 0){
    			$(".mapbox-img").html("<div style='text-align:center; padding:20px 0;'>请先联系地方监管管理员添加该市场区域楼层后操作!</div>");
    			return;
    		}
    		var areanum = $(".mapbox-area").find('li[class="current"]').attr("areaid").split("@")[1];
    		var floornum = $(".mapbox-bodl").find('li[class="current"]').attr("fid").split("@")[1];
    		var cpccorp = $("#cpccorp").val();
    		var matdiv= $(".mapbox-img");
    		matdiv.html("");	
		    matdiv.html('<img onerror="noImg()" id="caribbean" width="712" height="405" class="shiftzoom" onLoad="shiftzoom.add(this,{showcoords:true,zoom:100});getState('+cpccorp+','+areanum+','+floornum+');" src="<%=basePath%>marketFloorImage.shtml?areanum='+areanum+'&floornum='+floornum+'&cpccorp='+cpccorp+'">');
    		$("#caribbean_wrap").live('resize',function(){
    			alert($("#caribbean_text").html());
    		});
    	}
    	
    	function getState(cpccorp,areanum,floornum){
    		clearTimeout(timeid);
    		var state1 =0;
	    	var state2 =0;
	    	var state3 =0;
    		var param = "cpccorp="+cpccorp+"&partion="+areanum+"-"+floornum;
    		var url="<%=request.getContextPath()%>/userAjax!findParAndCoor.shtml?rid="+Math.random();
   			$.getJSON(url,param,function(data){
   				var list = data.model.userlist;
   				var str = '';
   				var pot = '';
		    	for(var i = 0 ; i <list.length ; i ++){
   					point = (list[i].coordinate).split(",");
   					xp = parseInt(point[0])+(point[2]-point[0]-32)/2;
   					yp = parseInt(point[1])+(point[3]-point[1]-32)/2;
   					pot += list[i].coordinate+'|';
   					statestr = "";
   					if(list[i].cstate==1){
   						str = '<%=basePath %>images/connection.png';
   						statestr = "已连接";
   						state1++;
   					}else if(list[i].cstate==2){
   						str = '<%=basePath %>images/trading.png';
   						statestr = "交易中";
   						state2++;
   					}else if(list[i].cstate==3){
   						str = '<%=basePath %>images/noconnection.png';
   						statestr = "未连接";
   						state3++;
   					}
   					shiftzoom.construct(document.getElementById("caribbean"),[{x:xp,y:yp,w:32,h:32,src:str,id:'ico'+i}]);
					cvi_tip.add(cvi_tip.$("ico"+i),'<small>商家：</small><br/><big><b><u>'+list[i].orgname+'</u></b></big><br/><small>当前状态：</small><br/><big><b class="green">'+statestr+'</b></big>');
   				}
		    	$("#state1").text(state1);
				$("#state2").text(state2);
				$("#state3").text(state3);
		    	timeid = setTimeout('getState('+cpccorp+','+areanum+','+floornum+')',20000);
   			});
    	}
    	
    	function noImg(){
    		$(".mapbox-img").html("<div style='text-align:center; padding:20px 0;'>暂无楼层图信息,请重新选择!</div>");
    	}
    	/*******************************************/
  	</script>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：溯源秤状态 &gt; 查看楼层图</div>
		<div class="mapbox">
			<form method="post" name="searchform" id="searchform">
			<input type="hidden" id="cpccorp" name="cpccorp" value="${cpccorp}">
			<div class="mapbox-top">
				<div class="mapbox-tit"></div>
				<div class="mapbox-txt"></div>
				<div class="mapbox-area">
					<ul>
						<c:forEach items="${arealist}" var="obj" varStatus="i">
							<c:if test="${obj != null}">
								<c:if test="${i.index==0}">
								<li class="current" areaid="${obj.area}@${obj.areanum}">
									${obj.area}
								</li>
								</c:if>
								<c:if test="${i.index>0}">
								<li areaid="${obj.area}@${obj.areanum}">
									${obj.area}
								</li>
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<div class="mapbox-bod">
				<ul class="mapbox-bodl">
				</ul>
				<div class="mapbox-bodr" id="matdiv">
					<div class="mapbox-img">请等待，正在努力为你加载...</div>
				</div>
				<div class="clear"></div>
			</div>
			</form>
		</div>
		<div class="mapbox-bom">
			<b>注：</b>秤状态 [
	   		<span class="noconn">未连接</span>
	   		<span class="alconn">已开机</span>
	   		<span class="tdconn">交易中</span>]
	   		<span style="margin-left:100px">
	   			已开机： <b id="state1" class="red"></b> 
	   			交易中： <b id="state2" class="red"></b> 
	   			未连接： <b id="state3" class="red"></b>
	   		</span>
		</div>
  	</div>
  	<script type="text/javascript">
    	$(".mapbox-area li").live('click',function(){
    		$(".mapbox-area li").removeClass("current");
    		$(this).addClass("current");
    		var num = $(".mapbox-area li").index(this);
    		var txt = $.trim($(this).text()).length;
    		var cw = 0;
    		for(var i=0;i<=num;i++){
    			cw = cw + $(".mapbox-area li").eq(i).width()+20;
    		}
    		var left = parseInt($(".mapbox-area ul").css("left"),10);
    		var next = $(".mapbox-area li").eq(num+1);
    		var prev = $(".mapbox-area li").eq(num-1);
    		if(isNaN(left))left=0;
    		if(cw+next.width()+20>=($(".mapbox-area").width()+Math.abs(left))&&left<=0&&next.length>0){
    			var xx = cw-($(".mapbox-area").width()+Math.abs(left));
    			$(".mapbox-area ul").css("left","-"+(Math.abs(left)+xx+next.width()+20-txt)+"px");
    		};
    		if(prev.length>0&&cw-$(this).width()-prev.width()-40<=Math.abs(left)){
    			var xx = cw-Math.abs(left)-$(this).width()-20;
    			$(".mapbox-area ul").css("left","-"+(Math.abs(left)+xx-prev.width()-20+txt)+"px");
    		};
    		var area = $(this).attr("areaid").split("@")[0];
    		findMarketFloor(area);
    	});
    	$(".mapbox-bodl li").live('click',function(){
    		$(".mapbox-bodl li").removeClass("current");
    		$(this).addClass("current");
    		changeFloor();
    	});
    	
  	</script>
	</body>
</html>