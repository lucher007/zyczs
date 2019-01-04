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
		<div class="cur-pos">当前位置：设备管理 > 打印机修改</div>
		<form action="" method="post" id="searchform" name="searchform">
		<input type="hidden" name="deviceid" id="deviceid" value="${requestScope.device.deviceid }"/>
	    <div class="form-box">
    		<div class="fb-tit">打印机修改</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		           <tr >
		            <td height="30" width="170" align="right">打印机编号：</td>
		            <td width="290">
		            	<input type="text" class="inp" readonly="readonly" style="background:#eeeeee;" size="39" name="devicecode" id="devicecode" maxlength="32" value="${requestScope.device.devicecode }" > <span class="red">*</span>
		            </td>
		            <td width="280">
						<label name="devicecodeLab" id="devicecodeLab" class="noico"></label>
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
		            <td ></td>
		          </tr>
		          <tr>
		            <td height="30"  align="right">归属单位名称：</td>
                    <td >
                    	<input type="text"  size="25" class="inp fl" readonly="readonly" id="corpname" name="corpname" style="background:#eeeeee;" value="${requestScope.device.corpname}">
                    </td>
                    <td ></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位CPC编号：</td>
                    <td >
                    	<input type="text" size="25" class="inp" readonly="readonly" id="cpccorp" name="cpccorp" style="background:#eeeeee;" value="${requestScope.device.cpccorp}">
                    </td>
                    <td></td>
		          </tr>
		          <tr>
		            <td height="30"  align="right"> 发放原因：</td>
		            <td>
		            	<select name="reason" id="reason" class="w150">
							<option value="1" <c:if test="${requestScope.device.reason == 1 }">selected</c:if>>初次发放</option>
							<option value="2" <c:if test="${requestScope.device.reason == 2 }">selected</c:if>>维修</option>
							<option value="3" <c:if test="${requestScope.device.reason == 3 }">selected</c:if>>更换</option>
							<option value="4" <c:if test="${requestScope.device.reason == 4 }">selected</c:if>>回收</option>
				  		</select>
		            </td>
		            <td></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">打印机备注信息：</td>
                    <td >
                        <textarea class="inp" rows="4" onkeydown="textCounter(searchform.remark,100);" onkeyup="textCounter(searchform.remark,100);" onblur="checkRemark(this.value);" id="remark" name="remark"  cols="40">${requestScope.device.remark}</textarea>
                    </td>
                    <td></td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="保存" class="sbt" onclick="updateDevice();" id="btnfinish"></cite>
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
	    if(devicecode != null && devicecode != ''){
	        if(checkChars(devicecode)){
				$("#devicecode").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
		    }
		    
		    $.ajax({
		    	url: "<%=basePath%>device!checkDeviceCode.shtml?devicetype=1&devicecode=" + devicecode,
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
    	queryCompany();
    	return false;
    });
    
    function queryCompany(){
	    t2 = $.dialog({
			title:'选择单位名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>device!companyChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeDG(s){
		$("#corpname").val(s[1]);
		$("#cpccorp").val(s[2]);
		t2.close();
	}
	
	function checkNumberChar(ob){
		if(/^\d+$/.test(ob)){
			return true;
		}else{
			return false;
		}
	}
	
	function updateDevice(){
	    $("#devicecode").val($.trim($("#devicecode").val()));
		if($("#devicecode") != undefined && $("#devicecode").val() == ""){
			$.dialog.tips("设备编号必须填写！",1,'alert.gif');
			$("#devicecode").focus();
			return false;
		}
		
		if(checkChars($("#devicecode").val())){
			$("#devicecode").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
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
		
		if(checkArea($("#remark").val())){
			$("#remark").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
	    }
		
		$("#searchform").attr("action", "<%=basePath%>device!updateDevice_printer.shtml");
		$("#searchform").submit();
	}
	
	$(function(){
	    if($("#confid").val()==null){
	        $.dialog.tips("请先配置设备规格！",1,'alert.gif');
			$("#confid").focus();
			document.getElementById("btnfinish").disabled=true;
	    }
	})
	
</script>   
</body>
</html>
