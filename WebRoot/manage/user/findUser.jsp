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
		<div class="cur-pos">当前位置：用户注册 > 用户管理</div>
	    <div class="seh-box">
	    	<cite><a href="javascript:roleFindByList(${requestScope.orgid });" class="btn-a"><span class="new">权限管理</span></a></cite>
	    	<cite>&nbsp;&nbsp;</cite>
	    	<cite><a href="javascript:saveInit_User(${requestScope.orgid },${opertype });" class="btn-a"><span class="new">添加用户</span></a></cite>
	    	<cite>&nbsp;&nbsp;</cite>
	    	<c:if test="${requestScope.opertype == 0}" var="flag">
	    		<cite><a href="<%=basePath %>company!findByList.shtml" class="btn-a"><span class="new">返回企业管理</span></a></cite>
	    	</c:if>
	    	<c:if test="${!flag}">
	    		<cite><a href="javascript:findByList_Org('${supercpccode}')" class="btn-a"><span class="new">返回单位管理</span></a></cite>
	    	</c:if>
	        <form action="user!findByList.shtml" method="post" id="searchform" name="searchform">
	        <input type="hidden" name="cpccorp" id="cpccorp" value="${requestScope.cpccorp }" />
	        <input type="hidden" name="supercpccode" id="supercpccode" value="${requestScope.supercpccode }" />
	        <input type="hidden" name="opertype" value="${opertype}">
	用户名称：<input type="text" value="${requestScope.username }" class="inp" id="username" name="username" maxlength="40"> 
	
	        <input type="button" value="查询" class="sch" onclick="return checkForm();">
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>组织代码</td>
	            <td>登录名称</td>
	            <td>用户名称</td>
	            <td>单位名称</td>
	            <td>单位类型</td>
	            <td>备案日期</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.userlist}" var="userlist">
	          <tr class="lb-list">
	            <td height="30">${userlist.cpccorp }</td>
	            <td title="${userlist.loginname }">${fn:substring(userlist.loginname ,0,10 )}</td>
	            <td title="${userlist.username }">${fn:substring(userlist.username ,0,10 )}&nbsp;</td>
	            <td title="${userlist.org.orgname }">${fn:substring(userlist.org.orgname  ,0,10 )}</td>
	            <td>
	            	<c:if test="${fn:substring(userlist.org.zyctype, 0, 1)=='1'}">药材种植</c:if><c:if test="${fn:substring(userlist.org.zyctype, 1, 2)=='1'}">药材经销商</c:if><c:if test="${fn:substring(userlist.org.zyctype, 2, 3)=='1'}">饮片生产</c:if><c:if test="${fn:substring(userlist.org.zyctype, 3, 4)=='1'}">饮片经销商</c:if><c:if test="${fn:substring(userlist.org.zyctype, 4, 5)=='1'}">药材市场</c:if><c:if test="${fn:substring(userlist.org.zyctype, 5, 6)=='1'}">医院</c:if><c:if test="${fn:substring(userlist.org.zyctype, 6, 7)=='1'}">管理机构</c:if><c:if test="${fn:substring(userlist.org.zyctype, 7, 8)=='1'}">其他</c:if>　
	            </td>
	            <td>${userlist.addtime }</td>
	            <td>
	            	<a href="javascript:updateInit(${userlist.userid },${userlist.org.orgid },${opertype });" class="btn-look">编辑</a>
	            	<a href="javascript:updatePassword(${userlist.userid });" class="btn-look">重置密码</a>  
	            </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="user!findByList.shtml"
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
						<pg:param name="username" value="${requestScope.username }"/>
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
	<script type="text/javascript">
	function updateInit(userid,orgid){
		$("#searchform").attr("action", "user!updateInit.shtml?userid="+userid+"&orgid="+orgid);
		$("#searchform").submit();
	}
	
	function updatePassword(userid){
		$.dialog.confirm('确定重置密码？', function(){
		    var url="<%=request.getContextPath()%>/userAjax!updatePassword.shtml?rid="+Math.random();
			$.getJSON(url,{'userid':userid}, function(data) {
				if(data.model.returncode == 1){
					$.dialog.tips("重置密码成功！",1,'alert.gif');
				}else{
				    $.dialog.tips("重置密码失败,请稍后重试！",1,'alert.gif');					
				}
			});
		}, function(){
		
		});
	}
	
	function checkForm(){
		$("#username").val($.trim($("#username").val()));
		if(checkquotmarks($("#username").val())){
			$("#username").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","user!findByList.shtml?orgid=${requestScope.orgid }");
		$("#searchform").submit();
	}
	function saveInit_User(orgid){
		$("#searchform").attr("action", "user!saveInit.shtml?orgid="+orgid);
		$("#searchform").submit();
	}

	function roleFindByList(orgid){
		t1 = $.dialog({
			title:'权限管理',
			id:'medChos',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="750" height="350" src="<%=basePath%>role!findByList.shtml?ischoice='+Math.random()+'&orgid='+orgid+'"></iframe>',
			max:false,
			min:false
		});	
	}
	
	function findByList_Org(){
		$("#cpccorp").val("");
		$("#searchform").attr("action", "org!findByList.shtml");
		$("#searchform").submit();
	}
	
	</script>
	</body>
</html>

