<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>种植/养殖统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 各环节统计</div>
    <div class="form-box">
    	<div class="fb-tit">
        	<div class="fbt-tab">
                <a href="<%=basePath %>govmentMedStat!findMedByList.shtml" class="act">种植库存统计</a>
                <a href="<%=basePath %>govmentMedStat!findGovMedSell.shtml">种植销售统计</a>
            </div>
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
        		<form action="<%=basePath %>govmentMedStat!findMedByList.shtml" method="post" id="searchform">
		            	<table width="100%">
		                  <tr>
		                    <td height="26" width="90" align="right">药材名称：</td>
		                    <td width="170">
		                  	  <input type="text" class="inp fl w100" id="medname" name="medname" maxlength="20" value="${medname }">
					  		  <a href="javascript:void(0);" id="xzyc" class="btn-xz fl">选择</a>
		                    </td>
		                    <td width="90" align="right">种植状态：</td>
		                    <td>
		                    	<select class="w158" name="state" id="state">
				                    	<c:if test="${state != 1 && state != 0}">
											<option value="" selected="selected">全部状态</option>
											<option value="0" >进行中</option>
											<option value="1" >已完成</option>
										</c:if>
										<c:if test="${state == 0}">
											<option value="" >全部状态</option>
											<option value="0" selected="selected">进行中</option>
											<option value="1" >已完成</option>
										</c:if>
										<c:if test="${state == 1}">
											<option value="">全部状态</option>
											<option value="0" >进行中</option>
											<option value="1" selected="selected">已完成</option>
										</c:if>
		                    	</select>
		                    	</td>
		                  </tr>
		                  <tr>
		                    <td height="26"  align="right">种植/养殖企业：</td>
		                    <td>
		                    <input type="text" class="inp fl w100" id="corpname" name="corpname" maxlength="20" value="${corpname}">
         		            <input type="hidden" id="orgid" name="orgid" value="${orgid}">
		                    <a href="javascript:void(0);" id="xzqy" class="btn-xz fl">选择企业</a>
		                    </td>
		                    <td></td>
		                    <td></td>
		                  </tr>
		                  <tr>
		                    <td height="26"  align="right">企业所属区域：</td>
		                    <td colspan="3">
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
								<input type="button" value="搜索" class="sch" onclick="query()"></td>
		                  </tr>
		                </table>
		                </form>
		            </div>
		        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		              <tr class="fbc-tit">
		                <td align="center">月份</td>
		                <td align="center">区域</td>
		                <td align="center">种植企业数量</td>
		                <td align="center">药材品种数量</td>
		                <td align="center">种植批次数量</td>
		                <td align="center">种植总面积(亩)</td>
		                <td align="center">预计产量(Kg)</td>
		                <td align="center">实际产量(Kg)</td>
		              </tr>
		              <c:forEach items="${list}" var="item">
			              <tr class="fb-list">
			                <td align="center" height="30">${item.mon }&nbsp;</td>
			                <td align="center">${item.area }&nbsp;</td>
			                <td align="center">${item.orgcount }&nbsp;</td>
			                <td align="center">${item.medcount }&nbsp;</td>
			                <td align="center">${item.plantcount }&nbsp;</td>
			                <td align="center">${item.plantareasum }&nbsp;</td>
			                <td align="center">${item.predictweight }&nbsp;</td>
			                <td align="center">${item.medweight }&nbsp;</td>
			              </tr>
			         </c:forEach>
		            </table>
            <div class="page">
				<cite>
				<pg:pager url="govmentMedStat!findMedByList.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="medname" value="${requestScope.medname }" />
					<pg:param name="state" value="${requestScope.state }" />
					<pg:param name="province" value="${requestScope.province }" />
					<pg:param name="city" value="${requestScope.city }" />
					<pg:param name="area" value="${requestScope.area }" />
					<pg:param name="starttime" value="${requestScope.starttime }" />
					<pg:param name="endtime" value="${requestScope.endtime }" />
					<pg:param name="orgid" value="${requestScope.orgid }" />
					<pg:param name="corpname" value="${requestScope.corpname }" />
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
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript" language="javascript" src="/js/areaSearch.js"></script>
<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script type="text/javascript">
	$("#xzyc").click(function(){
		selMedBase();
		return false;
	});
	function selMedBase(){
			t2 = $.dialog({
				title:'选择药材品名',
				id:'medWindow',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		});
	}
			
	function closeDG(s){
		$("#medname").val(s[1]);
		t2.close();
	}
	
	function query(){
		if($.trim($("#corpname").val())=="" || $("#corpname").val()==null){
			$("#orgid").val(null);
		}
		$("#searchform").submit();
	}
	
$("#xzqy").click(function(){
	selOrg();
	return false;
});

function selOrg(){
	t2 = $.dialog({
		title:'选择种植/养殖企业',
		id:'orgChos',
		lock:true,
		content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>org!findByListChoice.shtml?zyctype=10000000&rid='+Math.random()+'"></iframe>',
		max:false,
		min:false
	});			
}

function closeORG(s){
	$("#corpname").val(s[1]);
	$("#orgid").val(s[3]);
	t2.close();
}
</script>
</body>
</html>