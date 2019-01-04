<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>药材分包</title>
		<link type="text/css" rel="stylesheet" href="/style/market.css">
	</head>

	<body oncontextmenu='return false' oncopy='document.selection.empty()'
		onbeforecopy="return false" onpaste="return false;"
		oncut="return false;">
		<div id="body">
			<div class="cur-pos">
				当前位置：库存出库 > 药材分包
			</div>
			<div class="form-box">
				<form action="<%=basePath %>medSell!updateMedPack.shtml"
					method="post" name="searchform" id="searchform">
					<s:token></s:token>
					<input type="hidden" name="totalkgall" id="totalkgall"
						value="${vo.medweight / 10000}" />
					<input type="hidden" name="packstr" id="packstr" />
					<input type="hidden" name="leftmedweight" id="leftmedweight" />
					<input type="hidden" name="cpcmed" id="cpcmed"
						value="${vo.cpcmed }" />
					<input type="hidden" name="medstorid" id="medstorid"
						value="${vo.medstorid }" />
					<input type="hidden" name="usetotal" id="usetotal" />
					<div class="fb-tit">
						药材分包
						<span style="color: red">
							注:待分包重量不能大于待分包总重量,待分包规格不能大于待分包重量,分包数最多为10000包！ 
						</span>
					</div>
					<div class="fb-con">
						<table width="726" border="0" cellspacing="0" cellpadding="0"
							class="ml10">
							<tr>
								<td width="188" class="fbc-box" valign="top">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr class="fbc-tit b">
											<td>
												药材信息
											</td>
										</tr>
										<tr>
											<td height="25">
												品名：${vo.medname}
											</td>
										</tr>
										<tr>
											<td height="25">
												批次码：${vo.cpcmed }
											</td>
										</tr>
										<tr>
											<td height="25">
												入库时间：${vo.addtime }
											</td>
										</tr>
									</table>
								</td>
								<td valign="top" style="position: relative;">
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										class="fbc-box" id="packtable">
										<tr class="fbc-tit b">
											<td colspan="4">
												操作分包
											</td>
										</tr>
										<tr>
											<td height="50" colspan="4">
												待分包总重量（Kg）：
												<span id="totalkg" name="">${vo.medweight / 10000}</span>
											</td>
										</tr>
										<tr class="fbc-tit">
											<td>
												待分包重量（Kg）
											</td>
											<td>
												待分包规格（Kg/包）
											</td>
											<td>
												包数
											</td>
										</tr>
										<tr id="packTR_0">
											<td height="30">
												<input type="text" class="inp w60" name="medweight0"
													id="medweight0" maxlength="6" maxlength="6"
													onkeypress="onkeypressCheck(this);calcByMedWeight(this);"
													onkeyup="onkeyupCheck(this);calcByMedWeight(this)"
													onblur="calcByMedWeight(this);">
												<input type="hidden" name="medweightbak0" id="medweightbak0"
													value="0">
											</td>
											<td>
												<input type="text" class="inp w60" name="mednumweight0"
													id="mednumweight0" maxlength="6"
													onkeypress="onkeypressCheck(this);calcByMedNumWeight(this);"
													onkeyup="onkeyupCheck(this);calcByMedNumWeight(this)"
													onblur="calcByMedNumWeight(this);">
											</td>
											<td id="mednum0"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div class="fb-bom">
						<cite><input type="button" value="下一步" class="sbt"
								onclick="return checkForm();" id="next"> </cite>
					</div>
				</form>
			</div>
		</div>
		<script type="text/javascript" language="javascript"
			src="/js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
		<script language="javascript" type="text/javascript"
			src="/js/comtools.js"></script>
		<script language="javascript" type="text/javascript"
			src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
		<script type="text/javascript">
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
					if (obj.value.match(/^0\.000/)) {
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
			
/**
*根据待分包总量计算
*/
function calcByMedWeight(obj){
		//页面隐藏域存放待分包总重量,固定值用于判断每次分包重量
		var totalkgall = multiply($("#totalkgall").val(),1000);
		//待分包总重量
		var totalkg = multiply($("#totalkg").html(),1000);
		//计算已经使用的重量
		var useMedWeight_val;
		//当前的待分包重量
		var currtentMedWeight = $(obj).val();
		if(currtentMedWeight != ""){
			useMedWeight_val = multiply(currtentMedWeight,1000);
			if(subtr(totalkgall,useMedWeight_val) < 0 ){
				$(obj).val(currtentMedWeight.substr(0,currtentMedWeight.length-1));
				//$(obj).val("");
				return;
			}
		}
		
		var totalUseMedWeigth=0;
		$("tr[id^='packTR']").each(function(i){
				var idNum = $(this).attr("id").substr(7);
				var medweight_val = $("#medweight"+idNum).val();
				if(medweight_val != ""){
					totalUseMedWeigth += multiply(medweight_val,1000);
					if(subtr(totalkgall,totalUseMedWeigth) < 0){
						//$("#medweight"+idNum).val(medweight_val.substr(0,medweight_val.length-1));
						$("#medweight"+idNum).val("");
						return;
					}
				}else{
					$("#medweight"+idNum).val("");
					$("#mednum"+idNum).html("");
				}
				
				var mednumweight_val = $("#mednumweight"+idNum).val();
				if(subtr(medweight_val,mednumweight_val) < 0){
					// $("#mednumweight"+idNum).val(mednumweight_val.substr(0,mednumweight_val.length-1));
					 $("#mednumweight"+idNum).val("");
					 mednumweight_val = $("#mednumweight"+idNum).val();
				 }
				if(mednumweight_val != "" && mednumweight_val != "0" && mednumweight_val != "0."){
					var mednum = Math.ceil(division(multiply(medweight_val,1000), multiply(mednumweight_val,1000)));
					if(mednum > 10000){
						$("#mednum"+idNum).html("");
						return false;
					}
					$("#mednum"+idNum).html(mednum);
				}else{
					$("#mednum"+idNum).html("");
				}
		});
	}
	/**
	*根据规格输入后计算
	*/	
	function calcByMedNumWeight(obj){
		//1找到每一行的父tr元素的id
		var parentTr = $(obj).parents("tr").attr("id");
		//获取id的序号
		var idNum = parentTr.substr(7);
		var medWeightObj = document.getElementById("medweight"+idNum);
		calcByMedWeight(medWeightObj);
	}
	/**
	*表单提交验证
	*/
	function checkForm(){
	   		var packtable = document.getElementById("packtable");
	   		var packStr="";
	   		for(var i = 3 ; i < packtable.rows.length ; i++){
		   			var num = packtable.rows[i].id.substring(packtable.rows[i].id.length-1,packtable.rows[i].id.length);
					//alert("提交.."+num);
					var medweight = $("#medweight"+num).val();
					var mednumweight = $("#mednumweight"+num).val();
					var mednum = $("#mednum"+num).html();
					if(medweight != "" && mednumweight != "" && mednum != ""){
						packStr += multiply(medweight,10000)+"~"+ multiply(mednumweight,10000)+"~"+mednum+"~"+"|";
						$("#usetotal").val(multiply(medweight,10000));
					}else{
						$.dialog.tips("分包数据不正确,不予提交",1,'alert.gif');	
	   					return;
					}
	     	}
	     	//alert("提交.."+packStr);
	     	$("#packstr").val(packStr);
	   		if(packStr == ""){
	   			$.dialog.tips("未有分包数据,不予提交",1,'alert.gif');	
	   			return;
	   		}
	   		$("#next").attr("disabled","disabled");
	   		$.dialog({
					title:'正在进行分包',
					id:'pack',
					lock:true,
					content: '<div style="font-size:18px;color:red;padding:20px 50px">正在进行分包,请稍等...如果等待时间超过5分钟,请关闭重试.</div>',
					min:false,
					max:false,
					cancel:false
			});
	   		$("#searchform").submit();
		}
	  </script>
	</body>
</html>
