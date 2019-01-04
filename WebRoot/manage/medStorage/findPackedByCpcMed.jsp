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
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
		<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>

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
			}
			
			function onkeyblurCheck(obj){
				if(obj.value.match(/^0/))
						obj.value='';
				if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
					obj.value = obj.o_value;
				}else {
					if (obj.value.match(/^\.\d+$/)) {
						obj.value = 0 + obj.value;
					}
					if(!obj.value.match(/^\d+(\.\d{1})?$/)){
							obj.value = "";
					}
					//obj.o_value = obj.value;
				}
			}
			//////////////////////////////////////////////////////////////////////
			
var returnInfo="";
var num=1;

function initPack()
{
	addRow(-1,-1,-1);
}

function addData(optType){
	if(getLastRow()){
		return addRow(optType); 
	}else{
			
			returnInfo="";
			
			
			if(!isNullIpu("medweight"+(num-1)))
			{
				returnInfo+="待分包重量没有填写!\r\n";
			}
			if(!isNullIpu("mednumweight"+(num-1)))
			{
				returnInfo+="待分包规格没有填写!\r\n";
			}
					
			if(returnInfo != ""){
				alert(returnInfo);
				return;
			}
			
			var totalkgall = multiply($("#totalkgall").val(),1000);
			
			var totalkgobj = $("#totalkg");							//总重量
			var usetotalkgobj = $("#usetotalkg");						//已使用总重量
			var medweightobj = $("#medweight"+(num-1));		//待分包重量
			var mednumweightobj = $("#mednumweight"+(num-1));	//规格
			var mednumobj = $("#mednum"+(num-1));  //包数
			
			var totalkg = multiply($("#totalkg").html(),1000);
			var usetotalkg = multiply($("#usetotalkg").html(),1000);
			
			var medweight = multiply(parseFloat($("#medweight"+(num-1)).val()).toFixed(1),1000);
			var mednumweight = multiply(parseFloat($("#mednumweight"+(num-1)).val()).toFixed(1),1000);
			var mednum = division(medweight,mednumweight);
		
			if(mednum > 50000){
				returnInfo+="分包数不能大于5万包!";
				alert(returnInfo);
				return;
			}
			
			if(medweight > totalkg){
			  	returnInfo+="内容大于总重量!";
			  	alert(returnInfo);
				return;
		  	}
		  	
		  	if(mednumweight > medweight){
			  	returnInfo+="待分包规格不能大于待分包重量!";
			  	alert(returnInfo);
				return;
		  	}
		
			
		  	
			mednumobj.html(mednum);
			totalkgobj.html(division(subtr(totalkg,medweight),1000));
			usetotalkgobj.html(division(addtr(usetotalkg,medweight),1000));
			
			medweightobj.attr("disabled","disabled");
			mednumweightobj.attr("disabled","disabled");
		
			/**
			*如果待分包总重量==0,则不允许继续添加规格
			*/
			if(totalkgobj.text()==0){
				$("#addnumweight").attr("disabled","disabled");
				return;
			}
			//包装规格---包数---每箱包数
			//添加新的规格--加一行
			if(optType == 1)//
			{
				return addRow(optType);
			}else
			{
				return true;
			}
		}
}



function addRow(optType){
	//alert(multiply(mednumweight,tabletnum));
		if(optType != 0){
			var root = document.getElementById("packtable")
			var newRow = root.insertRow(-1);
			newRow.id="packTR_"+num;
			var newCell0 = newRow.insertCell(-1);	
			var newCell1 = newRow.insertCell(-1);
			var newCell2 = newRow.insertCell(-1);
		    newCell2.id="mednum"+num;
		    newCell2.height="30";
			var newCell3 = newRow.insertCell(-1);
			
			newCell0.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"medweight"+num+"\" id=\"medweight"+num+"\"  maxlength=\"6\"  onkeypress='onkeypressCheck(this);' onkeyup='onkeyupCheck(this);' onblur='onkeyblurCheck(this)'  \/>";
			newCell1.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"mednumweight"+num+"\" id=\"mednumweight"+num+"\"  maxlength=\"6\"  onkeypress='onkeypressCheck(this);' onkeyup='onkeyupCheck(this);' onblur='onkeyblurCheck(this)' \/>";
			newCell2.innerHTML = "";
			newCell3.width="120";
			newCell3.innerHTML = "<a href=\"#\" class=\"btn-del\" onclick='return removeRow(this.parentNode.parentNode,"+num+")' >删除</a> ";
					
			num++;
		}
	
	//已使用总重量 计算	
	//addUsetotalkg(packall);
	//alert(multiply(parseInt(mednumweight,parseInt(tabletnum)));
	 return true;
    
}



function removeRow(r,num){
	var root = r.parentNode;
   	var allRows = root.getElementsByTagName('tr');
   	if(allRows.length!=4){
   		var obj = $("#medweight"+num);
   		
   		if(obj.attr("disabled")=="disabled"){
		   		if(!delUsetotalkg(num)){
		   	   		return false;
		   		}         	
	      }
	       	$("#addnumweight").removeAttr("disabled");
		    root.removeChild(r);
   	}else{
       alert("已经是最后一行,不允许删除！");
   	}
}

function delUsetotalkg(num){
	var totalkgall = multiply($("#totalkgall").val(),1000);
	
	var totalkgobj=$("#totalkg");							//总重量
	var usetotalkgobj=$("#usetotalkg");						//已使用总重量
	
	var totalkg=multiply($("#totalkg").html(),1000);
	var usetotalkg=multiply($("#usetotalkg").html(),1000);
	
	
	
	
	var medweightvalue=multiply(parseFloat($("#medweight"+(num)).val()).toFixed(1),1000);		//分包总重量

	
	var value1 = addtr(totalkg,medweightvalue);
	var value2 = subtr(usetotalkg,medweightvalue);

	totalkgobj.html(division(value1,1000));
	usetotalkgobj.html(division(value2,1000));
	if(value2==0){
		usetotalkgobj.html("0");
	}
	return true;
}
	
function getLastRow(){
	var id = $("#packtable tr:last").attr("id").substr($("#packtable tr:last").attr("id").length-1);
	var ret = document.getElementById("medweight"+id).disabled;
	//var inputObj = $("#medweigth"+id);
	//alert(ret);
	return ret;
}

function checkForm(){
	   	if(addData(0)){
	   		var packtable = document.getElementById("packtable");
	   		var packStr="";
	   		for(var i = 3 ; i < packtable.rows.length ; i++){
		   			var num = packtable.rows[i].id.substring(packtable.rows[i].id.length-1,packtable.rows[i].id.length);
					packStr += multiply($("#medweight"+num).val(),10000)+"~"+ multiply($("#mednumweight"+num).val(),10000)+"~"+$("#mednum"+num).html()+"~"+"|";
	     	}
			     	$("#packstr").val(packStr);
			   		$("#usetotal").val(multiply($("#usetotalkg").text(),10000));
			   		$("#searchform").submit();
	   		}
}
</script>

	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：库存销售 > 药材拆包
			</div>
			<div class="form-box">
				<form action="<%=basePath %>medStorage!updateMedPacked.shtml" method="post" name="searchform" id="searchform">
				<input type="hidden" name="totalkgall" id="totalkgall" value="${vo.medweight / 10000}" />
				<input type="hidden" name="packstr" id="packstr"/>
				<input type="hidden" name="cpcmed" id="cpcmed" value="${vo.cpcmed }"/>
				<input type="hidden" name="medstorid" id="medstorid" value="${vo.medstorid }"/>
				<input type="hidden" name="usetotal" id="usetotal"/>
					<div class="fb-tit">
						药材分包
					</div>
					<div class="fb-con">
						<table width="726" border="0" cellspacing="0" cellpadding="0"
							class="ml10">
							<tr>
								<td width="188" class="fbc-box" valign="top">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" >
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
									<div class="fl-r">
										<a href="javascript:void(0)" onclick="addData(1);" class="btn-add" title="添加规格" id="addnumweight">添加规格</a>
									</div>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										class="fbc-box"  id="packtable">
										<tr class="fbc-tit b">
											<td colspan="4">
												操作分包
											</td>
										</tr>
										<tr>
											<td height="50" colspan="4">
												待分包总重量：
												<span id="totalkg" name="">${vo.medweight / 10000}</span> Kg 已使用重量：
												<span id="usetotalkg">0</span> Kg
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
											<td>
												操作
											</td>
										</tr>
										<tr id="packTR_0">
					                        <td height="30">
					                       		 <input type="text" class="inp w60" name="medweight0" id="medweight0" 
					                       			maxlength="6"
					                       		    onkeypress="onkeypressCheck(this);"
													onkeyup="onkeyupCheck(this);"
													onblur="onkeyblurCheck(this)" >
					                        </td>
					                        <td>
					                       		 <input type="text" class="inp w60" name="mednumweight0" id="mednumweight0"
					                       			maxlength="6"
					                       		    onkeypress="onkeypressCheck(this);"
													onkeyup="onkeyupCheck(this);"
													onblur="onkeyblurCheck(this)">
					                       	</td>
					                       	<td id="mednum0"></td>
					                        <td width="120"><a href="javascript:void(0);" class="btn-del"  onclick='removeRow(this.parentNode.parentNode,0)' >删除</a></td>
					                  </tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div class="fb-bom">
						<cite><input type="button" value="下一步" class="sbt" onclick="return checkForm();">
						</cite>
					</div>
				</form>
			</div>
		</div>
		<script type="text/javascript" language="javascript"
			src="/js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
		<script type="text/javascript">

</script>
	</body>
</html>
