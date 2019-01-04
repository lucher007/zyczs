<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<div class="cur-pos">当前位置：用户注册 > 添加</div>
		<form action="user!save.shtml" id="dataForm" name="dataForm" method="post">
		<s:token></s:token>
		<input type="hidden" name="cpccorp" id="cpccorp" value="${requestScope.org.cpccorp }" />
		<input type="hidden" name="orgid" id="orgid" value="${requestScope.org.orgid }" />
		<input type="hidden" name="state" id="state" value="1" />
		<input type="hidden" name="userrolestr" id="userrolestr" value="" />
		<input type="hidden" name="opertype" id="opertype" value="${opertype}" />
		<input type="hidden" name="supercpccode" id="supercpccode" value="${supercpccode}" />
	    <div class="form-box">
    		<div class="fb-tit">添加用户</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		        	<tr>
		            <td height="30" align="right">所属单位：</td>
		            <td colspan="2">
		            	${requestScope.org.orgname }
		           	</td>
		          </tr>	
		          <tr>
		            <td height="30" align="right">单位所属区域：</td>
		            <td colspan="2">
		            	<input type="text" name="province" id="province" value="${requestScope.org.province }" class="inponly" readonly="readonly" />
		            	<input type="text" name="city" id="city" value="${requestScope.org.city }" class="inponly" readonly="readonly" />
		            	<input type="text" name="area" id="area" value="${requestScope.org.area }" class="inponly" readonly="readonly" />
		           	</td>
		          </tr>
		         
		          <tr>
		            <td height="30" align="right">单位类型：</td>
		            <td colspan="2">
		            	<c:if test="${fn:substring(requestScope.org.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 4, 5)=='1'}">药材市场 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 5, 6)=='1'}">医院 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 6, 7)=='1'}">管理机构 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 7, 8)=='1'}">其他 </c:if>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">用户登录名：</td><td>
		            	<input type="text" class="inp w150" name="loginname" id="loginname" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
		            </td><td>
						<label name="loginnameLab" id="loginnameLab" class="noico">
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">用户登录密码：</td><td>
		            	<input type="password" class="inp w150"  name="loginpass" id="loginpass" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
		            </td><td>
						<label name="loginpassLab" id="loginpassLab" class="noico">
						</label>
					</td>
		          </tr>
		           <tr>
		            <td height="30" width="160" align="right">再次输入登录密码：</td><td width="170">
		            	<input type="password" class="inp w150" name="reloginpass" id="reloginpass" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
		            </td><td width="380">
						<label name="reloginpassLab" id="reloginpassLab" class="noico">
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">真实姓名：</td><td>
		            	<input type="text" class="inp w150" name="username" id="username" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
		            </td><td>
						<label name="usernameLab" id="usernameLab" class="noico">
						</label>
					</td>
		          </tr>
		          <tr><td colspan="2" height="10">&nbsp;</td></tr>
		          <tr>
		            <td height="30" align="right">用户组：</td><td>
		            	<table width="162" cellpadding="0" cellspacing="0" border="0" style="float:left;">
		            		<c:forEach items="${requestScope.rolelist}" var="rolelist">
		            		<tr>
		            			<td width="15" align="left"><input type="checkbox" onclick="chooseRole(this)" name="two" id="${rolelist.roleid }" value="${rolelist.roleid }" /></td>
		            			<td>${rolelist.rolename }</td>
		            		</tr>
		            		</c:forEach>
		            	</table>
		            	<span class="red">*</span>
		            </td><td>
						<label name="roleLab" id="roleLab" class="noico">
						</label>
					</td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="返回" class="sbt" onclick="return findByList();"></cite>
		        <cite><input type="button" value="确认" class="sbt" onclick="return showinfo();" id="finishbtn" disabled="disabled"></cite>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
        <div class="pop-box" id="pop-div">
			<div id="divTitle" >
				<table width="300">
					<tr>
						<td width="120" height="30" align="right" bgcolor="#EEEEEE">用户登录名：</td><td> <label id="l_loginname" /></td>
					</tr><tr>
						<td height="30" align="right" bgcolor="#EEEEEE">用户登录密码：</td><td> <label id="l_loginpass" /></td>
					</tr><tr>
						<td height="30" align="right" bgcolor="#EEEEEE">真实姓名：</td><td> <label id="l_username" /></td>
					</tr>
				</table>
			</div>
		</div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	function showinfo(){
		var flag=0;
		$("input").each(function(){
		    if(checkVal($(this).attr("name"))==false){
			    flag =1;
				return false;
			}
		});
		if(flag==1){
			return false;
		}
		var roleIdStrTemp="";
		if(arraycheck.length>0){
	 		for(var i = 0 ;i<arraycheck.length;i++){		 			
	 			roleIdStrTemp+=arraycheck[i]+","
	 		}
		}else{
			checkerror("role");
			$("#roleLab").html("用户组没有选择!");
			return false;
		}
		
		$("#userrolestr").val(roleIdStrTemp);
		editSure();
	}
	function check(ob){
		var pattern=/\w{4,20}/;
		var result = pattern.exec(ob);
		return result==ob;
	} 
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="loginname"){
			$("#finishbtn").attr("disabled","disabled");	
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("登录名称填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
	    	}
			var url="<%=request.getContextPath()%>/userAjax!findByExist.shtml?rid="+Math.random();
			$.getJSON(url,{'loginname':nameval}, function(data) {
				if(data.model.returncode==1){
					checkerror(name);
					namelab.html("用户已经存在");
					return false;
				}else{
					$("#finishbtn").removeAttr("disabled");
				}
			});
			checksuccess(name);
		}

		if(name=="loginpass"){
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("登录密码填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
	    	}
			checksuccess(name);
	    	if($("#reloginpass").val()!=""){
				if(nameval!=$("#reloginpass").val()){
					checkerror("reloginpass");
					$("#reloginpassLab").html("再次输入登录密码没有输入或不正确");
					return false;
				}
	    	}
	    	
		}

		if(name=="reloginpass"){
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("再次输入登录密码填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
	    	}
			if(nameval!=$("#loginpass").val()){
				checkerror(name);
				namelab.html("再次输入登录密码填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
			}
	    	checksuccess(name);
		}

		if(name=="username"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("真实姓名没有填写或者填写不正确!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}


		return true;
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
	
	function findByList_User(){
		$("#username").val("");
		$("#loginname").val("");
		$("#orgid").val("");
		$("#cpccorp").val("");
		$("#dataForm").attr("action", "user!findByList.shtml");
		$("#dataForm").submit();
	}
	
	function findByList(){
		$("#username").val("");
		$("#loginname").val("");
		//$("#orgid").val("");
		$("#dataForm").attr("action", "user!findByList.shtml");
		$("#dataForm").submit()
	}
	
	</script>   
	</body>
</html>
