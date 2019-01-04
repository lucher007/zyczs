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

	<body oncontextmenu='return false'    oncopy='document.selection.empty()'  onbeforecopy="return false" onpaste="return false;" oncut="return false;" >
	<div id="body">
		<div class="cur-pos">当前位置：饮片生产管理 > 饮片包装</div>
		<div class="form-box">
	    	<form action="tabletStorage!updateTabletPack.shtml" name="searchform" id="searchform">
	    	<input type="hidden" name="tabletstorid" id="tabletstorid" value="${requestScope.tabletStorage.tabletstorid}" />
	    	<input type="hidden" name="totalkgall" id="totalkgall" value="${requestScope.tabletStorage.tabletweight/10000}" />
	    	<input type="hidden" name="packStr" id="packStr" value="" />
	    	<input type="hidden" name="usetotal" id="usetotal" value="" />
	    	
	    	<div class="fb-tit">饮片分包
	    	<span style="color:red">
						注:每种批次饮片每次分包规格最多为2种,每种规格分包数最小200包、最多10000包、且每箱包数最少200包
					</span>
	    	</div>
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
		                		<a href="#" onclick="return addRow();" class="btn-add" id="addnumweight" title="添加规格">添加规格</a>
		                	</div>
		                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box" id="packtable">
		                      <tr class="fbc-tit b">
		                        <td colspan="6">操作分包</td>
		                      </tr>
		                      <tr>
		                        <td height="50" colspan="6">待分包总重量：<span id="totalkg">${requestScope.tabletStorage.tabletweight/10000}</span> Kg　　已使用重量：<span id="usetotalkg">0</span> Kg</td>
		                      </tr>
		                      <tr class="fbc-tit">
		                        <td>包装规格(g/包)</td>
		                        <td>包数(包)</td>
		                        <td>重量(g)</td>
		                        <td>每箱包数</td>
		                        <td>箱数(箱)</td>
		                        <td width="120">操作</td>
		                      </tr>
		                      <tr id="packTR_0">
		                        <td height="30">
		                        <input type="text" class="inp w60" name="tabletnumweight0" id="tabletnumweight0" maxlength="6" onkeyup="onkeypressCheck(this);calcTotal(this);" onkeypress="onkeypressCheck(this);calcTotal(this);" >
		                        </td>
		                        <td>
		                        <input type="text" class="inp w60" name="tabletnum0" id="tabletnum0" maxlength="6"  onkeyup="onkeyupNum(this);calcTotal(this);" onblur="onkeyupNum(this);" onkeypress="onkeyupNum(this);calcTotal(this);" >   
   
		                        </td>
		                        <td id="rowkg0"></td>
		                        <td><input type="text" class="inp w60" name="tabletboxnum0" id="tabletboxnum0" maxlength="6" onkeyup="onkeyupNum2(this);" onkeypress="onkeyupNum4(this);"  ></td>
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
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
		if ($.browser.msie && ($.browser.version == "6.0") && !$.support.style) {
			$("#bagbox").height($("#packtable").height());
		}
		/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
		
		//保留1位小数
		function onkeypressCheck(obj){
				if (!obj.value.match(/^[0-9]?\d*?\.?\d*?$/)) {
					obj.value = obj.t_value;
				} else {
					obj.t_value = obj.value;
				}
				if (obj.value.match(/^(?:[0-9]?\d+(?:\.\d+)?)?$/)) {
					obj.o_value = obj.value;
				}
				if (obj.value.match(/^00/)) {
					obj.value = obj.value.substr(0,obj.value.length-1);
				}
				if (obj.value.match(/^0\.0/)) {
					obj.value = obj.value.substr(0,obj.value.length-1);
				}
				if (obj.value.match(/^0[0-9]/)) {
					obj.value = obj.value.substr(0,obj.value.length-1);
				}
				if(obj.value.match(/^\d+\.\d{2}?$/)){
					obj.value = obj.value.substr(0,obj.value.length-1);
				} 
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
			if (obj.value>10000) {
				obj.value = obj.value.substring(0,obj.value.length-1);
			}			
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				obj.value=addtr(obj.value,0);
			}
		}
		//每箱包数判断
		function onkeyupNum2(obj){
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
			//大于200
			if (obj.value<200&&obj.value.length>=3) {
				
				obj.value = "";
			}
			
			/*
			//不能大于50000包
			if (obj.value>10000) {
				obj.value = obj.value.substring(0,obj.value.length-1);
			}	
			*/		
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				obj.value=addtr(obj.value,0);
			}
		}
		
		function onkeyupNum4(obj){
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
			//大于0
			if(obj.value<1&&obj.value.length==1) {
				obj.value = "";
			}
			
			//大于200
			//if (obj.value<200&&obj.value.length<=3) {
			//	obj.value = "";
			//}
			
			/*
			//不能大于50000包
			if (obj.value>10000) {
				obj.value = obj.value.substring(0,obj.value.length-1);
			}	
			*/		
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
		
		
		
		//箱数计算
		function calcBox(obj)
		{
			var currtNum=obj.id.substr(obj.id.length-1);
			var tabletnum=$("#tabletnum"+currtNum).val();         //包数						
			if($(obj).val()!=""&&tabletnum!="")
			{
				if(subtr(tabletnum,$(obj).val())<0)
				{
					$(obj).val($(obj).val().substr(0,$(obj).val().length-1));
				}
				if($(obj).val()!="")
				{
					var currtRowbox = Math.ceil(division(tabletnum,$(obj).val()));			
					$("#rowbox"+currtNum).html(currtRowbox);
				}else{
					$("#rowbox"+currtNum).text("");
				}								
			}else{
				$(obj).val("");
				$("#rowbox"+currtNum).text("");
			}		
		}
		
		//使用规格重量计算
		function calcTotal(obj){
			var totalkg = multiply($("#totalkg").html(),10000);//待分包总重量
			
			var currtNum=obj.id.substr(obj.id.length-1);
			
			//规格控制
			var currtTotal_val;//当前输入总重量		
			var currtTabletnumweight = $("#tabletnumweight"+currtNum).val() //规格
			var currtTabletnum=$("#tabletnum"+currtNum).val();//包数
				
			//判断当前规格是否超过待分包总重量
			if(currtTabletnumweight != ""){
				currtTotal_val = multiply(currtTabletnumweight,10);			
				if(subtr(totalkg,currtTotal_val) < 0 ){
					$(obj).val(obj.value.substr(0,obj.value.length-1));
					//$.dialog.alert("当前包装规格大于待分包总量!");
				}
			}
			
			//判断当前规格乘以包数是否超过待分包总重量 	
			if(currtTabletnumweight != ""&&currtTabletnum!=""){
				var currtWeight_val = multiply(currtTabletnumweight,10);					
				currtTotal_val=	multiply(currtWeight_val,currtTabletnum);//规格X 包数
				if(subtr(totalkg,currtTotal_val) < 0 ){
					$(obj).val(obj.value.substr(0,obj.value.length-1));
					//$.dialog.alert("当前规格乘以包数大于待分包总量!");				
				}		
			}
			
			//从新计算
			calcTables();
		
		}
		
		//使用规格重量计算
		function calcNum(obj){
			var totalkg = multiply($("#totalkg").html(),10000);//待分包总重量			
			var currtNum=obj.id.substr(obj.id.length-1);
								
			//判断当前规格乘以包数是否超过待分包总重量 	
			if(currtTabletnumweight != ""&&currtTabletnum!=""){
				var currtWeight_val = multiply(currtTabletnumweight,10);					
				currtTotal_val=	multiply(currtWeight_val,currtTabletnum);//规格X 包数
				if(subtr(totalkg,currtTotal_val) < 0 ){
					$(obj).val(obj.value.substr(0,obj.value.length-1));
					//$.dialog.alert("当前规格乘以包数大于待分包总量!");				
				}		
			}
			
			//从新计算
			calcTables();
		
		}
		
				
		function calcTables()
		{
			//找到每一行的父tr元素的id
			var totalUseWeigth=0;
			var totalWeight;       //当前输入总重量		
			var tabletnumweight;    //规格
			var tabletnum;         //包数
			var tabletboxnum;      // 每箱包数
			var rowbox;           //箱数(箱)
			
			$("tr[id^='packTR']").each(function(i){
					var idNum = $(this).attr("id").substr(7);
					
					tabletnumweight = $("#tabletnumweight"+idNum).val();//规格
					tabletnum=$("#tabletnum"+idNum).val();              //包数
					tabletboxnum=$("#tabletboxnum"+idNum).val();        //每箱包数
					rowbox=$("#rowbox"+idNum).text();             //箱数(箱)
					
					if(tabletnumweight != ""&&tabletnum!=""){
						var rowWeight = multiply(tabletnumweight,10);	//当前规格		
						totalWeight=multiply(rowWeight,tabletnum);//规格X 包数
						totalUseWeigth=addtr(totalUseWeigth,totalWeight) //每行规格总重量累加
						$("#rowkg"+idNum).text(division(totalWeight,10));	
						//计算箱数
						if(tabletboxnum!=""&&subtr(tabletnum,tabletboxnum)>=0)
						{
							var currtRowbox = Math.ceil(division(tabletnum,tabletboxnum));
							$("#rowbox"+idNum).text(currtRowbox);
						}else{
							$("#rowbox"+idNum).text("");
							$("#tabletboxnum"+idNum).val("");						
						}
									
					}else{
						$("#rowkg"+idNum).text("");
						$("#tabletboxnum"+idNum).val("");
					}										
			});
			
			
			 var totalkgall=multiply($("#totalkgall").val(),10000)
			$("#totalkg").html(division(subtr(totalkgall,totalUseWeigth),10000));
			$("#usetotalkg").html(division(totalUseWeigth,10000));
			
			if($("#totalkg").html() == 0){
				$("#addnumweight").hide("1000");
			}else{
				$("#addnumweight").show("1000");
			}
		}
		
		function removeRow(r,num){
			var root = r.parentNode;		   	         	
		    root.removeChild(r);   
			calcTables();
		   	resetH();
		}
		
		
		function addRow(){
			if(getTrLength() == 5){
				alert("分包次数最多为2次,继续点添加规格将无法新增分包输入框!");
				return;
			}
			
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
			
			newCell0.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnumweight"+num+"\" id=\"tabletnumweight"+num+"\"  maxlength=\"10\" onkeyup=\"onkeypressCheck(this);calcTotal(this);\" onkeypress=\"onkeypressCheck(this);calcTotal(this);\" \/>";
			newCell1.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnum"+num+"\" id=\"tabletnum"+num+"\"  maxlength=\"7\" onkeyup=\"onkeyupNum(this);calcTotal(this);\"  onblur=\"onkeyupNum(this);\" \/>";
			newCell2.innerHTML = "";
			newCell3.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletboxnum"+num+"\" id=\"tabletboxnum"+num+"\"  maxlength=\"7\"  onkeyup=\"onkeyupNum(this);calcBox(this);\"  onblur=\"onkeyupNum(this);calcBox(this);\" \/>";
			newCell4.innerHTML = "";	
			newCell5.width="120";
			newCell5.innerHTML = "<a href=\"#\" class=\"btn-del\" onclick='return removeRow(this.parentNode.parentNode,"+num+")' >删除</a> ";
					
			num++;
			resetH();

		    return true;
		}
			
		
		function getTrLength(){
			return  $("#packtable tr").length;
		}
		
			
		
		function checkForm(){
			var flag=true;
			$("input[type='text']").each(function(){
  				var currentVal = $(this).val();
  				if($.trim(currentVal) == "" ){
					flag=false;
  				}
			});
			
			if(flag!=true)
			{
				$.dialog.alert("分包信息未填写完整!");
				return;
			}
					   	
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
	     	
	     	if(packStr=="")
			{
				$.dialog.alert("为进行分包操作!");
				return;
			}
	   		//alert(packStr);
	   		$("#packStr").val(packStr);  		
	   		$("#usetotal").val(multiply($("#usetotalkg").text(),10000));
	   		
	   		$.dialog.confirm('确认要提交吗？', function(){
    			//$.dialog.tips('执行确定操作');
    			$("#searchform").submit();
			}, function(){
    			//$.dialog.tips('执行取消操作');
			});
	   			   		
		}
	</script>
	</body>
</html>
