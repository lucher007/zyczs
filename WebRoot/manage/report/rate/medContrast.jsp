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
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<link type="text/css" rel="stylesheet" href="/style/production.css">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	
	function checkForm(){
        document.searchform.action="rp_Rate!medContrast.shtml";
        
        <c:if test="${sessionScope.User.loginname!='linye'|| sessionScope.User.loginname!='nongye'}">
        var med="";
        for(var i=1;i<6;i++){
			med=med+$("#med"+i).val();
		}
		
		if(med==""){
			alert("请至少选择一种药材");
			return;
		}
		</c:if>
        if($("#year").val()==""){
        	alert("请输入日期");
        	return;
        }
    	document.searchform.submit();
	}	
	
	
	var med=1;
	function selMedBase( obj){
		med=obj;
			t2 = $.dialog({
				title:'选择药材品名',
				id:'medWindow',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		});
	}
			
	function closeDG(s){		
		t2.close();
		
		for(var i=1;i<6;i++){
			if(i!=med){			
				if($("#med"+i).val()==s[1]){
					$.dialog.tips('该药材已存在、请重新选择',2,'alert.gif');
					$("#med"+med).val("");
					break;
				}else{
					$("#med"+med).val(s[1]);
				}
			}
		}
		
		
		
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
                '${tlist.med1 }',
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
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} 吨</b></td></tr>',
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
            name: '实际产量',
            data: [
            <c:forEach items="${requestScope.list}" var="tlist1">
            <c:if test="${tlist1.curTotal!=0 }">
                ${tlist1.curTotal/1000},
            </c:if>
				</c:forEach>
            ]

        }, {
            name: '预计产量',
            data: [
            <c:forEach items="${requestScope.list}" var="tlist2">
                <c:if test="${tlist2.total!=0 }">
                   ${tlist2.total/1000 },
                   
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
	    <div class="cur-pos">当前位置：统计分析 >实际与预计产出</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">   
				<c:if test="${sessionScope.User.loginname!='linye'|| sessionScope.User.loginname!='nongye'}">
                   
                
				主要药材：
				<input type="text" name="med1" size="10" id="med1" value="${requestScope.med1}" onclick="selMedBase(1);">&nbsp;
				<input type="text" name="med2" size="10" id="med2" value="${requestScope.med2}" onclick="selMedBase(2);">&nbsp;
				<input type="text" name="med3" size="10" id="med3" value="${requestScope.med3}" onclick="selMedBase(3);">&nbsp;
				<input type="text" name="med4" size="10" id="med4" value="${requestScope.med4}" onclick="selMedBase(4);">&nbsp;
				<input type="text" name="med5" size="10" id="med5" value="${requestScope.med5}" onclick="selMedBase(5);">&nbsp;
				<br>
				</c:if>
				日期： <input type="text" name="year" id="year" value="${requestScope.year}" size="10" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate"/>
				
				&nbsp;
				
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    
    <div id="container" style="min-width:700px;height:400px"></div>
</div>
  </body>
</html>
