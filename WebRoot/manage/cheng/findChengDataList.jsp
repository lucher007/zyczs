<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
<base href="<%=basePath%>" />
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="/style/user.css">

</head>

<body>
	<div id="body">
	<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
		<div class="cur-pos">当前位置：市场管理 > 溯源秤交易查询</div>
	</c:if>
	<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
		<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤交易查询</div>
	</c:if>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
        	溯源秤编号：<input maxlength="32" type="text" value="${chengcode}" class="inp w250"  id="chengcode" name="chengcode" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);">                   
			&nbsp;交易时间： 从
				<input type="text" name="operstarttime" id="operstarttime" value="${fn:substring(operstarttime,0,11)}" class="Wdate inp w80" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'operendtime\');}'});"/>
				&nbsp;
				到
				<input type="text" name="operendtime" id="operendtime" value="${fn:substring(operendtime,0,11)}" class="Wdate inp w80" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'operstarttime\');}'});"/>
				&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>溯源秤编号</td>
            <td>药材名称</td>
            <td>单价(元/Kg)</td>
            <td>重量(Kg)</td>
            <td>总价(元)</td>
            <td>交易时间</td>
          </tr>
          <c:forEach items="${requestScope.chengdatalist}" var="dataList">
          <tr class="lb-list">
            <td width="100" height="30">${dataList.chengcode }&nbsp;</td>
            <td>${dataList.medname }&nbsp;</td>
            <td>${dataList.unitprice }&nbsp;</td>
            <td>${dataList.weight }&nbsp;</td>
            <td>${dataList.totalprice }&nbsp;</td>
            <td>${fn:substring(dataList.tradetime, 0, 19)}&nbsp;</td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="cheng!findChengDataByList.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="10"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="chengcode" value="${requestScope.chengcode }"/>
					<pg:param name="operstarttime" value="${requestScope.operstarttime }"/>
					<pg:param name="operendtime" value="${requestScope.operendtime }"/>
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
						<a href="<%=pageUrl %>">首页</a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
					  	<a href="<%= prevPageUrl %>">前一页</a>
					</pg:prev>
					<pg:pages>
		   				<%if (pageNumber == currentPageNumber) { 
					        %><span style="font:bold 16px arial;"><%= pageNumber %></span><%
					      } else { 
					        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
					      }
					    %>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
					  	<a href="<%= nextPageUrl %>">下一页</a>
					</pg:next>
					<pg:last>
					  	<a href="<%=pageUrl %>">末页</a>
					</pg:last>
					</pg:index>
			  		</pg:pager>
            </cite>
        </div>
    </div>
	</div>
	
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
<script type="text/javascript">
    function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	}
	
	function checkForm(){
	    $("#chengcode").val($.trim($("#chengcode").val()));
		if(checkquotmarks($("#chengcode").val())){
			$("#chengcode").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchForm").attr("action","cheng!findChengDataByList.shtml");
		$("#searchForm").submit();
	}
</script>
</body>
</html>

