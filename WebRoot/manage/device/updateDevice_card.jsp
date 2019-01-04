<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
			<div class="cur-pos">当前位置：市场管理 > IC卡</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：设备管理 > IC卡</div>
		</c:if>
		<form action="" method="post" id="searchform" name="searchform">
		<input type="hidden" name="deviceid" id="deviceid" value="${requestScope.device.deviceid }"/>
	    <div class="form-box">
    		<div class="fb-tit">IC卡重置</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
			      <tr>
			            <td height="30" align="right">IC卡编号：</td>
			            <td width="290">
			            	<input type="text" class="inp" readonly="readonly" style="background:#eeeeee;" size="39" name="devicecode" id="devicecode" maxlength="32" value="${requestScope.device.devicecode }" > <span class="red">*</span>
			            </td>
			      </tr>
			      <tr> 
						<td height="30" align="right" width="100">卡类型：</td>
						<td>
						    <input type="hidden" id="cardtype" name="cardtype" value="${requestScope.device.cardtype }" />
							<select style="width: 275px" disabled="disabled">
							    <option value="00001000" <c:if test="${requestScope.device.cardtype == '00001000'}">selected</c:if>>案秤IC卡</option>
								<option value="10000000" <c:if test="${requestScope.device.cardtype == '10000000'}">selected</c:if>>台秤IC卡</option>
							</select>
						</td>
				  </tr>
				  <tr>
		            <td height="30"  align="right"> 配置规格名称：</td>
		            <td >
		            	<select id="confid" name="confid">
							<c:forEach items="${requestScope.deviceconfmap}" var="deviceMap" varStatus="s">
						 		<option value="${deviceMap.key}" <c:if test="${requestScope.device.confid == deviceMap.key }">selected</c:if>>${deviceMap.value}</option>;
							</c:forEach>
						</select>
		            </td>
		          </tr>
				  <tr>
						<td height="30" align="right">归属单位名称：</td>
						<td>
						    <input size="40" class="inp fl" type="text" readonly="readonly" id="corpname" name="corpname" maxlength="24" style="background:#eeeeee;" value="${requestScope.device.corpname}">
					        <a href="javascript:void(0);" id="selectCpccorp" class="btn-xzs fl">选择单位</a><span class="red">&nbsp;*</span>
					    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">单位CPC编码：</td>
						<td>
						    <input type="hidden"  id="orgid" name="orgid" value="${requestScope.device.org.orgid}">
							<input size="40" class="inp"  type="text" readonly="readonly"  id="cpccorp" name="cpccorp" style="background:#eeeeee;" value="${requestScope.device.cpccorp}">
						</td>
				  </tr>
				  <tr>
						<td height="30" align="right">单位市场名称：</td>
						<td>
							<input size="40" class="inp" type="text" readonly="readonly" style="background:#eeeeee;" id="marketname" name="marketname" maxlength="24" value="${requestScope.device.org.marketname}">
							<span style="color:red;">不能大于24位, 非必填</span>
						</td>
				  </tr>
				  <tr>
						<td height="30" align="right">联系电话：</td>
						<td>
							<input size="40" class="inp" type="text" readonly="readonly" style="background:#eeeeee;" id="mobile" name="mobile" maxlength="30" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" value="${requestScope.device.org.mobile}">
							<span style="color:red;">不能大于30位, 非必填</span>						
						</td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤归属单位名称：</td>
						<td>
						    <input size="40" class="inp fl" type="text" readonly="readonly" value="" id="chengcorpname" name="chengcorpname" maxlength="24" style="background:#eeeeee;">
					        <a href="javascript:void(0);" id="selectChengCpccorp" class="btn-xzs fl">选择单位</a><span class="red">&nbsp;*</span>
					    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤归属单位CPC编码：</td>
						<td>
						    <input type="hidden"  id="chengorgid" name="chengorgid" value="">
							<input size="40" class="inp"  type="text" readonly="readonly"  id="chengcpccorp" name="chengcpccorp" style="background:#eeeeee;" value="">
						</td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤编号：</td>
						<td>
							<input size="40" class="inp fl" type="text" readonly="readonly" style="background:#eeeeee;" id="chengcode"  name="chengcode" maxlength="32" value="${requestScope.device.chengcode}">
							<a href="javascript:void(0);" id="selectCheng" class="btn-xzs fl">选择溯源秤</a><span class="red">&nbsp;*</span>
						</td>
				  </tr>
				  <tr style="display:none">
						<td height="30" align="right">内部序号：</td>
						<td>
							<input maxlength="1" size="40" class="inp" type="text" id="serialnum" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" title="区分同一商铺的不同智能溯源秤." value="1">
							<span style="color:red;">* 必须1位</span>						
						</td>
				  </tr>
		          <tr>
		            <td height="30"  align="right"> 重置原因：</td>
		            <td>
		            	<select name="reason" id="reason" class="w150">
							<option value="1" <c:if test="${requestScope.device.reason == 1 }">selected</c:if>>初次重置</option>
							<option value="2" <c:if test="${requestScope.device.reason == 2 }">selected</c:if>>维修</option>
							<option value="3" <c:if test="${requestScope.device.reason == 3 }">selected</c:if>>更换</option>
							<option value="4" <c:if test="${requestScope.device.reason == 4 }">selected</c:if>>回收</option>
				  		</select>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">重置备注信息：</td>
                    <td >
                        <textarea class="inp" rows="4" onkeydown="textCounter(searchform.remark,100);" onkeyup="textCounter(searchform.remark,100);" onblur="checkRemark(this.value);" id="remark" name="remark"  cols="40">${requestScope.device.remark}</textarea>
                    </td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="重置" class="sbt" onclick="saveDevice();" id="btnfinish"></cite>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	//验证查询框不能输入以下字符
	function checkChars(str){
		return /[\·\'\"\~\`\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
	}
	
	function checkArea(str){
		return /[\·\'\"\~\`\@\#\^\&\*\|\{\}\[\]\+\=?\<\>\/\\]/.test(str);
	}
	
	function checkRemark(remark){
		if(checkArea(remark)){
			$("#remark").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			document.getElementById("btnfinish").disabled=true;
			return false;
	    }else{
	        document.getElementById("btnfinish").disabled=false;
	    }
	}
	
	function textCounter(field,maxlimit) {  
	    if(field.value != null && field.value != ''){
		    if (field.value.length > maxlimit){  
		        field.value = field.value.substring(0, maxlimit);
		    } 
	    }
	}
	
	function checkDeviceCode(devicecode){
	    devicecode = $.trim(devicecode);
	    if(devicecode != null && devicecode != ''){
	        if(checkChars(devicecode)){
				$("#devicecode").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
		    }
		    
		    if(!(/^[A-Z0-9]{1,32}$/.test(devicecode))){
				$("#devicecode").focus();
				$.dialog.tips('设备编号只能由数字、大写字母组成。',1,'alert.gif');
				return false;
			}
		    
		    $.ajax({
		    	url: "<%=basePath%>device!checkDeviceCode.shtml?devicetype=4&devicecode=" + devicecode,
		    	type: 'post',
		    	success: function(html){
		    		if(html != ""){
		    			$.dialog.tips(html,2,'alert.gif');
		    			$("#devicecode").focus();
		    			document.getElementById("btnfinish").disabled=true;
		    		}else{
		    			document.getElementById("btnfinish").disabled=false;
		    		}
		  		}
			});
		}
	}
	
	
   $("#selectCpccorp").click(function(){
	    queryCompany($("#cardtype").val());
    	return false;
    });
    
    function queryCompany(cardtype){
	    t1 = $.dialog({
			title:'选择单位名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>device!companyChoice.shtml?cardtype="+cardtype+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeDG(s){
	    $("#orgid").val(s[0]);
		$("#corpname").val(s[1]);
		$("#cpccorp").val(s[2]);
		$("#marketname").val(s[3]);
		$("#mobile").val(s[4]);
		t1.close();
		$("#corpname").focus();
	}
	
	$("#selectChengCpccorp").click(function(){
	    queryChengCompany($("#cardtype").val());
    	return false;
    });
    
    function queryChengCompany(cardtype){
	    t1 = $.dialog({
			title:'选择单位名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>device!chengCompanyChoice.shtml?cardtype="+cardtype+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeChengCompanyDG(s){
	    $("#chengorgid").val(s[0]);
		$("#chengcorpname").val(s[1]);
		$("#chengcpccorp").val(s[2]);
		t1.close();
		$("#chengcorpname").focus();
	}
	
	
	function checkNumberChar(ob){
		if(/^\d+$/.test(ob)){
			return true;
		}else{
			return false;
		}
	}
	
	function createObj(){
		if($("#neowerPrinter").length<=0){
			$("body").append('<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>');
		}
	}
	
	function saveDevice(){
	    $("#devicecode").val($.trim($("#devicecode").val()));
		if($("#devicecode") != undefined && $("#devicecode").val() == ""){
			$.dialog.tips("IC卡编号必须填写！",1,'alert.gif');
			$("#devicecode").focus();
			return false;
		}
		
		if(checkChars($("#devicecode").val())){
			$("#devicecode").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
	    }
		
		if(!(/^[A-Z0-9]{1,32}$/.test($("#devicecode").val()))){
			$("#devicecode").focus();
			$.dialog.tips('IC卡编号只能由数字、大写字母组成。',1,'alert.gif');
			return false;
		}
		
		if($("#confid") != undefined && ($("#confid").val() == "" || $("#confid").val() == null )){
			$.dialog.tips("未选择设备配置规格！",1,'alert.gif');
			$("#confid").focus();
			return false ;
		}
		
		if($("#corpname") != undefined && $("#corpname").val() == ""){
			$.dialog.tips("归属企业名称不能为空！",1,'alert.gif');
			$("#corpname").focus();
			return false;
		}
		
		if($("#cpccorp") != undefined && $("#cpccorp").val() == ""){
			$.dialog.tips("归属企业CPC编码不能为空！",1,'alert.gif');
			$("#cpccorp").focus();
			return false;
		}
		
		if($("#chengcode") != undefined && $("#chengcode").val() == ""){
			$.dialog.tips("溯源秤编号不能为空！",1,'alert.gif');
			$("#corpname").focus();
			return false;
		}
		
		if(checkArea($("#remark").val())){
			$("#remark").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
	    }
		
		$(".sbt").attr("disabled","disabled");
		
		var data = $("#cardtype").val()+"|"+$("#cpccorp").val()+"|"+$("#corpname").val()+"|"+$("#mobile").val()+"|"+$.trim($("#chengcode").val())+"|"+$.trim($("#marketname").val())+"|"+$("#serialnum").val()+"|";
		
		createObj();
		
		try{
			var code = neowerPrinter.WriteRFID2(data,2);
			
			if(code == ""){
			    $("#searchform").attr("action", "<%=basePath%>device!updateDevice_card.shtml");
				$("#searchform").submit();
			}else{
				$.dialog.tips('更新卡失败！',3,'alert.gif');
				$(".sbt").removeAttr("disabled");
			}
		}catch(e){
			var str="";
			str+="<div>您尚未安装读卡器控件，请根据系统情况下载相应控件!<br />请安装后重新登录平台!</div><br />";
			str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载32位控件' onclick='printData_downControl(32);' />  ";
			//str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载64位控件' onclick='printData_downControl(64);' />  ";

			$.dialog({
				title:'下载控件',
				id:'checkRepo',
				lock:true,
				content: str,
				cancelVal: '关闭',
				cancel: function(){
					$(".sbt").removeAttr("disabled");
				}
			});
			return false;
		}
	}
	
	$(function(){
	    if($("#confid").val()==null){
	        $.dialog.tips("请先配置设备规格！",1,'alert.gif');
			$("#confid").focus();
			document.getElementById("btnfinish").disabled=true;
	    }
	})
	
	//判断是否回收设备
	function recoverDevice(){
		if($("#recoverCheck:checked").val()=="1"){
		    $("#recDeviceCodeTR").show();
		    $("#recConfidTR").show();
			$("#recReasonTR").show();
			$("#recRemarkTR").show();
			
		}else{
		    $("#recDeviceCodeTR").hide();
		    $("#recConfidTR").hide();
		    $("#recReasonTR").hide();
			$("#recRemarkTR").hide();
		}
		resetH();
	}
	
	$("#selectDevice").click(function(){
	    if($("#cpccorp").val() == ""){
	       $.dialog.tips("先选择重置单位！",1,'alert.gif');
	       return;
	    }
    	queryDevice($("#cpccorp").val());
    	return false;
    });
    
    function queryDevice(cpccorp){
	    t2 = $.dialog({
			title:'选择回收设备',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>device!deviceChoice.shtml?devicetype=4&cpccorp="+cpccorp+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
	
	function closeDeviceDG(s){
	    $("#recdeviceid").val(s[0]);
		$("#recdevicecode").val(s[1]);
		$("#recnormname").val(s[2]);
		t2.close();
		$("#recdevicecode").focus();
	}
	
	$("#selectCheng").click(function(){
    	if($("#cardtype").val() == '10000000'){
	        queryCheng(2,$("#chengcpccorp").val());
	    }else if($("#cardtype").val() == '00001000'){
	        queryCheng(1,$("#chengcpccorp").val());
	    }
    	return false;
    });
	
	function queryCheng(type,cpccorp){
	    t3 = $.dialog({
			title:'选择溯源秤',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>cheng!chengChoice.shtml?type="+type+"&cpccorp="+cpccorp+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeChengDG(s){
		$("#chengcode").val(s[1]);
		t3.close();
		$("#chengcode").focus();
	}
	function printData_downControl(num){
		if(num==32){
			window.location.href="js/setup32.exe"
		}else{
			window.location.href="js/setup64.exe"
		}
	}
</script>   
</body>
</html>
