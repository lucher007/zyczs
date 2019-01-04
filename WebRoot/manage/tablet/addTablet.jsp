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
		<base href="<%=basePath%>" >
		<title>新建生产任务</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：饮片生产管理  &gt; 新建饮片生产</div>
	    <form action="" method="post" name="form1" id="form1">
	    <s:token></s:token>
	    <input type="hidden" name="processflow" id="processflow">
	    <input type="hidden" name="cpctablet" id="cpctablet">
	    <input type="hidden" name="cpctabletimg" id="cpctabletimg">
	    <input type="hidden" name="assistStr" id="assistStr">
	    <input type="hidden" name="medid" id="medid">
	    <input type="hidden" name="prodcontent" id="prodcontent"/>
	    <div class="form-box">	
	    	<div id="step1">
		    	<div class="fb-tit">新建饮片生产</div>
	        	<div class="fb-con">
	        		<ul class="fb-ul">
		              <li class="fb-cbox">
		                <div class="fb-ctit">录入生产基本信息</div>
		                <div class="fb-tab"> 		
					    	<table cellpadding="0" cellspacing="0" width="100%"  border="0">
					  			<tr>
					  				<td height="30">饮片名：</td>
					  				<td>
					  				<input type="text" id="tabletname" name="tabletname" class="inp w100 fl" readonly="readonly" style="background:#eeeeee;">
					  				<a href="javascript:void(0);" id="xzyp" class="btn-xz fl">选择饮片品名</a><span class="red">&nbsp;*</span>
					  				</td>
					  				<td height="30">批次号：</td>
					  				<td><input type="text"  id="tabletnumber" maxlength="30" id="tabletnumber" name="tabletnumber" class="inp" size="20"> <span class="red">*</span></td>
					  				<td height="30">生产规格：</td>
					  				<td><input type="text"  id="tabletspec" name="tabletspec" class="inp w100" maxlength="7"> <span class="red">*</span></td>
					  			</tr>		 				
					  		</table>
					  	</div>
					  </li>
					  <li class="fb-cbox mt10">
		              	<div class="fb-ctit">录入饮片原药材信息</div>
		                <div class="fb-tab">
		                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			                  <tr>
			                    <td height="30" class="b">主料：</td>
			                    <td colspan="6" style="padding:0" width="670">
			                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                      <tr>
			                        <td width="72" align="right">药材名：</td>
			                        <td width="165"><input type="text" class="inp w80 fl" readonly="readonly" value="" id="medname" name="medname" style="background:#eeeeee;"><a href="javascript:void(0);" id="xzyc" class="btn-xz fl">选择主料品名</a><span class="red">&nbsp;*</span></td>
			                        <td>批次号：</td>
			                        <td>
				                        <input type="hidden" class="inp" value="" id="cpcmed" name="cpcmed"  style="background:#eeeeee;">
				                        <input type="text" class="inp" value="" id="mednumber" name="mednumber" readonly="readonly" style="background:#eeeeee;">
			                        </td>
			                        <td>产地：</td>
			                        <td><input type="text" class="inp w100" value="" id="medaddress" name="medaddress" readonly="readonly" style="background:#eeeeee;"></td>
			                      </tr>
			                    </table>
			                    </td>
			                  </tr>
			                  <tr>
			                    <td height="30">&nbsp;</td>
			                    <td colspan="6" style="padding:0" width="670">
			                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                      <tr>
			                        <td width="72" align="right">总重量(Kg)：</td>
			                        <td width="148"><input type="text" class="inp w100" value=""  id="medweight" name="medweight" readonly="readonly" style="background:#eeeeee;"> <span class="red">*</span></td>
			                        <td width="90" align="right">使用重量(Kg)：</td>
			                        <td>&nbsp;&nbsp;<input type="text" class="inp" value="" maxlength="6" id="meduseweight" name="meduseweight" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);" > <span class="red">*</span></td>
			                      </tr>
			                    </table>
			                    </td>
			                  </tr>
			                  <tr>
			                    <td height="30" class="b">辅料：</td>
			                    <td colspan="6"><a href="javascript:void(0);" onclick="addAssi();" class="btn-red">增加辅料</a></td>
			                  </tr>
			                  <tr>
			                  	<td width="714" colspan="7" id="growMedList">
			                  	</td>
			                  </tr>
			                </table>
		                </div>
		              </li>
		              <li class="fb-line">
		              	执行标准：<input maxlength="80" type="text" id="execstandard" name="execstandard" class="inp" size="90" value="中国药典">
		              </li>
		            </ul>
			  	</div>
			  	<div class="fb-bom">
		        	<cite class="gray"><input type="button" onclick="forStep(2);" value="下一步" class="sbt"></cite>
		        </div>
		  	</div>
		  	
		  	<div id="includecontent" class="hide">
		    <jsp:include page="/config/configTablet_all.jsp"/>
		    </div>
		    
		    <div id="step4" class="hide">
		    	<div class="fb-tit">确认生产信息</div>
		        <div class="fb-con">
		        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10">
		              <tr>
		                <td class="fbc-box" valign="top">
		                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		                      <tr class="fbc-tit b">
		                        <td colspan="3">完善生产信息</td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">工艺流程：</td>
		                        <td colspan="2" id="displayprocessflow"></td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">工 艺 员：</td>
		                        <td colspan="2"><input type="text" class="inp" name="operator" id="operator" maxlength="10"></td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">生产部经理：</td>
		                        <td colspan="2"><input type="text" class="inp" name="manager" id="manager" maxlength="10"></td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">QA人员：</td>
		                        <td colspan="2"><input type="text" class="inp" name="qa" id="qa" maxlength="10"></td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">生产日期：</td>
		                        <td><input type="text" class="Wdate inp" name="createtime" id="createtime" onblur="onBlurCheck(this.name);" onFocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
		                        <span class="red">*</span>
		                        </td>
		                        <td>
		                        	<label name="createtimeLab" id="createtimeLab" class="noico">
										生产日期没有填写
									</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">&nbsp;</td>
		                        <td colspan="2" class="red">（重要提示）此日期必须与该批次饮片外包装生产日期保持一致！</td>
		                      </tr>
		                      <tr>
		                        <td height="30" valign="top" align="right">备　注：</td>
		                        <td colspan="2"><input type="text" class="inp" maxlength="50" name="remark" id="remark"></td>
		                      </tr>
		                    </table>
		                </td>
		                <td width="188" valign="top">
		                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box">
		                      <tr class="fbc-tit b">
		                        <td height="30">饮片溯源二维码</td>
		                      </tr>
		                      <tr>
		                        <td height="160" valign="top" class="dcode" id="gpcodedivimg"></td>
		                      </tr>
		                      <tr>
		                        <td height="25" id="gpcodediv" align="center"><a href="#"  class="blue" style="visibility: hidden">导出二维码</a></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
		    	</div>
		        <div class="fb-bom">
		        	<cite class="gray"><input type="button" onclick="checkForm();" id="subBut" value="完成生产" class="sbt"></cite>
		            <input type="button" value="返回上一步" onclick="forStep(3);" id="backBut" class="sbt">
		        </div>
		    </div>
		</div>
	    </form>
	</div>    
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/comtools.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){  
		     $("#tabletnumber").focus();
		    
		     $("#xzyp").click(function(){
		     	selTabletBase();
		     	return false;
		     });
		     $("#xzyc").click(function(){
		     	selMedStorage();
		     	return false;
		     });
		 }); 
	   /////////////////////对必要的输入框进行数字合法验证/////小数一位/////////////////////
		function onkeypressCheck1(obj){
			if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if(obj.value.match(/^\d+\.\d{2}?$/)){
					obj.value = obj.value.substr(0,obj.value.length-1);
			} 
		}
		
		function onkeyupCheck1(obj){
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
				if(obj.value.match(/^\d+\.\d{2}?$/)){
							obj.value = obj.value.substr(0,obj.value.length-1);
				} 
				if(obj.value == 'undefined'){
							obj.value='';
				}
		}
		
		function onkeyblurCheck1(obj){
			if(obj.value=="0")
					obj.value='';
			if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
				obj.value = obj.o_value;
			}else {
				if (obj.value.match(/^\.\d+$/)) {
					obj.value = 0 + obj.value;
				}
				
				obj.o_value = obj.value;
			}
			if(!obj.value.match(/^\d+(\.\d{1})?$/)){
				obj.value = obj.value.substr(0,obj.value.indexOf(".")+2);
			} 
		}
		//////////////////////////////////////////////////////////////////////
	    
	    
		/////////////////////对必要的输入框进行数字合法验证////////小数三位//////////////////
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
			if(obj.value=="0")
					obj.value='';
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
	   
	   	function isNullIpu2(name)
		{
			var inputVal = $.trim($("#"+name).val());
			if(inputVal == null || inputVal == ""){
				return false;
			}else
			return true;
		}
		
		function isStrIpuabc2(name)
		{
			var inputVal = $.trim($("#"+name).val());
			return /[\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(inputVal);
		}
		
		function isStrIpuabc3(name)
		{
			var inputVal = $.trim($("#"+name).val());
			return /[\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\?\<\>\,\/\\]/.test(inputVal);
		}

		function selMedStorage(){
			//$("#returninfo_lastcheck").html("");
			t1 = $.dialog({
				title:'选择原药材',
				id:'medChos',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>medStorage!medStorageChoice2.shtml?ischoice='+Math.random()+'"></iframe>',
				max:false,
				min:false
			});	
		}
		function closeDGS(s){
			$("#medid").val(s[0]);
			$("#medname").val(s[1]);
			$("#cpcmed").val(s[2]);	
			$("#medweight").val(s[3]);	
			$("#medaddress").val(s[4]);
			$("#mednumber").val(s[5]);
			$("#meduseweight").focus();
			t1.close();
		}
		function selTabletBase(){
			//$("#returninfo_lastcheck").html("");
			t2 = $.dialog({
				title:'选择饮片品名',
				id:'tabletChos',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>tabletBase!tabletBaseChoice.shtml?rid='+Math.random()+'"></iframe>',
				max:false,
				min:false
			});			
		}
		
		function closeDG(s){
			$("#tabletname").val(s[1]);
			$("#tabletnumber").focus();
			t2.close();
		}
		var returnInfo="";
		var bool1 = false;//全局变量存放文本框是否验证通过
		var bool2 = false;//全局变量存放药材框是否验证通过
		var i = 0;
		
		//添加一列药材
		function addAssi(){
		     if(getTableLength()==5){
		     	$.dialog.alert('辅料不能超过5条！');
				return;
		     }
			 var str="<table cellpadding=\"0\" style=\"font-size:12px;\" cellspacing=\"0\" id=\"Assist_"+i+"\" class=\"assist\" >";
			 str+="<tr>"
			 +"<td height=\"30\">辅料品名：</td><td><input class=\"inp w80\" type=\"text\" maxlength=\"15\" name=\"assList["+i+"].assistplantname\"  id=\"\assistplantname"+i+"\" \/> <span class=\"red\">*</span></td>"
			 +"<td>辅料编号：</td><td><input class=\"inp w80\" type=\"text\" size=\"15\" maxlength=\"15\" name=\"assList["+i+"].assistgpcode\" id=\"assistgpcode"+i+"\" \/> <span class=\"red\">*</span></td>"
			 +"<td>辅料产地：</td><td><input class=\"inp w80\" type=\"text\" maxlength=\"15\" name=\"assList["+i+"].assistcity\"  id=\"assistcity"+i+"\" \/></td>"
			 +"<td width=\"50\"><a href=\"javascript:void(0)\" class=\"btn-del\" onClick=\"delAssi('"+i+"')\">删除</a></td>"
			 +"</tr>"
			 +"<tr>"
			 +"<td height=\"30\">辅料重量(g)：</td><td><input class=\"inp w80\" type=\"text\" maxlength=\"6\" name=\"assList["+i+"].assistweight\" id=\"assistweight"+i+"\" onkeypress=\"onkeypressCheck1(this);\" onkeyup=\"onkeyupCheck1(this);\" onblur=\"onkeyblurCheck1(this);\" \/> <span class=\"red\">*</span></td>"
			 +"<td>辅料使用比列：</td><td><input class=\"inp w80\" type=\"text\" size=\"15\" maxlength=\"15\" name=\"assList["+i+"].assistusecount\" id=\"assistusecount"+i+"\"  \/></td>"
			 +"<td>辅料/净药材%=：</td><td colspan=\"2\"><input class=\"inp w80\" type=\"text\" maxlength=\"15\" name=\"assList["+i+"].assistmaterial\" id=\"assistmaterial"+i+"\"  \/>%</td>"
			 +"</tr>";
			 
			 str+="</table>";
			    
		     $("#growMedList").append(str);	
		     i++;
		     resetH();
		}
		
		//删除一列选中的药材
		function delAssi(num){
			$("#Assist_"+num).remove();
			resetH();
		}
		
		function getTableLength(){
			return  $("table[id^='Assist_']").length;
		}	
		
		var assistStr="";
		var assisNull=true;
		var assisSucc=true;
		function checkAssi(){
			assisNull=true;
			assisSucc=true;		
			assistStr="";	
			$("table[id^='Assist_']").each(function(i){
				var assistplantname="";
				var assistgpcode="";
				var assistcity="";
				var assistweight="";
				var assistusecount="";
				var assistmaterial="";	
				//查找所有 text
				var num=this.id.substring(this.id.length-1,this.id.length);
				$("#"+this.id).find("input[type=text]").each(function(){
					//辅料品名
					
					if(this.id=="assistplantname"+num)
					{
						//alert(this.name);
						if(!isNullIpu2(this.id))
						{
							return assisNull=false;
						}else if(isStrIpuabc2(this.id)){		
							return assisSucc=false;
						}
						assistplantname=this.value;	 						
					}//辅料编号
					else if(this.id=="assistgpcode"+num)
					{
						if(!isNullIpu2(this.id))
						{
							return assisNull=false;
						}else if(isStrIpuabc2(this.id)){	
							return assisSucc=false;
						}
						assistgpcode=this.value;	 	
					}//辅料产地
					else if(this.id=="assistcity"+num)
					{
						if(isStrIpuabc2(this.id)){	
							return assisSucc=false;
						}
						assistcity=this.value;	
					}//辅料重量
					else if(this.id=="assistweight"+num)
					{
						if(!isNullIpu2(this.id))
						{
							return assisNull=false;
						}else if(isStrIpuabc2(this.id)){	
							return assisSucc=false;
						}
						assistweight=this.value;	
					}//使用比列
					else if(this.id=="assistusecount"+num)
					{
						if(isStrIpuabc3(this.id)){
							
							return assisSucc=false;
						}
						assistusecount=this.value;	
					}//净药材
					else if(this.id=="assistmaterial"+num)
					{
						if(isStrIpuabc3(this.id)){	
							return assisSucc=false;
						}
						assistmaterial=this.value;	
					} 		            
		        });
		      		
	      		if(assistplantname!=""&&assistgpcode!=""&&assistcity!=""&&assistweight!=""&&assistusecount!=""&&assistmaterial!="")
	      		{
	      			assistweight=multiply(assistweight,10);
	      			assistStr+=	assistplantname+"~"+assistgpcode+"~"+assistcity+"~"+assistweight+"~"+assistusecount+"~"+assistmaterial+"|";
	      		}
			});
		}
		
		function forStep(num)
		{
			returnInfo="";
			if(num==2)
			{
				$("#includecontent").attr("class","show");
				//非空验证===========================================
				//饮片基础信息验证
				if(!isNullIpu("tabletname"))
				{
					returnInfo+="饮片名没有填写！<br>";
				}
				if(!isNullIpu("tabletnumber"))
				{
					returnInfo+="批次号没有填写！<br>";
				}
				if(!isNullIpu("tabletspec"))
				{
					returnInfo+="生产规格没有填写！<br>";
				}	
				//原药材信息验证
				if(!isNullIpu("medname"))
				{
					returnInfo+="药材名没有填写！<br>";
				}
				
				if(!isNullIpu("meduseweight"))
				{
					returnInfo+="使用重量没有填写！<br>";
				}
				
				if(parseFloat($("#meduseweight").val())>parseFloat($("#medweight").val())){
					$.dialog.alert('使用重量不能大于总重量');
					return;
				}
					  		
				//非法字符验证===================================
				if(isStrIpuabc("tabletnumber")){	
					returnInfo+="批次号存在非法字符！<br>";
				}
				if(isStrIpuabc("tabletspec")){	
					returnInfo+="生产规格存在非法字符！<br>";
				}
				
				//execstandard 执行标准
				
				if(returnInfo!="")
				{
					$.dialog.alert('<div style="line-height:22px; width:150px; padding-left:20px;">'+returnInfo+'</div>');
					return;
				}
								
				//辅料信息验证=================================
				
				checkAssi();	
				if(assisNull!=true)
				{
					$.dialog.alert("辅料信息未填写完整！");
					return;
				}
				if(assisSucc!=true)
				{
					$.dialog.alert("辅料信息存在非法字符！");
					return;
				}
				//以动态数组方式映射到form.assList 中
				//$("#assistStr").val(assistStr)			
			}
			if(num==3){
				//alert($('#includecontent').css('display'));
				$("#includecontent").attr("class","show");
			}
			if(num==4)
			{
				$("#includecontent").attr("class","hide");
				var flag = 0 ;
				var processflow="";
				//净制
				$("#processtr1 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {			
						processflow+="净制,";
						
						flag=1;
						return false;
					} 
				});
				
				//洗润
				$("#processtr2 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="洗润,"
						flag=1;
						return false;
					} 
				});
				//切制
				$("#processtr3 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="切制,"
						flag=1;
						return false;
					} 
				});
				//干燥
				$("#processtr4 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="干燥,"
						flag=1;
						return false;
					} 
				});
				//筛选
				$("#processtr5 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="筛选,"
						flag=1;
						return false;
					} 
				});
				//炮制
				$("#processtr6 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="炮制,"
						flag=1;
						return false;
					} 
				});
				//精选
				$("#processtr7 :checkbox").each(function(){ 
					if ($(this).attr("checked")) {
						processflow+="精选,"
						flag=1;
						return false;
					} 
				});
				
				if(flag==0){
					$.dialog.alert("工艺流程没有选择");
					forStep(2);
					return false;
				}		
				$("#displayprocessflow").html(processflow.substring(0,processflow.length-1));
				$("#processflow").val(processflow.substring(0,processflow.length-1));	
				
				inContent();
				
				if($("#prodcontent").val()==""){
					$.dialog.alert("工艺流程出错，请退出重试！");
					return;
				}

				findByProducecode();
				//opDiv(num);		
			}
			
			opDiv(num);		
			
		}

		function inContent(){
			$("#includecontent input[type=checkbox]").each(function(i){
			if($(this).attr("checked")){
				$(this).attr("checked","checked")
				}else{
					$(this).removeAttr("checked")
				}
			})
			$("#includecontent input[type=text]").each(function(i){
				if($(this).val()!=""){
					$(this).attr("value",$(this).val());
				}else{
					$(this).attr("value","");
				}
			})
			$("#includecontent textarea").each(function(i){
				if($(this).val()!=""){
					$(this).text($(this).val());
				}else{
					$(this).text("");
				}
			})
			$("#prodcontent").val($("#includecontent").html());
			
			
		}

		
		function opDiv(num)
		{
			for(var y=1;y<5;y++)
			{
				if(y==num)
				{
					$("#step"+num).show(0);
				}else{
				$("#step"+y).hide(0);
				}
			}
			resetH();
		}
		
		//获取溯源二维码
		function findByProducecode(){
			var data=""	
			var url="<%=request.getContextPath()%>/tablet!findByTabletcode.shtml?rid="+Math.random();
			$.getJSON(url,function(msg){
				var gpcodediv = $("#gpcodediv a");
				var gpcodedivimg = $("#gpcodedivimg");
				var gpcodeimg = $("#cpctabletimg");	
				if(msg.cpctabletimg!=""){
					gpcodedivimg.html("<img src=\"<%=basePath%>images/qrcode.png\" width=\"150\" height=\"150\">");
					gpcodediv.attr("href","<%=basePath%>images/qrcode.png");
					gpcodediv.attr("target","_blank");
				}else{
					gpcodedivimg.html("服务器异常、请返回重新获取");
					gpcodediv.attr("href","javascript:void(0);");
				}
				
				$("#cpctablet").val(msg.cpctablet);
				$("#cpctabletimg").val(msg.cpctabletimg);
			});
		}
		
		function checkForm(){
			returnInfo="";
			
			if($("#createtime").val()==null||$("#createtime").val()=="")
			{
				returnInfo+="生产日期没有填写!<br>";
			}
			if($("#cpctabletimg").val()==null||$("#cpctabletimg").val()=="")
			{
				returnInfo+="饮片溯源二维码没有生成!<br>";
			}
			//输入非法验证================
			if(isStrIpuabc("operator")){	
				returnInfo+="批次号存在非法字符！<br>";
			}		
			if(isStrIpuabc("manager")){	
				returnInfo+="生产部经理存在非法字符！<br>";
			}
			if(isStrIpuabc("qa")){	
				returnInfo+="QA人员存在非法字符！<br>";
			}
			if(isStrIpuabc("remark")){
				returnInfo+="备注存在非法字符！<br>";
			}
			if(returnInfo!=""){
				$.dialog.alert('<div style="line-height:22px; width:150px; padding-left:20px;">'+returnInfo+'</div>');
				return;
			}
			
			
			if(!onBlurCheck("createtime")){
				return ;
			}	
		
			$("input[type='checkbox']").each(function(){ 
				if ($(this).attr("checked")) {			
					$(this).val("是");		
				}else{
				$(this).val("否");	
				}
			});
			
			$("#step2 input").each(function(i){
					$(this).val('');					
			});
			
			$("#step3 input").each(function(i){
					$(this).val('');					
			});
			
			//$.dialog.confirm("<div style='padding:0 50px 0 10px;'>确认要提交吗?</div>",function(){
					
				$.dialog({
					title:'正在新建生产任务',
					id:'pack',
					lock:true,
					content: '<div style="font-size:18px;color:red;padding:20px 50px">系统处理中,请稍等...</div>',
					min:false,
					max:false,
					cancel:false
				});	
				
				$("#form1").attr("action","tablet!saveObject.shtml");
				$("#form1").submit();
				$("#subBut").attr("disabled","disabled");
				$("#backBut").attr("disabled","disabled");
					
				//alert($("#assistStr").val());		
			//})
			
		}
		function selAll(){
			$("input[type='checkbox']").each(function(){ 
				$(this).attr("checked",!this.checked);
			});
		}
	</script>
	</body>
</html>