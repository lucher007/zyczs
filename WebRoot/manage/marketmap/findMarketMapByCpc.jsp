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
   		<link type="text/css" rel="stylesheet" href="/js/plugin/imgareaselect/imgareaselect-animated.css">
		<script type="text/javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" src="/js/plugin/imgareaselect/jquery.imgareaselect.min.js"></script>
		<script type="text/javascript" src="/js/plugin/imgzoom/shiftzoom.js"></script>
		<script type="text/javascript" src="/js/form.js"></script>
		<script type="text/javascript" src="/js/comtools.js"></script>
		<script type="text/javascript" language="javascript">
		if(document.images&&document.createElement&&document.getElementById){ 
		    document.writeln('<style type="text/css">'); 
		    document.writeln('img.shiftzoom { visibility: hidden; }'); 
		    document.writeln('<\/style>'); 
		} 
		shiftzoom.defaultCurpath = '/js/plugin/imgzoom/images/cursors/';
		shiftzoom.defaultButtons = false;
		shiftzoom.defaultNozoom = true;
		shiftzoom.defaultOverview = false;
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
    	var imgApi=null;
    	var pot;
    	function changeFloor(){
    		if($(".mapbox-area").find('li[class="current"]').length == 0){
    			$(".mapbox-img").html("<div style='text-align:center; padding:20px 0;'>请先联系地方监管管理员添加该市场区域楼层后操作!</div>");
    			return;
    		}
    		if(imgApi!=null)imgApi.cancelSelection();
    		//parent.bindButton("");
    		var areanum = $(".mapbox-area").find('li[class="current"]').attr("areaid").split("@")[1];
    		var floornum = $(".mapbox-bodl").find('li[class="current"]').attr("fid").split("@")[1];
    		var cpccorp = $("#cpccorp").val();
   			$(".mapbox-img").html('<img onerror="noImg()" id="caribbean" width="712" height="405" class="shiftzoom" onLoad="shiftzoom.add(this,{showcoords:true,zoom:100});getPoint('+cpccorp+','+areanum+','+floornum+');" src="<%=basePath%>marketFloorImage.shtml?areanum='+areanum+'&floornum='+floornum+'&cpccorp='+cpccorp+'">');	
    	}
    	
    	/**
    	*获取区域坐标
    	*/
    	function getPoint(cpccorp,areanum,floornum){
    		var param = "cpccorp="+cpccorp+"&partion="+areanum+"-"+floornum;
    		var url="<%=request.getContextPath()%>/userAjax!findParAndCoor.shtml?rid="+Math.random();
    		$.getJSON(url,param,function(data){
   				var list = data.model.userlist;
   				var str = '';
   				pot = '';
   				for(var i = 0 ; i <list.length ; i ++){
   					point = (list[i].coordinate).split(",");
   					width = point[2]-point[0];
   					height = point[3]-point[1];
   					pot += list[i].coordinate+'|';
   					str += '<span id="'+list[i].partion+'" class="tipspan" style="left:'+point[0]+'px; top:'+point[1]+'px; width:'+width+'px; height:'+height+'px;">'+list[i].orgname+'</span>';
   				};
    			$("#caribbean_wrap").append(str);
    		});
    	}
    	
    	function bindPoint(){
    		shiftzoom.set(document.getElementById("caribbean"), 'nopan', true);
    		if($(".mapbox-area").find('li[class="current"]').attr("areaid")==undefined){
    			return;
    		}
    		var areanum = $(".mapbox-area").find('li[class="current"]').attr("areaid").split("@")[1];
    		if($(".mapbox-bodl").find('li[class="current"]').attr("fid")==undefined){
    			return;
    		}
	    	var floornum = $(".mapbox-bodl").find('li[class="current"]').attr("fid").split("@")[1];
    		var cpccorp = $("#cpccorp").val();
    		var obj = $('#caribbean_wrap');
    		if(obj.length<=0){
    			obj = $('.mapbox-img');
    		};
    		imgApi = obj.imgAreaSelect({
				handles: true,
				instance: true,
				onSelectEnd: function(img,selection){
					var selArray=new Array(2);
					var w = selection.width;
					var h = selection.height;
					var x1 = selection.x1;
					var y1 = selection.y1;
					var x2 = selection.x2;
					var y2 = selection.y2;
					var partion = areanum+"-"+floornum;
					var coordinate = x1+","+y1+","+x2+","+y2;
					selArray[0] = partion;
					selArray[1] = coordinate;
					if(pot == undefined){
						return;
					}
					if(pot.indexOf("|")>-1){
						var pia = pot.split("|");
						for(var x=0;x<pia.length;x++){
							if(pia[x].indexOf(",")>-1){
								var pio = pia[x].split(",");
								if((x1<pio[0]&&x2>pio[0]||x1>pio[0]&&x1<pio[2])&&(y2>pio[1]&&y2<pio[3]||y1>pio[1]&&y1<pio[3])){
									var api = parent.t1, W = api.opener;
									W.$.dialog.alert('该区域已被其他商家占用，请重新选择！',function(){
										imgApi.cancelSelection();
									},api);
									selArray[0] = "";
									selArray[1] = "";
								};
							};
						};
					};
					parent.closeMarketMap(selArray);
				}
			});
    	}
    	
    	function unBindPoint(){
    		if(imgApi!=null){
    			imgApi.cancelSelection();
    			imgApi.setOptions({disable:true});
    		}
    		shiftzoom.set(document.getElementById("caribbean"), 'nopan', false);
    	}
    	
    	function noImg(){
    		$(".mapbox-img").html("<div style='text-align:center; padding:20px 0;'>暂无楼层图信息,请重新选择!</div>");
    	}
    	/*******************************************/
  	</script>
	</head>

	<body style="padding:0;">
		<div class="mapbox" style="margin-top:0;">
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
    		if(imgApi!=null){
    			imgApi.cancelSelection();
    		}
    	});
    	$(".mapbox-bodl li").live('click',function(){
    		$(".mapbox-bodl li").removeClass("current");
    		$(this).addClass("current");
    		changeFloor();
    		if(imgApi!=null){
    			imgApi.cancelSelection();
    		}
    	});
  	</script>
	</body>
</html>

