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
    	     中药材流通追溯打码数量(单位:万个)
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	          <table width="100%">
                  <tr>
                    <td height="26"  align="right">查询年份：</td>
                    <td>
                    	<input type="text" name="opertime" id="opertime" value="${fn:substring(opertime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy'});"/>
                    </td>
					<td colspan="4">
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
		
		$("#searchform").attr("action","rp_Build!codeNumStat.shtml");
		$("#searchform").submit();
	}	   
   
   //绘制图形报表
   $(function () {
       $('#container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: '中药材每月打码数量'
        },
        subtitle: {
            text: ' '
        },
        xAxis: {
            categories: ['一', '二', '三', '四', '五', '六',
                '七', '八', '九', '十', '十一', '十二']
        },
        yAxis: {
            title: {
                text: '打码数量(万个)'
            },
            labels: {
                formatter: function() {
                    return this.value +'°'
                }
            }
        },
        tooltip: {
            crosshairs: true,
            shared: true
        },
        plotOptions: {
            spline: {
                marker: {
                    radius: 4,
                    lineColor: '#666666',
                    lineWidth: 1
                }
            }
        },
        series: [{
            name: '${fn:substring(opertime,0,11)}打码数',
            marker: {
                symbol: 'square'
            },
            data: [
              ${buildmap['01']/10000},
              ${buildmap['02']/10000},
              ${buildmap['03']/10000},
              ${buildmap['04']/10000},
              ${buildmap['05']/10000},
              ${buildmap['06']/10000},
              ${buildmap['07']/10000},
              ${buildmap['08']/10000},
              ${buildmap['09']/10000},
              ${buildmap['10']/10000},
              ${buildmap['11']/10000},
              ${buildmap['12']/10000}
            ]
        }]
    });
		
   });
    
    
    
   
   
</script>
</body>
</html>
 