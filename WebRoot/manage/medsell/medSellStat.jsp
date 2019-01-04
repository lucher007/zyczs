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
		<title>药材经销平台出库统计</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css"/>
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析  &gt; 出库统计</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	                         品名：<input maxlength="20" type="text" name="medname" id="medname" value="${requestScope.medname }" class="inp"/>
			出库时间： 从
			<input type="text" name="querybegintime" id="querybegintime" value="${fn:substring(querybegintime,0,11)}" class="Wdate inp w100" 
			onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'queryendtime\');}'});"/>
			&nbsp;
			到
			<input type="text" name="queryendtime" id="queryendtime" value="${fn:substring(queryendtime,0,11)}" class="Wdate inp w100" 
			onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'querybegintime\');}'});"/>
			&nbsp;
	        <input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td>
	            <td>规格(Kg/包)</td>
	            <td>包数</td>
	            <td>总重量(Kg)</td>
	          </tr>
	          <c:forEach items="${requestScope.medStatlist}" var="medStatlist">
		  	  <tr class="lb-list">
		  		<td height="30">${medStatlist.prodname }</td>
		  		<td>
	            	${(medStatlist.mednumber==null || medStatlist.mednumber =='')?'无':medStatlist.mednumber }&nbsp;
	            </td>
		  		<td >
		  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${medStatlist.batchcpc }${initParam.batchcpc_med}');" class="btn-look">查看</a>
		  		</td>
		  		<td >${medStatlist.boxnumweight/10000}</td>
		  		<td>${medStatlist.boxnum }</td>
		  		<td>${medStatlist.strtotalweight}</td>
		  	  </tr>
	  		  </c:forEach>
	  		  <tr>
	  		    <td height="30" colspan="6" bgcolor="#EEEEEE"><cite>总重量(Kg):<b class="red">${requestScope.strsumweight }</b></cite></td>
	  		  </tr>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="medSellStat!getMedSellStat.shtml"
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
						<pg:param name="medname" value="${requestScope.medname }"/>
						<pg:param name="querybegintime" value="${requestScope.querybegintime }"/>
						<pg:param name="queryendtime" value="${requestScope.queryendtime }"/>
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
							<a href="<%=pageUrl %>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
						  	<a href="<%= prevPageUrl %>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
			   				<%if (pageNumber == currentPageNumber) { 
						        %><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a><%
						      } else { 
						        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
						      }
						    %>  
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
						  	<a href="<%= nextPageUrl %>" title="下一页" class="next">&nbsp;</a>
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
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('品名不能包含~ # *等字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medSellStat!getMedSellStat.shtml");
			$("#searchform").submit();
		}
    </script>
	</body>
</html>
 