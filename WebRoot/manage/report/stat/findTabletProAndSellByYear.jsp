<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>饮片生产量与销售量</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：监管平台 > 饮片生产量与销售量
			</div>
			<div class="seh-box">
					<form action="" method="post" name="myform" id="myform" />
						统计年份:
						<input type="text" class="inp" name="year" value="${year}"
									id="year"
									onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy'});"
									 />
						<input type="button" value="查询" class="sch" id="search"/>
			</div>
				<div id="container" style="min-width: 700px; height: 400px;margin-top: 30px"></div>
		</div>

<script type="text/javascript" language="javascript"src="js/common/jquery.js"></script>
<script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
<script type="text/javascript" language="javascript" src="js/highcharts/highcharts.js"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript" language="javascript">

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
              '一月', '二月', '三月', '四月', '五月', '六月','七月', '八月', '九月', '十月', '十一月', '十二月'
          ]
      },
      yAxis: {
          min: 0,
          title: {
              text: '吨'
          }
      },
      tooltip: {
          headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
              '<td style="padding:0"><b>{point.y:.7f} 吨</b></td></tr>',
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
      series: [
   	  {
      	 <c:if test="${tabletsells != null}" var="flag_tabletsells">
         	name: '生产量',
            data: [${tabletsells.m1}, ${tabletsells.m2}, ${tabletsells.m3}, ${tabletsells.m4}, ${tabletsells.m5}, ${tabletsells.m6},${tabletsells.m7}, ${tabletsells.m8}, ${tabletsells.m9}, ${tabletsells.m10}, ${tabletsells.m11}, ${tabletsells.m12}]
		 </c:if>
		 <c:if test="${!flag_tabletsells}">
		 	name: '生产量',
            data: []
		 </c:if>
      }, 
      {
         <c:if test="${tabletproduces != null}" var="flag_tabletproduces">
         	name: '销售量',
         	data: [${tabletproduces.m1}, ${tabletproduces.m2}, ${tabletproduces.m3}, ${tabletproduces.m4}, ${tabletproduces.m5}, ${tabletproduces.m6},${tabletproduces.m7}, ${tabletproduces.m8}, ${tabletproduces.m9}, ${tabletproduces.m10}, ${tabletproduces.m11}, ${tabletproduces.m12}]
		 </c:if>
		 <c:if test="${!flag_tabletproduces}">
		 	name: '销售量',
            data: []
		 </c:if>
      }
      ]
  });
       
      /**
      *选择年份后查询
      */ 
      $("#search").click(function(){
		if($("#year").val() == null || $("#year").val() == ""){
			$.dialog.tips('请选择年份查询',1,'alert.gif');
			return false;
		}
      		$("#myform").attr("action","rp_Stat!findTabletProAndSellByYear.shtml");
 			$("#myform").submit();
      }); 
       
 	 });
    
	</script>
	</body>
</html>