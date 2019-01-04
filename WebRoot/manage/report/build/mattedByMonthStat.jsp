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
<title>流通追溯合格率按月比</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 使用统计</div>
	<div class="form-box">
    	<div class="fb-tit">
    	   流通追溯合格率按月比
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	           <table width="100%">
                  <tr>
                    <td height="26"  align="right">查询类型：</td>
                    <td >
                    	<select id="checktype" name="checktype" style="width:128px">
                    		<option value="0" <c:if test="${requestScope.checktype == '0' }">selected</c:if>>中药材</option>
                    		<option value="1" <c:if test="${requestScope.checktype == '1' }">selected</c:if>>中药饮片</option>
                    	</select>
                    </td>
                    <td height="26"  align="right"> 统计月份：</td>
                    <td>
                    	<input type="text" name="opertime" id="opertime" value="${fn:substring(opertime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM'});"/>
                    </td>
					<td colspan="2">
						<input type="button" value="查询" class="sch" onclick="return checkForm();">
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
		$("#searchform").attr("action","rp_Build!mattedByMonthStat.shtml");
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
            text: '流通追溯合格率按月比'
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
            name: '合格率',
            data: [
                ['已合格',   ${build.mattedrate}*100],
                ['未合格',   ${1-build.mattedrate}*100],
            ]
        }]
    });
});

    
    
    
   
   
</script>
</body>
</html>
 