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
		<div class="cur-pos">当前位置：备案管理 > 备案企业管理</div>
	    <div class="seh-box">
	        <form action="company!findByList.shtml" method="post" id="searchform" name="searchform">
	        	<table width="100%">
		    		<tr><td align="right" width="80">所属区域：</td><td><select name="province" id="province" v="${province }"></select>
						<select name="city" id="city" v="${city }"></select>
						<select name="area" id="area" v="${area }"></select></td>
						<td width="130"></td></tr>
		    		<tr><td align="right">企业名称：</td><td><input type="text" value="${requestScope.corpname }" class="inp w250" id="corpname" name="corpname" maxlength="40">&nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"> </td><td><a href="manage/company/addCompany.jsp" class="btn-a"><span class="new">新建企业备案</span></a></td></tr>
		    	</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	           	<td>企业名称</td>
	            <td>所属区域</td>
	            <td>类型</td>
	            <td>备案日期</td>
	            <td>企业代码</td>
	            <td>详情</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.companylist}" var="companylist">
	          <tr class="lb-list">
	           	<td height="30" title="${companylist.corpname}">${fn:substring(companylist.corpname,0,20)}</td>
	            <td width="80" title="${companylist.province }${companylist.city }${companylist.area }"><div class="w80 ho">${companylist.province }${companylist.city }${companylist.area }</div></td>
	             <td>
			        <c:if test="${fn:substring(companylist.zyctype,4,8)=='0000'}">生产经销企业</c:if>
	           		<c:if test="${fn:substring(companylist.zyctype, 4, 5)=='1'}">药材市场 </c:if>
	           		<c:if test="${fn:substring(companylist.zyctype, 5, 6)=='1'}">医院 </c:if>
	           		<c:if test="${fn:substring(companylist.zyctype, 6, 7)=='1'}">管理机构 </c:if>
	           		<c:if test="${fn:substring(companylist.zyctype, 7, 8)=='1'}">其他 </c:if>
	            </td>
	            <td>${companylist.addtime }</td>
	            <td>${companylist.cpccorp }</td>
	            <td><a href="javascript:updateInit(${companylist.companyid });" class="btn-edit">编辑</a></td>
	            <td>
	            	<!--<c:if test="${fn:substring(companylist.zyctype,4,8)=='0000' }">
	            		<a href="javascript:findByList_Org('${companylist.cpccorp }',1);">下属单位管理</a>
	            	</c:if>
	            	<c:if test="${fn:substring(companylist.zyctype,4,8)!='0000' }">
	            		<c:forEach items="${companylist.orgs}" var="orglist" varStatus="vs">
	            		<c:if test="${vs.index==0}">
	            			<a href="javascript:findByList_User('${orglist.cpccorp }',${orglist.orgid },0);">用户管理</a>
	            		</c:if>
	            		<c:if test="${fn:substring(companylist.zyctype,4,8)=='1000'}">
	            			<a href="javascript:findByList_MarketMap('${orglist.cpccorp }')">编辑市场区域</a>
            			</c:if>
	            		</c:forEach>
	            	</c:if>
	            	-->
	            	
	            	<c:if test="${companylist.corp==0 }" var="flag">
	            		<a href="javascript:findByList_Org('${companylist.cpccorp }',1);">下属单位管理</a>
	            	</c:if>
	            	<c:if test="${!flag}">
	            		<c:forEach items="${companylist.orgs}" var="orglist" varStatus="vs">
	            		<c:if test="${vs.index==0}">
	            			<a href="javascript:findByList_User('${orglist.cpccorp }',${orglist.orgid },0);">用户管理</a>
	            		</c:if>
	            		<c:if test="${fn:substring(companylist.zyctype,4,8)=='1000'}">
	            			<a href="javascript:findByList_MarketMap('${orglist.cpccorp }')">编辑市场区域</a>
            			</c:if>
	            		</c:forEach>
	            	</c:if>
	            	
	            </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="company!findByList.shtml"
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
						<pg:param name="corpname" value="${requestScope.corpname }"/>
						<pg:param name="province" value="${requestScope.province }"/>
						<pg:param name="city" value="${requestScope.city }"/>
						<pg:param name="area" value="${requestScope.area }"/>
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
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	cMenu(0,0);
	function updateInit(companyid){
		$("#searchform").attr("action", "company!updateInit.shtml?companyid="+companyid);
		$("#searchform").submit();
	}
	function findByList_Org(cpccorp,opertype){
		$("#searchform").attr("action", "org!findByList.shtml?supercpccode="+cpccorp+"&opertype="+1);
		$("#searchform").submit();
	}
	function checkForm(){
		$("#corpname").val($.trim($("#corpname").val()));
		if(checkquotmarks($("#corpname").val())){
			$("#corpname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","company!findByList.shtml");
		$("#searchform").submit();
	}
	
	function findByList_User(cpccorp,orgid,opertype){
		$("#searchform").attr("action", "user!findByList.shtml?cpccorp="+cpccorp+"&orgid="+orgid+"&opertype="+0);
		$("#searchform").submit();
	}
	
	function findByList_MarketMap(cpccorp){
		$("#searchform").attr("action", "marketMap!findByList.shtml?cpccorp="+cpccorp);
		$("#searchform").submit();
	}
	
	
	</script>
	</body>
</html>
