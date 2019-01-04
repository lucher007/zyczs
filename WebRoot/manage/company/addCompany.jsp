<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：备案管理 > 新建备案企业</div>
		<form action="company!save.shtml" id="dataForm" name="dataForm" method="post">
		<s:token></s:token>
		<input type="hidden" name="zyctype" id="zyctype">
		<input type="hidden" name="uploadType" id="uploadType"/>
		<input type="hidden" name="uploadids" id="uploadids" value="${uploadids }"/>
		<input type="hidden" name="corp" id="corp">
		<input type="hidden" name="ishospital" id="ishospital">
		<s:token id="tokenid" name="tokenid"></s:token>
		<div class="form-box">
	    	<div class="fb-tit">新建备案企业</div>
			<div id="content1" style="display:block">
			    <div class="reg-box mt10">
			        <table width="100%" border="0" cellpadding="0" cellspacing="0">
			          <tr>
			            <td width="200" height="30" align="right">企业名称<img class="comimg" src="images/warning.png" alt="注册后不能修改" title="注册后不能修改">：</td>
			            <td width="190">
			            	<input type="text" class="inp" name="corpname" id="corpname" maxlength="50" onblur="checkVal(this.name);"> <span class="red">*</span>
			            </td>
			            <td colspan="3" width="356"><label name="corpnameLab" id="corpnameLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">企业简称：</td>
			            <td>
				            <input type="text" class="inp" name="corpshortname" id="corpshortname" maxlength="50" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="corpshortnameLab" id="corpshortnameLab" class="noico"></label>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">营业执照号：</td>
			            <td>
				            <input type="text" class="inp" name="businesscode" id="businesscode" maxlength="100" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="businesscodeLab" id="businesscodeLab" class="noico"></label>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">营业执照：</td>
			            <td colspan="4" id="businesscodediv">
				            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(1);">上传营业执照</a>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">组织机构代码：</td>
			            <td><input type="text" class="inp" name="orgcode" id="orgcode" maxlength="100" onblur="checkVal(this.name);"> </td>
			            <td colspan="3"><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
			          </tr>
			          <tr>
			            <td height="30" align="right">组织机构代码证：</td>
			         	 <td colspan="4" id="orgcodediv">
				            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(2);">上传组织机构代码证</a>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">其他证书证明：</td>
			            <td colspan="4" id="otherdiv">
				            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(3);">上传其他证书</a>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">法人：</td>
			            <td>
			            	<input type="text" class="inp" name="masterman" id="masterman" maxlength="10" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
			          </tr>
			          
                      <tr>
			          	<td height="30" align="right">法人身份证：</td>
			          	<td><input type="text" class="inp" name="identitycard" id="identitycard" maxlength="18" onblur="checkVal(this.name);"> <span class="red">*</span></td>
			          	<td colspan="3"><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
                      </tr>
                      
                      <tr>
			            <td height="30" align="right">联系人：</td>
                        <td><input type="text" class="inp" name="linkman" id="linkman" maxlength="10" onblur="checkVal(this.name);"> </td>
                        <td colspan="3"><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">移动电话：</td>
			            <td>
			            	<input type="text" class="inp" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="mobileLab" id="mobileLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">固定电话：</td>
			            <td>
			            	<input type="text" class="inp" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">传真：</td>
			            <td>
			            	<input type="text" class="inp" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
			            <td colspan="3"><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
			          </tr>
			          
			          
			          <tr>
			            <td height="30" align="right">电子邮箱：</td>
			            <td>
			            	<input type="text" class="inp" name="email" id="email" maxlength="30" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
						<td colspan="3"><label name="emailLab" id="emailLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right" title="注册后不能修改">所属区域：</td>
			            <td colspan="4">
			            	<select name="province" id="province"  style="width:135px;"  v="${initParam.province }"></select>
							<select name="city" id="city"></select>
							<select name="area" id="area"></select>
			            	<span class="red">*</span>
			           	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">邮编：</td>
			            <td>
			            	<input type="text" class="inp" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> 
			            </td>
			            <td colspan="3"><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
                      </tr>
                      
			          <tr>
						<td height="30" align="right">经营地址：</td>
						<td>
			            	<input type="text" class="inp" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);"> <span class="red">*</span>
						</td>
						<td colspan="3"><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
			          </tr>
			          <tr>
						<td height="30" align="right">经度：</td>
						<td>
			            	<input type="text" class="inp" name="longitude" id="longitude" maxlength="6" readonly>
						</td>
						<td colspan="3"></td>
			          </tr>
			          <tr>
						<td height="30" align="right">纬度：</td>
						<td>
			            	<input type="text" class="inp" name="latitude" id="latitude" maxlength="6" readonly>
						</td>
						<td colspan="3"><input type="button" value="选取经纬度" class="sbt" id="lonlat" onclick="openMap()"></td>
			          </tr>
			          <tr>
			          	<td colspan="5" style="padding-bottom:10px;">
						  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="typel">
		                    <tr>
		                      <td width="190" height="30" align="right" title="注册后不能修改">选择企业类型：</td>
		                      <td>
		                      <ul class="typec">
		                        <li><label for="typec1"><input type="radio" name="typec" id="typec1" value="1"> 集团公司</label></li>
		                        <li>&nbsp;&nbsp;</li>
		                        <li><label for="typec2"><input type="radio" name="typec" id="typec2" value="2"> 非集团公司</label></li>
		                      </ul>
		                      </td>
		                    </tr>
		                  </table>
		                  <div id="typebox-1" class="typeb">
		                  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		                  	  <tr>
		                    	<td><label for="typeb1"><input type="checkbox" name="typeb" id="typeb1" value="1"> 药材种植&nbsp;</label></td>
		                    	<td><label for="typeb2"><input type="checkbox" name="typeb" id="typeb2" value="2"> 药材经销商&nbsp;</label></td>
		                    	<td><label for="typeb3"><input type="checkbox" name="typeb" id="typeb3" value="3"> 饮片生产&nbsp;</label></td>
		                    	<td><label for="typeb4"><input type="checkbox" name="typeb" id="typeb4" value="4"> 饮片经销商</label></td>
		                      </tr>
		                    </table>
		                  </div>
		                  <div id="typebox-2" class="typeb">
		                    <label for="typeb5"><input type="radio" name="typeb" id="typeb5" value="5"> 药材种植</label>&nbsp;
		                    <label for="typeb6"><input type="radio" name="typeb" id="typeb6" value="6"> 药材经销商</label>&nbsp;
		                    <label for="typeb7"><input type="radio" name="typeb" id="typeb7" value="7"> 饮片生产</label>&nbsp;
		                    <label for="typeb8"><input type="radio" name="typeb" id="typeb8" value="8"> 饮片经销商</label> <br>
		                    <label for="typeb9"><input type="radio" name="typeb" id="typeb9" value="9"> 药材市场</label>&nbsp;
		                    <label for="typeb10"><input type="radio" name="typeb" id="typeb10" value="10"> 医院/药店&nbsp;
		                    <label for="typeb11"><input type="radio" name="typeb" id="typeb11" value="11"> 管理机构</label>&nbsp;
		                    <label for="typeb12"><input type="radio" name="typeb" id="typeb12" value="12"> 其他</label>
		                    <div style="padding-left: 70px;display: none;" id="div_ishospital">
		                    	<input type="radio" name="rad_ishospital" id="rad1" value="0" checked="checked">医院&nbsp;<input type="radio" name="rad_ishospital" id="rad2" value="1">药店</label>
		                    </div>
		                  </div>
						</td>
			          </tr>
			        </table>
				</div>
			</div>
			
			<div class="fb-bom">
		        <cite><input type="button" value="确定" onclick="showinfo();" disabled="disabled" class="sbt" id="finishcodebtn"></cite>
		    </div>
	    </form>
	    
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="520">
					<tr>
						<td width="140px;" height="30" bgcolor="#EEEEEE" align="right">选择所属区域：</td><td><label id="l_region" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">企业名称：</td><td><label id="l_corpname" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">企业简称：</td><td><label id="l_corpshortname" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">营业执照号：</td><td><label id="l_businesscode" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">组织机构代码证：</td><td><label id="l_orgcode" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">法人：</td><td><label id="l_masterman" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">法人身份证：</td><td><label id="l_identitycard" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">联系人：</td><td><label id="l_linkman" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">移动电话：</td><td><label id="l_mobile" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">固定电话：</td><td><label id="l_telephone" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">传真：</td><td><label id="l_officephone" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">电子邮箱：</td><td><label id="l_email" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">邮编：</td><td><label id="l_postcode" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">经营地址：</td><td colspan="3"><label id="l_registeraddress" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">企业类型：</td><td colspan="3"><label id="l_zyctypedisplay" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
	<link type="text/css" rel="stylesheet" href="/js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
	<script type="text/javascript" language="javascript" src="/js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
	<script type="text/javascript" language="javascript" src="/js/areaChoose.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#corpname").focus();
		
		$("input[type='radio'][name!='rad_ishospital']").click(function(){
			if($(this).val() == 10 || $("#typeb10").attr("checked")){
				$("#div_ishospital").show();
			}else{
				$("#div_ishospital").hide();
			}
		})
	});
	
	window.onerror = function(){
		return true;
	}
	
	function checkCode(str){
			return /[\·\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
	}
	
	$("input[name='typec']").click(function(){
		$('.typec li').removeClass('act');
		$('.typeb').hide();
		$(this).parents('li').addClass('act');
		
		if($(this).attr('checked')&&$(this).val()=='1'){
			$('#typebox-1').show();
		}else if($(this).attr('checked')&&$(this).val()=='2'){
			$('#typebox-2').show();
			$('#typebox-2').find("input[type='radio']").click(function(){
				$('#gmpcode, #gspcode , #gapcode').poshytip('hide');
				$(".pTxt").remove();
				
				if($(this).attr('checked')){
					switch($(this).val()){
						case '5':
							if($('.pTxt').length<1){
								$(this).parents('label').after('<span class="pTxt red">&nbsp;&nbsp;GAP：<input type="text" id="gapcode" name="gapcode" class="inp w80" maxlength="50" onblur="checkVal(this.name)"></span>');
							}
							break;
						case '7':
							if($('.pTxt').length<1){
								$(this).parents('label').after('<span class="pTxt red">&nbsp;*&nbsp;GMP：<input type="text" id="gmpcode" name="gmpcode" class="inp w80"  maxlength="50" onblur="checkVal(this.name)"></span>');
							}
							break;
						case '8':
							if($('.pTxt').length<1){
								$(this).parents('label').after('<span class="pTxt red">&nbsp;*&nbsp;GSP：<input type="text" id="gspcode" name="gspcode" class="inp w80"  maxlength="50" onblur="checkVal(this.name)"></span>');
							}
							break;
						default:
							
							break;
					}
					
				}
				$('#gmpcode, #gspcode , #gapcode').poshytip({
					className: 'tip-yellowsimple',
					showOn: 'none',
					alignTo: 'target',
					alignX: 'center',
					alignY: 'bottom',
					offsetX: 0,
					offsetY: 5
				});
			});
		}
		resetH();
	})
	
	
	function checkEmail(strEmail) {
		if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1){
			return true;
		}else{
			return false;
		}
	}
	function checkMoblie(ob){
		if((/^(13|15|18|17)[0-9]{9}$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	function checkNumberChar(ob){
		if((/\d+(\d+|x+|X+)$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	*固定电话，传真格式028-34234234-2342
	*/
	function checkPhone(ob){
		if((/^\d{7,8}$|^\d{3,4}-\d{7,8}$|^\d{3,4}-\d{7,8}-\d{1,4}$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	/**
	*验证邮编
	*/
	function checkPostCode(ob){
		if((/^\d{6}$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	/**
	*验证身份证
	*/
	function checkIdentityCard(ob){
		if(ob.length == 18){
			if((/^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\d{4}((19\d{2}(0[13-9]|1[012])(0[1-9]|[12]\d|30))|(19\d{2}(0[13578]|1[02])31)|(19\d{2}02(0[1-9]|1\d|2[0-8]))|(19([13579][26]|[2468][048]|0[48])0229))\d{3}(\d|X|x)?$/
			.test(ob)))
				return true;
			else
				return false;
		}
		
		else if(ob.length == 15){
			if((/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/.test(ob)))
				return true;
			else
				return false;
		}
		
		else{
			if((/^[A-Z|a-z]\d{6}\([\d|A]\)$/.test(ob)))
				return true;
			else
				return false;
		}
	}
	
	/**
	*验证组织机构代码证
	*/
	function checkOrgCode(ob){
		if((/^[a-zA-Z0-9]\d{7}\-[a-zA-Z0-9]$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	/**
	*失去焦点验证
	*/
	var ajaxFlag = false;
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="corpname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("企业名称没有输入");
				ajaxFlag = false;
				return ajaxFlag;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符,只包括大小写字母，中文！");
				ajaxFlag = false;
				return ajaxFlag;
			}
			
			if(getBytesLength(nameval) > 42){
				checkerror(name);
				namelab.html("企业名称超长");
				ajaxFlag = false;
				return ajaxFlag;
			}
			var url="<%=request.getContextPath()%>/companyAjax!findByExist.shtml?rid="+Math.random();
			$.getJSON(url,{'corpname':$("#corpname").val()}, function(data) {
				$("#corpname").attr("disabled","disabled");
				if(data.model.returncode != 0){
					checkerror(name);
					namelab.html(data.model.returninfo);
					$("#corpname").removeAttr("disabled");
					ajaxFlag = false;
					return ajaxFlag;
				}else{
					$("#corpname").removeAttr("disabled");
					ajaxFlag = true;
					checksuccess(name);
					return ajaxFlag;
				}
			});
		}
		
		if(name=="corpshortname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("企业简称没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符,只包括大小写字母，中文！");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="businesscode"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("营业执照号没有输入");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="masterman"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="identitycard"){
			if(checkIdentityCard(nameval) == false || nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人身份证没有输入或不正确");
				return false;
	    	}
			
			checksuccess(name);
		}
		if(name=="linkman"){
			if(nameval!=""){
				if(checkquotmarks(nameval)){
					checkerror(name);
					namelab.html("不要输入非法字符！");
					return false;
		    	}else{
		    		checksuccess(name);
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var linkman = $("#linkmanLab");
				linkman.attr("class", "noico");
			}
		}
		if(name=="mobile"){
			if(checkMoblie(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("移动电话没有输入或不正确");
				return false;
	    	}
			checksuccess(name);
		}
		if(name=="telephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("固定电话没有输入或不正确");
				return false;
	    	}
			checksuccess(name);
		}
		if(name=="officephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("传真没有输入或不正确");
				return false;
	    	}
			checksuccess(name);
		}
		if(name=="email"){
			if(checkEmail(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("电子邮箱没有输入或不正确");
				return false;
	    	}
			checksuccess(name);
		}
		if(name=="postcode"){
			if(nameval!=""){
				if(checkPostCode(nameval)==false){
					checkerror(name);
					namelab.html("邮编输入不正确");
					return false;
		    	}else{
		    		checksuccess(name);
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var postcodeLab = $("#postcodeLab");
				postcodeLab.attr("class", "noico");
			}
		}
		if(name=="registeraddress"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("经营地址没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="orgcode"){
			if(nameval!=""){
				if(checkquotmarks_businesscode(nameval)){
					checkerror(name);
					namelab.html("非法字符！");
					return false;
		    	}else{
		    		checksuccess(name);
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var orgcodeLab = $("#orgcodeLab");
				orgcodeLab.attr("class", "noico");
			}
		}
		if(name=="gapcode"){
			if(nameval!=""){
				if(checkquotmarks_businesscode(nameval)){
					//checkerror(name);
					//namelab.html("不要输入非法字符！");
					$('#gapcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
					return false;
				}else{
					$('#gapcode').poshytip('hide');
				}
			}
			//namelab.html("");
		}
		
		if(name=="gmpcode"){
			if(nameval == ""){
				//checkerror(name);
				$('#gmpcode').poshytip('update','<b class="red">GMP没有填写！</b>').poshytip('show');
				return false;
			}else{
				if(checkquotmarks_businesscode(nameval)){
					//checkerror(name);
					$('#gmpcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
					return false;
				}else{
					$('#gmpcode').poshytip('hide');
				}
			}
			//namelab.html("");
		}
		
		if(name=="gspcode"){
			if(nameval==""){
				$('#gspcode').poshytip('update','<b class="red">GSP没有填写！</b>').poshytip('show');
				return false;
			}else{
				if(checkquotmarks_businesscode(nameval)){
					$('#gspcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
					return false;
				}else{
					$('#gspcode').poshytip('hide');
				}
			}
			//namelab.html("");
		}
		
	}

	function chkCheck(){
		$("input[type='checkbox']").each(function(i){
			if($(this).attr("checked")){
				var name="zyctype";
				var spanVal = $("label[id^=" + name + "]");
				var img = $("img[name^=" + name + "]");
				spanVal.hide();
				img.attr("src", "/images/ok.png").show();
				return false;
			}
		});
	}
	
	
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
	
		//uploadType 上传的文件类型  1营业执照 2组织机构代证码 3其他证书
		function uploadInfo(uploadType){
			$("#uploadType").val(uploadType);
			$("#finishcodebtn").attr("disabled","disabled");	
			var uphtml = '';
			uphtml+='<div class="albox">';
			uphtml+='<div class="alb-tit">';
			
			if(uploadType == 1){
				uphtml+='	<span>上传营业执照</span>';
			}else if(uploadType == 2){
				uphtml+='	<span>上传组织机构代码证</span>';
			}else if(uploadType == 3){
				uphtml+='	<span>上传证书</span>';
			}
			
			uphtml+='</div>';
			uphtml+='<div class="alb-con">';
			uphtml+='	<table width="100%" cellpadding="0" cellspacing="0" border="0">';
			uphtml+='		<tr>';
			uphtml+='			<td height="40" valign="top">';
			uphtml+='				<input type="file" name="uploadify" id="uploadify" />';
			uphtml+='			</td>';
			uphtml+='			<td valign="top">';
			uphtml+='				<input type="button" class="upbtn" >';
			uphtml+='			</td>';
			uphtml+='			<td valign="top">';
			uphtml+='				<span>注意:单个文件小于2M的<br />jpg,gif,png,bmp,doc,xls,docx,xlsx文件</span>';
			uphtml+='			</td>';
			uphtml+='		</tr>';
			uphtml+='		<tr>';
			uphtml+='			<td colspan="3">';
			uphtml+='				<div id="fileQueue" class="alb-list"></div>';
			uphtml+='			</td>';
			uphtml+='		</tr>';
			uphtml+='	</table>';
			uphtml+='</div>';
			uphtml+='</div>';

			var dia = $.dialog({
				title:'文件上传',
				id:'upfile',
				lock:true,
				content: uphtml,
				max:false,
				min:false,
				button:[
			        {
			            name: '取消上传',
			            callback: function(){
			            	clearFile();
			                return false;
			            }
			        }
				],
				cancelVal:'关闭',
				cancel:function(){
					$("#finishcodebtn").removeAttr("disabled");
					
				}
			});	
			
			if(uploadType != 3){
				$("#uploadify").uploadify({    			   		
		            'uploader'       : '<%=basePath%>js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
		            'script'         : '<%=basePath%>orgUploadAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
		            'cancelImg'      : '<%=basePath%>js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
		            'folder'         : 'uploads',//上传文件的目录
		            'fileDataName'   : 'uploadify',//和input的name属性值保持一致就好，Struts2就能处理了
		            'queueID'        : 'fileQueue',
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':0,'tokenid':$("input[name='tokenid']").val()},//提交到action中的数据
		            'auto'           : false,//是否选取文件后自动上传
		            'multi'          : false,//是否支持多文件上传
		            'simUploadLimit' : 2,//每次最大上传文件数
		            //'buttonText'     : 'choice file',//按钮上的文字
		            'width'          : 84,
		            'height'         : 29,    			 
		            'buttonImg'      : '<%=basePath%>images/btnfile.png',
		            'displayData'    : 'speed',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
		            'fileDesc'       : '支持格式:jpg/gif/png/bmp/xls/doc/docx/xlsx.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
		            'fileExt'        : '*.jpg;*.gif;*.png;*.xls;*.doc;*.bmp;*.docx;*.xlsx',//允许的格式                 
					'method'         : 'POST',
		            'onComplete'     : function (event, queueID, fileObj, response, data){
		         		dia.close();
		         		$("#finishcodebtn").removeAttr("disabled");
		         		if(fileObj.size>1024*1024*2){
		         			alert("单个文件小于2M!");	
		         			return;
		         		}
			            var content = eval('(' + response + ')');    
			            //alert(content.model.uploadid+"  "+content.model.uploadtype+"  "+content.model.type);            
		            	findByMaterial(content.model.uploadid,content.model.uploadtype,content.model.type);
		            }
		        });
		      }else{
		      	$("#uploadify").uploadify({    			   		
		            'uploader'       : '<%=basePath%>js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
		            'script'         : '<%=basePath%>orgUploadAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
		            'cancelImg'      : '<%=basePath%>js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
		            'folder'         : 'uploads',//上传文件的目录
		            'fileDataName'   : 'uploadify',//和input的name属性值保持一致就好，Struts2就能处理了
		            'queueID'        : 'fileQueue',
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':0,'tokenid':$("input[name='tokenid']").val()},//提交到action中的数据
		            'auto'           : false,//是否选取文件后自动上传
		            'multi'          : true,//是否支持多文件上传
		            'simUploadLimit' : 2,//每次最大上传文件数
		            //'buttonText'     : 'choice file',//按钮上的文字
		            'width'          : 84,
		            'height'         : 29,    			 
		            'buttonImg'      : '<%=basePath%>images/btnfile.png',
		            'displayData'    : 'speed',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
		            'fileDesc'       : '支持格式:jpg/gif/png/bmp/xls/doc/docx/xlsx.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
		            'fileExt'        : '*.jpg;*.gif;*.png;*.xls;*.doc;*.bmp;*.docx;*.xlsx',//允许的格式                 
					'method'         : 'POST',
		            'onComplete'     : function (event, queueID, fileObj, response, data){
		            	if(fileObj.size>1024*1024*2){
		         			alert("单个文件小于2M!");	
		         			return;
		         		}
			            var content = eval('(' + response + ')');    
			            //alert(content.model.uploadid+"  "+content.model.uploadtype+"  "+content.model.type);            
		            	findByMaterial(content.model.uploadid,content.model.uploadtype,content.model.type);
		            },
		            'onAllComplete' : function(event,data){
		            	dia.close();
		         		$("#finishcodebtn").removeAttr("disabled");
		            }
		        });
		      }
		}
			

		$(document).ready(function() {
	        $(".upbtn").live('click',function(){
	        	$('#uploadify').uploadifySettings("scriptData",{'uploadtype':$("#uploadType").val()});
				uploadFile();
			});
	    });
    
	    function showResult(){//删除显示的上传成功结果        
	      	$("#result").html("");
	    }
	    function uploadFile(){//上传文件
	     	$('#uploadify').uploadifyUpload();
	    }
	    function clearFile(){//清空所有上传队列
	        $('#uploadify').uploadifyClearQueue();
	    }
    	
    	/**
    	*根据上传附件id,类型,企业或者组织查询附件
    	*/
	    function findByMaterial(uploadid,uploadtype,type){
	    	var data="";
	    	data+="uploadid="+uploadid+"&uploadtype="+uploadtype+"&type="+type;			
			var url="<%=request.getContextPath()%>/orgUploadAjax!findByMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				findByMaterialReturn(data);
				resetH();
			});
	    }
	    
	    function findByMaterialReturn(responseText){
	    	var loginForm = responseText;    		
	    	var list = loginForm.model.list;
	    	var uploadtype = loginForm.model.uploadtype;
	    	var matdiv;
	    	var str='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox">';
    		if(uploadtype == 1){
        		matdiv = $("#businesscodediv");
        	}
        	else if(uploadtype == 2){
        		matdiv = $("#orgcodediv");
        	}
        	else if(uploadtype == 3){
        		matdiv = $("#otherdiv");
        		str='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox2">';
        		if(matdiv.html().indexOf("删除")>-1){
        			str='';
        		};
        	}
	    	
	    	for(var i = 0 ; i < list.length ; i++){
    			var uploadcontent = list[i].uploadcontent;
    			uploadcontent = uploadcontent.substring(uploadcontent.length-3,uploadcontent.length);
    			str+='<tr'+(matdiv.html().indexOf("删除")>-1?' class="upLbline"':'')+' id="tr'+list[i].uploadid +'"><td height=26><a class="blue" target="_blank" id="name'+list[i].uploadid +'" href="';
   				if(uploadcontent=="jpg"||uploadcontent=="gif"||uploadcontent=="png"||uploadcontent=="bmp"){
   					str+='<%=basePath%>orgUploadImage.shtml?uploadcontent='+list[i].uploadcontent;
   				}else{
   					str+='<%=basePath%>orgUploadImage!getOrgUploadImageFile.shtml?uploadcontent='+list[i].uploadcontent;
   				}
   				str+='">'+list[i].uploadname+'</a></td><td><a href="javascript:void(0);" class="btn-del" id="del'+list[i].uploadid +'" onclick="deleteMaterial('+list[i].uploadid+','+list[i].uploadtype+');">删除</a></td></tr>';
	    	}
	    	if(uploadtype == 3){
        		if(matdiv.html().indexOf("删除")<=-1){
        			str+='</table>';
        		}else{
        			$(".uploadbox2").append(str);
        			return;
        		};
        	}else{
        		str+='</table>';
        	}
	    	
	    	if(str=='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox"></table>'||str=='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox2"></table>'){
	    		str = '';
	    		if(uploadtype == 1){
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(1);">上传营业执照</a>';
	    		}else if(uploadtype == 2){
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(2);">上传组织机构代码证</a>';
	    		}
	    		str += '';
	    	}
	    		
	    	matdiv.append(str);
	    	if(matdiv.html().indexOf("删除")>-1 && uploadtype != 3){
	    		matdiv.find(".btn-up").remove();
	    	}
	    	
	    }
	    
	    function deleteMaterial(uploadidtemp,uploadtypetemp){
	    	//alert(uploadidtemp+" >>"+uploadtypetemp);
	    	if(!confirm("是否删除?")){
	    		return ;
	    	}
	    	var data="";
	    	if($("#del"+uploadidtemp).parents(".uploadbox").length>0){
	    		$("#del"+uploadidtemp).parents(".uploadbox").remove();
	    	}else if($("#del"+uploadidtemp).parents(".uploadbox2").length>0){
	    		$("#tr"+uploadidtemp).remove();
	    		if($(".uploadbox2").html().indexOf("删除")<=-1){
	    			$(".uploadbox2").remove();
	    		}
	    	}
	    	//$("#name"+uploadidtemp).hide();
	    	data+="uploadid="+uploadidtemp+"&uploadtype="+uploadtypetemp;			
			var url="<%=request.getContextPath()%>/orgUploadAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				//alert(data.model.uploadid+"   "+data.model.uploadtype);
				findByMaterial(data.model.uploadid,data.model.uploadtype,0);
			});
	    }
/**
*确定信息验证
*/		
var corpFlag = false;
function showinfo(){
		var flag=0;
		$("input").each(function(){
			if($(this).attr("name")!="corpname"){
			    if(checkVal($(this).attr("name"))==false){
				    flag =1;
					return false;
				}
			}
		});
		if(flag==1){
			return false;
		}
		
		var flag1=0;
		
		var typeId; 
		var corpFlag = false;
		var zyctype="";
		var type="";
		var uploadids = "";
		$("a[id^='del']").each(function (i) {
			var currentId = $(this).attr("id").substr($(this).attr("id").length-3)+",";
			uploadids += currentId;
		});
		$("#uploadids").val(uploadids.substr(0,uploadids.length-1));
		//判断集团或者非集团下属单位输入信息
			if($("input[name='typec']:checked").length > 0){
				$("#ishospital").val("");
				$("input[name='typec']").each(function(i){
					if($(this).attr("checked")){
						//判断集团下属单位信息录入
						if($(this).val()=="1"){
							$("#corp").val(0);
							if($('#typebox-1').find("input[type='checkbox']:checked").length == 0){
								$.dialog.alert("请选择集团下属单位类型");
								corpFlag = false;
								return corpFlag;
							}
							corpFlag = true;
							$('#typebox-1').find("input[type='checkbox']").each(function(i){
									if($(this).attr("checked")){
										if($(this).val() == 1){
											type += "药材种植 ";
										}else if($(this).val() == 2){
											type += "药材经销商 ";
										}else if($(this).val() == 3){
											type += "饮片生产 ";
										}else if($(this).val() == 4){
											type += "饮片经销商 ";
										}
										zyctype+="1";
									}else{
										zyctype+="0";
									}
										
							});
								zyctype+="0000";
						}else if($(this).val()=="2"){//判断非集团下属单位信息录入
							$("#corp").val(1);
							//alert("非集团");
							//非集团下属单位信息和企业信息一致,只需要判断gap,gsp,gmp
							if($('#typebox-2').find("input[type='radio']:checked").length == 0){
								$.dialog.alert("请选择非集团下属单位类型");
								corpFlag = false;
								return corpFlag;
							}
							var typeId = 0;
							$('#typebox-2').find("input[type='radio']").each(function(){
								if($(this).attr("checked")){
									typeId = $(this).val();
									if(typeId == 5){
											type = "药材种植";
											zyctype="10000000";
											var nameobj = $("#gapcode");
											var nameval = $.trim(nameobj.val());
											var namelab = $("#gapcodeLab");
											if(nameval!=""){
												if(checkquotmarks(nameval)){
													//checkerror(name);
													//namelab.html("不要输入非法字符！");
													$('#gapcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
													corpFlag = false;
													return corpFlag;
										    	}else{
										    		$('#gapcode').poshytip('hide');
										    		//checksuccess(name);
													corpFlag = true;
													return corpFlag;
										    	}
											}else{
													$('#gapcode').poshytip('hide');
													corpFlag = true;
													return corpFlag;
										   }
									}else if(typeId == 6){
											type = "药材经销商"
											zyctype = "01000000";
											corpFlag = true;
											return corpFlag;
									}else if(typeId == 7){
										//alert(2222222)
											type = "饮片生产";
											zyctype = "00100000";
											var nameobj = $("#gmpcode");
											var nameval = $.trim(nameobj.val());
											var namelab = $("#gmpcodeLab");
												if(nameval==null||nameval==""){
													//checkerror(name);
													//namelab.html("GMP没有填写！");
													$('#gmpcode').poshytip('update','<b class="red">GMP没有填写！</b>').poshytip('show');
													corpFlag = false;
													return corpFlag;
										    	}else if(checkquotmarks_businesscode(nameval)){
													//checkerror(name);
													//namelab.html("不要输入非法字符！");
													$('#gmpcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
													corpFlag = false;
													return corpFlag;;
												}else{
													$('#gmpcode').poshytip('hide');
													corpFlag = true;
													return corpFlag;
												}
												//checksuccess(name);
												
									}else if(typeId == 8){
											type = "饮片经销商";
											zyctype = "00010000";
											var nameobj = $("#gspcode");
											var nameval = $.trim(nameobj.val());
											var namelab = $("#gspcodeLab");
											if(nameval==null||nameval==""){
												//checkerror(name);
												//namelab.html("GSP没有填写！");
												$('#gspcode').poshytip('update','<b class="red">GSP没有填写！</b>').poshytip('show');
												corpFlag = false;
												return corpFlag;
									    	}else if(checkquotmarks_businesscode(nameval)){
												//checkerror(name);
												//namelab.html("不要输入非法字符！");
												$('#gspcode').poshytip('update','<b class="red">不要输入非法字符！</b>').poshytip('show');
												corpFlag = false;
												return corpFlag;
											}else{
												$('#gmpcode').poshytip('hide');
												corpFlag = true;
												return corpFlag;
											}
											//checksuccess(name);
									}else if(typeId == 9){
												type = "药材市场";
												zyctype = "00001000";
												corpFlag = true;
												return corpFlag;
									}else if(typeId == 10){
												type = "医院/药店";
												zyctype = "00000100";
												$("input[name='rad_ishospital']").each(function(){
													if($(this).attr('checked')){
														$("#ishospital").val($(this).val());
														corpFlag = true;
														return corpFlag;
													}
												});
									}else if(typeId == 11){
												type = "管理机构";
												zyctype = "00000010";
												corpFlag = true;
												return corpFlag;
									}else if(typeId == 12){
												type = "其他";
												zyctype = "00000001";
												corpFlag = true;
												return corpFlag;
									}
								}
							});
						}
						return false;
					}
				});
			}else{
				$.dialog.alert("请选择企业类型");
				corpFlag = false;
				return corpFlag;
			}
			$("#l_region").text($("#province").val()+$("#city").val()+$("#area").val());
			$("#zyctype").val(zyctype);
			$("#l_zyctypedisplay").text(type);
			
			//alert($("#ishospital").val());
			
			if(corpFlag && ajaxFlag){
				editSure();
			}
	}
	
	
	$(".comimg").poshytip({
		className: 'tip-yellowsimple',
		showTimeout: 1,
		alignTo: 'target',
		alignX: 'right',
		alignY: 'center',
		offsetX: 8,
		allowTipHover: false,
		fade: false,
		slide: false
	});
	</script>
	</body>
</html>