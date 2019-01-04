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
	<form action="role!updateByIdRoleUser.shtml" method="post" name="searchForm" id="searchForm">
	<input type="hidden" name="roleid" id="roleid" value="${requestScope.roleid }" />
	<input type="hidden" name="orgid" id="orgid" value="${requestScope.orgid }" />
	<input type="hidden" name="useriddel" id="useriddel" />
	<input type="hidden" name="useridtype" id="useridtype" />
	<div id="body">
			<table cellpadding="0" cellspacing="1" width="220" align="left" style="float:left;font-family:arial;border:1px solid #6EB33D;">									
			<tr>
				<td width="150" class="table_title1" style="padding-left:0px;font-weight:bold;">名称</td>								
			</tr>
  			<tr>
  				<td>组名：${requestScope.role.rolename }</td>
  			</tr> 			
  			<c:forEach items="${requestScope.userlistchoose}" var="userlistchoose">		
  			<tr>
  				<td style="font-weight:bold;border:none;">
  					<input type="checkbox" value="${userlistchoose.userid }" name="${userlistchoose.userid }" id="${userlistchoose.userid }" onclick="chooseRole(this)" />
  					${userlistchoose.loginname }_${userlistchoose.username }
  				</td>
  			</tr>
  			</c:forEach>
	  		<tr><td height="10" style="border:none;">&nbsp;</td></tr> 		
		</table>
		
		<table cellpadding="0" cellspacing="1" width="220" align="left" style="float:left;position:relative;left:10px;border:1px solid #6EB33D;">
			<tr>
				<td height="19px" width="150" colspan="3" class="table_title1" style="padding-left:0px;font-weight:bold;">相关操作</td> 				
			</tr>  			
			<tr><td height="10" colspan="3" style="border:none;">&nbsp;</td></tr>
			<tr>
				<td width="30" height="25" style="border:none;"></td>  				
				<td align="center" style="border:none;"><input type="button" class="btncss"  value="删除用户" onclick="return deluserrole();" /></td>
				<td style="background:url('images/rightcursor.png') no-repeat;border:none;" width="30" height="25"></td>  				
			</tr>
			<tr><td height="10" colspan="3" style="border:none;">&nbsp;</td></tr>  
			<tr>  				
				<td style="background:url('images/leftcursor.png') no-repeat;border:none;" width="30" height="25"></td>
				<td align="center" style="border:none;"><input type="button" class="btncss"  value="添加用户" onclick="return adduserrole();" /></td>
				<td width="30" height="25" style="border:none;"></td>	
			</tr>
			<tr><td height="10" colspan="3" style="border:none;">&nbsp;</td></tr>  
			<tr>  				
				<td width="30" height="25" style="border:none;"></td>
				<td align="center" style="border:none;"><input type="button" class="btncss"  value="返回查询" onclick="return returnSearch();" /></td>
				<td width="30" height="25" style="border:none;"></td>	
			</tr>
			<tr><td height="10" colspan="3" align="center" style="border:none;"><label id="returninfo" style="color:red;">${requestScope.returnInfo }</label>&nbsp;</td></tr>  					
	  	</table>
	  	
		<table cellpadding="0" cellspacing="1" width="220" align="left" style="float:left;position:relative;left:20px;border:1px solid #6EB33D;">			
			<tr>
				<td height="19px" width="150" colspan="3" class="table_title1" style="padding-left:0px;font-weight:bold;">管理用户(按ctrl键可进行多选)</td> 				
			</tr> 
			<tr>
				<td style="font-weight:bold;">
					<select multiple="multiple" style="width:210px;border:0px solid red;" size="20" name="useridadd" id="useridadd">
						<c:forEach items="${requestScope.userlist}" var="userlist">
							<option value="${userlist.userid }">${userlist.loginname }_${userlist.username }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
	  	</table>

	</div>
	</form>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	function returnSearch(){
		document.searchForm.action="role!findByList.shtml";
		document.searchForm.submit();
	}
	function deluserrole(){    	
		var returninfo = document.getElementById("returninfo");
		var useriddel = document.getElementById("useriddel");	
		var useridtype = document.getElementById("useridtype");
		if(arraycheck.length>0){
			var roleIdStrTemp="";
	 		for(var i = 0 ;i<arraycheck.length;i++){
	 			roleIdStrTemp+=arraycheck[i]+","
	 		}
		}else{
			returninfo.innerHTML="未选择用户！";
			return false;
		}
		returninfo.innerHTML="";
		useriddel.value=roleIdStrTemp;
		useridtype.value="deluser";
		document.searchForm.submit();
		
	}
	
	function adduserrole(){
		var useridadd = document.getElementById("useridadd");
		var returninfo = document.getElementById("returninfo");
		var useridtype = document.getElementById("useridtype");
		if(useridadd.value==""){
			returninfo.innerHTML="请选择用户！";
			return false;
		}    		
		returninfo.innerHTML="";
		useridtype.value="adduser";
		document.searchForm.submit();
	}
	
	//多项选择checkbox开始
	function chooseRole(obj){
		OnclickBox(obj);
	}
	var arraycheck=new Array();
	function OnclickBox(obj){
		if(obj.checked){	
			arraycheck[arraycheck.length]=obj.value;	
			var tagname=obj.name;
		}else{
			if(Arraycontains(arraycheck,obj.value)){
			arraycheck.splice(getindex(arraycheck,obj.value),1);
			}
		}			  	
	}		
	function Arraycontains(arraychecks,chvalue){
		var falgs=false;
		for(var i=0;i<arraychecks.length;i++){
		if(arraychecks[i]==chvalue){
			falgs=true;
			break;
			}
		}
	return falgs;
	}
	function getindex(array,objvalue){
		var index;
		for(var i=0;i<array.length;i++){
		if(array[i]==objvalue){
			index=i;
			break;
			}
		}
		return index;
	}
	//多项选择checkbox结束
	</script>
	
	</body>
</html>

