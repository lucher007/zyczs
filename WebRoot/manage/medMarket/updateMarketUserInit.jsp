<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
		<link type="text/css" rel="stylesheet" href="/style/market.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">	当前位置：市场管理 &gt; 更新经营户 </div>
		<form action="<%=basePath%>company!updateUserMarket.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="zyctype" id="zyctype" value="01000000">
		<input type="hidden" name="province" id="province" value="${company.province}">
		<input type="hidden" name="areacode" id="areacode" value="${company.areacode}">
		<input type="hidden" name="city" id="city" value="${company.city}">
		<input type="hidden" name="area" id="area" value="${company.area}">
		<input type="hidden" id="cpccorp" name="cpccorp" value="${company.cpccorp }" >
		<input type="hidden" id="companyid" name="companyid" value="${company.companyid }" >
		<input type="hidden" id="orgid" name="orgid" value="${orgid }" >
		<input type="hidden" id="marketcode" name="marketcode" value="${marketcode }" >
		<div class="form-box">
			<div class="fb-tit">更新经营户</div>
			<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		          <tr>
		           	<td align="right" height="30" width="120">所属区域：
					</td>
					<td  colspan="4">
						${User.org.province}${User.org.city}${User.org.area}
					</td>
		          </tr>
		          <tr>
		           	<td align="right" height="30" width="120">商户类型：
					</td>
					<td colspan="4">
							  药材经销商
					</td>
		          </tr>
		          <tr>
		            <td width="120" height="30" align="right">商户名称：</td>
		            <td width="170">
		            	<input type="text" class="inponly"  maxlength="50" id="corpname" name="corpname" value="${company.corpname}" readonly="readonly">
		            </td>
		            <td colspan="3"><label name="corpnameLab" id="corpnameLab" class="noico"></label></td>
		          </tr>
		         
		          <tr>
		            <td width="120" height="30" align="right">商户简称：</td>
		            <td width="170">
		            	<input type="text" class="inponly"  maxlength="50" id="corpshortname" name="corpshortname" value="${company.corpshortname}" readonly="readonly">
		            </td>
		            <td colspan="3"><label name="corpshortnameLab" id="corpshortnameLab" class="noico"></label></td>
		          </tr>
		           
		           <tr>
		            <td width="120" height="30" align="right">	商户编号：</td>
		            <td width="170">
		            	<input type="text" class="inp" name="businessnumber" id="businessnumber" maxlength="20" onblur="checkVal(this.name);" value="${businessnumber }"> <span class="red">*</span>
		            </td>
		            <td colspan="3"><label name="businessnumberLab" id="businessnumberLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">营业执照号：</td>
		            <td>
			            <input type="text" class="inp" name="businesscode" id="businesscode" maxlength="22" onblur="checkVal(this.name);" value="${company.businesscode}"> <span class="red">*</span>
					</td>
		            <td colspan="3"><label name="businesscodeLab" id="businesscodeLab" class="noico"></label>
		          	</td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">组织机构代码证：</td>
		            <td><input type="text" class="inp" name="orgcode" id="orgcode" maxlength="10" onblur="checkVal(this.name);" value="${company.orgcode }"> </td>
		            <td colspan="3"><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">法人：</td>
		            <td>
		            	<input type="text" class="inp" name="masterman" id="masterman" maxlength="10" onblur="checkVal(this.name);" value="${company.masterman }"> <span class="red">*</span>
					</td>
		            <td colspan="3"><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
		          </tr>
		          
                     <tr>
		          	<td height="30" align="right">法人身份证：</td>
		          	<td><input type="text" class="inp" name="identitycard" id="identitycard" maxlength="18" onblur="checkVal(this.name);" value="${company.identitycard }"> <span class="red">*</span></td>
		          	<td colspan="3"><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
                     </tr>
                     
                     <tr>
		            <td height="30" align="right">联系人：</td>
                       <td><input type="text" class="inp" name="linkman" id="linkman" maxlength="10" onblur="checkVal(this.name);" value="${company.linkman }"><span class="red">*</span></td>
                       <td colspan="3"><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">联系电话(手机)：</td>
		            <td>
		            	<input type="text" class="inp" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${company.mobile }"> <span class="red">*</span>
					</td>
		            <td colspan="3"><label name="mobileLab" id="mobileLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">固定电话：</td>
		            <td>
		            	<input type="text" class="inp" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);"  value="${company.telephone }"> <span class="red">*</span>
					</td>
		            <td colspan="3"><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">传真：</td>
		            <td>
		            	<input type="text" class="inp" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);"   value="${company.officephone}"> <span class="red">*</span>
					</td>
		            <td colspan="3"><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
		          </tr>
		          
		          
		          <tr>
		            <td height="30" align="right">电子邮箱：</td>
		            <td>
		            	<input type="text" class="inp" name="email" id="email" maxlength="30" onblur="checkVal(this.name);" value="${company.email }">
					</td>
					<td colspan="3"><label name="emailLab" id="emailLab" class="noico"></label></td>
		          </tr>
		          
		          
		          <tr>
		            <td height="30" align="right">邮编：</td>
		            <td>
		            	<input type="text" class="inp" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${company.postcode }"> 
		            </td>
		            <td colspan="3"><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
                     </tr>
                     
		          <tr>
					<td height="30" align="right">经营地址：</td>
					<td>
		            	<input type="text" class="inp" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);" value="${company.registeraddress }"> <span class="red">*</span>
					</td>
					<td colspan="3"><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
		          </tr>
		          
		         <tr>
					<td height="30" align="right">市场区域：</td>
					<td>
		            	<input type="text" class="inponly" name="partion" id="partion" readonly="readonly" value="${org.partion }">
					</td>
					<td colspan="3"></td>
		         </tr>
	          
	           	 <tr>
					<td height="30" align="right">商铺坐标：</td>
					<td>
	            	<input type="text" class="inponly" name="coordinate" id="coordinate" readonly="readonly" value="${org.coordinate }">
					</td>
					<td colspan="3"><input type="button" value="选取市场分区和商铺坐标" class="sbt" onclick="openMarketMap('${User.cpccorp}')"></td>
	           	 </tr>
				</table>
			</div>
			<div class="fb-bom">
		        <cite><input type="button" value="确定" onclick="return showinfo();" class="sbt"></cite>
		        <span class="red">${returninfo }</span>
		    </div>
		</div>
	    </form>
	    
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="520">
					<tr>
						<td width="140px;" height="30" bgcolor="#EEEEEE" align="right">选择所属区域：</td><td><label id="l_region">${User.org.province}${User.org.city}${User.org.area}</label></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">商户类型：</td><td colspan="3"><label id="l_zyctypedisplay">药材经销商</label></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">商户名称：</td><td><label id="l_corpname" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">商户简称：</td><td><label id="l_corpshortname" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">商户编号：</td><td><label id="l_businessnumber" /></td>
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
						<td height="30" bgcolor="#EEEEEE" align="right">联系电话(手机)：</td><td><label id="l_mobile" /></td>
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
						<td height="30" bgcolor="#EEEEEE" align="right">市场分区：</td><td colspan="3"><label id="l_partion" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">商铺坐标：</td><td colspan="3"><label id="l_coordinate" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	function checkEmail(strEmail) {
		if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1){
			return true;
		}else{
			return false;
		}
	}
	function checkMoblie(ob){
		if((/^(13|15|18)[0-9]{9}$/.test(ob))){
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
		if((/\d+(\d+|x+)$/.test(ob))){
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
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		
		if(name=="businessnumber"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("商户编号没有输入");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("编号不能包含~ # *等字符");
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
				namelab.html("营业执照号名称不能包含~ # *等字符");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="orgcode"){
			if(nameval!=""){
				if(checkOrgCode(nameval)==false){
					checkerror(name);
					namelab.html("组织机构代码证格式32020021-a");
					return false;
		    	}else{
		    		checksuccess(name);
		    		return true;
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var orgcodeLab = $("#orgcodeLab");
				orgcodeLab.attr("class", "noico");
			}
		}
		
		if(name=="masterman"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("法人不能包含~ # *等字符");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="identitycard"){
			if(checkIdentityCard(nameval) == false || nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人身份证格式123456701010123");
				return false;
	    	}
			checksuccess(name);
		}
		
		if(name=="linkman"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("联系人没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("联系人不能包含~ # *等字符");
				return false;
			}
			checksuccess(name);
		}
		
		
		if(name=="mobile"){
			if(checkMoblie(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("移动电话格式13400000000");
				return false;
	    	}
			checksuccess(name);
		}
		
		if(name=="telephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("固定电话格式028-31312111");
				return false;
	    	}
			checksuccess(name);
		}
		
		if(name=="officephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("传真格式0281-31312111");
				return false;
	    	}
			checksuccess(name);
		}
		
		if(name=="email"){
			if(nameval!=""){
				if(checkEmail(nameval)==false){
					checkerror(name);
					namelab.html("电子邮箱格式21212112@qq.com");
					return false;
		    	}else{
		    		checksuccess(name);
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var emailLab = $("#emailLab");
				emailLab.attr("class", "noico");
			}
		}
		
		if(name=="postcode"){
			if(nameval!=""){
				if(checkPostCode(nameval)==false){
					checkerror(name);
					namelab.html("邮编格式641400");
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
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("地址不能包含~ # *等字符");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="partion"){
			if(nameval!=""){
				if(checkquotmarks(nameval)==false){
					checkerror(name);
					namelab.html("市场分区输入不正确");
					return false;
		    	}else{
		    		checksuccess(name);
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var partionLab = $("#partionLab");
				partionLab.attr("class", "noico");
			}
		}
	}

	
	function showinfo(){
			var flag=0;
			$("input").each(function(){
			    if(checkVal($(this).attr("name"))==false){
				    flag =1;
					return false;
				}
			});
			if(flag==1){
				return false;
			}
			//$("#corpshortname").val($("#corpname").val());
			editSure();
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
	</script>
	</body>
</html>