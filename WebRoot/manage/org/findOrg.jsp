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
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：用户注册 > 下属单位管理</div>
	    <div class="seh-box">
	        <form action="org!findByList.shtml" method="post" id="searchform" name="searchform">
	        	<!-- <input type="hidden" name="supercpccode" value="${supercpccode}"> -->
	        	<input type="hidden" name="opertype" value="${opertype}">
	        	<table width="100%">
	    		<tr>
	    			<td align="right" width="80">所属区域：</td>
	    			<td colspan="2">
		    			<select name="province" id="province" v="${province }"></select>
						<select name="city" id="city" v="${city }"></select>
						<select name="area" id="area" v="${area }"></select>
					</td>
					<td width="130"></td>
				</tr>
	    		<tr>
	    		<td align="right">单位名称：</td>
	    		<td>
	    			<input type="text" value="${requestScope.orgname }" class="inp" id="orgname" name="orgname" maxlength="40"> &nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();">
	    		</td>
	    		<td>
	    			<a href="<%=basePath %>company!findByList.shtml" class="btn-a"><span class="new">返回企业管理</span></a>
	    		</td>
	    		<td>
		    		<a href="javascript:saveInit('${requestScope.supercpccode }',1);" class="btn-a"><span class="new">新建下属单位</span></a>
		    	</td>
	    		</tr>
		    	</table>
	     
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>组织代码</td>
	            <td>所属区域</td>
	            <td>类型</td>
	            <td>组织机构名称</td>
	            <td>备案日期</td>
	            <td>详情</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.orglist}" var="orglist">
	          <tr class="lb-list">
	            <td height="30">${orglist.cpccorp }</td>
	            <td>${orglist.province }${orglist.city }${orglist.area }</td>
	            <td>
	            	<c:if test="${fn:substring(orglist.zyctype, 0, 1)=='1'}">药材种植 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 4, 5)=='1'}">药材市场 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 5, 6)=='1'}">医院 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 6, 7)=='1'}">管理机构 </c:if>
	           		<c:if test="${fn:substring(orglist.zyctype, 7, 8)=='1'}">其他 </c:if>
	            </td>
	            <td title="${orglist.orgname }">${fn:substring(orglist.orgname ,0,10 )}</td>
	            <td>${orglist.addtime }</td>
	            <td><a href="javascript:updateInit(${orglist.orgid },1);" class="btn-look">编辑</a></td>
	            <td><a href="javascript:findByList_User('${orglist.cpccorp }',${orglist.orgid },1,'${orglist.supercpccode }');">用户管理</a> <!-- | <a href="javascript:saveInit_User(${orglist.orgid },1,'${orglist.supercpccode }');" class="btn-add">添加用户管理</a> --> </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="org!findByList.shtml"
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
						<pg:param name="orgname" value="${requestScope.orgname }"/>
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
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	function updateInit(orgid){
		$("#searchform").attr("action", "org!updateInit.shtml?orgid="+orgid);
		$("#searchform").submit();
	}
	function saveInit(cpccorp){
		$("#searchform").attr("action", "org!saveInit.shtml?cpccorp="+cpccorp);
		$("#searchform").submit();
	}
	function saveInit_User(orgid,supercpccode){
		$("#searchform").attr("action", "user!saveInit.shtml?orgid="+orgid+"&supercpccode="+supercpccode);
		$("#searchform").submit();
	}
	function findByList_User(cpccorp,orgid,opertype,supercpccode){
		$("#searchform").attr("action", "user!findByList.shtml?cpccorp="+cpccorp+"&orgid="+orgid+"&supercpccode="+supercpccode);
		$("#searchform").submit();
	}
	function checkForm(){
		$("#orgname").val($.trim($("#orgname").val()));
		if(checkquotmarks($("#orgname").val())){
			$("#orgname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","org!findByList.shtml?supercpccode="+${supercpccode});
		$("#searchform").submit();
	}
	</script>
	</body>
</html>
