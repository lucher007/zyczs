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
		<div class="cur-pos">当前位置：应急处理 > 追溯锁定</div>
		<form action="freeze!save.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="state" id="state" value="0" />
	    <div class="form-box">
    		<div class="fb-tit">追溯锁定</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="30" align="right">CPC码：</td><td>
		            	<input type="text" class="inp w150" name="cpccode" id="cpccode" maxlength="35" value="${requestScope.cpccode }" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> <span class="red">*</span>
		            </td><td>
						<label name="cpccodeLab" id="cpccodeLab" class="noico">
						</label>
					</td>
		          </tr>
		          <tr>
		            <td height="30" width="160" align="right"> 品种：</td><td width="170">
		            	<select name="cpctype" id="cpctype" class="w150">
							<option value="0">药材</option>
							<option value="1">饮片</option>
				  		</select>
				  		 <span class="red">*</span>
		            </td><td width="380">
					</td>
		          </tr>
		          <tr>
		            <td height="30" width="160" align="right"> 原因：</td><td width="170">
		            	<select name="reason" id="reason" class="w150">
							<option value="1">质量原因</option>
							<option value="2">其它</option>
						 </select>
				  		 <span class="red">*</span>
		            </td><td width="380">
					</td>
		          </tr>
		          <tr>
		            <td height="30" width="160" align="right"> 类型：</td><td width="170">
		            	<select name="cpclevel" id="cpclevel" class="w150">
								<option value="0">溯源码</option>
								<option value="1">批次码</option>
								<option value="2">产品码</option>
								<option value="3">企业码</option>
						  </select>
				  		 <span class="red">*</span>
		            </td><td width="380">
					</td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="确认冻结" class="sbt" onclick="return showinfo();" id="btnfinish"></cite>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
        <div class="pop-box" id="pop-div">
			<div id="divTitle" >
				<table width="300">
					<tr>
						<td width="120" height="30" align="right" bgcolor="#EEEEEE">CPC码：</td><td> <label id="l_cpccode" /></td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">品种：</td><td> <label id="l_cpctype" /></td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">原因：</td><td> <label id="l_reason" /></td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">类型：</td><td> <label id="l_cpclevel" /></td>
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
	cMenu(2,1);
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="cpccode"){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("CPC码没有输入");
				return false;
	    	}
			checksuccess(name);
		}
	}
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
		$("#l_cpctype").text($("#cpctype").find("option:selected").text());
		$("#l_reason").text($("#reason").find("option:selected").text());
		$("#l_cpclevel").text($("#cpclevel").find("option:selected").text());
		editSure();
		$("#btnfinish").attr("disabled","disabled");
	}
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	}
	</script>   
	</body>
</html>
