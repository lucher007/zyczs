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
    	<title>田间操作管理</title>    	
    	<link type="text/css" rel="stylesheet" href="/style/plant.css">
  	</head>
  
  	<body>
  	<div id="body">
  		<div class="cur-pos">
			当前位置：种植管理 > 田间操作管理
		</div>
		<span>种子种苗植物名：${plant.plantname}&nbsp; &nbsp;种植批次号：${plant.cpcplant}&nbsp;&nbsp;种植时间：${plant.plantaddtime}</span>
		<div class="seh-box">
			<c:if test="${requestScope.oper=='details'}">
			<cite><a href="<%=basePath %>fieldCare!saveInit.shtml?cpcplant=${plant.cpcplant }&oper=details" class="btn-a"><span class="new">新建田间管理</span>
			</a> </cite>
			</c:if>
			<form action="" method="post" id="searchform" name="myform">
				<input type="hidden" name="oper" id="oper" value="${requestScope.oper }"/>
				操作类型：
				<select id="fieldcaretype" name="fieldcaretype" style="margin-right: 30px">
					<option value="" <c:if test="${fieldcaretype=='' }">selected="selected"</c:if> >全部操作</option>
					<option value="施肥" <c:if test="${fieldcaretype=='施肥' }">selected="selected"</c:if>>施肥</option>
					<option value="农药" <c:if test="${fieldcaretype=='农药' }">selected="selected"</c:if>>农药</option>
					<option value="浇水" <c:if test="${fieldcaretype=='浇水' }">selected="selected"</c:if>>浇水</option>
					<option value="中耕" <c:if test="${fieldcaretype=='中耕' }">selected="selected"</c:if>>中耕</option>
					<option value="除草" <c:if test="${fieldcaretype=='除草' }">selected="selected"</c:if>>除草</option>
					<option value="其它" <c:if test="${fieldcaretype=='其它' }">selected="selected"</c:if>>其它</option>
				</select>
				田间操作关键字:<input type="text" value="${fieldcarename}" class="inp" size="30" id="fieldcarename" name="fieldcarename"/>
				<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
				<input type="hidden"  value="${plant.cpcplant}" name="cpcplant"/> 
			</form>
		</div>
		
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>操作类型</td>
					<td>操作信息</td>
					<td>备注</td>
					<td>操作时间</td>					
				</tr>
				<c:forEach items="${requestScope.fieldcarelist}" var="fieldcare">
		  		<tr  class="lb-list">
		  			<td>${fieldcare.fieldcaretype }&nbsp;</td>
		  			<c:if test="${fieldcare.fieldcaretype=='施肥' || fieldcare.fieldcaretype=='农药'}" var="flag">
						<td>
							${fieldcare.fieldcarename}${fieldcare.fieldcareweight / 10000}Kg&nbsp;
						</td>
					</c:if>
					<c:if test="${!flag}">
						<td>--</td>
					</c:if>
					<c:if test="${fieldcare.remark == null }">
						<td>--</td>
					</c:if>
		  			<c:if test="${fieldcare.remark != null }">
		  				<td>${fieldcare.remark }</td>
		  			</c:if>
		  			<td height="30">${fieldcare.fieldcaretime}&nbsp;</td>
		  		</tr>
		  		</c:forEach>
			</table>
			<div class="page">
				<cite>
				<pg:pager
			    url="fieldCare!findByList.shtml"
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
				<pg:param name="fieldcarename" value="${requestScope.fieldcarename }"/>
				<pg:param name="cpcplant" value="${plant.cpcplant }"/>
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		cMenu(0,0);
		function checkForm(){
			$("#fieldcarename").val($.trim($("#fieldcarename").val()));
			if(checkquotmarks($("#fieldcarename").val())){
				$("#fieldcarename").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","fieldCare!findByList.shtml");
			$("#searchform").submit();
		}
    </script>
  	</body>
</html>
 