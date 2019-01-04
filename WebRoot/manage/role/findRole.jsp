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
		<base href="<%=basePath%>" target="_self">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body style="margin:0;padding:0;">
	<div id="body">
	    <div class="seh-box">
	    	<cite><a href="javascript:saveInit();" class="btn-a"><span class="new">添加用户角色</span></a></cite>
	        <form action="role!findByList.shtml" method="post" id="searchform" name="searchform">
	        <input type="hidden" name="orgid" id="orgid" value="${requestScope.orgid }" >
	        <input type="hidden" name="roleid" id="roleid" >
	角色名称：<input type="text" value="${requestScope.rolename }" class="inp" id="rolename" name="rolename" maxlength="40"> 
	
	        <input type="button" value="查询" class="sch" onclick="return checkForm();">
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>角色名称</td>
	            <td>相关操作</td>
	          </tr>
	          <c:forEach items="${requestScope.rolelist}" var="rolelist">
	          <tr class="lb-list">
	            <td height="30">${rolelist.rolename }</td>
	            <td>
	            	<a href="javascript:void(0);" onclick="return deleteObject('${rolelist.roleid }');">删除</a>
	  				<a href="javascript:void(0);" onclick="return findById('${rolelist.roleid }',1);">更新</a>
	  				<a href="javascript:void(0);" onclick="return findById('${rolelist.roleid }',2);">编辑组用户</a>
	  				<a href="javascript:void(0);" onclick="return findById('${rolelist.roleid }',3);">编辑组权限</a>
	            </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="role!findByList.shtml"
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
						<pg:param name="rolename" value="${requestScope.rolename }"/>
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
	function checkForm(){
		$("#rolename").val($.trim($("#rolename").val()));
		if(checkquotmarks($("#rolename").val())){
			$("#rolename").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","role!findByList.shtml");
		$("#searchform").submit();
	}
	function saveInit(){
		$("#searchform").attr("action","role!saveObjectInit.shtml");
		$("#searchform").submit();
	}
	
	function deleteObject(roleid){
		if(!confirm("确认删除吗?如果删除组，该组下所有用户权限将不存在!")){
			return;
		}
		$("#roleid").val(roleid);
		$("#searchform").attr("action","role!deleteObject.shtml");
		$("#searchform").submit();
	}
	
	function findById(roleid,temptype){
		$("#roleid").val(roleid);
		if(temptype==1){
			$("#searchform").attr("action","role!updateObjectInit.shtml");
		}else if(temptype==2){    		
			$("#searchform").attr("action","role!findByIdRoleUser.shtml");    		
		}else if(temptype==3){
			$("#searchform").attr("action","role!findByIdRoleMenu.shtml");    		
		}
		$("#searchform").submit();
	} 
	</script>
	</body>
</html>

