<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<title>溯源药材销售量</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：监管平台 > 溯源药材销售量
			</div>
			<div class="seh-box">
					<form action="" method="post" name="myform" id="myform" />
						统计年份:
						<input type="text" class="inp" name="year" value="${year}"
									id="year"
									onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy'});"
									 />
						<input type="button" value="查询" class="sch" id="search"/>
			</div>
				<div id="container" style="min-width: 700px; height: 400px;margin-top: 30px"></div>
		</div>

		<script type="text/javascript" language="javascript"src="js/common/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
		<script type="text/javascript" language="javascript" src="js/highcharts/highcharts.js"></script>
		<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
		<script type="text/javascript" language="javascript">
		
		$(function () {
			
	        $('#container').highcharts({
	            title: {
	                text: '',
	                x: -20 //center
	            },
	            subtitle: {
	                text: '',
	                x: -20
	            },
	            xAxis: {
	                categories: [
		                 '一月', '二月', '三月', '四月', '五月', '六月','七月', '八月', '九月', '十月', '十一月', '十二月'
	                ]
	            },
	            yAxis: {
	                title: {
	                    text: '单位(吨)'
	                },
	                plotLines: [{
	                    value: 0,
	                    width: 1,
	                    color: '#808080'
	                }]
	            },
	            tooltip: {
	                valueSuffix: '吨'
	            },
	            legend: {
	                layout: 'vertical',
	                align: 'right',
	                verticalAlign: 'middle',
	                borderWidth: 0
	            },
	            series: [
		            		{
			                name: '溯源药材销售量',
			                data: 
			                [
			                	${rp_state.m1},${rp_state.m2},${rp_state.m3},${rp_state.m4},${rp_state.m5},${rp_state.m6},
						 		${rp_state.m7},${rp_state.m8},${rp_state.m9},${rp_state.m10},${rp_state.m11},${rp_state.m12}
					 		]
					 		}	
	             ]
	        });
	        
	        
	       /**
	       *选择年份后查询
	       */ 
	       $("#search").click(function(){
				if($("#year").val() == null || $("#year").val() == ""){
					$.dialog.tips('请选择年份查询',1,'alert.gif');
					return false;
				}
	       		$("#myform").attr("action","rp_Stat!findSellWeightByYear.shtml");
	  			$("#myform").submit();
	       }); 
	        
   	 });
    
	</script>
	</body>
</html>