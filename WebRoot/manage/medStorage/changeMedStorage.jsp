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
	
	String medstorid = request.getParameter("medstorid");
	String cpcmed = request.getParameter("cpcmed");
	String medname = request.getParameter("medname");
	String medweight = request.getParameter("medweight");
	String mednumweight = request.getParameter("mednumweight");//规格
	String mednum = request.getParameter("mednum");//包数
	String medtype = request.getParameter("medtype");//0未分包,1已分包
	
	request.setAttribute("medstorid",medstorid);
	request.setAttribute("cpcmed",cpcmed);
	request.setAttribute("medname",medname);
	request.setAttribute("medweight",medweight);
	request.setAttribute("mednumweight",mednumweight);
	request.setAttribute("mednum",mednum);
	request.setAttribute("medtype",medtype);
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>库存修改</title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
   		<style type="text/css">
   			html,body{
   				margin:0;
   				padding:0;
   			}
   		</style>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos"></div>
		<div class="form-box" style="width:463px;">
			<form action="" method="post" name="searchform" id="searchform">
			<input type="hidden" id="medstorid" name="medstorid" />
			<input type="hidden" id="medtype" name="medtype" />
			<s:token></s:token>
    		<div class="fb-tit">注:库存修改重量上限不超过实际库存5%,下限不超过实际库存10%</div>
				<table border="0" cellspacing="0" cellpadding="0" width="400" height="200">
					<tr>
						<td height="39" align="left">
							批次号：
						</td>
						<td id="cpcmed">
							
						</td>
					</tr>
					
					<tr>
						<td height="39" align="left">
							品名：
						</td>
						<td id="medname">
						</td>
					</tr>
					
					<tr>
						<td height="39" align="left">
							库存重量(Kg)：
						</td>
						<td id="medweight">
						</td>
					</tr>
					
					<tr>
						<td height="39" align="left">
							规格(Kg)：
						</td>
						<td id="mednumweight">
						</td>
					</tr>
					
					<tr>
						<td height="39" align="left">
							包数：
						</td>
						<td id="mednum">
						</td>
					</tr>
					
					<tr>
						<td height="39" align="left" width="110" id="td_change">
							库存修改重量(Kg)：
						</td>
						<td>
							<input type="text"  name="change" maxlength="6" class="inp w150"
								id="change" 
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);isValid(this.value)"
								 />
							<span class="red">*</span>
						</td>
					</tr>
				</table>
				<div class="fb-bom" style="width:463px;">
					<cite style="padding-right:20px;">
					<input type="button" value="确定" class="sbt" id="updateMedStorage">
					<input type="button" value="关闭" class="sbt" id="closeMe" style="display: none;">
					</cite>
				</div>
			</form>
  		</div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
	<script type="text/javascript" language="javascript">
	$(function(){
		//如果是未分包则隐藏规格和包数
		if(${medtype} == 0){
			$("#mednumweight").html("未包装");
			$("#mednum").html("未包装");
		}else{
			$("#mednumweight").html(${mednumweight});
			$("#mednum").html(${mednum});
			$("#td_change").html("每包修改重量(Kg)：");
		}
		$("#medstorid").val(${medstorid});
		$("#medtype").val(${medtype});
		$("#cpcmed").html('${cpcmed}');
		$("#medname").html('${medname}');
		$("#medweight").html(${medweight});
		$("#change").focus();
	});
	/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
		function onkeypressCheck(obj){
			if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if(obj.value.match(/^\d+\.\d{4}?$/)){
					obj.value = obj.value.substr(0,obj.value.length-1);
			} 
		}
		
		function onkeyupCheck(obj){
			if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
					obj.value = obj.t_value;
				} else {
					obj.t_value = obj.value;
				}
				if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
					obj.o_value = obj.value;
				}
				if (obj.value.match(/^\.$/)) {
					obj.value = "";
				}
				if (obj.value.match(/^\-$/)) {
					obj.value = "";
				}
				if (obj.value.match(/^00+/)) {
					obj.value = "";
				}
				if (obj.value.match(/^0\.00/)) {
					obj.value = "";
				}
				if (obj.value.match(/^0[1-9]/)) {
					obj.value = "";
				}
				if(obj.value.match(/^\d+\.\d{4}?$/)){
							obj.value = obj.value.substr(0,obj.value.length-1);
				} 
				if(obj.value == 'undefined'){
							obj.value='';
				}
		}
		
		function onkeyblurCheck(obj){
			if(obj.value==0){
					obj.value='';
			}
			if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
				obj.value = obj.o_value;
			}else {
				if (obj.value.match(/^\.\d+$/)) {
					obj.value = 0 + obj.value;
				}
				obj.o_value = obj.value;
			}
			if(!obj.value.match(/^\d+(\.\d{3})?$/)){
				obj.value = obj.value.substr(0,obj.value.indexOf(".")+4);
			} 
		}
		//////////////////////////////////////////////////////////////////////
		/**
		*判断库存修改是否合理
		*/
		function isValid(val){	
			var medweight = $("#medweight").html();
			
			//未分包的直接用库存量计算,分包的则用规格乘以库存后计算
			if(val == "" || val == null){
				var str = "库存修改重量未输入";
				if($("#medtype").val() == 1){
					str = "每包修改重量未输入";
				}
				$.dialog.alert(str,1,'alert.gif');
				return false;
			}else{
				if($("#medtype").val() == 1){
					val = val * $("#mednum").html();
				}
			}
			
			
			if(subtr(val,medweight) > 0){
				if(division(subtr(val,medweight),medweight) *100 >	 5){
					$.dialog.alert("上限调整超过5%,不予保存",1,'alert.gif');
					return false;
				}
			}else if(subtr(val,medweight) < 0){
				if(division(subtr(medweight,val),medweight) *100 > 10){
					$.dialog.alert("下限调整超过10%,不予保存",1,'alert.gif');
					return false;
				}
			}
				return true;
		}
		
		$("#updateMedStorage").click(function(){
			$(".red").text("*");
			if(isValid($("#change").val())){
				var url="medStorAjax!updateChangeMedWeight.shtml?rid="+Math.random();
				var mednum = $("#medtype").val() == 1?$("#mednum").html():"";
				var oldchange = $("#medtype").val() == 1?$("#mednumweight").html():$("#medweight").html();
				$.getJSON(url,{'change':$("#change").val(),'medstorid':$("#medstorid").val(),'medtype':$("#medtype").val(),'medname':$("#medname").html(),'cpcmed':$("#cpcmed").html(),'mednum':mednum,'oldchange':oldchange}, function(data) {
					if(data.model.returncode==1){
						$(".red").text("库存调整成功");
						if(data.model.medtype == 1){
							$("#change").val(data.model.change);
							$("#mednumweight").html(data.model.change);
						}
						$("#medweight").html(data.model.medweight / 10000);
						$("#closeMe").show();
						$("#updateMedStorage").hide();
						$("#change").attr("readonly","readonly");
						$("#change").css("background","#CCC");
					}else{
						$(".red").text("库存调整失败,请关闭窗口后重试");
					}
				});
			}
		});
		
		$("#closeMe").click(function(){
			parent.closeChangeMedWeight();
		});
  	</script>
	</body>
</html>

