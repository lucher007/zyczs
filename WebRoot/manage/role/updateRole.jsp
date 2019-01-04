<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<body style="margin:0;padding:0;">
	<div id="body">
		<div class="cur-pos">当前位置：更新角色</div>
		<form action="role!updateObject.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="orgid" id="orgid" value="${requestScope.orgid }" />
		<input type="hidden" name="roleid" id="roleid" value="${requestScope.role.roleid }" />
	    <div class="form-box">
    		<div class="fb-tit">更新角色</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="30" align="right">角色名称：</td><td>
		            	<input type="text" class="inp w150" name="rolename" id="rolename" maxlength="20" value="${requestScope.role.rolename }" onblur="checkVal(this.name);"> <span class="red">*</span>
		            </td>
		            <td width="150">
						<label name="rolenameLab" id="rolenameLab" class="noico">
						</label>
					</td>
					<td width="300">&nbsp;</td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="返回" class="sbt" onclick="return findByList();"></cite>
		        <cite><input type="button" value="更新" class="sbt" onclick="return showinfo();"></cite>		        
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
        <div class="pop-box" id="pop-div">
			<div id="divTitle" >
				<table width="300">
					<tr>
						<td width="120" height="30" align="right" bgcolor="#EEEEEE">角色名称：</td><td><label id="l_rolename" /></td>
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
		editSure();
	}
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="rolename"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("角色名称没有填写!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符!");
				return false;
			}
			var url="<%=request.getContextPath()%>/roleAjax!findByExist.shtml?rid="+Math.random();
			$.getJSON(url,{'rolename':nameval}, function(data) {
				if(data.model.returncode==1){
					checkerror(name);
					namelab.html("角色已经存在!");
					return false;
				}
			});
			checksuccess(name);
		}
		return true;
	}
	function findByList(){
		$("#rolename").val("");
		$("#dataForm").attr("action","role!findByList.shtml");
		$("#dataForm").submit();
	}
	</script>   
	</body>
</html>
