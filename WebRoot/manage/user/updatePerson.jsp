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
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：个人资料</div>
    	<div class="form-box">
    		<form action="user!updatePerson.shtml" id="dataForm" name="dataForm" method="post">
			<input type="hidden" name="userid" id="userid" value="${sessionScope.User.userid }" />
    		<div class="fb-tit">用户详情 <span>企业CPC码：${sessionScope.User.cpccorp }</span></div>
        	<div class="fb-con">
		        <table border="0" cellpadding="0" cellspacing="0" width="100%">
		          <tr>
		            <td height="30" width="160" align="right">用户登录名：</td>
		            <td width="175">
		            	<input type="text" class="inponly" name="loginname" id="loginname" maxlength="20" value="${sessionScope.User.loginname }" readonly="readonly"> <span class="red">*</span>
					</td>
		            <td>
						<label name="loginnameLab" id="loginnameLab" class="noico">
							用户登录名没有输入或不正确
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">用户登录密码：</td><td>
		            	<input type="password" class="inp w150" name="oldloginpass" id="oldloginpass" maxlength="20" onblur="checkVal(this.name);" value=""> <span class="red">*</span>
					</td>
		            <td>
						<label name="oldloginpassLab" id="oldloginpassLab" class="noico">
							用户登录密码没有输入或不正确
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">修改后的密码：</td><td>
		            	<input type="password" class="inp w150" name="loginpass" id="loginpass" maxlength="20" onblur="checkVal(this.name);" value=""> <span class="red">*</span>
					</td>
		            <td>
						<label name="loginpassLab" id="loginpassLab" class="noico">
							修改后的密码没有输入或不正确
						</label>
					</td>
		          </tr>
		           <tr>
		            <td height="30" align="right">再次输入登录密码：</td><td>
		            	<input type="password" class="inp w150" name="reloginpass" id="reloginpass" maxlength="20" onblur="checkVal(this.name);" value=""> <span class="red">*</span>
					</td>
		            <td>
						<label name="reloginpassLab" id="reloginpassLab" class="noico">
							再次输入登录密码没有输入或不正确
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">真实姓名：</td>
		            <td>
		            	<input type="text" class="inps w150" name="username" id="username" maxlength="20" onblur="checkVal(this.name);" value="${sessionScope.User.username }"> <span class="red">*</span>
		            </td>
		            <td>
						<label name="usernameLab" id="usernameLab" class="noico">
							真实姓名没有输入或不正确
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="40"></td><td colspan="2"><input type="button" value="更新个人信息" class="sbt" onclick="return showinfo();"> <span class="red">${requestScope.returninfo }</span> </td>
		          </tr>
		      </table>
		      <table border="0" cellpadding="0" cellspacing="0" width="726" class="fbc-box ml10 mt10">
		        <tr class="fbc-tit">
		          	<td><b>单位信息</b></td>
		        </tr>
		      	<tr>
		      	  <td valign="top" style="padding:10px;">
		      	  <table width="100%">
		          <tr>
		            <td height="30" width="120" align="right" bgcolor="#EEEEEE">所属单位：</td>
		            <td>
		            	${sessionScope.User.org.orgname }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">单位类型：</td>
		            <td style="line-height:22px;">
		            	<c:if test="${fn:substring(sessionScope.User.org.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 4, 5)=='1'}">药材市场 </c:if>　
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 5, 6)=='1'}">医院 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 6, 7)=='1'}">管理机构 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.org.zyctype, 7, 8)=='1'}">其他 </c:if>　
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">单位联系人：</td>
		            <td>
		            	${sessionScope.User.org.linkman }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">单位所属区域：</td>
		            <td>
		            	${sessionScope.User.org.province } - 
		            	${sessionScope.User.org.city } - 
		            	${sessionScope.User.org.area }
		           	</td>
		          </tr>
		         <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">详细地址：</td>
		            <td>
		            	${sessionScope.User.org.registeraddress }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">移动电话：</td>
		            <td>
		            	${sessionScope.User.org.mobile }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">固定电话：</td>
		            <td>
		            	${sessionScope.User.org.telephone }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">传真：</td>
		            <td>
		            	${sessionScope.User.org.officephone }
		            </td>
		           </tr>
		           
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">电子邮件：</td>
		            <td>
		            	${sessionScope.User.org.email }
		            </td>
		           </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">邮编：</td>
		            <td>
		            	${sessionScope.User.org.postcode }
		            </td>
		           </tr>
		           </table>
		           </td>
		           
		           </tr>
		        </table>
        	</div>
        	<div class="pop-box" id="pop-div">
				<div id="divTitle">
					<table width="300" cellpadding="0" cellspacing="0">
						<tr>
							<td height="30" bgcolor="#EEEEEE" align="right" width="120">用户登录名：</td><td>&nbsp;<label id="l_loginname" /></td>
						</tr>
						<tr>
							<td height="30" bgcolor="#EEEEEE" align="right">用户登录密码：</td><td>&nbsp;<label id="l_loginpass" /></td>
						</tr>
						<tr>
							<td height="30" bgcolor="#EEEEEE" align="right">真实姓名：</td><td>&nbsp;<label id="l_username" /></td>
						</tr>
					</table>
				</div>
			</div>
        	</form>
        </div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
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
		var url="<%=request.getContextPath()%>/userAjax!findByExist_password.shtml?rid="+Math.random();
		$.getJSON(url,{'userid':$("#userid").val(),'loginpass':$("#oldloginpass").val()}, function(data) {
			if(data.model.returncode==0){
				checkerror(name);
				namelab.html("密码填写不正确!");
				return false;
			}else{
				editSure();
			}
		});
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
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("登录名称填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
	    	}
			checksuccess(name);
		}

		if(name=="oldloginpass"){
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("密码填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
				return false;
	    	}
			var url="<%=request.getContextPath()%>/userAjax!findByExist_password.shtml?rid="+Math.random();
			$.getJSON(url,{'userid':$("#userid").val(),'loginpass':nameval}, function(data) {
				if(data.model.returncode==0){
					checkerror(name);
					namelab.html("密码填写不正确!");
					return false;
				}
			});
			checksuccess(name);
		}

		if(name=="loginpass"){
			if(check(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("修改后的密码填写不正确!4-20个字符使用字母(A-Z,a-z)数字(0-9)下划线(_)不能含空格或中文！");
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
	</script>
	</body>
</html>
