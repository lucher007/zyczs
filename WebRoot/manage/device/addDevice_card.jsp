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
	    <div class="form-box">
    		<div class="fb-tit">IC卡发放</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
			      <tr>
			            <td height="30" align="right" width="145">IC卡编号：</td>
			            <td width="375">
			            	<input type="text" class="inp" size="39" name="devicecode" id="devicecode" maxlength="32" value="" onblur="checkVal(this.name);checkDeviceCode(this.value)" > <span class="red">*</span>
			            </td>
			            <td >	    
						<label name="devicecodeLab" id="devicecodeLab" class="noico"></label>
						</td>
			      </tr>
			      <tr> 
						<td height="30" align="right" >卡类型：</td>
						<td>
							<select id="cardtype" name="cardtype" style="width: 275px" onchange="chengCardType();">
								<option value="00001000">案秤IC卡</option>
								<option value="10000000">台秤IC卡</option>
							</select>
						</td>
						<td >	    
						
						</td>
				  </tr>
				  <tr>
			            <td height="30"  align="right">配置规格名称：</td>
			            <td >
			            	<select id="confid" name="confid">
								<c:forEach items="${requestScope.deviceconfmap}" var="deviceMap" varStatus="s">
							 		<option value="${deviceMap.key}">${fn:substring(deviceMap.value, 0, 20)}</option>;
								</c:forEach>
							</select>
			            </td>
			            <td >
			            <label name="confidLab" id="confidLab" class="noico"></label>
			            </td>
		          </tr>
				  <tr>
						<td height="30" align="right">归属单位名称：</td>
						<td>
						    <input size="40" class="inp fl" type="text" readonly="readonly" value="" id="corpname" name="corpname" maxlength="24" style="background:#eeeeee;">
					        <a href="javascript:void(0);" id="selectCpccorp" class="btn-xzs fl">选择单位</a><span class="red">&nbsp;*</span>
					    </td>
					    <td >
	                    <label name="corpnameLab" id="corpnameLab" class="noico"></label>
	                    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">单位CPC编码：</td>
						<td>
						    <input type="hidden"  id="orgid" name="orgid" value="">
							<input size="40" class="inp"  type="text" readonly="readonly"  id="cpccorp" name="cpccorp" style="background:#eeeeee;" value="">
						</td>
						<td>
	                    <label name="cpccorpLab" id="cpccorpLab" class="noico"></label>
	                    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">单位市场名称：</td>
						<td>
							<input size="40" class="inp" type="text" readonly="readonly" style="background:#eeeeee;" id="marketname" name="marketname" maxlength="24" >
						</td>
						<td></td>
				  </tr>
				  <tr>
						<td height="30" align="right">联系电话：</td>
						<td>
							<input size="40" class="inp" type="text" readonly="readonly" style="background:#eeeeee;" id="mobile" name="mobile" maxlength="30" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
						</td>
						<td></td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤归属单位名称：</td>
						<td>
						    <input size="40" class="inp fl" type="text" readonly="readonly" value="" id="chengcorpname" name="chengcorpname" maxlength="24" style="background:#eeeeee;">
					        <a href="javascript:void(0);" id="selectChengCpccorp" class="btn-xzs fl">选择单位</a>
					    </td>
					    <td>
	                    <label name="chengcorpnameLab" id="chengcorpnameLab" class="noico"></label>
	                    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤归属单位CPC编码：</td>
						<td>
						    <input type="hidden"  id="chengorgid" name="chengorgid" value="">
							<input size="40" class="inp"  type="text" readonly="readonly"  id="chengcpccorp" name="chengcpccorp" style="background:#eeeeee;" value="">
						</td>
						<td>
	                    <label name="chengcpccorpLab" id="chengcpccorpLab" class="noico"></label>
	                    </td>
				  </tr>
				  <tr>
						<td height="30" align="right">溯源秤编号：</td>
						<td>
							<input size="40" class="inp fl" type="text" readonly="readonly" style="background:#eeeeee;" id="chengcode"  name="chengcode" maxlength="32" >
							<a href="javascript:void(0);" id="selectCheng" class="btn-xzs fl">选择溯源秤</a><span class="red">&nbsp;*</span>
						</td>
						<td>
	                    <label name="chengcodeLab" id="chengcodeLab" class="noico"></label>
	                    </td>
				  </tr>
				  <tr style="display:none">
						<td height="30" align="right">内部序号：</td>
						<td>
							<input maxlength="1" size="40" class="inp" type="text" id="serialnum" name="serialnum" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" title="区分同一商铺的不同智能溯源秤." value="1">
							<span style="color:red;">* 必须1位</span>						
						</td>
						<td>
	                    <label name="serialnumLab" id="serialnumLab" class="noico"></label>
	                    </td>
				  </tr>
		          <tr>
		            <td height="30"  align="right"> 发放原因：</td>
		            <td>
		            	<select name="reason" id="reason" class="w150">
							<option value="1">初次发放</option>
							<option value="2">维修</option>
							<option value="3">更换</option>
							<option value="4">回收</option>
				  		</select>
		            </td>
		            <td>
	                    
	                 </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">发放备注信息：</td>
                    <td >
                        <textarea class="inp" rows="4"  id="remark" name="remark"  cols="40" onblur="checkVal(this.name);"></textarea>
                    </td>
                    <td>
                     <label name="remarkLab" id="remarkLab" class="noico"></label>
                    </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">回收原IC卡：
                    </td>
                    <td>
                       <input id="recoverCheck" name="recoverCheck" type="checkbox" value="1" onclick="recoverDevice();"/>
                       <input id="recdeviceid" name="recdeviceid" type="hidden" value=""/>
                    </td>
		          </tr>
		           <tr id="recDeviceCodeTR" style="display:none">
		            <td height="30"  align="right">回收IC卡编号：</td>
                    <td >
                    	<input type="text"  size="25" class="inp fl" readonly="readonly" value="" id="recdevicecode" name="recdevicecode" style="background:#eeeeee;"><a href="javascript:void(0);" id="selectDevice" class="btn-xzs fl">选择设备</a><span class="red">&nbsp;*</span>
                    </td>
                    <td>
                     <label name="recdevicecodeLab" id="recdevicecodeLab" class="noico"></label>
                    </td>
		          </tr>
		          <tr id="recConfidTR" style="display:none">
		            <td height="30" align="right">回收IC卡规格：</td>
                    <td >
                    	<input type="text" size="25" class="inp" readonly="readonly" value="" id="recnormname" name="recnormname" style="background:#eeeeee;">
                    </td>
                    <td>
                     <label name="recnormnameLab" id="recnormnameLab" class="noico"></label>
                    </td>
		          </tr>
		          <tr id="recReasonTR" style="display:none">
		            <td height="30" align="right">回收原因：
                    </td>
                    <td>
                        <select name="recreason" id="recreason" class="w150">
							<option value="1">回收</option>
							<option value="2">维修</option>
							<option value="3">更换</option>
				  		</select>
                    </td>
		          </tr>
		          <tr id="recRemarkTR" style="display:none">
		            <td height="30" align="right">回收备注信息：
                    </td>
                    <td>
                         <textarea class="inp" rows="4"   id="recremark" name="recremark"  cols="40" onblur="checkVal(this.name);"></textarea>
                    </td>
                    <td>
                     <label name="recremarkLab" id="recremarkLab" class="noico"></label>
                    </td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="发放" class="sbt" onclick="saveDevice();" id="btnfinish"></cite>
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
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
				
		if(name=="devicecode"){			
		    if($("#devicecode") != undefined && $("#devicecode").val() == ""){
				checkerror(name);
				namelab.html("IC卡编号必须填写！");
				return false;
			}		
			if(checkChars($("#devicecode").val())){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
		    }
			if(!(/^[A-Z0-9]{1,32}$/.test($("#devicecode").val()))){
				checkerror(name);
				namelab.html("IC卡编号只能由数字、大写字母组成！");
				return false;
			}
	    	checksuccess(name);
	    	$("#devicecode").val($.trim($("#devicecode").val()));
		}
		if(name=="confid"){
			if($("#confid") != undefined && ($("#confid").val() == "" || $("#confid").val() == null )){				
				checkerror(name);
				namelab.html("未选择设备配置规格！");
				return false;
			}
	    	checksuccess(name);
		}
		if(name=="corpname"){
			if($("#corpname") != undefined && $("#corpname").val() == ""){
				checkerror(name);
				namelab.html("归属企业名称不能为空！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="cpccorp"){
			if($("#cpccorp") != undefined && $("#cpccorp").val() == ""){
				checkerror(name);
				namelab.html("归属企业CPC编码不能为空！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="chengcode"){
			if($("#chengcode") != undefined && $("#chengcode").val() == ""){
				checkerror(name);
				namelab.html("溯源秤编号不能为空！");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="remark"){
			if(checkArea($("#remark").val())){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false ;
		    }
			if(subTextarea("remark",100)){
				checkerror(name);
				namelab.html("输入内容不能超过100个字符！");
				return false ;
			}
			checksuccess(name);
		}	
		
		if(name=="recremark"){
			if(checkArea($("#recremark").val())){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
	    	}
	    	if(subTextarea("recremark",100)){
				checkerror(name);
				namelab.html("输入内容不能超过100个字符！");
				return false ;
			}
			checksuccess(name);
		}
		if($("#recoverCheck:checked").val()=="1"){	
			if(name=="recdevicecode"){
				if($("#recdevicecode") != undefined && $("#recdevicecode").val() == ""){
					checkerror(name);
					namelab.html("回收IC卡编号必须选择！");
					return false ;
				}
				checksuccess(name);
			}		
		}
			
		
		return true;
	}
	
	function checkDeviceCode(devicecode){
	    devicecode = $.trim(devicecode);
	    if(devicecode != null && devicecode != ''){
	        if(checkChars(devicecode)){
				checkerror("devicecode");
				$("#devicecodeLab").html("不要输入非法字符！");
				return false;
		    }
		    
		    if(!(/^[A-Z0-9]{1,32}$/.test(devicecode))){
				checkerror("devicecode");
				$("#devicecodeLab").html("设备编号只能由数字、大写字母组成！");
				return false;
			}
		    
		    $.ajax({
		    	url: "<%=basePath%>device!checkDeviceCode.shtml?devicetype=4&devicecode=" + devicecode,
		    	type: 'post',
		    	success: function(html){
		    		if(html != ""){
		    			checkerror("devicecode");
						$("#devicecodeLab").html(html);		
		    			document.getElementById("btnfinish").disabled=true;
		    		}else{
		    			document.getElementById("btnfinish").disabled=false;
		    		}
		  		}
			});
			checksuccess("devicecode");
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
		
		checksuccess("corpname");
		checksuccess("cpccorp");
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
		
		checksuccess("chengcorpname");
		checksuccess("chengcpccorp");
		
		$("#chengcorpname").focus();
		t1.close();
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
	
	function showinfo(){
		var flag=0;
		$("input").each(function(){
		    if(checkVal($(this).attr("name"))==false){
			    flag++;	   
			}
		});
		$("textarea").each(function(){
		    if(checkVal($(this).attr("name"))==false){
		    
			    flag++;	   
			}
		});
		return flag;
	}
	
	function saveDevice(){
	    
		if(showinfo()!=0){
			return;
		}
		$(".sbt").attr("disabled","disabled");
		
		var data = $("#cardtype").val()+"|"+$("#cpccorp").val()+"|"+$("#corpname").val()+"|"+$("#mobile").val()+"|"+$.trim($("#chengcode").val())+"|"+$.trim($("#marketname").val())+"|"+$("#serialnum").val()+"|";
		
		createObj();
		
		try{
		    var code = "";//保存读卡信息
		    var info = neowerPrinter.ReadRFID2(2); //参数为等待秒数
		    if(info == null || info == ""){
		    	var code = neowerPrinter.WriteRFID2(data,1);//初始化卡
		    }else{
		        var code = neowerPrinter.WriteRFID2(data,2);//重置卡
		    }
			
			if(code == ""){
			    $("#searchform").attr("action", "<%=basePath%>device!saveDevice_card.shtml");
				$("#searchform").submit();
			}else{
				$.dialog.tips(code,3,'alert.gif');
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
	       checkerror("confid");
			$("#confidLab").html("请先配置溯源秤规格!");	
			document.getElementById("btnfinish").disabled=true;
	    }
	    //checksuccess("confid");
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
	   if(!checkVal("cpccorp")){
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
		
		checksuccess("recdevicecode");
		checksuccess("recnormname");
		
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
		checksuccess("chengcode");
		t3.close();
	}
	
	function chengCardType(){
		$("#corpname").val("");
		$("#cpccorp").val("");
		$("#marketname").val("");
		$("#mobile").val("");
		$("#chengcorpname").val("");
		$("#chengcpccorp").val("");
		$("#chengcode").val("");
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
