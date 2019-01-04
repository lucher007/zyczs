<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript" language="javascript" src="js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="js/highcharts/highcharts.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<link type="text/css" rel="stylesheet" href="/style/production.css">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	
	function checkForm(){
        document.searchform.action="rp_Rate!companyUseRate_month.shtml";
        
        if($('#month').val()==""){
        	alert("请输入日期");
        	return;
        }
    	document.searchform.submit();
	}	
	
	$(function () {
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '企业使用率(月份), ${month}'
        },
        tooltip: {
    	    pointFormat: ' <b>{point.percentage:.1f}%</b>'
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
            name: '',
            data: [
                
                <c:forEach items="${requestScope.list}" var="rlist">
            	['企业总数',${rlist.total}],['使用数',${rlist.curTotal}]
				</c:forEach>
            ]
        }]
    });
});				
	
	</script>
  </head>
  
  <body>
     
<div id="body">
	    <div class="cur-pos">当前位置：统计分析 > 企业使用率-月比</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">   
				月份： <input type="text" name="month" id="month" value="${requestScope.month}" size="10" onfocus="WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false })" class="Wdate"/>
				
				&nbsp;
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    
    <div id="container" style="min-width:700px;height:400px"></div>
</div>
  </body>
</html>
