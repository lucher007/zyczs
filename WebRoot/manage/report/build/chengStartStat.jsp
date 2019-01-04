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
<title>溯源秤开机统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 建设统计</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     溯源秤开机统计
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	           <table width="100%">
                 <tr>
                    <td height="26" >开始日期：</td>
                    <td>
                    	<input type="text" name="operstarttime" id="operstarttime" value="${fn:substring(operstarttime,0,11)}" class="Wdate inp w100" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'operendtime\');}'});"/>
                    </td>
                    <td>结束日期：</td>
                    <td>
                    	<input type="text" name="operendtime" id="operendtime" value="${fn:substring(operendtime,0,11)}" class="Wdate inp w100" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'operstarttime\');}'});">
					</td>
					<td>
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
		$("#searchform").attr("action","rp_Build!chengStartStat.shtml");
		$("#searchform").submit();
	}
	
	function checkForm_exp(){
		$("#searchform").attr("action","rp_Build!chengStartStat_excel.shtml");
		$("#searchform").submit();
	}	   
   
   //绘制图形报表
   $(function () {
    
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 1,//null,
            plotShadow: false
        },
        title: {
            text: '溯源秤开机率'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.2f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: '溯源秤',
            data: [
                ['已开机',   ${build.rate}*100],
                ['未开机',   100-${build.rate}*100],
            ]
        }]
    });
});

    
    
    
   
   
</script>
</body>
</html>
 