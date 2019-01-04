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
			<div class="cur-pos">当前位置：市场管理 > 打印机</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：设备管理 > 打印机</div>
		</c:if>
		<form action="" method="post" id="searchform" name="searchform">
		<input type="hidden" name="deviceid" id="deviceid" value="${requestScope.device.deviceid }"/>
	    <div class="form-box">
    		<div class="fb-tit">打印机回收</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		           <tr >
		            <td height="30" width="170" align="right">打印机编号：</td>
		            <td width="290">
		            	<input type="text" class="inp" readonly="readonly" style="background:#eeeeee;" size="39" name="devicecode" id="devicecode" maxlength="32" value="${requestScope.device.devicecode }" > 
		            </td>
		            <td width="">
						<label name="devicecodeLab" id="devicecodeLab" class="noico"></label>
					</td>
		          </tr>
		          <tr>
		            <td height="30"  align="right"> 配置规格名称：</td>
		            <td >
		            	<input type="text" class="inp" readonly="readonly" style="background:#eeeeee;" size="39" name="devicecode" id="devicecode" maxlength="32" value="${requestScope.device.normname }" >
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
		            <td height="30"  align="right"> 回收原因：</td>
		            <td>
		            	<select name="reason" id="reason" class="w150">
							<option value="1">回收</option>
							<option value="2">维修</option>
							<option value="3">更换</option>
				  		</select>
		            </td>
		            <td></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">回收备注信息：</td>
                    <td >
                        <textarea class="inp" rows="4"    id="remark" name="remark"  cols="40" onblur="checkVal(this.name);"></textarea>
                    </td>
                    <td>
                    <label name="remarkLab" id="remarkLab" class="noico"></label>
                    </td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="回收" class="sbt" onclick="recoverDevice();" id="btnfinish"></cite>
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
		if(name=="remark"){
			if(checkChars($("#remark").val())){
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
	
	function recoverDevice(){
		if(checkVal("remark")==false){
			return false;
	    }		
		$("#searchform").attr("action", "<%=basePath%>device!recoverDevice_printer.shtml");
		$("#searchform").submit();
	}
</script>   
</body>
</html>
