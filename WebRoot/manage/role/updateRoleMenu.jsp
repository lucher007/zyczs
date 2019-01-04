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
		<style type="text/css">
		 .tablecss tr td{
		 	height:20px;
		 }
		</style>
	</head>
	
	<body style="margin:0;padding:0;" onload="getCount();">
	<form action="" method="post" name="searchform" id="searchform">
  	<input type="hidden" name="menustr" id="menustr" />
  	<input type="hidden" name="menustrchild" id="menustrchild" />
  	<input type="hidden" name="roleid" id="roleid" value="${requestScope.roleid }" />
	<input type="hidden" name="orgid" id="orgid" value="${requestScope.orgid }" />
	<div style="height:350px;overflow-y:scroll;">
  	<table cellpadding="0" cellspacing="2" border="0"  width="700" class="tablecss">
  		
   		<tr><td align="left"><!-- 开始-->
   		<table cellpadding="0" cellspacing="0" width="220" border="0">
		<c:forEach items="${requestScope.menulist}" var="menulist" varStatus="vs">
			<c:if test="${vs.index%2==0}">
				</table>
				<table style="float:left;margin-left:5px;" cellpadding="0" cellspacing="0" width="220" border="0">
			</c:if>
			<c:if test="${menulist.menuparentid==0}">
    			<tr><td style="font:bold 14px arial;color:#005073;">一级菜单 ${menulist.menutitle }</td></tr>
				<c:forEach items="${requestScope.menulist}" var="menulistsub">
					<c:set var="i" value="${0}" />
					<c:set var="j" value="${0}" />
					<c:if test="${menulistsub.menuparentid==menulist.menumainid&&menulistsub.menutype==2}">
						<c:if test="${i==0}">	
    					<tr><td>
    					<span style="margin-left:20px;font:bold 13px arial;color:#00709E;">二级菜单</span>
    					<span style="margin-left:20px;width:80px;display:inline-block;">${menulistsub.menutitle }</span>
    					<c:forEach items="${requestScope.rolemenulist}" var="rolemenulist">
								<c:if test="${rolemenulist.menuid==menulistsub.menumainid}">
									<input type="checkbox" onclick="chooseRole(this)" checked="checked" name="two" id="${menulistsub.menumainid }" value="${menulistsub.menumainid }_${menulistsub.menuparentid }" />
									<c:set var="i" value="${1}" />
									<c:set var="j" value="${1}" />
								</c:if>
						</c:forEach>
						<c:if test="${j!=1}">
								<input type="checkbox" onclick="chooseRole(this)" name="two" id="${menulistsub.menumainid }" value="${menulistsub.menumainid }_${menulistsub.menuparentid }" />							
						</c:if>
						</td></tr>	
						</c:if>
						
					</c:if>
					
				</c:forEach>
			</c:if>
			
		</c:forEach>
		
		</table>
		</td></tr><!-- 结束 -->
		
		<tr>  			
  			<td class="table_content1" align="center">
  				<label id="returninfo" name="returninfo" style="color:red;">&nbsp;${requestScope.returninfo }</label>
  			</td>  			
  		</tr> 
   		<tr>
   			<td class="table_content1" align="center">
   				<input type="button" value="确认更新" class="btncss" onclick="return checkForm();" id="addbtn" />
  				<input type="button" value="返回查询" class="btncss" onclick="return findByList();" />
   			</td>
   		</tr>
   	</table>
   	</div>
	</form>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	function findByList(){    		
		document.searchform.action="role!findByList.shtml";
		document.searchform.submit();
	}
	function checkForm(){ 		
		var returninfo = document.getElementById("returninfo");
		if(arraycheck.length>0){
			var roleIdStrTemp="";
	 		for(var i = 0 ;i<arraycheck.length;i++){		 			
	 			roleIdStrTemp+=arraycheck[i]+","
	 		}
	 		var riststr = roleIdStrTemp.substring(0,roleIdStrTemp.length-1);
	 		var rist = riststr.split(",");
	 		var count=0;
	 		for(var j=0;j<rist.length;j++){
		 		if(rist[j]!='76_75'&&rist[j]!='77_75'&&rist[j]!='78_75'&&rist[j]!='79_75'&&rist[j]!='80_75'&&rist[j]!='81_75'&&rist[j]!='82_75'&&rist[j]!='83_75'&&rist[j]!='85_84'&&rist[j]!='86_84'){
			 		count=1;
		 		}
	 		}
	 		if(count==0){
	 			returninfo.innerHTML="市场平台除库存管理，检验管理还必须选择其它权限!";
	 			return;
	 		}
		}else{
			returninfo.innerHTML="未选择权限!";
			return;
		}
		if(arraycheckchild.length>0){
			var roleIdStrTempChild="";
			for(var i = 0 ;i<arraycheckchild.length;i++){		 			
	 			roleIdStrTempChild+=arraycheckchild[i]+","
	 		}
			var menustrchild = document.getElementById("menustrchild");
			menustrchild.value=roleIdStrTempChild
		}			
		var menustr = document.getElementById("menustr");
		menustr.value=roleIdStrTemp
		returninfo.innerHTML="";			
    	document.searchform.action="role!updateByIdRoleMenu.shtml"
    	document.searchform.submit();
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
	
	//多项选择checkbox开始
	function chooseRoleChild(obj){
		
		OnclickBoxChild(obj);
	}
	var arraycheckchild=new Array();
	function OnclickBoxChild(obj){
		if(obj.checked){	
			arraycheckchild[arraycheckchild.length]=obj.value;	
			var tagname=obj.name;
		}else{
			if(ArraycontainsChild(arraycheckchild,obj.value)){
			arraycheckchild.splice(getindexChild(arraycheckchild,obj.value),1);
			}
		}			  	
	}		
	function ArraycontainsChild(arraycheckchilds,chvalue){
		var falgs=false;
		for(var i=0;i<arraycheckchilds.length;i++){
		if(arraycheckchilds[i]==chvalue){
			falgs=true;
			break;
			}
		}
	return falgs;
	}
	function getindexChild(array,objvalue){
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
	function getCount(){
	       var items=document.getElementsByName("two");
	       var count=0;
	       for(var i=0;i<items.length;i++){
	            if(items[i].type=="checkbox"){		            	
	                if(items[i].checked){
	                	chooseRole(items[i]);
	                    count++;
	                }		                
	            }
	       }
	       
	       var itemschild=document.getElementsByName("three");
	       var countchild=0;
	       for(var i=0;i<itemschild.length;i++){
	            if(itemschild[i].type=="checkbox"){		            	
	                if(itemschild[i].checked){
	                	chooseRoleChild(itemschild[i]);
	                    countchild++;
	                }		                
	            }
	       }		       
	}
	</script>
	
	</body>
</html>

