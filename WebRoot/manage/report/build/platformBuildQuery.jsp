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
<title>平台各类型企业统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 统计导出</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     平台各类型企业统计
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
		  	  <tr class="fbc-tit">
	            <td align="center">企业类型</td>
	            <td align="center">数量(单位:户)</td>
	          </tr>
	          <c:forEach items="${requestScope.buildlist}" var="bulid">
		  	  <tr class="fb-list">
		  		<td height="30" align="center">
		  		   <c:if test="${bulid.zyctype=='10000000'}">药材种植</c:if>
		  		   <c:if test="${bulid.zyctype=='01000000'}">药材经销</c:if>
		  		   <c:if test="${bulid.zyctype=='00100000'}">饮片生产</c:if>
		  		   <c:if test="${bulid.zyctype=='00010000'}">饮片经销</c:if>
		  		   <c:if test="${bulid.zyctype=='00001000'}">药材市场</c:if>
		  		   <c:if test="${bulid.zyctype=='01000000-'}">市场经销户</c:if>
		  		   <c:if test="${bulid.zyctype=='00000100'}">医院药店</c:if>
		  		   <c:if test="${bulid.zyctype=='00000010'}">管理机构</c:if>
		  		</td>
		  		<td align="center">${bulid.num}&nbsp;</td>
		  	  </tr>
	  		  </c:forEach>
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
		$("#searchform").attr("action","rp_Build!platformBuildQuery.shtml");
		$("#searchform").submit();
	}	   
   
   function checkForm_exp(){
		$("#searchform").attr("action","rp_Build!platformBuildStat_excel.shtml");
		$("#searchform").submit();
	}	
   
</script>
</body>
</html>
 