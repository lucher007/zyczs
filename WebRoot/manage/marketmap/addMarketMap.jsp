<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cpccorp = request.getParameter("cpccorp");
	request.setAttribute("cpccorp",cpccorp);
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>区楼层添加</title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：市场平面图管理 > 区楼层添加</div>
		<div class="form-box">
			<form action="<%=basePath %>marketMap!save.shtml" method="post" name="searchform" id="searchform">
			<s:token></s:token>
    		<div class="fb-tit">区楼层添加</div>
        	<div class="fb-con">
				<input type="hidden" id="cpccorp" name="cpccorp" value="${cpccorp }" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="39" align="right" width="170">
							名称(楼)：
						</td>
						<td width="170">
							<input type="text"  name="area" maxlength="6" class="inp w150"
								id="area" onblur="checkVal(this.name)"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="areaLab" id="areaLab" class="noico">
							</label>
						</td>
						<td></td>
					</tr>
					<tr>
						<td height="39" align="right">
							名称(区)：
						</td>
						<td>
							<input type="text"  name="floor" maxlength="1" class="inp w150"
								id="floor" 
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="checkVal(this.name);"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="floorLab" id="floorLab" class="noico">
							</label>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<div class="fb-bom">
				<cite><input type="button" value="确定" id="finishbtn" class="sbt" onclick="checkInfoMarketMap()"></cite>
			</div>
			</form>
  		</div>
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right" width="120">
							名称(楼)： 
						</td>
						<td>
							<label id="l_area" />
						</td>
					</tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right">
							名称(区)： 
						</td>
						<td>
							<label id="l_floor" />
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2" height="60" class="red">
							确定后信息将无法更改，请仔细核对任务信息
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
	/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9])?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?$/)) {
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
	
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	
	function check(ob){
		var pattern=/\w{1,6}/;
		var result = pattern.exec(ob);
		return result==ob;
	} 
	
	/**
	*验证市场区域
	*/
	function checkVal(name) {
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="area"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("名称没有填写!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("名称填写不正确!使用中文,字母,数字！");
				return false;
	    	}
	    	   checksuccess(name);
	    	   return true;
		}
		if(name=="floor"){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("名称没有输入！");
				return false;
	    	}
    		checkload(name);
    		namelab.html("数据验证中，请稍后...");
	    	var url="<%=request.getContextPath()%>/marketMapAjax!findExist.shtml?rid="+Math.random();
	    	var param = "cpccorp="+$("#cpccorp").val()+"&area="+encodeURIComponent($.trim($("#area").val()))+"&floor="+$("#floor").val();
			$.getJSON(url,param, function(data) {
				if(data.model.returninfo==1){
					checkerror(name);
					//$.dialog.tips($("#area").val()+"区"+$("#floor").val()+"楼名称已经被使用!请重新填写楼名称",1,'alert.gif');
					namelab.html($("#floor").val()+"名称已经被使用,请重新填写名称！");
					return false;
				}
					checksuccess(name);
					return true;
			});
		}
	}
	
	function checkInfoMarketMap(){
		if(!checkVal("area")){
			return false;
		}
		if($("#floor").val()==null||$("#floor").val()==""){
			checkerror("floor");
			$("#floorLab").html("名称没有输入！");
			return false;
		}
    	checksuccess("floor");
    	var url="<%=request.getContextPath()%>/marketMapAjax!findExist.shtml?rid="+Math.random();
    	var param = "cpccorp="+$("#cpccorp").val()+"&area="+encodeURIComponent($.trim($("#area").val()))+"&floor="+$("#floor").val();
		$.getJSON(url,param, function(data) {
			if(data.model.returninfo==1){
				checkerror("floor");
				//$.dialog.tips($("#area").val()+"区"+$("#floor").val()+"楼名称已经被使用!请重新填写楼名称",1,'alert.gif');
				$("#floorLab").html($("#floor").val()+"名称已经被使用,请重新填写名称！");
				return false;
			}else{
				checksuccess("floor");
				editSure();
			}
		});
	}
	//////////////////////////////////////////////////////////////////////
  	</script>
	</body>
</html>

