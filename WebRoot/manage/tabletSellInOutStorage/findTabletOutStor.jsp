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
        <meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>出库查询</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css"> 
	</head>
<body>
    <div id="body">
	    <div class="cur-pos">当前位置：库存管理 &gt; 出库查询</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	             品名：<input maxlength="20" type="text" value="${prodname}" size="10" class="inp"  id="prodname" name="prodname">                   
		                     采购企业：<input maxlength="50" type="text" name="buycorpname" id="buycorpname" value="${requestScope.buycorpname }" class="inp"/>             
		                      出库时间： 从
				<input type="text" name="operstarttime" id="operstarttime" value="${fn:substring(operstarttime,0,11)}" class="Wdate inp w80" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'operendtime\');}'});"/>
				&nbsp;
				到
				<input type="text" name="operendtime" id="operendtime" value="${fn:substring(operendtime,0,11)}" class="Wdate inp w80" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'operstarttime\');}'});"/>
				&nbsp; 
		        <input type="button" value="查询" class="sch" onclick="return checkForm();" />
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          	  <tr class="lb-tit">
          	    <td>品名</td>
          	    <td>采购企业名称</td>
          	    <td>销售时间</td>
	            <td>出库负责人</td>
	            <td>总价(元)</td>
	            <td>详情</td>
	          </tr>
	          <c:forEach items="${requestScope.inoutstoragelist}" var="inoutstorage">
		  	   <tr class="lb-list">
		  	    <td width="15%" height="30">
		  			${(inoutstorage.prodname==null || inoutstorage.prodname == '--大包装--')?'--':inoutstorage.prodname }&nbsp;
		  		</td>
		  		<td width="25%">
		  			${(inoutstorage.buycorpname==null || inoutstorage.buycorpname == '')?'--':inoutstorage.buycorpname }&nbsp;
		  		</td>
		  		<td width="20%">${fn:substring(inoutstorage.opertime, 0, 11)}&nbsp; </td>
		  		<td width="15%">
		  		  ${(inoutstorage.operator==null || inoutstorage.operator == '')?'--':inoutstorage.operator }&nbsp;
		  		</td>
		  		<td width="15%">
		  			${(inoutstorage.strtotalmoney == null || inoutstorage.strtotalmoney == '')?'--':inoutstorage.strtotalmoney }&nbsp;
		  		</td>
		  		<td width="10%">
					<a class="btn-look" href="<%=basePath %>inOutStorBox!findTabletOutStorBox_tabletSell.shtml?inoutstorid=${inoutstorage.inoutstorid }">详情</a>
				</td> 
		  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
				<cite>
				<pg:pager url="inOutStor!findTabletOutStor_tabletSell.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="buycorpname" value="${requestScope.buycorpname }" />
					<pg:param name="operstarttime" value="${requestScope.operstarttime }" />
					<pg:param name="operendtime" value="${requestScope.operendtime }" />
					<pg:index>
					总共 ${requestScope.pager_count}条记录
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
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script> 
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
<script type="text/javascript">
	function checkForm(){
	    $("#prodname").val($.trim($("#prodname").val()));
		if(checkquotmarks($("#prodname").val())){
			$("#prodname").focus();
			$.dialog.tips('品名不能包含~ # *等字符！',1,'alert.gif');
			return false;
		}
		$("#buycorpname").val($.trim($("#buycorpname").val()));
		if(checkquotmarks($("#buycorpname").val())){
			$("#buycorpname").focus();
			$.dialog.tips('企业不能包含~ # *等字符！',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","inOutStor!findTabletOutStor_tabletSell.shtml");
		$("#searchform").submit();
	}   
</script>
    
</body>
</html>
 