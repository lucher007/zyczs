<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!doctype html>
<html>
	<head>
	<meta charset="utf-8">
	<title>药材检验</title>
	<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：饮片生产管理 > 饮片包装</div>
		<div class="form-box">
	    	<form action="tabletStorage!updateTabletPack.shtml" name="searchform" id="searchform">
	    	<input type="hidden" name="tabletstorid" id="tabletstorid" value="${requestScope.tabletStorage.tabletstorid}" />
	    	<input type="hidden" name="totalkgall" id="totalkgall" value="${requestScope.tabletStorage.tablet.tabletweight/10000}" />
	    	<input type="hidden" name="packStr" id="packStr" value="" />
	    	<input type="hidden" name="usetotal" id="usetotal" value="" />
	    	
	    	<div class="fb-tit">饮片分包</div>
	        <div class="fb-con">
	        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10" >
	              <tr>
	                <td width="188" class="fbc-box" valign="top">
	                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	                      <tr class="fbc-tit b">
	                        <td>饮片信息</td>
	                      </tr>
	                      <tr>
	                        <td height="25">品名：${requestScope.tabletStorage.tablet.tabletname }</td>
	                      </tr>
	                      <tr>
	                        <td height="25" style="line-height:22px;">生产批次码：${requestScope.tabletStorage.tablet.cpctablet }</td>
	                      </tr>
	                      <tr>
	                        <td height="25">内部批次码：${requestScope.tabletStorage.tablet.tabletnumber }</td>
	                      </tr>
	                      <tr>
	                        <td height="25">生产规格：${requestScope.tabletStorage.tablet.tabletspec }</td>
	                      </tr>
	                      <tr>
	                        <td height="25">生产时间：${fn:substring(requestScope.tabletStorage.tablet.createtime, 0, 11)}</td>
	                      </tr>
	                    </table>
	                </td>
	                <td valign="top">
	                	<div id="bagbox" style="position:relative;">
		                	<div class="fl-r">
		                		<a href="#" onclick="return addData(1);" class="btn-add" title="添加规格">添加规格</a>
		                	</div>
		                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box" id="packtable">
		                      <tr class="fbc-tit b">
		                        <td colspan="6">操作分包</td>
		                      </tr>
		                      <tr>
		                        <td height="50" colspan="6">待分包总重量：<span id="totalkg">${requestScope.tabletStorage.tablet.tabletweight/10000}</span> Kg　　已使用重量：<span id="usetotalkg">0</span> Kg</td>
		                      </tr>
		                      <tr class="fbc-tit">
		                        <td>包装规格(g/包)</td>
		                        <td>包数(包)</td>
		                        <td>重量(g)</td>
		                        <td>每箱包数</td>
		                        <td>箱数(箱)</td>
		                        <td>操作</td>
		                      </tr>
		                      <tr id="packTR_0">
		                        <td height="30"><input type="text" class="inp w60" name="tabletnumweight0" id="tabletnumweight0" maxlength="7" onkeyup="onkeyupCheck(this);" ></td>
		                        <td><input type="text" class="inp w60" name="tabletnum0" id="tabletnum0" maxlength="7"  onkeyup="onkeyupNum(this);" onblur="onkeyupNum(this);">   
   
		                        </td>
		                        <td id="rowkg0"></td>
		                        <td><input type="text" class="inp w60" name="tabletboxnum0" id="tabletboxnum0" maxlength="7" onkeyup="onkeyupNum(this);"  onblur="onkeyupNum(this);"></td>
		                        <td id="rowbox0"></td>
		                        <td width="120"><a href="#" class="btn-del"  onclick='return removeRow(this.parentNode.parentNode,0)' >删除</a></td>
		                      </tr>                  
		                    </table>
	                    </div>
	                </td>
	              </tr>
	            </table>
	    	</div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="确 认" class="sbt" onclick="return  checkForm();"></cite>
	        </div>
	        </form>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
		if ($.browser.msie && ($.browser.version == "6.0") && !$.support.style) {
			$("#bagbox").height($("#packtable").height());
		}
		/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
		
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
				if(obj.value == 'undefined')
					obj.value='';
		}
		//
		function ValDecimal(obj) 
		{            
			if (!/^\d+(\d|(\.[1-9]{1}))$/.test(obj.value)) {                
				alert("只能输入一位小数!");           
		 	}        
		}
		
		//饮片包数判断
		function onkeyupNum(obj){
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
			//大于0
			if (obj.value<1) {
				obj.value = "";
			}
			//不能大于50000包
			if (obj.value>50000) {
				obj.value = obj.value.substring(0,obj.value.length-1);
			}			
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				obj.value=addtr(obj.value,0);
			}
		}
		
		//////////////////////////////////////////////////////////////////////
			

		var returnInfo="";
		var num=1;
		
		
		function addData(opType){
			returnInfo="";
			if(getLastRow()){
				return addRow(opType); 
			}else{
			
				if(!isNullIpu("tabletnumweight"+(num-1)))
				{
					returnInfo+="包装规格没有填写!\r\n";
				}
				if(!isNullIpu("tabletnum"+(num-1)))
				{
					returnInfo+="包数没有填写!\r\n";
				}
				if(!isNullIpu("tabletboxnum"+(num-1)))
				{
					returnInfo+="每箱包数没有填写!\r\n";
				}
			
				if(returnInfo!=""){
					alert(returnInfo);
					return false;
				}
			
				var totalkgall = multiply($("#totalkgall").val(),10000);
			
				var totalkgobj=$("#totalkg");							//总重量
				var usetotalkgobj=$("#usetotalkg");						//已使用总重量
				var rowkgobj=$("#rowkg"+(num-1));						//分包总重量
				var rowboxobj=$("#rowbox"+(num-1));						//箱数
				var tabletnumweightobj=$("#tabletnumweight"+(num-1));	//规格
				var tablenumobj = $("#tabletnum"+(num-1));				//包数
				var tabletboxnumobj= $("#tabletboxnum"+(num-1));		//每箱包数
			
				var totalkg=multiply($("#totalkg").html(),10000);
				var usetotalkg=multiply($("#usetotalkg").html(),10000);
			
				var rowkg=$("#rowkg"+(num-1)).html();
				var rowbox=$("#rowbox"+(num-1)).html();
			
				var tabletnumweight=multiply(parseFloat($("#tabletnumweight"+(num-1)).val()).toFixed(1),10);
				var tablenum = parseInt($("#tabletnum"+(num-1)).val());
				var tabletboxnum= parseInt($("#tabletboxnum"+(num-1)).val());
		
				if(tablenum>50000){
					alert("分包数不能大于5万包!");
					return false;
				}
				if(tabletboxnum>tablenum)
				{
					alert("每箱包数不能大于包数!");
					return false;
				}
				var rowkgvalue = multiply(tabletnumweight,tablenum); 	//分包总重量 的值
			
				if(rowkgvalue>totalkg){
					alert("当前分包总总量大于待分包总重量!");
					return false;
		  		}
		
				var tabletbox =  Math.ceil(division(tablenum,tabletboxnum));
				if(tabletbox<=0){
					alert("箱数计算出错,退出重试!");
					return false;
				}
		
				if(subtr(totalkg,rowkgvalue)<0){
					alert("总量计算出错,退出重试!");
					return false;
				}
		
				if(totalkgall!=addtr(subtr(totalkg,rowkgvalue),addtr(usetotalkg,rowkgvalue))){
					alert("待包装，已使用计算出错,退出重试!");
					return false;
				}
			
		
				rowkgobj.html(division(rowkgvalue,10));
				rowboxobj.html(tabletbox);
				totalkgobj.html(division(subtr(totalkg,rowkgvalue),10000));
				usetotalkgobj.html(division(addtr(usetotalkg,rowkgvalue),10000));
		
				tabletnumweightobj.val(division(tabletnumweight,10));
			
				if(returnInfo!=""){
					alert(returnInfo);
					return false;
				}
		
				tabletnumweightobj.attr("disabled","disabled");
				tablenumobj.attr("disabled","disabled");
				tabletboxnumobj.attr("disabled","disabled");
			
				if(opType == 1)
				{
					return addRow(opType);
				}else
				{
					return true;
				}
			}
			
		}
		
		
		
		function addRow(opType){
			if(getTrLength() == 8 && opType == 1){
				alert("分包次数最多为5次,继续点添加规格将无法新增分包输入框!");
				return;
			}
			if(opType != 0){
				var root = document.getElementById("packtable");
				var newRow = root.insertRow(-1);
				newRow.id="packTR_"+num;
				var newCell0 = newRow.insertCell(-1);	
				var newCell1 = newRow.insertCell(-1);
				var newCell2 = newRow.insertCell(-1);
				newCell2.id="rowkg"+num;
				newCell2.height="30";
				var newCell3 = newRow.insertCell(-1);
				var newCell4 = newRow.insertCell(-1);
				newCell4.id="rowbox"+num;
				var newCell5 = newRow.insertCell(-1);
				
				newCell0.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnumweight"+num+"\" id=\"tabletnumweight"+num+"\"  maxlength=\"10\"  \/>";
				newCell1.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnum"+num+"\" id=\"tabletnum"+num+"\"  maxlength=\"7\" onkeyup=\"onkeyupNum(this);\"  onblur=\"onkeyupNum(this);\" \/>";
				newCell2.innerHTML = "";
				newCell3.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletboxnum"+num+"\" id=\"tabletboxnum"+num+"\"  maxlength=\"7\"  onkeyup=\"onkeyupNum(this);\"  onblur=\"onkeyupNum(this);\" \/>";
				newCell4.innerHTML = "";	
				newCell5.width="120";
				newCell5.innerHTML = "<a href=\"#\" class=\"btn-del\" onclick='return removeRow(this.parentNode.parentNode,"+num+")' >删除</a> ";
						
				num++;
				resetH();
			}
		    return true;
		}
		
		function getLastRow(){
			var id = $("#packtable tr:last").attr("id").substr($("#packtable tr:last").attr("id").length-1);
			var ret = document.getElementById("tabletnumweight"+id).disabled;
			return ret;
		}
		
		function getTrLength(){
			return  $("#packtable tr").length;
		}
		
		function removeRow(r,num){
			var root = r.parentNode;
		   	var allRows = root.getElementsByTagName('tr')
		   	if(allRows.length!=4){
		   		if(document.getElementById("tabletnumweight"+num).disabled==true)
				{
					if(!delUsetotalkg(num)){
		   	   			return false;
		   			}
				}		         	
		       	root.removeChild(r);   
		   	}else{
		       alert("已经是最后一行,不允许删除！");
		   	}
		   	resetH();
		}
		
		function delUsetotalkg(num){
			var totalkgall = multiply($("#totalkgall").val(),10000);
			
			var totalkgobj=$("#totalkg");							//总重量
			var usetotalkgobj=$("#usetotalkg");						//已使用总重量
			
			var totalkg=multiply($("#totalkg").html(),10000);
			var usetotalkg=multiply($("#usetotalkg").html(),10000);
				
			var rowkgvalue=multiply(parseFloat($("#rowkg"+(num)).html()).toFixed(1),10);		//分包总重量
			
			var value1 = addtr(totalkg,rowkgvalue);
			var value2 = subtr(usetotalkg,rowkgvalue);
		
			if(totalkgall!=addtr(value1,value2)){
				alert("待包装，已使用计算出错,退出重试!");
				return false;
			}
			totalkgobj.html(division(value1,10000));
			usetotalkgobj.html(division(value2,10000));
			if(value2==0){
				usetotalkgobj.html("0");
			}
			return true;
		}
		
		
		function checkForm(){
		   	if(addData(0))
		   	{
		   		var packtable= document.getElementById("packtable"); 		
		   		var packStr="";
		   		for(var i = 3;i<packtable.rows.length;i++){
		   			
		   			var num=packtable.rows[i].id.substring(packtable.rows[i].id.length-1,packtable.rows[i].id.length);
		   			var tabletnumweight=multiply($("#tabletnumweight"+num).val(),10);//规格
		   			var tabletnum=$("#tabletnum"+num).val();//包数
		   			var tabletweight=multiply($("#rowkg"+num).text(),10);//重量
		   			var tabletboxitemnum=$("#tabletboxnum"+num).val();//每箱包数
		   			var tabletboxnum= $("#rowbox"+num).text();         //箱数		
					packStr+=tabletnumweight+"~"+tabletnum+"~"+tabletweight+"~"+tabletboxitemnum+"~"+tabletboxnum+"|";
		     	}
		   		//alert(packStr);
		   		$("#packStr").val(packStr);  		
		   		$("#usetotal").val(multiply($("#usetotalkg").text(),10000));
		   		
		   		if(confirm("确认要提交吗?"))
				{
					$("#searchform").submit();
				}
		   				
		   	}
		   	
		   	
		
		}
	</script>
	</body>
</html>
