<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
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
		<title>药材价格指数</title>	
	   	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	   	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	   	<script type="text/javascript" language="javascript" src="js/highcharts/highcharts.js"></script>
	   	<link type="text/css" rel="stylesheet" href="/style/plant.css">
  </head>
  
  <body>
  	<div id="body">
		<div class="cur-pos">
			当前位置：统计分析 > 价格指数
		</div>
		<div class="seh-box">
				<form action="" method="post" name="myform" id="myform">
				<input type="hidden" id="indexusername" name="indexusername">
				<input type="hidden" id="corptype" name="corptype" value="1">
				<input type="hidden" id="orgid" name="orgid" value="${User.orgid}">
				<input type="hidden" id="indexweekperiod" name="indexweekperiod" value="${indexweekperiod }">
					<span>请选择品名查询:</span>
	  				<select id="sel_mainMeds" onchange="changeVal()" class="inp" >
	  					<option value="-1">--请选择--</option>
	  					<c:forEach items="${medstorage}" var="item">
	  						<option value="${item.medname }" <c:if test='${item.medname==indexusername}'>selected</c:if>>${item.medname }</option>
	  					</c:forEach>
	  				</select>
	  				<input type="button" value="月浏览" id="btn_month" class="sch">
	  				<input type="button" value="周浏览" id="btn_week" class="sch">
	  	开始时间：
		<input type="text" name="startindexweekdate" id="startindexweekdate" value="${fn:substring(startindexweekdate,0,11)}" class="Wdate inp w80" 
		onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'endindexweekdate\');}'});">
		&nbsp;
		结束时间:
		<input type="text" name="endindexweekdate" id="endindexweekdate" value="${fn:substring(endindexweekdate,0,11)}" class="Wdate inp w80" 
		onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'startindexweekdate\');}'});">
		&nbsp;
		<input type="button" value="查  询" id="search" class="sch">
  				</form>
		</div>
		<div id="container" style="min-width: 700px; height: 380px;margin-top: 30px"></div>	
  </div>
 <script type="text/javascript" language="javascript">
 $(function () {
 	getData();
 	
 	$("#btn_month").click(function(){
 		$("#indexweekperiod").val("month");
 		$("#indexusername").val($("#sel_mainMeds").val());
	 	$("#myform").attr("action","indexUser!findPriceChart_medSell.shtml");
	 	$("#myform").submit();
 	});
 	
 	$("#btn_week").click(function(){
 		$("#indexweekperiod").val("week");
 		$("#indexusername").val($("#sel_mainMeds").val());
	 	$("#myform").attr("action","indexUser!findPriceChart_medSell.shtml");
	 	$("#myform").submit();
 	});
 	
 	$("#search").click(function(){
 		$("#indexusername").val($("#sel_mainMeds").val());
	 	$("#myform").attr("action","indexUser!findPriceChart_medSell.shtml");
	 	$("#myform").submit();
 	});
 	
 	
 });
 
 function changeVal(){
 	$("#indexusername").val($("#sel_mainMeds").val());
 	$("#myform").attr("action","indexUser!findPriceChart_medSell.shtml");
 	$("#myform").submit();
 }
 
 
 function getData(){
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
                <c:forEach items="${indexuserlist}" var="indexuser" varStatus="vs">
	            	'${indexuser.indexweekdate}',
	            </c:forEach>
               ]
           },
           yAxis: {
               title: {
                   text: '单位(元/Kg)'
               },
               plotLines: [{
                   value: 0,
                   width: 1,
                   color: '#808080'
               }]
           },
           tooltip: {
               valueSuffix: '(元/Kg)'
           },
           legend: {
               layout: 'vertical',
               align: 'right',
               verticalAlign: 'middle',
               borderWidth: 0
           },
           series: [
           			<c:if test='${fn:length(indexuserlist)==0}' var='flag'>
            			{
			            name: '暂无数据',
			            data: [0,0,0,0,0,0,0,0,0,0,0,0]
			       		}
	            	</c:if>
           			<c:if test='${!flag}'>
            	    {
	                name: '药材价格指数',
	                data: 
	                [
	                	 <c:forEach items="${indexuserlist}" var="indexuser" varStatus="vs">
			            	${indexuser.indexweekvalue},
			            </c:forEach>
			 		  ]
			 		}	
			 	  </c:if>
            ]
       });
 }
</script> 
</body>
</html>
 