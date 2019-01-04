<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>种植/养殖统计</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 各环节统计</div>
    <div class="form-box">
    	<div class="fb-tit">
    		饮片经销统计
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
        		<form action="" method="post" id="searchform" name="myform">
            	<table border="0" width="100%">
                    <tr>
	                    <td height="26" width="90" align="right">饮片名称：</td>
	                    <td width="170">
	                    	<input type="text" class="inp w100 fl" name="tabletname" id="tabletname" value="${requestScope.tabletname }">
	                    	<a href="javascript:void(0);" id="xzyp" class="btn-xz fl">选择饮片品名</a>
	                    </td>
	                    
                     	 <td height="26"  align="right">生产企业：</td>
	                    <td>
	                    <input type="text" class="inp w100 fl" name="orgname" id="orgname" value="${requestScope.orgname }">
	                    <a href="javascript:void(0);" id="xzqy" class="btn-xz fl">选择企业</a>
	                    </td>
	                    
                  </tr>
                  <tr>
                  	  <td align="right" width="90">企业所属区域：</td>
                  	  <td  colspan="3">
	                  	 <select name="province" id="province" v="${province }">
	                   	 </select>
	                   	 <select name="city" id="city"  v="${city }">
	                   	 </select>
	        			 <select name="area" id="area"   v="${area }">
	        			 </select>
			        </td>
                   
                  </tr>
                  <tr>
		                    <td height="26"  align="right">开始月份：</td>
		                    <td>
		                    	<input type="text" id="starttime" name="starttime"   value="${starttime }"
		                    	onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM',maxDate:'#F{$dp.$D(\'endtime\');}'});" class="Wdate inp w150">
		                    </td>
		                    <td align="right">结束月份：</td>
		                    <td>
		                    	<input type="text" id="endtime" name="endtime"  value="${endtime }"
		                    	onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM',minDate:'#F{$dp.$D(\'starttime\');}'});" class="Wdate inp w150">
								<input type="button" value="搜索" class="sch" onclick="return checkForm();" >
								</td>
		                  </tr>
                </table>
                </form>
            </div>
        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
              <tr class="fbc-tit">
                <td align="center">月份</td>
                <td align="center">区域</td>
                <td align="center">生产企业名称</td>
                <td align="center">品名</td>
                <td align="center">批次号</td>
<%--                <td align="center">生产总量(kg)</td>--%>
<%--                <td align="center">生产批次数量</td>--%>
                <td align="center">销售总量(Kg)</td>
                <td align="center">平均价格(元/Kg)</td>
                <td align="center">销售订单数量</td>
                <td align="center">溯源码数量</td>
               
              </tr>
              <c:forEach items="${tabletList}" var="item">
              <c:set var="outtotalweight" value="${item.outtotalweight}" scope="request" /> 
              <%
	            Object outtotalweight=request.getAttribute("outtotalweight");
	          %>
	          
	              <tr class="fb-list">
	                <td align="center" height="30">${item.mon }</td>
	                <td align="center">${item.area }</td>
	                <td align="center">${item.orgname }</td>
	                <td align="center">${item.tabletname }</td>
	                <td align="center">${item.cpctablet }</td>
<%--	                <td align="center">${item.totaltabletweight}</td>--%>
<%--	                <td align="center">${item.cpctabletCount}</td>--%>
	                <td align="center"><%=Tools.scienceToString(Tools.dealNullDouble(outtotalweight.toString(),0))%></td>
	                <td align="center">${item.avgprice}</td>
	                <td align="center">${item.outorderCount}</td>
	                <td align="center">${item.codeCount}</td>
	              </tr>
	         </c:forEach>
            </table>
            <div class="page">
                <cite>
				<pg:pager url="govmentTabletStat!findByTabletSellList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="9"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="area" value="${requestScope.area }" />
					<pg:param name="tabletname" value="${requestScope.tabletname }" />
					<pg:param name="orgname" value="${requestScope.orgname }" />
					<pg:param name="city" value="${requestScope.city }" />
					<pg:param name="province" value="${requestScope.province }" />
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
							<a href="<%=pageUrl%>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
							<a href="<%=prevPageUrl%>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
							<%
								if (pageNumber == currentPageNumber) {
							%><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a>
							<%
								} else {
							%><a href="<%=pageUrl%>"><%=pageNumber%></a>
							<%
								}
							%>
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
							<a href="<%=nextPageUrl%>" title="下一页" class="next">&nbsp;</a>
						</pg:next>
						<pg:last>
							<a href="<%=pageUrl%>">末页</a>
						</pg:last>
					</pg:index>
				</pg:pager>
				</cite>
            </div>
    	</div>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">
//控制搜索词效果
inp(".seh-box .inp",'输入药材批次码或品名查询');
</script>

<script type="text/javascript">
function checkForm(){
	/*
	$("#mcontent").val($.trim($("#mcontent").val()));
	if(checkquotmarks($("#mcontent").val())){
		$("#mcontent").focus();
		$.dialog.tips('不要输入非法字符',1,'alert.gif');
		return false;
	}
	*/
	$("#searchform").attr("action","govmentTabletStat!findByTabletSellList.shtml");
	$("#searchform").submit();
}

$("#xzyp").click(function(){
	selTabletBase();
	return false;
});
		     
function selTabletBase(){
	t2 = $.dialog({
		title:'选择饮片品名',
		id:'tabletChos',
		lock:true,
		content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>tabletBase!tabletBaseChoice.shtml?rid='+Math.random()+'"></iframe>',
		max:false,
		min:false
	});			
}

function closeDG(s){
	$("#tabletname").val(s[1]);
	t2.close();
}

$("#xzqy").click(function(){
	selOrg();
	return false;
});

function selOrg(){
	t2 = $.dialog({
		title:'选择饮片经销企业',
		id:'orgChos',
		lock:true,
		content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>org!findByListChoice.shtml?zyctype=00010000&rid='+Math.random()+'"></iframe>',
		max:false,
		min:false
	});			
}

function closeORG(s){
	$("#orgname").val(s[1]);
	t2.close();
}

</script>	
	
</body>
</html>