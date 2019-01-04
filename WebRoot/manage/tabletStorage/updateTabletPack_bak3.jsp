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
		                        <input type="text" class="inp w60" name="tabletnumweight0" readonly="readonly" id="tabletnumweight0" maxlength="6" onclick="return inProSpec(this);"  >
		                        </td>
		                        <td>
		                        <input type="text" class="inp w60" name="tabletnum0" id="tabletnum0" readonly="readonly" maxlength="6"  onclick="return inProNum(this);"    >   
   
		                        </td>
		                        <td id="rowkg0"></td>
		                        <td><input type="text" class="inp w60" name="tabletboxnum0" id="tabletboxnum0" readonly="readonly" maxlength="6" onclick="return inBoxNum(this);"   ></td>
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
		
function showKeys(obj,point,maxLen,minVal,maxVal,func)
{
   	var dis="display:block";
   	if(point<=0){
   		dis="display:none";
   	}

   	var str = '<table id="monitable"><tr><td colspan="4" align="center"><input type="hidden" id="func" value="'+func+'"><input type="hidden" id="point" value="'+point+'" ><input type="hidden" id="maxLen" value="'+maxLen+'" ><input type="hidden" id="minVal" value="'+minVal+'" ><input type="hidden" id="maxVal" value="'+maxVal+'" ><input type="text" value="'+$(obj).val()+'" style="padding:10px;text-align:right;" readonly></td></tr><tr><td align="center" height="40"><input type="button" value="1"></td><td align="center"><input type="button" value="2"></td><td align="center"><input type="button" value="3"></td><td align="center"><input type="button" value="4"></td></tr><tr><td align="center" height="40"><input type="button" value="5"></td><td align="center"><input type="button" value="6"></td><td align="center"><input type="button" value="7"></td><td align="center"><input type="button" value="8"></td></tr><tr><td align="center" height="40"><input type="button" value="9"></td><td align="center"><input type="button" value="0"></td><td align="center" ><input type="button" style="'+dis+'" value="."></td><td align="center"><input type="button" value="←"></td></tr></table><div><b id="errorInfo" style="color:red;"></b></div>';
	
	$.dialog({
	title:'编辑键位值',
	id:'moni',
	lock:true,
	content:str,
	max:false,
    resize: false,
	okVal:'确定',
	ok:function(){
		var val=$("#monitable input[type=text]").val();
		if(val!="")
		{
			if(parseFloat(val)<parseFloat(minVal))
			{
				$("#errorInfo").text("不能小于"+minVal);
				return false;
			}
			//规格
			if(func==1)
			{
				var errorInfo=calcTotal(obj,val,1);
				if(errorInfo!="")
				{
					$("#errorInfo").text(errorInfo);
					return false;
				}else{
					$(obj).val(parseFloat(val));
					//从新计算
					calcTables();
				}
			//包数	
			}else if(func==2)
			{
				
				var errorInfo=calcTotal(obj,val,2);
				if(errorInfo!="")
				{
					$("#errorInfo").text(errorInfo);
					return false;
				}else{
					$(obj).val(parseFloat(val));
					//从新计算
					calcTables();
				}
			//每箱包数
			}else if(func==3)
			{
				$(obj).val(parseFloat(val));
				calcBox(obj,val);
			}
			
		}else{
			$(obj).val("");
			
			if(func==3)
			{
				calcBox(obj,val);
			}else 
			{
				//从新计算
				calcTables();
			}
		}
			
	},
	cancelVal:'取消',
	cancel:true
	});
	$("#monitable input[type=button]").height(38).width(38)
}
        
$("#monitable input[type=button]").live('click',function(){
	var val=$("#monitable input[type=text]").val();
	$("#errorInfo").text("");
	var point=$("#point").val();//小数位数
	var maxLen=$("#maxLen").val();//最大长度
	var minVal=$("#minVal").val();//最小值
	var maxVal=$("#maxVal").val();//最大值
	var func=$("#func").val();//
	if($(this).val()+""=="←"){
		$("#monitable input[type=text]").val(val.substring(0,val.length-1));
		
	}else{
		if(val.length==maxLen)
		{
			currVal="";
			$("#errorInfo").text("长度不能超过"+maxLen+"位数");	
			return;				
		}
		var currVal=$(this).val();
		//正整数
		if(point==0)
		{
			//第一次输入不能为0
			if(val==""&&currVal==0)
			{	
				currVal="";		
			}				
		}//小数位数控制
		else if(point>0)
		{
			//第一次不能直接输入小数点
			if(val==""&&currVal==".")
			{
				currVal="";		
			}//已存在小数点
			if(val.indexOf(".")!=-1&&currVal==".")
			{
				currVal="";
			}//小数位数控制
			if(val!=""&&val.indexOf(".")!=-1)
			{
				if(val.substr(val.indexOf(".")+1).length>=point)
				{
					currVal="";
					$("#errorInfo").text("小数保留"+point+"位");
				}
			}//去掉整数前面的0
			if(val!=""&&val.length==1&&val==0&&currVal!=".")
			{
				val="";
			}
		}
		//最大值控制
		if(func==1)//规格
		{
			var speVal=multiply(currVal,10);
			//alert(parseFloat(val+speVal));
			if(parseFloat(val+speVal)>parseFloat(maxVal))
			{
				currVal="";	
				$("#errorInfo").text("规格不能大于待分包总重量");
			}		
			
		}else if(func==2)//包数
		{
			if(parseFloat(val+currVal)>parseFloat(maxVal))
			{
				currVal="";	
				$("#errorInfo").text("包数不能大于"+maxVal);
			}
		}else if(func==3)//每箱包数
		{
			if(parseFloat(val+currVal)>parseFloat(maxVal))
			{
				currVal="";	
				$("#errorInfo").text("每箱包数不能大于总包数");
			}
		}		
		
		$("#monitable input[type=text]").focus().val(val+currVal);	
	}
});
		
		function ValDecimal(obj) 
		{            
			if (!/^\d+(\d|(\.[1-9]{1}))$/.test(obj.value)) {                
				alert("只能输入一位小数!");           
		 	}        
		}
		
		//规格
		function inProSpec(obj)
		{
			var totalkg =getUnUseTotal(obj);		
			//alert(totalkg);
			showKeys(obj,1,6,0.1,totalkg,1);

		}
		//包数
		function inProNum(obj)
		{		
			showKeys(obj,0,6,200,10000,2);
		}
		//每箱包数
		function inBoxNum(obj)
		{
			var currtNum=obj.id.substr(obj.id.length-1);
			var tabletnum=$("#tabletnum"+currtNum).val(); //包数					
			showKeys(obj,0,6,1,tabletnum,3);
		}	

		var returnInfo="";
		var num=1;
		
		
		
		//箱数计算
		function calcBox(obj,currtVal)
		{
			var currtNum=obj.id.substr(obj.id.length-1);
			var tabletnum=$("#tabletnum"+currtNum).val(); //包数								
			if(currtVal!=""&&tabletnum!="")
			{
				var currtRowbox = Math.ceil(division(tabletnum,currtVal));			
				$("#rowbox"+currtNum).html(currtRowbox);			
			}else{		
				$("#rowbox"+currtNum).text("");
			}		
		}
		
		//使用规格重量计算
		function calcTotal(obj,currtVal,otype){
			var errorInfo="";
			//var totalkg = multiply($("#totalkg").html(),10000);//待分包总重量
			var totalkg = getUnUseTotal(obj);
			var currtNum=obj.id.substr(obj.id.length-1);
			
			//规格控制
			var currtTotal_val;//当前输入总重量				
			var currtTabletnumweight;//规格
			var currtTabletnum;//包数
			
			if(otype==1)//规格调用
			{
				currtTabletnumweight= currtVal; //规格
				currtTabletnum=$("#tabletnum"+currtNum).val();//包数
			}else{//包数调用
				currtTabletnumweight=$("#tabletnumweight"+currtNum).val();
				currtTabletnum=currtVal;//包数
			}	
			
			
			//判断当前规格是否超过待分包总重量
			if(currtTabletnumweight != ""){
				currtTotal_val = multiply(currtTabletnumweight,10);			
				if(subtr(totalkg,currtTotal_val) < 0 ){
					return errorInfo="当前包装规格大于待分包总量";
				}
			}
			
			//判断当前规格乘以包数是否超过待分包总重量 	
			if(currtTabletnumweight != ""&&currtTabletnum!=""){
				var currtWeight_val = multiply(currtTabletnumweight,10);					
				currtTotal_val=	multiply(currtWeight_val,currtTabletnum);//规格X 包数
				if(subtr(totalkg,currtTotal_val) < 0 ){
					return errorInfo="当前规格乘以包数大于待分包总量";			
				}		
			}	
			return errorInfo;
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
		
		function getUnUseTotal(obj)
		{
			var currtNum=obj.id.substr(obj.id.length-1);
			
			//找到每一行的父tr元素的id
			var totalUseWeigth=0;
			var totalWeight;       //当前输入总重量		
			var tabletnumweight;    //规格
			var tabletnum;         //包数
			var tabletboxnum;      // 每箱包数
			var rowbox;           //箱数(箱)
			
			$("tr[id^='packTR']").each(function(i){
					var idNum = $(this).attr("id").substr(7);
					
					if(currtNum!=idNum)
					{
						tabletnumweight = $("#tabletnumweight"+idNum).val();//规格
						tabletnum=$("#tabletnum"+idNum).val();              //包数
						tabletboxnum=$("#tabletboxnum"+idNum).val();        //每箱包数
						rowbox=$("#rowbox"+idNum).text();             //箱数(箱)
					
						if(tabletnumweight != ""&&tabletnum!=""){
							var rowWeight = multiply(tabletnumweight,10);	//当前规格		
							totalWeight=multiply(rowWeight,tabletnum);//规格X 包数
							totalUseWeigth=addtr(totalUseWeigth,totalWeight) //每行规格总重量累加										
						}	
					}									
			});
			
			var totalkgall=multiply($("#totalkgall").val(),10000);			
			totalUseWeigth=subtr(totalkgall,totalUseWeigth);
			
			return totalUseWeigth;
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
			
			newCell0.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnumweight"+num+"\" id=\"tabletnumweight"+num+"\"  maxlength=\"6\" readonly=\"readonly\" onclick=\"inProSpec(this);\" \/>";
			newCell1.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletnum"+num+"\" id=\"tabletnum"+num+"\"  maxlength=\"6\" readonly=\"readonly\" onclick=\"inProNum(this);\" \/>";
			newCell2.innerHTML = "";
			newCell3.innerHTML = "<input class=\"inp w60\" type=\"text\" name=\"tabletboxnum"+num+"\" id=\"tabletboxnum"+num+"\"  maxlength=\"6\" readonly=\"readonly\"  onclick=\"inBoxNum(this);\" \/>";
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
    			$("#searchform").submit();
    			//showFirm();
			}, function(){

			});
	   			   		
		}
		/*
		function showFirm()
		{
			$.dialog({
					title:'正在进行分包',
					id:'pack2',
					lock:true,
					content: '<div style="font-size:18px;color:red;padding:20px 50px">正在进行分包,请稍等...如果等待时间超过5分钟,请关闭重试.</div>',
					min:false,
					max:false,
					cancel:false,
			});
		}
		*/
	</script>
	</body>
</html>
