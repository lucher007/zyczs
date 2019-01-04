<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>国家中药材流通追溯体系${initParam.titlename }</title>
<link type="text/css" rel="stylesheet" href="style/login.css">
</head>

<body>
	<div id="regmain">
    	<form action="companyRegister!register.shtml" id="dataForm" name="dataForm" method="post">
    	<s:token id="tokenid" name="tokenid"></s:token>
    	<input type="hidden" name="zyctype" id="zyctype">
		<input type="hidden" name="uploadids" id="uploadids"/>
		<input type="hidden" name="uploadType" id="uploadType"/>
		<input type="hidden" name="gapcode" id="gapcode">
		<input type="hidden" name="gspcode" id="gspcode">
		<input type="hidden" name="gmpcode" id="gmpcode">
		<input type="hidden" name="corp" id="corp">
		<input type="hidden" name="orgnames" id="orgnames">
		<input type="hidden" name="ishospital" id="ishospital">
		<div style="visibility: hidden" name="orgdiv" id="orgdiv"></div>
    	<div class="reg_box">
            <div class="rb-tit">填写注册基本信息</div>
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="rb-con">
              <tr>
                <td width="180" height="40" align="right">企业名称：</td>
                <td width="230"><input type="text" class="inp" name="corpname" id="corpname" maxlength="50" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td width="250" class="f12"> <label name="corpnameLab" id="corpnameLab" class="noico"></label></td>
              </tr>
               <tr>
                <td width="180" height="40" align="right">企业简称：</td>
                <td width="230"><input type="text" class="inp" name="corpshortname" id="corpshortname" maxlength="50" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td width="250" class="f12"> <label name="corpshortnameLab" id="corpshortnameLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">营业执照号：</td>
                <td><input type="text" class="inp" name="businesscode" id="businesscode" maxlength="100" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td class="f12"><label name="businesscodeLab" id="businesscodeLab" class="noico"></label></td>
              </tr>
              <tr>
	            <td height="40" align="right">营业执照：</td>
	            <td colspan="2" id="businesscodediv">
		            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(1);">上传营业执照</a>
	          	</td>
	          </tr>
              <tr>
                <td height="40" align="right">组织机构代码：</td>
                <td><input type="text" class="inp" name="orgcode" id="orgcode" maxlength="100" onblur="checkVal(this.name);"></td>
                <td class="f12"><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
              </tr>
             <tr>
	            <td height="40" align="right">组织机构代码证：</td>
	         	 <td colspan="2" id="orgcodediv">
		            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(2);">上传组织机构代码证</a>
	          	</td>
	         </tr>
 			 <tr>
	            <td height="30" align="right">其他证书证明：</td>
	            <td colspan="2" id="otherdiv">
		            <a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(3);">上传其他证书</a>
	          	</td>
		     </tr>
              <tr>
                <td height="40" align="right">法人：</td>
                <td><input type="text" class="inp" name="masterman" id="masterman" maxlength="10" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td class="f12"><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">法人身份证：</td>
                <td><input type="text" class="inp" name="identitycard" id="identitycard" maxlength="18" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td class="f12"><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">联系人：</td>
                <td><input type="text" class="inp" name="linkman" id="linkman" maxlength="10" onblur="checkVal(this.name);"></td>
                <td class="f12"><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">移动电话：</td>
                <td><input type="text" class="inp" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"><span class="red"> *</span></td>
                <td class="f12"><label name="mobileLab" id="mobileLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">固定电话：</td>
                <td><input type="text" class="inp" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td class="f12"><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
              </tr>
               <tr>
                <td height="40" align="right">传真：</td>
                <td><input type="text" class="inp" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);"><span class="red"> *</span></td>
                <td class="f12"><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">电子邮箱：</td>
                <td><input type="text" class="inp" name="email" id="email" maxlength="30" onblur="checkVal(this.name);"></td>
                <td class="f12"><label name="emailLab" id="emailLab" class="noico"></label></td>
              </tr>
              <tr>
           	  	<td height="30" align="right">选择所属区域：</td>
				<td colspan="4">
					<select name="province" id="province"  style="width:120px;"  v="${initParam.province }"></select>
					<select name="city" id="city"></select>
					<select name="area" id="area"></select>
					<span class="red">*</span>
				</td>
              <tr>
              <tr>
                <td height="40" align="right">邮编：</td>
                <td><input type="text" class="inp" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> </td>
                <td class="f12"><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">经营地址：</td>
                <td><input type="text" class="inp" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);"> <span class="red"> *</span> </td>
                <td class="f12"><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
              </tr>
              <tr>
                <td height="40" align="right">经度：</td>
                <td><input type="text" class="inp" name="longitude" id="longitude" maxlength="6" readonly></td>
                <td></td>
              </tr>
              <tr>
                <td height="40" align="right">纬度：</td>
                <td><input type="text" class="inp" name="latitude" id="latitude" maxlength="6" readonly>
					</td>
                <td><input type="button" value="选取经纬度" class="sbt" id="lonlat" onclick="openMap()"></td>
              </tr>
              <tr>
                <td colspan="3">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="typel">
                    <tr>
                      <td width="180" height="40" align="right" title="注册后不能修改">选择企业类型：</td>
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
                    	<td style="border-right:solid green 1px;width:140px;"><label for="typeb1"><input type="checkbox" name="typeb" id="typeb1" value="1"> 药材种植&nbsp;</label></td>
                    	<td style="padding-left:10px;border-right:solid green 1px;width:140px;"><label for="typeb2"><input type="checkbox" name="typeb" id="typeb2" value="2"> 药材经销商&nbsp;</label></td>
                    	<td style="padding-left:10px;border-right:solid green 1px;width:140px;"><label for="typeb3"><input type="checkbox" name="typeb" id="typeb3" value="3"> 饮片生产&nbsp;</label></td>
                    	<td style="padding-left:10px;width:140px;"><label for="typeb4"><input type="checkbox" name="typeb" id="typeb4" value="4"> 饮片经销商</label></td>
                      </tr>
                      <tr>
                        <td class="green" style="border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;"></td>
                      </tr>
                    </table>
                  </div>
                  
                  <div id="typebox-2" class="typeb">
                  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                  	  <tr>
                    	<td style="border-right:solid green 1px;width:140px;"><label for="typeb5"><input type="radio" name="typed" id="typeb5" value="5"> 药材种植</label>&nbsp;</td>
                    	<td style="padding-left:10px;border-right:solid green 1px;width:140px;"> <label for="typeb6"><input type="radio" name="typed" id="typeb6" value="6"> 药材经销商</label>&nbsp;</td>
                    	<td style="padding-left:10px;border-right:solid green 1px;width:140px;"> <label for="typeb7"><input type="radio" name="typed" id="typeb7" value="7"> 饮片生产</label>&nbsp;</td>
                    	<td style="padding-left:10px;width:140px;">  <label for="typeb8"><input type="radio" name="typed" id="typeb8" value="8"> 饮片经销商</label></td>
                      </tr>
                      
                      <tr>
                        <td class="green" style="border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;"></td>
                      </tr>
                      
                      <tr>
                    	<td style="border-right:solid green 1px;"><label for="typeb9"><input type="radio" name="typed" id="typeb9" value="9"> 药材市场</label>&nbsp;</td>
                    	<td style="padding-left:10px;border-right:solid green 1px;"><label for="typeb10"><input type="radio" name="typed" id="typeb10" value="10"> 医院/药店</label>&nbsp;</td>
                    	<td style="padding-left:10px;border-right:solid green 1px;"> <label for="typeb11"><input type="radio" name="typed" id="typeb11" value="11"> 管理机构</label>&nbsp;</td>
                    	<td style="padding-left:10px;"><label for="typeb12"><input type="radio" name="typed" id="typeb12" value="12"> 其他</label></td>
                      </tr>
                      
                      <tr>
                        <td class="green" style="border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;border-right:solid green 1px;"></td>
                        <td class="green" style="padding-left:10px;"></td>
                      </tr>
                      
                    </table>
                  </div>
                </td>
			   </tr>
			   <tr>
                <td colspan="3" height="70" class="rb-btn">
                	<input type="button" onclick="showinfo();" id="finishcodebtn" disabled="disabled">  
                    <a href="<%=basePath %>login.jsp" onclick="location='<%=basePath %>login.jsp'">返回登录</a>
                </td>
              </tr>
            </table>
            <div class="rb-bom"></div>
        </div>
        <div class="login-copy">${initParam.copyright }</div>
        </form>
    </div>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
    <script language="javascript" type="text/javascript" src="js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
	<script language="javascript" type="text/javascript" src="js/comtools.js"></script>
	<script type="text/javascript" language="javascript" src="js/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
	<script type="text/javascript" language="javascript"  src="js/register.js"></script>
</body>
</html>