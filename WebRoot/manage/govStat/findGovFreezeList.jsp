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
		<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：应急处置 > 应急公示</div>
	    <div class="seh-box">
<%--	    	<cite><a href="manage/govStat/addGovFreeze.jsp" class="btn-a"><span class="new">填报招回信息</span></a></cite>--%>
	        <form action="" method="post" id="searchform" name="searchform">
	        <input type="hidden" name="freezeid" id="freezeid">
	        <input type="hidden" name="state" id="state">
	        <table cellpadding="0" cellspacing="0">
	        <tr>
	        	<td width="90" align="right">输入CPC码：</td>
	        	<td><input type="text" value="${requestScope.cpccode }" class="inp w150" id="cpccode" name="cpccode" maxlength="40"></td>
	        	<td width="90" align="right">类型：</td>
	        	<td>
	        		<select name="cpclevel" id="cpclevel" class="w158">
						<option value="-1" <c:if test="${cpclevel==-1 }">selected</c:if>>全部</option>
						<option value="1" <c:if test="${cpclevel==1 }">selected</c:if>>企业码</option>
						<option value="2" <c:if test="${cpclevel==2 }">selected</c:if>>产品码</option>
						<option value="3" <c:if test="${cpclevel==3 }">selected</c:if>>批次码</option>
						<option value="4" <c:if test="${cpclevel==4 }">selected</c:if>>溯源码</option>
				  	</select>
				</td>
				<td></td>
	        </tr>
	        <tr>
	        	<td align="right">开始时间：</td>
	        	<td>
	        		<input type="text" name="addtime" id="addtime" value="${fn:substring(addtime,0,11)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'endtime\');}'});"/>
	        	</td>
	        	<td align="right">结束时间：</td>
	        	<td>
	        		<input type="text" name="endtime" id="endtime" value="${fn:substring(endtime,0,11)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'addtime\');}'});"/>
	        	</td>
	        	<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
	        </tr>
			</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>CPC编码</td>
	            <td>原因</td>
	            <td>类型</td>
	            <td>时间</td>
	            <td>状态</td>
	          </tr>
	          <c:forEach items="${requestScope.freezelist}" var="freezelist">
	          <tr class="lb-list">
	            <td height="30">${freezelist.cpccode }</td>
	            <td class="remarkClass" title="<c:if test="${freezelist.reason=='NA' }">无</c:if><c:if test="${freezelist.reason!='NA' }">${freezelist.reason }</c:if>">
	            	<c:if test="${freezelist.reason=='NA' }">无</c:if>
	            	<c:if test="${freezelist.reason!='NA' }">${fn:substring(freezelist.reason, 0, 20)}</c:if>
	            </td>
	            <td>
	            	<c:if test="${freezelist.cpclevel==1}">企业码</c:if>
	            	<c:if test="${freezelist.cpclevel==2}">产品码</c:if>
	            	<c:if test="${freezelist.cpclevel==3}">批次码</c:if>
	            	<c:if test="${freezelist.cpclevel==4}">溯源码</c:if>
	            </td>
	            <td>${freezelist.addtime }</td>
	            <td>
	            	<c:if test="${freezelist.state==1}">冻结状态</c:if>
	            	<c:if test="${freezelist.state==0}">解冻</c:if>
	            </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="freeze!findByList.shtml"
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
						<pg:param name="cpclevel" value="${requestScope.cpclevel }"/>
						<pg:param name="cpccode" value="${requestScope.cpccode }"/>
						<pg:param name="addtime" value="${requestScope.addtime }"/>
						<pg:param name="endtime" value="${requestScope.endtime }"/>
						
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
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script type="text/javascript">
	cMenu(2,0);
	function checkForm(){
		$("#cpccode").val($.trim($("#cpccode").val()));
		if(checkquotmarks($("#cpccode").val())){
			$("#cpccode").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","freeze!findByList.shtml");
		$("#searchform").submit();
	}
	
	</script>
	</body>
</html>
