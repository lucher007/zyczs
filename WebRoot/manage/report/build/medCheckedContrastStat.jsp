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
<title>中药材流通追溯检验率同比</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 使用统计</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     中药材检验率同比
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
		
		$("#searchform").attr("action","rp_Build!medCheckedContrastStat.shtml");
		$("#searchform").submit();
	}	   
   
  $(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '中药材检验率同比'
        },
        xAxis: {
            categories: [
                '一',
                '二',
                '三',
                '四',
                '五',
                '六',
                '七',
                '八',
                '九',
                '十',
                '十一', 
                '十二'
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: '检验率 (%)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table style="width:150px">',
            pointFormat: '<tr><td style="color:{series.color};padding:0;width:80px">{series.name}: </td><td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
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
            name: '${fn:substring(opertime,0,11)}检验率',
            data: [
	             ${checkedmap['01']*100},
	             ${checkedmap['02']*100},
	             ${checkedmap['03']*100},
	             ${checkedmap['04']*100},
	             ${checkedmap['05']*100},
	             ${checkedmap['06']*100},
	             ${checkedmap['07']*100},
	             ${checkedmap['08']*100},
	             ${checkedmap['09']*100},
	             ${checkedmap['10']*100},
	             ${checkedmap['11']*100},
	             ${checkedmap['12']*100}
	           ]
           },{
            name: '${fn:substring(opertime,0,11)-1}检验率',
            data: [
	             ${checkedcontrastmap['01']*100},
	             ${checkedcontrastmap['02']*100},
	             ${checkedcontrastmap['03']*100},
	             ${checkedcontrastmap['04']*100},
	             ${checkedcontrastmap['05']*100},
	             ${checkedcontrastmap['06']*100},
	             ${checkedcontrastmap['07']*100},
	             ${checkedcontrastmap['08']*100},
	             ${checkedcontrastmap['09']*100},
	             ${checkedcontrastmap['10']*100},
	             ${checkedcontrastmap['11']*100},
	             ${checkedcontrastmap['12']*100}
	           ]
           }]
    });
});
    
   
   
</script>
</body>
</html>
 