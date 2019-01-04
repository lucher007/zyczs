<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>药材库存统计</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析 > 饮片生产任务</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	              品名： <input maxlength="20" type="text" name="tabletname" id="tabletname" value="${requestScope.tabletname }" class="inp w100"/>
				生产日期： 从 <input type="text" name="createtime" id="createtime" value="${fn:substring(createtime,0,11)}" class="Wdate inp w120" onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'endtime\');}'});"/>
				&nbsp;
				到 <input type="text" name="endtime" id="endtime" value="${fn:substring(endtime,0,11)}" class="Wdate inp w120" onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'createtime\');}'});"/>
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
	            <td>饮片原药材</td>
	            <td>原药材使用重量(Kg)</td>
	            <td>生产日期</td>
	          </tr>
	          <c:forEach items="${requestScope.tabletlist}" var="tabletlist">
			  	  <tr class="lb-list">
			  		<td height="30">${tabletlist.tabletname }&nbsp;</td>
			  		<td>
		            	${(tabletlist.tabletnumber==null || tabletlist.tabletnumber =='')?'无':tabletlist.tabletnumber }&nbsp;
		            </td>
			  		<td>
			  		    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletlist.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
			  		</td>
			  		<td>${tabletlist.medname }&nbsp;</td>
			  		<td>
			  		<c:set var="meduseweight" value="${tabletlist.meduseweight}" scope="request" />
           		 <%
           		Object meduseweight=request.getAttribute("meduseweight");	
           		 %>   
                <%=Tools.scienceToString(Tools.division(meduseweight.toString(),"10000"))%>      
                
			  		&nbsp;
			  		</td>
			  		<td>${fn:substring(tabletlist.createtime, 0, 11)}&nbsp;</td>	
		  		
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tablet!findByList.shtml"
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
						<pg:param name="medname" value="${requestScope.tabletname }"/>
						<pg:param name="medaddtime" value="${requestScope.createtime }"/>
						<pg:param name="medendtime" value="${requestScope.endtime }"/>
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
			$("#tabletname").val($.trim($("#tabletname").val()));
			if(checkquotmarks($("#tabletname").val())){
				$("#tabletname").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tablet!findByList.shtml");
			$("#searchform").submit();
		}
    </script>   
	</body>
</html>
 