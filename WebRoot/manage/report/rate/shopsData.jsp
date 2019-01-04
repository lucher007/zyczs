<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
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
        document.searchform.action="rp_Rate!shopsData.shtml";
        if($('#year').val()==""){
        	alert("请输入日期");
        	return;
        }
        
    	document.searchform.submit();
	}	
	
	$(function () {
    $('#container').highcharts({
        title: {
            text: '药材市场溯源商户数',
            x: -20 //center
        },
        subtitle: {
            text: '',
            x: -20
        },
        xAxis: {
            categories: [
            <c:forEach items="${requestScope.list}" var="tlist">
                '${tlist.month }',
				</c:forEach>
            ]
        },
        yAxis: {
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '户'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: ':',
            data: [
            <c:forEach items="${requestScope.list}" var="rlist">  	
            	${rlist.total}
            	,
			</c:forEach>
            ]
        }]
    });
});
				
	</script>
  </head>
  
  <body>
     
<div id="body">
	    <div class="cur-pos">当前位置：统计分析 > 溯源商户数</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">   
				日期： <input type="text" name="year" id="year" value="${requestScope.year}" size="10" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>
				
				&nbsp;
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    
    <div id="container" style="min-width:700px;height:400px"></div>
</div>
  </body>
</html>
