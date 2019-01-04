<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String code ="COM1";
	if(request.getParameter("code")!=null){
		code=request.getParameter("code");
		request.getSession().setAttribute("code",code);
	}
	if(request.getSession().getAttribute("code")!=null){
		code =(String) request.getSession().getAttribute("code");
	}
	
	String mac = request.getParameter("mac");
	request.setAttribute("mac",mac);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>中药溯源信息平台</title>
<base href="<%=basePath %>" />
<style>
html, body {
	margin:0;
	padding:0;
	font-size:12px;
	height:1024px;
	overflow:hidden;
	background:#ffffff;
	}
.container{
	margin:0 auto;
	width:768px;
	height:1024px;
	margin-top:-10px;
	background:#ffffff;
}
a {
color:#000000;
text-decoration: none;		
}		
a:visited {
color:#000000;
text-decoration: none;
}
a:hover {
color:#000000;
text-decoration: none;
}

*{margin:0px;padding:0px}
.pop-box {
	z-index: 9999;
	margin-bottom:2px;
	display:none;
	position:absolute;
	background:#ffffff;
	border:solid 3px #96b3c3;
}

.pop-box-body{
	clear:both;
	margin:2px;
	padding:1px;
}
.closetable td input{
	width:40px;
	height:20px;
	border:1px solid #555555;
	background:#ffffff;
}
</style>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/ajaxobj.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/easyDrag/jquery.easydrag.js"></script>
<script type="text/javascript">
	function document.oncontextmenu(){event.returnValue=false;}
	var timenum=2;
	var timeid;
	function downTime(){		
		timenum--;		
		if(timenum<0){						
			clearInterval(timeid);
			closeInfo();
			timenum=2;
		}		
	}
	function downTimeStart(){
		timeid=setInterval("downTime()", 1000);
	}	
	//downTimeStart();


	
	var timenum2=10;
	var timeid2;
	function downTime2(){		
		timenum2--;		
		if(timenum2<0){						
			clearInterval(timeid2);
			closeDiv('pop-div');
			timenum2=10;
		}		
	}
	function downTimeStart2(){
		timeid2=setInterval("downTime2()", 1000);
	}	
	//downTimeStart2();

	
	/*剩余<span style="text-align:center;border:0px solid red;width:30px;display:inline-block;color:red;font:bold 25px arial;" id="timespan">10</span>秒*/
	
	//按钮状态开始
	function changeNumBt1(obj){		
		obj.style.background="#F3F3F3";		
	}
	function changeNumBt2(obj){		
		obj.style.background="none";		
	}
	function changeClearBt1(obj){
		obj.style.background="#F3F3F3 url('<%=basePath %>search/images1/child7.png') no-repeat center";	
	}
	function changeClearBt2(obj){
		obj.style.background="#FFFFFF url('<%=basePath %>search/images1/child7.png') no-repeat center";	
	}
	function changeBackBt1(obj){
		obj.style.background="#F3F3F3 url('<%=basePath %>search/images1/child9.png') no-repeat center";
	}
	function changeBackBt2(obj){
		obj.style.background="#FFFFFF url('<%=basePath %>search/images1/child9.png') no-repeat center";
	}
	function changeEnsureBt1(obj){
		obj.style.background="#F3F3F3 url('<%=basePath %>search/images1/child8.png') no-repeat center";
	}
	function changeEnsureBt2(obj){
		obj.style.background="#FFFFFF url('<%=basePath %>search/images1/child8.png') no-repeat center";
	}

	function changeRfidBt(obj){
		var objstyle = obj.style.backgroundImage; 
		objstyle = objstyle.substring(11,objstyle.length-5);
		if(objstyle=="searchcoderfid1"){
			obj.style.backgroundImage="url(images/searchcoderfid2.png)";
		}else if(objstyle=="searchcoderfid2"){
			obj.style.backgroundImage="url(images/searchcoderfid1.png)";
		}	
	}

	function changeTwoBt(obj){
		var objstyle = obj.style.backgroundImage; 
		objstyle = objstyle.substring(11,objstyle.length-5);
		if(objstyle=="searchcodetwo1"){
			obj.style.backgroundImage="url(images/searchcodetwo2.png)";
		}else if(objstyle=="searchcodetwo2"){
			obj.style.backgroundImage="url(images/searchcodetwo1.png)";
		}
	}
	//按钮状态结束
	
	var pos=0
	function getPosition(obj){ 
		var result = 0; 
		if(obj.selectionStart){ //IE以外 
			result = obj.selectionStart 
		}else{ //IE 
			var rng; 
			if(obj.tagName == "textarea"){ //TEXTAREA 
				rng = event.srcElement.createTextRange(); 
				rng.moveToPoint(event.x,event.y); 
			}else{ //Text 
				rng = document.selection.createRange(); 
			} 
			rng.moveStart("character",-obj.value.length); 
			result = rng.text.length; 
		} 
		return result; 
	} 
	
	function getValue(obj) {
		if(obj.value=="请输入溯源码查询"){
			obj.value=="";
			return false;
		}
		pos = getPosition(obj);
		//alert("--->"+pos);
	}
	function chanageContent(obj,type){
		if(type==1){
			if(obj.value=="请输入溯源码查询"){
				obj.value="";
			}else{
				getValue(obj);
			}
		}else if(type==2){
			if(obj.value==""){
				obj.value="请输入溯源码查询"
			}
		}
	}
	function inputBySourceCode(num){
		//alert(pos);
		
		var sourcecode = document.getElementById("sourcecode");
		
		
		if(sourcecode.value=="请输入溯源码查询"){
			sourcecode.value="";
		}
		if(sourcecode.value.length>35){
			return false;
		}
		var txt = sourcecode.value;
		/*if(pos>0){						
			txt = txt.substr(0, pos)+num+ txt.substr(pos, txt.length);
			pos++;
			sourcecode.value=txt;
		}else if(pos==0){							
			txt = txt.substr(0, pos)+num+ txt.substr(pos, txt.length);
			pos++;
			//pos=sourcecode.value.length;
		}*/


		txt = txt.substr(0, pos)+num+ txt.substr(pos, txt.length);
		pos++;
		sourcecode.value=txt;

		
		var rtextRange =sourcecode.createTextRange(); 
		rtextRange.move('character',pos);
		rtextRange.collapse(true); 
		rtextRange.select(); 
		
	}	
	function clearBySourceCode(){		
		var sourcecode = document.getElementById("sourcecode");
		sourcecode.value="请输入溯源码查询"
		pos=0;
	}
	function backBySourceCode(){
		var sourcecode = document.getElementById("sourcecode");		
		if(sourcecode.value=="请输入溯源码查询"||sourcecode.value==""){			
			return false;
		}
		var txt = sourcecode.value
		//alert("pos--->"+pos);
		if(pos>0){
			txt = txt.substr(0, pos - 1) + txt.substr(pos, txt.length);
			pos--;
			sourcecode.value=txt;
		}
		/*else if(pos==0){
			txt = txt.substr(0, txt.length-1)
			sourcecode.value=txt;	
			//pos=sourcecode.value.length;			
		}*/
		var rtextRange =sourcecode.createTextRange(); 
		rtextRange.moveStart('character',pos);
		rtextRange.collapse(true); 
		rtextRange.select(); 
		
	}
	window.onload=function(){
		document.getElementById("sourcecode").focus()
	}

	//弹出
	function showInfo(inputHtml){
		document.getElementById("sourcecode").value="";
		var shield = document.createElement("DIV");
		shield.id = "shield";
    	shield.style.position = "fixed";
    	shield.style.left = "0px";
    	shield.style.top = "0px";
    	shield.style.width = "100%";
    	shield.style.height = "100%";
    	shield.style.background = "#000000";
    	shield.style.textAlign = "center";
    	shield.style.zIndex = "9999";
    	shield.style.filter = "alpha(opacity=0)";
    			
    	var alertFram = document.createElement("DIV");
    	alertFram.id="alertFram";
    	alertFram.style.position = "absolute";
		alertFram.style.right = "50%";
		alertFram.style.bottom = "50%";
		alertFram.style.marginRight = "-275px";
		alertFram.style.marginBottom = "-125px";			    
		alertFram.style.width = "570px";
		alertFram.style.height = "88px";
		alertFram.style.lineHeight = "88px";
		alertFram.style.zIndex = "10002";		
		strHtml = "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"570\" height=\"88\" style=\"background:#000000;color:#ffffff;\"><tr>"
		strHtml += "<td width=\"570\" height=\"88\" style=\"padding-left:100px;background:url(<%=basePath %>search/images1/child10.png) no-repeat 50px 30px;font:bold 25px '微软雅黑'\" id=\"inputinfo\">正在扫描，请稍后 ...</td>" 		
		strHtml += "</tr></table>"
		alertFram.innerHTML=strHtml;
	    document.body.appendChild(alertFram);
		document.body.appendChild(shield);	
		var c = 0;
	    	this.doAlpha = function(){
		    	c+=10;
	        	if (c > 70){
		        	clearInterval(ad);
		        	if(inputHtml=="二维码"){			        		        	
		        		ReadQR();
		        	}
		        	return 0;
		        }
	        	shield.style.filter = "alpha(opacity="+c+");";
	    	}
		var ad = setInterval("doAlpha()",3);
	}

	//取消警告
	function closeInfo(){	
		if(document.getElementById("shield")!=undefined){	
			var shield = document.getElementById("shield");		
			shield.id = "";
	    	shield.style.position = "";
	    	shield.style.left = "";
	    	shield.style.top = "";
	    	shield.style.width = "";
	    	shield.style.height = "";
	    	shield.style.background = "";
	    	shield.style.textAlign = "";
	    	shield.style.zIndex = "";
	    	shield.style.filter = "";
			var alertFram = document.getElementById("alertFram");
			alertFram.id="";
		    alertFram.style.position = "";
			alertFram.style.right = "";
			alertFram.style.bottom = "";
			alertFram.style.marginRight = "";
			alertFram.style.marginBottom = "";			    
			alertFram.style.width = "";
			alertFram.style.height = "";
			alertFram.style.background = "";
			alertFram.style.textAlign = "";
			alertFram.style.lineHeight = "";
			alertFram.style.zIndex = "";
			alertFram.innerHTML ="";
			clearInterval(timeid);	
			timenum=5;
			timenum1=30;
		}
	}

	
		
	function findBySourceCode(){
		var sourcecode= document.getElementById("sourcecode");
		if(sourcecode.value==""||sourcecode.value=="请输入溯源码查询"){
			return false;
		}
		if(isNaN(sourcecode.value)){
			return false;
		}
		if(sourcecode.value.length>35){
			return false;
		}
		document.searchform.action="search!findBySourceCode.shtml";
		document.searchform.submit();
	}


	function ReadQR(){ 
      var k1 = neowerQR.GetCameraData();
      if(k1 == null || k1 == ""){
			var inputinfo= document.getElementById("inputinfo");
			inputinfo.innerHTML="二维码设备错误，请重试！"
			downTimeStart();
      }else{
      		closeInfo();
	      	var sourcecode = k1.substring(10,k1.length);
	      	document.getElementById("sourcecode").value = sourcecode;
	      	if(sourcecode==""||sourcecode=="请输入溯源码查询"){
				return false;
			}
			if(isNaN(sourcecode)){
				return false;
			}
			if(sourcecode.length>35){
				return false;
			}
			document.searchform.action="search!findBySourceCode.shtml";
			document.searchform.submit();
      }
	  
    }

	function goback(){
		window.location.href="searchcode.jsp"
	}
	
	function gohome(){
		window.location.href="<%=basePath %>search/search.jsp?mac="+$("#mac").val();
	}

	
	
	function closeWin(){
		closePass = "";
		$("#closePassword").val(closePass);
		div_id="pop-div";
		var div_obj=$("#"+div_id);
		var windowWidth=document.documentElement.clientWidth;
		var windowHeight=document.documentElement.clientHeight;
		var popupHeight=div_obj.height();
		var popupWidth=div_obj.width();
		$("#mask").addClass("mask").click(function(){
			hideDiv(div_id);
		}).appendTo("body").fadeIn(200);
		div_obj.css({"position":"absolute"})
		.animate({left:200,top:800,opacity:"show"},"show");
		timenum2=10;
		downTimeStart2();
	}
	
	function makeSure(){
		if("8608"== closePass.substring(closePass.length-4,closePass.length)){
			window.close();
		}
	}
	
	function closeDiv(div_id){
		closePass = "";
		$("#closePassword").val(closePass);
		$("#mask").remove();
		$("#"+div_id).animate({left:0,top:0,opacity:"hide"},"slow");
	}
	
	function clearPass(){
		closePass = "";
		$("#closePassword").val(closePass);
	}
	
	//只能输入数字
	function onkeyupNum(obj){
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined')
			obj.value='';	
	}
</script>

</head>

<body>
<!-- <object classid="CLSID:D260E7A7-DEB9-4F12-ACC8-A884ADD97789" ID="ActiveXDown"  CODEBASE="LpDecode.ocx#version=1,0,0,0"  width=0 height=0></object> -->
<object classid="clsid:10FC882A-21CD-4159-A04A-4E1B523F3B7A" name="neowerQR" id="neowerQR" width="0" height="0"></object>
<div class="container">	
	<form action="" method="post" name="searchform" id="searchform">	
	<input type="hidden" id="area" name="area"/>	
	<input type="hidden" id="mac" name="mac" value="${mac }"/>
	<table cellpadding="0" cellspacing="0" border="0" width="768" height="1024" >
		<tr><td width="768" height="94" style="background:url('<%=basePath %>search/images1/child1.png') no-repeat;">&nbsp;</td></tr>
		<tr><td width="768" height="123" style="background:url('<%=basePath %>search/images1/child2.png') no-repeat;">&nbsp;</td></tr>
		<tr><td width="768" height="50">&nbsp;</td></tr>
		<tr>
			<td width="768" height="452">
				<table cellpadding="0" cellspacing="" border="0" width="768" height="75">
					<tr>
						<td width="100" style="font:bold 30px arial;">溯源码</td>
						<td style="border:2px solid #22baf2;">
							 <input type="text" name="sourcecode" id="sourcecode" value="请输入溯源码查询" onmouseup="return chanageContent(this,1);" onblur="return chanageContent(this,2);" style="font:bold 29px arial;color:#4493cc;width:590px;height:35px;border:0;" maxlength="35" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);"/>
						</td>
						<td width="80" valign="middle">
							<input type="button" style="width:70px;height:55px;background:#ffffff url('<%=basePath %>search/images1/child9.png') no-repeat center;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" onmousedown="return changeBackBt1(this);" onmouseup="return changeBackBt2(this);" onmouseout="return changeBackBt2(this);" onclick="return backBySourceCode();" />
						</td>
					</tr>
				</table>
				<br /><br /><br />
				<table cellpadding="0" cellspacing="" border="0" width="768" height="452">
					<tr>
						<td width="319" style="background:url('<%=basePath %>search/images1/child3.png') no-repeat;"></td>
						<td></td>
						<td width="427" height="452" valign="top">
							<table cellpadding="0" cellspacing="" border="0" width="427" height="375" style="background:url('<%=basePath %>search/images1/child4.png') no-repeat 0px -1px;"> 
								<tr>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="1" id="1" name="1" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(1);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="2" id="2" name="2" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(2);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="3" id="3" name="3" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(3);" /></td>
								</tr>
								<tr>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="4" id="4" name="4" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(4);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="5" id="5" name="5" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(5);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="6" id="6" name="6" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(6);" /></td>
								</tr>
								<tr>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="7" id="7" name="7" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(7);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="8" id="8" name="8" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(8);" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="9" id="9" name="9" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(9);" /></td>
								</tr>
								<tr>
									<td width="142" align="right" valign="top"><input type="button" style="width:138px;height:86px;background:#ffffff url('<%=basePath %>search/images1/child7.png') no-repeat center;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" onmousedown="return changeClearBt1(this);" onmouseup="return changeClearBt2(this);" onmouseout="return changeClearBt2(this);" onclick="return clearBySourceCode();" /></td>
									<td width="142"><input type="button" style="width:142px;height:92px;background:none;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" value="0" id="0" name="0" onmousedown="return changeNumBt1(this);" onmouseup="return changeNumBt2(this);" onmouseout="return changeNumBt2(this);" onclick="return inputBySourceCode(0);" /></td>
									<td width="142" align="left" valign="top"><input type="button" style="width:138px;height:86px;background:#ffffff url('<%=basePath %>search/images1/child8.png') no-repeat center;border:0px solid red;font:bold 25px arial;color:#01B0F0;cursor:hand;" onmousedown="return changeEnsureBt1(this);" onmouseup="return changeEnsureBt2(this);" onmouseout="return changeEnsureBt2(this);" onclick="return findBySourceCode();" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>			
			</td>
		</tr>
		<tr><td width="768" height="30">&nbsp;</td></tr>
		<tr>
			<td width="768" height="71">
				<table cellpadding="0" cellspacing="0" border="0" width="768" height="71" bgcolor="#FFFFFF">
					<tr>
						<td width="204" style="background:url('<%=basePath %>search/images1/orgchild6.png') no-repeat;cursor:hand;" height="71" onclick="gohome();"></td>
						<td width="204"></td>
						<td></td>
						<td width="204" style="background:url('<%=basePath %>search/images1/child5.png') no-repeat;cursor:hand;" height="71" onclick="showInfo('二维码');"></td>
					</tr>
				</table>			
			</td>
		</tr>
		<tr><td width="768" height="50">&nbsp;</td></tr>
	</table>
	
	</form>
	
<div class="pop-box" style="width:260px;" id="pop-div">
			<div  id="divTitle"
				style="width: 400px ;">
				<table width="100%">
					<tr>
						<td>
							<input type="text" id="closePassword" maxlength="8" style="border:1px solid #555555;width:180px;height:20px;" />
							<input type="button"  onclick="closeDiv('pop-div')" value="关闭窗口"/>
						</td>
					</tr>
				</table>
				</div>
				<div>
				<table width="100%" class="closetable">
					<tr>
						<td>
							<input type="button" id="btn0" name="btn0" value="0"/>
						</td>
						<td>
							<input type="button" id="btn1" name="btn1"  value="1"/>
						</td>
						<td>
							<input type="button" id="btn2" name="btn2"  value="2"/>
						</td>
						<td>
							<input type="button" id="btn3" name="btn3"  value="3"/>
						</td>
						<td>
							<input type="button" id="btn4" name="btn4"  value="4"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" id="btn5"  name="btn5" value="5"/>
						</td>
						<td>
							<input type="button" id="btn6"  name="btn6" value="6"/>
						</td>
						<td>
							<input type="button" id="btn7"  name="btn7" value="7"/>
						</td>
						<td>
							<input type="button" id="btn8"  name="btn8" value="8"/>
						</td>
						<td>
							<input type="button" id="btn9"  name="btn9" value="9"/>
						</td>
					</tr>
					<tr>
						<td align="right" colspan="5" style="position:relative;right:10px;">
							<input type="button" value="清空" onclick="clearPass()">
							<input type="button" value="确定" onclick="makeSure()">
						</td>
					</tr>
				</table>
			</div>
		</div>
</div>
</body>
</html>

