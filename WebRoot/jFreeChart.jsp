<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript">
		function changeChart(charType){     
			var type = charType.options[charType.selectedIndex].value;    
			var width = document.getElementById("chartWidthId").value;  
			var height = document.getElementById("chartHeightId").value;  
			var url = "";
			if(type == "bar" ){
			    url = "sellTotalWeightStat!getTotalWeightJFreeChartLineStat.shtml";
			}else if (type == "pie" ){
			    url = "jFreeChartStat!buildPieChart.shtml";
			}else if (type == "line" ){
				url = "jFreeChartStat!buildLineChart.shtml";
			}
			var neSrc = url + "?time="+Math.random()+"&width="+width+"&height="+height;   
			
			document.getElementById("chart").innerHTML="<IMG  SRC="+neSrc+">";  
		}  
		
	</script>
	
	
	
  </head>
  
  <body>
          宽：<input type="text" name="chartWidth" id="chartWidthId" value="500">  
          高：<input type="text" name="chartHeight" id="chartHeightId" value="300">  
	<select onchange="changeChart(this)">  
		<option value="bar">柱图</option>  
		<option value="pie">饼图</option>  
		<option value="line">折线图</option>  
	</select>  
	<br/>  
	<br/>  
	<hr/>  
	<div id="chart"  style="padding-top: 10px" mce_style="padding-top: 10px" style="position:" >   
	</div>  
     
  </body>
</html>
