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
		<base href="<%=basePath%>" >    
		<title></title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>


	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析 &gt; 药材库存</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	                               品名： <input maxlength="20" type="text" name="medname" id="medname" value="${requestScope.medname }" class="inp">
				入库时间： 从 <input type="text" class="inp Wdate w120" name="medaddtime" id="medaddtime" value="${fn:substring(medaddtime,0,11)}" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'medendtime\');}'});">
				&nbsp;
				到 <input type="text" class="inp Wdate w120" name="medendtime" id="medendtime" value="${fn:substring(medendtime,0,11)}" 
				onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'medaddtime\');}'});">
				&nbsp;
	        	<input type="button" value="查询" class="sch" onclick="return checkForm();">
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td>
	            <td>小包装规格(Kg/包)</td>
	            <td>重量(Kg)</td>
	            <td>入库时间</td>
	          </tr>
	          <c:forEach items="${requestScope.tabletStatList}" var="tabletStatList">
			  	  <tr class="lb-list">
			  		<td height="30">${tabletStatList.medname }&nbsp;</td>
			  		<td>
		            	${(tabletStatList.mednumber==null || tabletStatList.mednumber =='')?'无':tabletStatList.mednumber }&nbsp;
		            </td>
			  		<td>
			  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatList.cpcmed }${initParam.batchcpc_med}');" class="btn-look">查看</a>
			  		</td>
			  		
			  		 <td>
		            <c:if test="${tabletStatList.mednumweight == null || tabletStatList.mednumweight == 0.0}" var="flag">
						未包装
					</c:if>
					<c:if test="${!flag}" >
						${tabletStatList.mednumweight / 10000}&nbsp;
					</c:if>
	            </td>   
			  		<td>${tabletStatList.medweight / 10000}&nbsp;</td>
			  		<td>${fn:substring(tabletStatList.medaddtime, 0, 11)}&nbsp;</td>
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tabletStat!findByMedStorageStat.shtml"
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
						<pg:param name="medaddtime" value="${requestScope.medaddtime }"/>
						<pg:param name="medendtime" value="${requestScope.medendtime }"/>
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
			$("#searchform").attr("action","tabletStat!findByMedStorageStat.shtml");
			$("#searchform").submit();
		}
		
		$(function(){
			$("#reset").click(function(){
				$("#medname").val("");
				$("#medaddtime").val("");
				$("#medendtime").val("");
			});
		});
    </script> 
	</body>
</html>
 