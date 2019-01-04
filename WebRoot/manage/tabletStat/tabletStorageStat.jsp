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
		<title></title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：统计分析  &gt; 饮片库存</div>
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
	                  	        <option value="0" <c:if test="${requestScope.codetype == 0 }">selected</c:if>>未包装</option>
								<option value="5" <c:if test="${requestScope.codetype == 5 }">selected</c:if>>小包</option>
								<option value="8" <c:if test="${requestScope.codetype == 8 }">selected</c:if>>大包</option>
						  </select>
                    </td>
                  </tr>
                  <tr>
                  	  <td align="right">入库时间：从</td>
                  	  <td id="confidTD" colspan="2">
	                  	   <input type="text" class="inp w120 Wdate" name="tabletaddtime" id="tabletaddtime" value="${fn:substring(tabletaddtime,0,11)}" 
							onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'tabletendtime\');}'});">
							&nbsp;
							到 <input type="text" class="inp w120 Wdate" name="tabletendtime" id="tabletendtime" value="${fn:substring(tabletendtime,0,11)}" 
							onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'tabletaddtime\');}'});">
							&nbsp;
			         </td>
                    <td>
                    	<input type="button" value="查询" class="sch" onclick="return checkForm();">
                    </td>
                  </tr>
                </table>
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <c:if test="${requestScope.codetype ==0 }">
	                <td>品名</td>
		            <td>批次号</td>
		            <td>批次详情</td>
	            	<td>库存量(Kg)</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==5 }">
	                <td>品名</td>
		            <td>批次号</td>
		            <td>批次详情</td>
	            	<td>小包装规格(g/包)</td>
	            	<td>小包数</td>
	            	<td>库存量(Kg)</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==6 }">
	            	<td>品名</td>
		            <td>批次号</td>
		            <td>批次详情</td>
	            	<td>小包装规格(g/包)</td>
	            	<td>中包数</td>
	            	<td>包装规格(小包/中包)</td>
	            	<td>库存量(Kg)</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==7 }">
	            	<td>品名</td>
		            <td>批次号</td>
		            <td>批次详情</td>
	            	<td>小包装规格(g/包)</td>
	            	<td>中包数</td>
	            	<td>包装规格(小包/中包)</td>
	            	<td>库存量(Kg)</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==8}">
	            	<td>包装类型</td>
	            	<td>溯源码</td>
	            	<td>重量(Kg)</td>
	            	<td>操作</td>
	            </c:if>
	          </tr>
	          <c:forEach items="${requestScope.tabletStatList}" var="tabletStatList">
			  	  <tr class="lb-list">
			  		<c:if test="${requestScope.codetype == 0 }">
		  			<td height="30">${tabletStatList.tabletname }&nbsp;</td>
			  		<td>
		            	${(tabletStatList.tabletnumber==null || tabletStatList.tabletnumber =='')?'无':tabletStatList.tabletnumber }&nbsp;
		            </td>
			  		<td>
			  		    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatList.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
			  		</td>
			  		<td>
			  		<c:set var="tabletweight" value="${tabletStatList.tabletweight}" scope="request" />
	           		 <%
	           			Object tabletweight=request.getAttribute("tabletweight");	
	           		 %>   	 
	                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000")) %>
			  		&nbsp;
			  		</td>
	            </c:if>
		  		<c:if test="${requestScope.codetype ==5 }">
		  			<td height="30">${tabletStatList.tabletname }&nbsp;</td>
			  		<td>
		            	${(tabletStatList.tabletnumber==null || tabletStatList.tabletnumber =='')?'无':tabletStatList.tabletnumber }&nbsp;
		            </td>
			  		<td>
			  		    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatList.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
			  		</td>
	            	<td>${tabletStatList.tabletnumweight/10 }&nbsp;</td>
	            	<td>${tabletStatList.tabletboxnum }&nbsp;</td>
	            	<td>
			  		<c:set var="tabletweight" value="${tabletStatList.tabletweight}" scope="request" />
	           		 <%
	           			Object tabletweight=request.getAttribute("tabletweight");	
	           		 %>   	 
	                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000")) %>
			  		&nbsp;
			  		</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==6 }">
	            	<td height="30">${tabletStatList.tabletname }&nbsp;</td>
			  		<td>
		            	${(tabletStatList.tabletnumber==null || tabletStatList.tabletnumber =='')?'无':tabletStatList.tabletnumber }&nbsp;
		            </td>
			  		<td>
			  		    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatList.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
			  		</td>
	            	<td>${tabletStatList.tabletnumweight/10 }&nbsp;</td>
	            	<td>${tabletStatList.tabletboxnum }&nbsp;</td>
	            	<td>${tabletStatList.tabletboxitemnum }&nbsp;</td>
	            	<td>
			  		<c:set var="tabletweight" value="${tabletStatList.tabletweight}" scope="request" />
	           		 <%
	           			Object tabletweight=request.getAttribute("tabletweight");	
	           		 %>   	 
	                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000")) %>
			  		&nbsp;
			  		</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==7 }">
	            	<td height="30">${tabletStatList.tabletname }&nbsp;</td>
			  		<td>
		            	${(tabletStatList.tabletnumber==null || tabletStatList.tabletnumber =='')?'无':tabletStatList.tabletnumber }&nbsp;
		            </td>
			  		<td>
			  		    <a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${tabletStatList.cpctablet }${initParam.batchcpc_tablet}');" class="btn-look">查看</a>
			  		</td>
	            	<td>${tabletStatList.tabletnumweight/10 }&nbsp;</td>
	            	<td>${tabletStatList.tabletboxnum }&nbsp;</td>
	            	<td>${tabletStatList.tabletboxitemnum }&nbsp;</td>
	            	<td>
			  		<c:set var="tabletweight" value="${tabletStatList.tabletweight}" scope="request" />
	           		 <%
	           			Object tabletweight=request.getAttribute("tabletweight");	
	           		 %>   	 
	                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000")) %>
			  		&nbsp;
			  		</td>
	            </c:if>
	            <c:if test="${requestScope.codetype ==8}">
	            	<td height="30">--大包装--</td>
	            	<td>${tabletStatList.boxcode }&nbsp;</td>
			  		<td>
			  		<c:set var="tabletweight" value="${tabletStatList.tabletweight}" scope="request" />
	           		 <%
	           			Object tabletweight=request.getAttribute("tabletweight");	
	           		 %>   	 
	                <%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000")) %>
			  		&nbsp;
			  		</td>
			  		<td>
			  			<a href="printCode!findByBox.shtml?packcode=${tabletStatList.boxcode }&storagetype=1">查看详情</a>
			  		</td>
	            </c:if>	
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="tabletStat!findByTabletStorageStat.shtml"
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
						<pg:param name="tabletaddtime" value="${requestScope.tabletaddtime }"/>
						<pg:param name="tabletendtime" value="${requestScope.tabletendtime }"/>
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
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>   
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#tabletname").val($.trim($("#tabletname").val()));
			if(checkquotmarks($("#tabletname").val())){
				$("#tabletname").focus();
				$.dialog.tips('品名不能包含~ # *等字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletStat!findByTabletStorageStat.shtml");
			$("#searchform").submit();
		}
		
		$(function(){
			$("#reset").click(function(){
				$("#tabletname").val("");
				$("#tabletaddtime").val("");
				$("#tabletendtime").val("");
			});
		});
    </script>
	</body>
</html>
 