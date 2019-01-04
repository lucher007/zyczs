<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!doctype html>
<html>
	<head>
	<meta charset="utf-8">
	<title>饮片包装</title>
	<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body oncontextmenu='return false'    oncopy='document.selection.empty()'  onbeforecopy="return false" onpaste="return false;" oncut="return false;" >
	<div id="body">
		<div class="cur-pos">当前位置：饮片生产管理 > 饮片分包</div>
		<div class="form-box">
	    	<form action="tabletStorage!updateTabletPack.shtml" name="searchform" id="searchform" method="post">
	    	<s:token></s:token>
	    	<input type="hidden" name="tabletstorid" id="tabletstorid" value="${requestScope.tabletStorage.tabletstorid}" />
	    	<input type="hidden" name="totalkgall" id="totalkgall" value="${requestScope.tabletStorage.tabletweight/10000}" />
	    	<input type="hidden" name="packStr" id="packStr" value="" />
	    	<input type="hidden" name="usetotal" id="usetotal" value="" />
	    	
	    	<div class="fb-tit">饮片分包
	    	<span style="color:red">
						注:每种规格分包数最大10000包、每箱包数不能大于总包数
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
		                	
		                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box" id="packtable">
		                      <tr class="fbc-tit b">
		                        <td colspan="6">操作分包</td>
		                      </tr>
		                      <tr>
		                        <td height="50" colspan="6">待分包总重量：
		                        <span id="totalkg">
		                        <c:set var="tabletweight" value="${requestScope.tabletStorage.tabletweight}" scope="request" />
				              		 <%
				              		Object tabletweight=request.getAttribute("tabletweight");	
				              		 %>   
	              		 
		                        	<%=Tools.scienceToString(Tools.division(tabletweight.toString(),"10000"))%>
		                        
		                        </span> Kg　<span style="display:none;" id="usetotalkg">0</span>
		                        包装类型：
		                        <select id="flag" name="flag" class="w158">	
									<option value="2">中包</option>
									<option value="1">小包</option>
								</select>
		                      </td>
		                      </tr>
		                      <tr class="fbc-tit">
		                        <td>小包装规格(g/包)</td>
		                        <td>小包数(包)</td>
		                        <td>重量(g)</td>
		                        <td id="td_tabletboxnum0">包装规格(小包/中包)</td>
		                        <td id="td_rowbox0">中包数</td>
		                        
		                      </tr>
		                      <tr id="packTR_0">
		                        <td height="30">
		                        <input type="text" class="inp w60" name="tabletnumweight0" id="tabletnumweight0" maxlength="6" onkeyup="onkeypressCheck(this);calcTotal(this);" onkeypress="onkeypressCheck(this);calcTotal(this);" onblur="onkeypressCheck(this);calcTotal(this);">
		                        </td>
		                        <td>
		                        <input type="text" class="inp w60" name="tabletnum0" id="tabletnum0" maxlength="6"  onkeyup="onkeyupNum(this);calcTotal(this);" onblur="onkeyupNum(this);calcTotal(this);" onkeypress="onkeyupNum(this);calcTotal(this);" >   
   
		                        </td>
		                        <td id="rowkg0"></td>
		                        <td><input type="text" class="inp w60" name="tabletboxnum0" id="tabletboxnum0" maxlength="6" onkeyup="onkeyupNum2(this);calcBox(this);" onkeypress="onkeyupNum2(this);calcBox(this);"  onblur="onkeyupNum2(this);calcBox(this);"></td>
		                        <td id="rowbox0"></td>
		                        
		                        <script>
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
				if(obj.value=='.'){
					obj.value='';
				} 
				if(obj.value == 'undefined')
				obj.value='';
			}
		
			
		//饮片包数判断
		function onkeyupNum(obj){
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
			//大于0
			if (obj.value<1) {
				obj.value = "";
			}
			//不能大于10000包
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
					
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				obj.value=addtr(obj.value,0);
			}
			//大于0
			if(obj.value<1&&obj.value.length==1) {
				obj.value = "";
			}	
		}
			
		//////////////////////////////////////////////////////////////////////
			
		                        </script>
		                        
		                      </tr>                  
		                    </table>
	                    </div>
	                </td>
	              </tr>
	            </table>
	    	</div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="确 认" id="subBut" class="sbt" onclick="return  checkForm();"></cite>
	        </div>
	        </form>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
		if ($.browser.msie && ($.browser.version == "6.0") && !$.support.style) {
			$("#bagbox").height($("#packtable").height());
		}
		

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
			var totalkg = multiply($.trim($("#totalkg").text()),10000);//待分包总重量
			
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
			//$("#totalkg").html(division(subtr(totalkgall,totalUseWeigth),10000));
			$("#usetotalkg").html(division(totalUseWeigth,10000));

		}
		
		
		function checkForm(){
			var flag=true;
			$("input[type='text']").each(function(){
			
				if($("#flag").val() == 1){
					if($(this).attr("id") == "tabletboxnum0"){
						return true;;
					}
				}
				
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
	   			var tabletboxitemnum;//每箱包数
	   			var tabletboxnum;         //箱数
	   			
	   			//选择箱/包则页面录入,包则给默认值	
	   			if($("#flag").val() == 2){
	   				tabletboxitemnum=$("#tabletboxnum"+num).val();//每箱包数
	   				tabletboxnum= $("#rowbox"+num).text();         //箱数	
	   			}else{
	   				tabletboxitemnum = 0;
	   				tabletboxnum = tabletnum;
	   			}
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
    		$("#subBut").attr("disabled","disabled");
	   			   		
		}
		
		/**
		*切换包装类型
		*/
		$("#flag").change(function(){
			var selectval = $(this).val();
			if(selectval == 2){
				$("#td_tabletboxnum0").show();
				$("#td_rowbox0").show();
				$("#tabletboxnum0").show();
				$("#rowbox0").show();
			}else{
				$("#td_tabletboxnum0").hide();
				$("#td_rowbox0").hide();
				$("#tabletboxnum0").hide();
				$("#rowbox0").hide();
			}
		});
	</script>
	</body>
</html>
