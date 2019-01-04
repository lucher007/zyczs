<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>称的运行状况</title>
	<link type="text/css" rel="stylesheet" href="/style/user.css">
    <style type="text/css">
        #container
        {
            width:100%;
            height:460px;
        }
        .boxc{ line-height:20px;}
    </style>
    <script type="text/javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
</head>
<body>
    <div class="seh-box">
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
    <div id="container">
    </div>
    <script type="text/javascript">
    	//称的状态
    	var state1 =0;
    	var state2 =0;
    	var state3 =0;
    	/**
    	*读取后台数据根据经纬度显示在地图上
    	*/
    	$(function(){
	    	var param="";
			var url="<%=request.getContextPath()%>/orgAjax!findOrgCheng.shtml?rid="+Math.random();
			$.getJSON(url,param,function(data){
				findOrgChengReturn(data);
			});
	    });
	    /**
	    *回调函数
	    */
	    function findOrgChengReturn(responseText){
	    	var loginForm = responseText;    		
	    	var list = loginForm.model.orglist;
	    	//创建地图容器
    		window.map = new BMap.Map("container");
    		//清除图层
    		map.clearOverlays();
	    	for(var i = 0 ; i < list.length ; i++){
	    			var obj = list[i];
	    			//声明点对象
	    		    var point = new BMap.Point(obj.longitude,obj.latitude);
	    		    //创建自定义图标
	    		     var img;
	    		     if(obj.state == 1){
	    		     	img="<%=basePath %>images/connection.png";
   					 }else if(obj.state == 2){
   						img="<%=basePath %>images/trading.png";
   					 }else if(obj.state == 3){
   					 	img="<%=basePath %>images/noconnection.png";
   					 }
   					 
   					 if(obj.zyctype == '00001000'){
   					 	img="<%=basePath %>images/market.png";
   					 }
   					 
	    		    // 创建图标对象  
					var myIcon = new BMap.Icon(img, new BMap.Size(32, 32));    
	    		    
	    		    //声明marker对象
	    		    var marker = new BMap.Marker(point, {icon: myIcon});  
	    		     //标记地图
	    		    map.addOverlay(marker);
	    		    //这里一定要用这种方式创建infoWindow,不清楚为什么
	    			(function(){
						var _obj = obj;
						var _iw = createInfoWindow(_obj);
						var _marker = marker;
						 //单击标注,显示信息窗口
						_marker.addEventListener("click",function(){
								//this.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
								this.openInfoWindow(_iw);
						  });
						  /*关闭信息窗口,关闭对应的标注动画
						 _iw.addEventListener("close",function(){
						     _marker.setAnimation();
						 });*/
					})()
	    			marker.disableDragging(); //启用拖拽
	    		}
		            map.addControl(new BMap.NavigationControl()); //左上角控件
		            map.enableScrollWheelZoom(); //滚动放大
		            map.enableKeyboard(); //键盘放大
		            map.centerAndZoom(new BMap.Point(104.073446,30.658395),5); //初始化以第一个点作为中心点
		            map.addControl(new BMap.OverviewMapControl());//添加默认缩略地图控件
					map.addControl(new BMap.OverviewMapControl({isOpen:true, anchor: BMAP_ANCHOR_TOP_RIGHT}));//右上角，打开
					$("#state1").text(state1);
					$("#state2").text(state2);
					$("#state3").text(state3);
	    }
	   
        /**
        *创建InfoWindow
        */
		function createInfoWindow(obj){
					 var title = "称的运行状况";
					 if(obj.zyctype == '00001000'){
					 	title = "药材市场";
					 }
					//创建信息窗口对象
		    		var opts  = {
		                width: 300,     // 信息窗口宽度  
		                height: 150,     // 信息窗口高度  
		                title: "<b class='f14 red'>"+title+"</b>"  // 信息窗口标题  
		            }
		            var str;
		            if(obj.zyctype != '00001000'){
		            	str  = "<ul class='boxc'><li>机构名称:"+obj.orgname+"</li>"
	    					 +"<li>秤编号:"+obj.chengcode+"</li>"
	    					 +"<li>秤状态:";
	    					 if(obj.state == 1){
	    					 	str+="已开机";
	    					 	state1+=1;
	    					 }else if(obj.state == 2){
	    					 	str+="交易中";
	    					 	state2 += 1;
	    					 }else if(obj.state == 3){
	    					 	str+="未连接";
	    					 	state3 += 1;
	    					 }
	    					 str += "</li>";
	    					
	    					 str+="<li>是否锁定:";
	    					 if(obj.locked == 0){
	    					 	str += "正常工作";
	    					 }else if(obj.locked == 1){
	    					 	str += "已锁定";
	    					 }else if(obj.locked == 2){
	    					 	str += "锁定中";
	    					 }else{
	    					 	str += "解锁中";
	    					 }
	    					 str += "</li>";
	    					 
	    					 str+="<li>机构类型:";
	    					 if(obj.zyctype == '10000000'){
	    					 	str += "药材种植";
	    					 }else if(obj.zyctype == '01000000'){
	    					 	str += "药材经销商";
	    					 }else if(obj.zyctype == '00100000'){
	    					 	str += "饮片生产";
	    					 }else if(obj.zyctype == '00010000'){
	    					 	str += "饮片经销商";
	    					 }else if(obj.zyctype == '00001000'){
	    					 	str += "药材市场  ";
	    					 	var link = "<a href='<%=basePath%>marketMap!findMarketAreaByCpc.shtml?cpccorp="+obj.cpccorp+"' class='btn-look'>进入市场平面图</a>"
	    					 	str += link;
	    					 }else if(obj.zyctype == '00000100'){
	    					 	str+="医院";
	    					 }
	    					 if(obj.zyctype != '00001000'){
		    					 str += "</br><a href='<%=basePath %>cheng!findChengDataByList_chengCode.shtml?chengcode="+obj.chengcode+"&opertype=0' class='btn-look'>交易记录</a>";
		    					 str += "<a href='<%=basePath %>manage/map/chengStateChart.jsp?chengcode="+obj.chengcode+"' class='btn-look'>前一周状态变化</a>";
		    					 str += "<a href='<%=basePath %>cheng!findChengStateLogByList_chengCode.shtml?chengcode="+obj.chengcode+"&opertype=0' class='btn-look'>历史状态变化</a>";
	    					 }
		            }else{
		            		str  = "<ul class='boxc'><li>机构名称:"+obj.orgname+"</li>";
		            		str+="<li>企业cpc:"+obj.cpccorp+"</li><li>注册地址:"+obj.registeraddress+"</li><li>电子邮件:"+obj.email+"</li>"
		            		str += "药材市场  ";
    					 	var link = "<a href='<%=basePath%>marketMap!findMarketAreaByCpc.shtml?cpccorp="+obj.cpccorp+"' class='btn-look'>进入市场平面图</a>"
    					 	str += link;
    					 	
		            }
				    
	    					str += "</li></ul>";
						    var iw = new BMap.InfoWindow(str,opts);
						    return iw;
		}
		
    </script>
</body>
</html> 