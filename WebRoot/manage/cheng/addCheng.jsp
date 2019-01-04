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
			<div class="cur-pos">当前位置：市场管理 > 溯源秤管理</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤管理</div>
		</c:if>
		<form action="chengAction!saveCheng.shtml" method="post" id="searchform" name="searchform">
	    <div class="form-box">
    		<div class="fb-tit">溯源秤发放</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		           <tr >
		            <td height="30" width="170" align="right">溯源秤编号：</td>
		            <td width="290">
		            	<input type="text" class="inp" size="39" name="chengcode" id="chengcode" maxlength="8" value="${requestScope.cpccode }" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" onblur="checkVal(this.name);checkChengCode(this.value);" > <span class="red">*</span>
		            </td>
		            <td width="">
						<label name="chengcodeLab" id="chengcodeLab" class="noico"></label>
					</td>
		          </tr>
		          <tr>
		            <td height="30"  align="right"> 溯源秤类型：</td>
		            <td>
		            	<select name="type" id="type" class="w150" onchange="chengCardType();">
							<option value="1">案秤</option>
							<option value="2">台秤</option>
				  		</select>
		            </td>
		            <td></td>
		          </tr>
		          <tr>
		            <td height="30"  align="right"> 配置规格名称：</td>
		            <td >
		            	<select id="confid" name="confid">
							<c:forEach items="${requestScope.chengconfmap}" var="chengMap" varStatus="s">
						 		<option value="${chengMap.key}">${chengMap.value}</option>;
							</c:forEach>
						</select>
		            </td>
		            <td >
		            <label name="confidLab" id="confidLab" class="noico"></label>
		            </td>
		          </tr>
		          <tr>
		            <td height="30"  align="right">发放单位名称：</td>
                    <td >
                    	<input type="text"  size="25" class="inp fl" readonly="readonly" value="" id="corpname" name="corpname" style="background:#eeeeee;"><a href="javascript:void(0);" id="selectCpccorp" class="btn-xzs fl">选择单位</a><span class="red">&nbsp;*</span>
                    </td>
                    <td >
                    <label name="corpnameLab" id="corpnameLab" class="noico"></label>
                    </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位CPC编号：</td>
                    <td >
                    	<input type="text" size="25" class="inp" readonly="readonly" value="" id="cpccorp" name="cpccorp" style="background:#eeeeee;">
                    </td>
                    <td>
                    <label name="cpccorpLab" id="cpccorpLab" class="noico"></label>
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
		            <td></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">发放备注信息：</td>
                    <td >
                        <textarea class="inp" rows="4"   id="remark" name="remark"  cols="40" onblur="checkVal(this.name);" ></textarea>
                    </td>
                    <td>
                    <label name="remarkLab" id="remarkLab" class="noico"></label>
                    </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">回收原溯源秤：
                    </td>
                    <td>
                       <input id="recoverCheck" name="recoverCheck" type="checkbox" value="1" onclick="recoverDevice();"/>
                       <input id="recdeviceid" name="recdeviceid" type="hidden" value=""/>
                    </td>
		          </tr>
		           <tr id="recDeviceCodeTR" style="display:none">
		            <td height="30"  align="right">回收溯源秤编号：</td>
                    <td >
                    	<input type="text"  size="25" class="inp fl" readonly="readonly" value="" id="recdevicecode" name="recdevicecode" style="background:#eeeeee;"><a href="javascript:void(0);" id="selectDevice" class="btn-xzs fl">选择溯源秤</a><span class="red">&nbsp;*</span>
                    </td>
                    <td ><label name="recdevicecodeLab" id="recdevicecodeLab" class="noico"></label></td>
		          </tr>
		          <tr id="recConfidTR" style="display:none">
		            <td height="30" align="right">回收溯源秤规格：</td>
                    <td >
                    	<input type="text" size="25" class="inp" readonly="readonly" value="" id="recnormname" name="recnormname" style="background:#eeeeee;">
                    </td>
                    <td><label name="recnormnameLab" id="recnormnameLab" class="noico"></label></td>
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
		        <cite><input type="button" value="保存" class="sbt" onclick="saveCheng();" id="btnfinish"></cite>
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
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	}
	
	function check(ob){
		var pattern=/^[1-9]?\d*?\d*?$/;
		var result = pattern.exec(ob);
		return result==ob;
	} 
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
				
		if(name=="chengcode"){
			if($("#chengcode") != undefined && $("#chengcode").val() == ""){
				checkerror(name);
				namelab.html("溯源秤编号必须填写！");
				return;
			}
			if($("#chengcode").val() != undefined){
				if(!checkNumberChar($("#chengcode").val())){
					checkerror(name);
					namelab.html("溯源秤编号必须为数字！");
					return;
				}
			}
	    	checksuccess(name);
		}
		
		
		
		
		
		
		if(name=="confid"){			
			if($("#confid") != undefined && ($("#confid").val() == "" || $("#confid").val() == null )){
				checkerror(name);
				namelab.html("未选择溯源秤配置规格！");
				return false ;
			}
	    	checksuccess(name);
		}
		if(name=="corpname"){			
			if($("#corpname") != undefined && $("#corpname").val() == ""){
				checkerror(name);
				namelab.html("归属企业名称不能为空！");
				return false ;
			}
			checksuccess(name);
		}
		if(name=="cpccorp"){		
			if($("#cpccorp") != undefined && $("#cpccorp").val() == ""){
				checkerror(name);
				namelab.html("归属企业CPC编码不能为空！");
				return false ;
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
					namelab.html("回收溯源秤编号必须选择！");
					return false ;
				}
				checksuccess(name);
			}					
		}
		
		return true;
	}
	
	function checkChengCode(chengcode){
	    if(chengcode != null && chengcode != ''){
		    $.ajax({
		    	url: "<%=basePath%>cheng!checkChengCode.shtml?chengcode=" + chengcode,
		    	type: 'post',
		    	success: function(html){
		    		if(html != ""){
		    			checkerror("chengcode");
						$("#chengcodeLab").html(html);		
		    			document.getElementById("btnfinish").disabled=true;
		    		}else{
		    			document.getElementById("btnfinish").disabled=false;
		    		}
		  		}
			});
			checksuccess("chengcode");
		}
	}
	
	
   $("#selectCpccorp").click(function(){
    	queryCompany($("#type").val());
    	return false;
    });
    function queryCompany(type){
	    t2 = $.dialog({
			title:'选择单位名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>cheng!companyChoice.shtml?type="+type+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeDG(s){
		$("#corpname").val(s[1]);
		$("#cpccorp").val(s[2]);
		checksuccess("corpname");
		checksuccess("cpccorp");
		t2.close();
		$("#corpname").focus();
	}
	
	function checkNumberChar(ob){
		if(/^\d+$/.test(ob)){
			return true;
		}else{
			return false;
		}
	}
	
	function checkArea(str){
		return /[\·\'\"\~\`\@\#\^\&\*\|\{\}\[\]\+\=?\<\>\/\\]/.test(str);
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
	function saveCheng(){
		if(showinfo()!=0){
			return;
		}
		
		$("#searchform").attr("action", "<%=basePath%>cheng!saveCheng.shtml");
		$("#searchform").submit();
	}
	
	$(function(){
	    if($("#confid").val()==null){
			checkerror("confid");
			$("#confidLab").html("请先配置溯源秤规格!");							
			document.getElementById("btnfinish").disabled=true;
	    }
	    checksuccess("confid");
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
    	queryCheng($("#cpccorp").val());
    	return false;
    });
    
    function queryCheng(cpccorp){
	    t2 = $.dialog({
			title:'选择回收溯源秤',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>cheng!chengChoice.shtml?cpccorp="+cpccorp+"&ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeChengDG(s){
	    $("#recdeviceid").val(s[0]);
		$("#recdevicecode").val(s[1]);
		$("#recnormname").val(s[2]);
		checksuccess("recdevicecode");
		$("#recdevicecode").focus();
		t2.close();
		
	}
	
	
	function chengCardType(){
		$("#corpname").val("");
		$("#cpccorp").val("");
	}
</script>   
</body>
</html>
