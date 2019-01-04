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
		<title>主要药材交易量走势</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：监管平台 > 主要药材交易量走势
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
				<div id="container" style="min-width: 700px;height: 400px;margin-top: 30px"></div>
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
	            		<c:if test='${fn:length(list)==0}' var='flag'>
	            			{
				            name: '暂无数据',
				            data: [0,0,0,0,0,0,0,0,0,0,0,0]
				       		}
	            		</c:if>
	            		<c:if test='${!flag}'>
		            		<c:forEach items="${list}" var="plant" varStatus="vs">
		            		{
			                name: '${plant.plantname}',
			                data: 
			                [
			                	${plant.m1},${plant.m2},${plant.m3},${plant.m4},${plant.m5},${plant.m6},
						 		${plant.m7},${plant.m8},${plant.m9},${plant.m10},${plant.m11},${plant.m12}
					 		]
					 		}	
					 		<c:if test="${fn:length(list)!=(vs.index+1)}">
						 		,
						 	</c:if>
					 		</c:forEach>
					  </c:if>
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
	       		$("#myform").attr("action","rp_Stat!findSellWeightByYear_NotAdmin.shtml");
	  			$("#myform").submit();
	       }); 
	        
   	 });
    
	</script>
	</body>
</html>