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
	<div class="cur-pos">当前位置：库存销售 &gt; 中药材经销</div>
    <div class="form-box">
    	<div class="fb-tit">
        	<div class="fbt-tab">
                <a href="<%=basePath %>govmentMedStat!findMedSellBase.shtml" >库存统计列表</a>
                <a href="<%=basePath %>govmentMedStat!findMedSellSale.shtml" class="act">销售统计列表</a>
            </div>
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
        		<form action="<%=basePath %>govmentMedStat!findMedSellSale.shtml" method="post" id="searchform">
		            	<table>
		                  <tr>
		                    <td height="30" width="90" align="right">药材名称：</td>
		                    <td width="170">
		                  	  <input type="text" class="inp fl w100" id="medname" name="medname" maxlength="20" value="${medname }"/>
					  		  <a href="javascript:void(0);" id="xzyc" class="btn-xz fl">选择</a>
		                    </td>
		                    <td align="right">经销企业：</td>
		                    <td><input type="text" class="inp w150" id="corpname" name="corpname" maxlength="20" value="${corpname}"></td>
		                  </tr>
		                  <tr>
		                    <td align="right">企业所属区域：</td>
		                    <td colspan="3">
		                    	<select name="province" id="province" v="${province }"></select><select name="city" id="city" v="${city }"></select>
			        			 <select name="area" id="area" v="${area }"></select>
		                 	   <input type="button" value="搜索" class="sch" onclick="query()">
		                    </td>
		                  </tr>
		                </table>
		                </form>
		            </div>
		        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		              <tr class="fbc-tit">
		                <td>月份</td>
		                <td>区域</td>
		                <td>销售重量</td>
		                <td>平均价格(Kg/元)</td>
		                <td>品名</td>
		                <td>溯源码数量</td>
		              </tr>
		              <c:forEach items="${list}" var="item">
			              <tr class="fb-list">
			                <td height="30">${item.mon }&nbsp;</td>
			                <td>${item.area }&nbsp;</td>
			                <td>${item.totalweight }&nbsp;</td>
			                <td>${item.avgmoney }&nbsp;</td>
			                <td>${item.medname }&nbsp;</td>
			                <td>${item.boxnum }&nbsp;</td>
			              </tr>
			         </c:forEach>
		            </table>
            <div class="page">
				<cite>
				<pg:pager url="govmentMedStat!findMedSellSale.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="medname" value="${requestScope.medname }" />
					<pg:param name="province" value="${requestScope.province }" />
					<pg:param name="city" value="${requestScope.city }" />
					<pg:param name="area" value="${requestScope.area }" />
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
<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
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
		$("#searchform").submit();
	}
</script>
</body>
</html>