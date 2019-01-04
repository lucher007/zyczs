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
		<title>药材种植全年占比</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：监管平台 > 药材种植全年占比
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
			 <c:if test='${rp_state==null}' var='flag'>
			 	  $('#container').html('暂无统计数据！').css({
															  "font-family":"Arial",
															  "font-size":"20px",
															  "margin-top":"220px",
															  "margin-left":"300px"
														  });
			 </c:if>
			 <c:if test='${!flag}'>
		    $('#container').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: ''
		        },
		        tooltip: {
		    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    color: '#000000',
		                    connectorColor: '#000000',
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: '药材种植全年占比',
		            data: [
		                ['一月', ${rp_state.m1}],
		                ['二月', ${rp_state.m2}],
		                ['三月', ${rp_state.m3}],
		                ['四月', ${rp_state.m4}],
		                ['五月',   ${rp_state.m5}],
		                ['六月',   ${rp_state.m6}],
		                ['七月',   ${rp_state.m7}],
		                ['八月',   ${rp_state.m8}],
		                ['九月',   ${rp_state.m9}],
		                ['十月',   ${rp_state.m10}],
		                ['十一月',   ${rp_state.m11}],
		                ['十二月',   ${rp_state.m12}]
		            ]
		        }]
		    });
		    	</c:if>
	       /**
	       *选择年份后查询
	       */ 
	       $("#search").click(function(){
				if($("#year").val() == null || $("#year").val() == ""){
					$.dialog.tips('请选择年份查询',1,'alert.gif');
					return false;
				}
	       		$("#myform").attr("action","rp_Stat!findMedRateByYear.shtml");
	  			$("#myform").submit();
	       }); 
   	 });
    
	</script>
	</body>
</html>