<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<base href="<%=basePath%>" />
		<title>非溯源药材入库</title>
		<link type="text/css" rel="stylesheet" href="/style/market.css"/>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：药材库存 &gt; 非溯源药材入库</div>
		<div class="form-box">
	    	<form action=""  method="post" name="searchform" id="searchform">
				<s:token></s:token>
				
				<div class="fb-tit">非溯源药材入库</div>
				<div class="fb-con">
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
				            <td height="30"><label class="starcss"></label></td>
				            <td align="right">药材产地：</td>	
				            <td colspan="4">
				            	<select name="province" id="province" class="w150" value="${province}" v="${initParam.province }"></select>
								<select name="city" id="city" class="w150" value="${city}" v="${city}"></select>
								<select name="area" id="area" class="w150" value="${area}" v="${area}"></select>
				            	<span class="red">*</span>&nbsp;&nbsp;
				            	<span style="color:red; display: none" id="areaCheck" >请选择区域</span>
				           	</td>
				        </tr>
				        <tr>
			  				<td width="2%" height="30"><label class="starcss"></label></td>
			  				<td width="13%"align="right">药材品种：</td>
			  				<td width="34%">
			  					<input type="text" class="inp fl" id="medname" name="medname" maxlength="20" value="${medname }"/>
			  					<a href="javascript:void(0);" onclick="selMedBase();" class="btn-xz fl">选择药材品种</a>
			  				</td>
			  				<td width="2%"><label class="starcss"></label></td>
			  				<td align="right">收获时间：</td>
							<td>
								<c:if test="${source=='栽培' || source=='' || source == null}" var="flag">
									<input type="text" class="inp" name="harvesttime" id="harvesttime" 
											  style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" 
										 	  onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'intime\');}'});"
											  value="${harvesttime }">
								</c:if>
								<c:if test="${!flag}">
									<input type="text" class="inp hide" name="harvesttime" id="harvesttime" 
										  style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" 
									 	  onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'intime\');}'});"
										  value="${harvesttime }">
								</c:if>
							</td>
			  			</tr>
				        <tr>
			  				<td height="30"></td>
			  				<td width="15%" align="right">批次号：</td>
			  				<td width="34%"><input type="text" class="inp" name="mednumber" id="mednumber" maxlength="15" value="${mednumber }"/><span class="red">*</span></td>
							<td></td>
			  				<td align="right">施肥状况：</td>
			  				<td >
			  				<!-- 
			  					<c:if test="${source=='栽培' || source=='' || source == null}">
				  					<select name="fertilizer" id="fertilizer" style="width: 155px; " value="${fertilizer}">
				  						<c:if test="${fertilizer==null || fertilizer=='有'}">
				  							<option value="有" selected="selected">有</option>
				  							<option value="无">无</option>
				  						</c:if>
				  						<c:if  test="${fertilizer=='无'}">
				  							<option value="有">有</option>
				  							<option value="无" selected="selected">无</option>
				  						</c:if>
				  					</select>
				  				</c:if>
				  				<c:if test="${!flag}">
				  					<select name="fertilizer" id="fertilizer" style="width: 155px; " value="${fertilizer}" class="hide">
				  						<option value="有">有</option>
				  						<option value="无">无</option>
				  					</select>
				  				</c:if>
				  			-->
				  				<input type="text" class="inp fl" id="fertilizer" name="fertilizer" maxlength="20" value="${fertilizer }"/>
			  				</td>
			  			</tr>
			  			<tr>
			  				<td height="30"></td>
			  				<td align="right">药材类型：</td>
			  				<td>
			  					<select name="source" id="source" style="width: 155px; " value="${source}">
			  						<c:if test="${source==null}">
			  							<option value="栽培"  selected="selected">栽培</option>
				  						<option value="野生">野生</option>
				  						<option value="自购">自购</option>
			  						</c:if>
			  						<c:if test="${source=='自购'}">
			  							<option value="栽培">栽培</option>
				  						<option value="野生">野生</option>
				  						<option value="自购" selected="selected">自购</option>
			  						</c:if>
			  						<c:if test="${source=='野生'}">
			  							<option value="栽培">栽培</option>
				  						<option value="野生" selected="selected">野生</option>
				  						<option value="自购">自购</option>
			  						</c:if>
			  						<c:if test="${source=='栽培'}">
			  							<option value="栽培" selected="selected">栽培</option>
				  						<option value="野生">野生</option>
				  						<option value="自购">自购</option>
			  						</c:if>
			  					</select>
			  				</td>
			  				<td></td>
			  				<td align="right">农药情况：</td>
			  				<td>
			  				<!-- 
			  					<c:if test="${flag}">
				  					<select name="pesticide" id="pesticide" style="width: 155px; " value="${pesticide}">
				  						<c:if test="${pesticide==null || pesticide=='有'}">
				  							<option value="有" selected="selected">有</option>
				  							<option value="无">无</option>
				  						</c:if>
				  						<c:if  test="${pesticide=='无'}">
				  							<option value="有">有</option>
				  							<option value="无" selected="selected">无</option>
				  						</c:if>
				  					</select>
				  				</c:if>
				  				<c:if test="${!flag}">
				  					<select name="pesticide" id="pesticide" style="width: 155px; " value="${pesticide}" class="hide">
				  						<option value="有">有</option>
				  						<option value="无">无</option>
				  					</select>
				  				</c:if>
				  		    -->
				  		    
				  		    <input type="text" class="inp fl" id="pesticide" name="pesticide" maxlength="20" value="${pesticide }"/>
			  				</td>
			  			</tr>
			  			<tr>
			  				<td height="30"><label class="starcss"></label></td>
			  				<td align="right">入库重量(Kg)：</td>
			  				<td><input type="text" class="inp" name="medweight" id="medweight" maxlength="6" value="${medweight }" 
			  					onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this)"><span class="red">*</span>
			  					<span style="color:red; display: none" id="medweightCheck" >请填写重量</span>
			  				</td>
			  				<td><label class="starcss"></label></td>
			  				<td align="right">入库时间：</td>
	  						<td><input type="text" class="inp" name="intime" id="intime"
	  						 style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" 
	  						 onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'harvesttime\');}'});" value="${intime }">
	  						 <span class="red">*</span>
	  						</td>
			  			</tr>
					</table>
				</div>
				<div style="color: red; font-size: 18px">${returninfo }</div>
		        <div class="fb-bom">
		        	<cite><input type="submit" value="下一步" class="sbt" id="next"/></cite>
		        </div>
	        </form>
		</div>
		
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
		<script type="text/javascript" language="javascript">
			
			$("#source").change(function(){
				if($("#source").val() == "栽培"){
				    $("#harvesttime").attr("disabled",false);
					$("#fertilizer").attr("disabled",false); 
					$("#pesticide").attr("disabled",false); 
					
					$("#harvesttime").css("background","#ffffff url('images/growaddunittime.png') no-repeat right");
					$("#fertilizer").css("background","");
					$("#pesticide").css("background","");
				}else{
				
					$("#harvesttime").attr("disabled",true); 
					$("#fertilizer").attr("disabled",true); 
					$("#pesticide").attr("disabled",true); 
					
					$("#harvesttime").css("background","#eeeeee");
					$("#fertilizer").css("background","#eeeeee");
					$("#pesticide").css("background","#eeeeee");
					
				}
			});
			
			function selMedBase(){
				$("#returninfo_lastcheck").html("");
				t2 = $.dialog({
					title:'选择药材品名',
					id:'tabletChos',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
			});
			}
			
			function closeDG(s){
				$("#medname").val(s[1]);
				t2.close();
			}
			
			$("#searchform").submit(function(){
				if(!checkFrom()){
					return false;
				}
				$("#next").attr("disabled","disabled");
				$.dialog({
					title:'正在进行处理',
					id:'pack',
					lock:true,
					content: '<div style="font-size:18px;color:red;padding:20px 50px">正在进行处理,请稍等...如果等待时间超过5分钟,请关闭重试.</div>',
					min:false,
					max:false,
					cancel:false
				});
				$("#searchform").attr("action", "<%=basePath%>medSell!notSourceMedSave.shtml");
			});
			
			function checkFrom(){
				if($("#area").val() == ""){
					$("#areaCheck").css("display","inline-block");
					return false;
				}else{
					$("#areaCheck").css("display","none");
				}
				/*if($("#medname").val() == ""){
					$("#mednameCheck").css("display","inline-block");
					return false;
				}else{
					$("#mednameCheck").css("display","none");
				}*/
				if(!isNullIpu("medname"))
				{
					$.dialog.alert("药材品种未选择！");
					return;
				}
				
				var medname = $.trim($("#medname").val());
				if(medname != ""){
					if(checkquotmarks(medname)){
						$("#medname").focus();
						$.dialog.tips('品名不能包含~ # *等字符！',3,'alert.gif');
						return false;
					}
				}
				
				if(!isNullIpu("mednumber"))
				{
					$.dialog.alert("批次号未输入！");
					return;
				}
				
				var mednumber = $.trim($("#mednumber").val());
				if(mednumber != ""){
					if(checkquotmarks(mednumber)){
						$("#mednumber").focus();
						$.dialog.tips('批次号不能包含~ # *等字符！',3,'alert.gif');
						return false;
					}
				}
				
				if(!isNullIpu("medweight"))
				{
					$.dialog.alert("入库重量未输入！");
					return;
				}
				
				if($("#medweight").val() == ""){
					$("#medweightCheck").css("display","inline-block");
					return false;
				}else{
					$("#medweightCheck").css("display","none");
				}
				
				if(!isNullIpu("intime"))
				{
					$.dialog.alert("入库时间未选择！");
					return;
				}
				
				return true;
			}
			
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
			if(obj.value=="0"){
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
  		</script>
	</body>
</html>