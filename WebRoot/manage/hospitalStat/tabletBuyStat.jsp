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
		<title>医院平台采购统计</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析 &gt; 入库统计</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
	        <table border="0" width="100%">
                  <tr>
                    <td height="26"  align="right">品名：</td>
	                 <td>
	                    <input type="text" size="50" class="inp w250" maxlength="32" name="tabletname" id="tabletname" value="${requestScope.tabletname }">
	                </td>
                    <td height="26" width="100" align="right">包装类型：</td>
                    <td>
                    	<select id="codetype" name="codetype" class="w158">
	                  	        <option value="6" <c:if test="${requestScope.codetype == 6 }">selected</c:if>>中包</option>
								<option value="5" <c:if test="${requestScope.codetype == 5 }">selected</c:if>>小包</option>
								<option value="8" <c:if test="${requestScope.codetype == 8 }">selected</c:if>>大包</option>
						</select>
                    </td>
                  </tr>
                  <tr>
                  	  <td align="right">入库时间：从</td>
                  	  <td id="confidTD" colspan="2">
	                  	  <input type="text" name="querybegintime" id="querybegintime" value="${fn:substring(querybegintime,0,11)}" class="Wdate inp w100" 
							onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'queryendtime\');}'});"/>
							&nbsp;
							到
							<input type="text" name="queryendtime" id="queryendtime" value="${fn:substring(queryendtime,0,11)}" class="Wdate inp w100" 
							onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'querybegintime\');}'});"/>
							&nbsp;
			         </td>
                    <td>
                    	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
                    </td>
                  </tr>
                </table>
	        
	        </form>
	    </div>
    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td>
	            <td>小包装规格(g/包)</td>
	            <!--	            <td>包装类型</td>-->
<!--	            <td>包数</td>-->
	            <td>总重量(Kg)</td>
	            <td>总价(元)</td>
	          </tr>
	          <c:forEach items="${requestScope.tabletStatlist}" var="tabletStatlist">
		  	  <tr class="lb-list">
		  		<td height="30">${tabletStatlist.prodname }&nbsp;</td>
		  		<td>
	            	${(tabletStatlist.tabletnumber==null || tabletStatlist.tabletnumber =='')?'无':tabletStatlist.tabletnumber }&nbsp;
	            </td>
		  		<td>
		  			<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatlist.batchcpc }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
		  		</td>
		  		<td>${tabletStatlist.boxnumweight/10}&nbsp;</td>
<!--		  		<td>-->
<!--			  		<c:if test="${tabletStatlist.codetype ==5 }">-->
<!--		            	小包装-->
<!--		            </c:if>-->
<!--		            <c:if test="${tabletStatlist.codetype ==6 }">-->
<!--		            	中包装-->
<!--		            </c:if>-->
<!--	            </td>-->
<!--		  		<td>${tabletStatlist.boxnum }&nbsp;</td>-->
		  		<td>${tabletStatlist.strtotalweight}&nbsp;</td>
		  		<td>${tabletStatlist.strtotalmoney}&nbsp;</td>
		  	  </tr>
	  		  </c:forEach>
	  		  <tr>
	  		    <td height="30" colspan="7" bgcolor="#EEEEEE"><cite>总重量(Kg)：<b class="red">${requestScope.strsumweight }</b></cite></td>
	  		  </tr>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="hospitalStat!getTabletBuyStat.shtml"
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
						<pg:param name="tabletname" value="${requestScope.tabletname }"/>
						<pg:param name="querybegintime" value="${requestScope.querybegintime }"/>
						<pg:param name="queryendtime" value="${requestScope.queryendtime }"/>
						<pg:param name="codetype" value="${requestScope.codetype }"/>
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
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript">
		function checkForm(){
			$("#tabletname").val($.trim($("#tabletname").val()));
			if(checkquotmarks($("#tabletname").val())){
				$("#tabletname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","hospitalStat!getTabletBuyStat.shtml");
			$("#searchform").submit();
		}
    </script>
	</body>
</html>
 