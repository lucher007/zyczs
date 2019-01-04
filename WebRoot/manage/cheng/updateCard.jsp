<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>发卡</title>
		<link type="text/css" rel="stylesheet" href="/style/market.css">
	</head>

	<body>
		<div id="body">
			<div class="cur-pos">
				当前位置：溯源秤管理 &gt; 溯源秤发卡 
			</div>
			<div class="form-box">
				<div class="fb-tit">经营户发卡</div>
					<div class="fb-con">
						<!-- <table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td height="30" align="right">市场商铺溯源秤：</td>
								<td>
									<input size="40" class="inp" type="text" id="scalesnum" maxlength="8" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
									<span style="color:red;">* 必须8位数字</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">企业代码：</td>
								<td><input size="40" class="inp" type="text" readonly="readonly" id="cpccorp" value="<%=request.getParameter("cpccorp") %>"></td>
							</tr>
							<tr>
								<td height="30" align="right">商品企业码：</td>
								<td>
									<input size="40" class="inp" type="text" id="comnum" maxlength="10" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
									<span style="color:red;">* 必须10位数字</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">溯源秤设备代码：</td>
								<td>
									<input size="40" class="inp" type="text" id="scalesdevicenum" maxlength="32" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
									<span style="color:red;">* 必须32位数字</span>						
								</td>
							</tr>
							<tr>
								<td height="30" align="right">企业名称：</td>
								<td>
									<input size="40" class="inp" type="text" id="comname" maxlength="24">
									<span style="color:red;">不能大于24位, 非必填</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">市场名称：</td>
								<td>
									<input size="40" class="inp" type="text" id="marketname" maxlength="24">
									<span style="color:red;">不能大于24位, 非必填</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">内部序号：</td>
								<td>
									<input maxlength="1" size="40" class="inp" type="text" id="serialnum" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
									<span style="color:red;">* 必须1位数字</span>						
								</td>
							</tr>
						</table> -->
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td height="30" align="right">卡类型：</td>
								<td>
									<select id="cardType" style="width: 275px">
										<option value="10000000">种植基地台秤</option>
										<option value="00001000">市场商铺智能溯源秤</option>
									</select>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">单位名称：</td>
								<td>
								    <input size="40" class="inp fl" type="text" readonly="readonly" value="" id="corpname" name="corpname" maxlength="24" style="background:#eeeeee;">
							        <a href="javascript:void(0);" id="selectCpccorp" class="btn-xzs fl">选择单位</a><span class="red">&nbsp;*</span>
							    </td>
							</tr>
							<tr>
								<td height="30" align="right">单位CPC编码：</td>
								<td>
									<input size="40" class="inp"  type="text" readonly="readonly"  id="cpccorp" name="cpccorp" style="background:#eeeeee;" value="">
								</td>
							</tr>
							<tr>
								<td height="30" align="right">市场名称：</td>
								<td>
									<input size="40" class="inp" type="text" id="marketname" maxlength="24">
									<span style="color:red;">不能大于24位, 非必填</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">联系电话：</td>
								<td>
									<input size="40" class="inp" type="text" id="phone" maxlength="30" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);">
									<span style="color:red;">不能大于30位, 非必填</span>						
								</td>
							</tr>
							<tr>
								<td height="30" align="right">溯源秤编号：</td>
								<td>
									<input size="40" class="inp" type="text" readonly="readonly" id="scalesdevicenum" maxlength="32" style="background:#eeeeee;" value="<%=request.getParameter("chengcode") %>">
									<span style="color:red;">* 必须32位</span>
								</td>
							</tr>
							<tr>
								<td height="30" align="right">内部序号：</td>
								<td>
									<input maxlength="1" size="40" class="inp" type="text" id="serialnum" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" title="区分同一商铺的不同智能溯源秤.">
									<span style="color:red;">* 必须1位</span>						
								</td>
							</tr>
						</table>
					</div>
					<div class="fb-bom">
						<cite><input type="button" value="更新卡" class="sbt" onclick="return updateCard();"></cite>
<!--						<cite><input type="button" value="发卡" class="sbt" onclick="return sendCard();"></cite>-->
					</div>
				
			</div>
		</div>
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
		<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
		<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
		<script type="text/javascript">
			function onkeypressCheck(obj){
				if (!obj.value.match(/^[1-9]-?\d*?\d*?$/)) {
					obj.value = obj.t_value;
				} else {
					obj.t_value = obj.value;
				}
				if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
					obj.o_value = obj.value;
				}
				if(obj.value == 'undefined'){
				    obj.value='';
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
			
			<%
				String cpccorp = request.getParameter("cpccorp");
				String orgid = request.getParameter("orgid");
				
				pageContext.setAttribute("cpccorp",cpccorp);
				pageContext.setAttribute("orgid",orgid);
			%>
			
			function createObj(){
				if($("#neowerPrinter").length<=0){
					$("body").append('<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>');
				}
			}
			function sendCard(){
				$(".sbt").attr("disabled","disabled");
			
				if(!checkInput()){
					return false;
				}
				
				var data = $("#cardType").val()+"|"+$("#cpccorp").val()+"|"+$("#corpname").val()+"|"+$.trim($("#phone").val())+"|"+$.trim($("#scalesdevicenum").val())+"|"+$.trim($("#marketname").val())+"|"+$.trim($("#serialnum").val())+"|";
				createObj();
				try{
					var code = neowerPrinter.WriteRFID2(data,1);
					if(code == ""){
						$.dialog.tips('发卡成功！',3,'alert.gif');
					}else{
						$.dialog.tips('发卡失败！',3,'alert.gif');
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
			
			function updateCard(){
				$(".sbt").attr("disabled","disabled");
				
				if(!checkInput()){
					return false;
				}
				
				var data = $("#cardType").val()+"|"+$("#cpccorp").val()+"|"+$("#corpname").val()+"|"+$.trim($("#phone").val())+"|"+$.trim($("#scalesdevicenum").val())+"|"+$.trim($("#marketname").val())+"|"+$.trim($("#serialnum").val())+"|";
				createObj();
				try{
					var code = neowerPrinter.WriteRFID2(data,2);
					if(code == ""){
						$.dialog.tips('更新卡成功！',3,'alert.gif');
					}else{
						$.dialog.tips('更新卡失败！',3,'alert.gif');
						$(".sbt").removeAttr("disabled");
					}
				}catch(e){
					var str="";
					str+="<div>您尚未安装读卡器控件，请根据系统情况下载相应控件!<br />请安装后重新登录平台!</div><br />";
					str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载32位控件' onclick='printData_downControl(32);' />  ";
					str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载64位控件' onclick='printData_downControl(64);' />  ";
					
	
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
			
			function printData_downControl(num){
				if(num==32){
					window.location.href="js/setup32.exe"
				}else{
					window.location.href="js/setup64.exe"
				}
			}
			
			function checkInput(){
				var scalesdevicenum = $("#scalesdevicenum").val();
				if(scalesdevicenum.length != 32){
					$.dialog.tips('溯源秤设备代码必须32位！',3,'alert.gif');
					$(".sbt").removeAttr("disabled");
					return false;
				}
				var serialnum = $("#serialnum").val();
				if(serialnum.length != 1){
					$.dialog.tips('内部序号必须1位！',3,'alert.gif');
					$(".sbt").removeAttr("disabled");
					return false;
				}
				return true;
			}
			
    $("#selectCpccorp").click(function(){
    	queryCompany();
    	return false;
    });
    function queryCompany(){
	    t2 = $.dialog({
			title:'选择企业名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>cheng!companyChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		 });
	   	
	}
		
	function closeDG(s){
		$("#corpname").val(s[1]);
		$("#cpccorp").val(s[2]);
		$("#marketname").val(s[3]);
		t2.close();
	}
		</script>
	</body>
</html>