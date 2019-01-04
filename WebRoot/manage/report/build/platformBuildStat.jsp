<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>平台建设监控统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 建设统计</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     平台建设监控统计(单位:户)
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	          <table width="100%">
                  <tr>
                    <td height="26"  align="right">开始日期：</td>
                    <td>
                    	<input type="text" name="operstarttime" id="operstarttime" value="${fn:substring(operstarttime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'operendtime\');}'});"/>
                    </td>
                    <td align="right">结束日期：</td>
                    <td>
                    	<input type="text" name="operendtime" id="operendtime" value="${fn:substring(operendtime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'operstarttime\');}'});">
					</td>
					<td colspan="2">
						<input type="button" value="查询" class="sch" onclick="return checkForm();">
					</td>
					<td>
						<cite><a href="javascript:void(0)" class="btn-a" onclick="return checkForm_exp();"><span class="new">导出EXCEL</span></a></cite>
					</td>
                  </tr>
                </table>   
	        </form>
		    </div>
		    <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		  	  <tr>
				<td style="padding:0">
				  <div id="container" style="min-width: 400px; max-width: 600px; height: 400px; margin: 0 auto"></div>   
				</td>
              </tr>
            </table>
            <br/>
		</div>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaSearch.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/highcharts.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/highcharts-more.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/exporting.js"></script>
<script type="text/javascript">
   function checkForm(){
		
		$("#searchform").attr("action","rp_Build!platformBuildStat.shtml");
		$("#searchform").submit();
	}	   
   
   function checkForm_exp(){
		$("#searchform").attr("action","rp_Build!platformBuildStat_excel.shtml");
		$("#searchform").submit();
	}	
   
   
   //绘制图形报表
   $(function () {
       
	$('#container').highcharts({
	    chart: {
	        polar: true,
	        type: 'line'
	    },
	    
	    title: {
	        text: '',
	        x: -100
	    },
	    
	    pane: {
	    	size: '90%'
	    },
	    
	    xAxis: {
	       
	        categories: [
            	<c:forEach items="${buildlist}" var="build" varStatus="vs">
	            	 <c:if test="${build.zyctype=='10000000'}">
	  		        	'药材种植',
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='01000000'}">
	  		        	'药材经销',
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00100000'}">
	  		        	'饮片生产',
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00010000'}">
	  		        	'饮片经销',
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='01000000-'}">
	  		        	'市场经营户',
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00000100'}">
	  		        	'医院药店',
	  		    	 </c:if>
            	</c:forEach>
            ],
	        
	        tickmarkPlacement: 'on',
	        lineWidth: 0
	    },
	        
	    yAxis: {
	        gridLineInterpolation: 'polygon',
	        lineWidth: 0,
	        min: 0
	    },
	    
	    tooltip: {
	    	shared: true,
	        pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y}</b><br/>'
	    },
	    
	    legend: {
	        align: 'right',
	        verticalAlign: 'top',
	        y: 70,
	        layout: 'vertical'
	    },
	    
	   series: [{
	        name: '建设情况',
	        data: [
	        	<c:forEach items="${buildlist}" var="build" varStatus="vs">
	            	 <c:if test="${build.zyctype=='10000000'}">
	  		        	${build.num},
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='01000000'}">
	  		        	${build.num},
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00100000'}">
	  		        	${build.num},
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00010000'}">
	  		        	${build.num},
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='01000000-'}">
	  		        	${build.num},
	  		    	 </c:if>
	  		    	 <c:if test="${build.zyctype=='00000100'}">
	  		        	${build.num},
	  		    	 </c:if>
            	</c:forEach>
            ],
	       
	        pointPlacement: 'on'
	    }]

	});
});
    
    
    
   
   
</script>
</body>
</html>
 