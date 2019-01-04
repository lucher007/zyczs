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
        document.searchform.action="rp_Rate!companyUseRate.shtml";
        if($('#year').val()==""){
        	alert("请输入日期");
        	return;
        }
    	document.searchform.submit();
	}	
	
	$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [
                
                <c:forEach items="${requestScope.list}" var="tlist">
                '${tlist.month }',
				</c:forEach>
            
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0"> </td>' +
                '<td style="padding:0;font-size:10px"><b>{point.y:.1f} %</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: '${requestScope.year}',
            data: [
            <c:forEach items="${requestScope.list}" var="rlist">
            	<c:if test="${rlist.total!=0}">
            	${rlist.curTotal/rlist.total*100},
            	</c:if>
                <c:if test="${rlist.total==0}">
            	0,
            	</c:if>
				</c:forEach>
            ]

        }]
    });
});				
	</script>
  </head>
  
  <body>
     
<div id="body">
	    <div class="cur-pos">当前位置：统计分析 > 企业使用率</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">   
				生产日期： <input type="text" name="year" id="year" value="${requestScope.year}" size="10" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>
				
				&nbsp;
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    
    <div id="container" style="min-width:700px;height:400px"></div>
</div>
  </body>
</html>
