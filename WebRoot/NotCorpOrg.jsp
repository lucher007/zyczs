<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zyctype = request.getParameter("zyctype");
request.setAttribute("zyctype",zyctype);
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
		<style>
		body{ font-size:14px; padding:20px 0;}
		td{ padding:0;}
		.inp, .inponly{ width:200px;}
		.sbt{ width:120px; height:40px; font-weight: bolder; font-size:14px;}
		</style>
		<link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="js/comtools.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
		<script type="text/javascript">
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
			    	str+='<tr'+(matdiv.html().indexOf("删除")>-1?' class="upLbline"':'')+' id="tr'+list[i].uploadid +'"><td height=26>&nbsp;<a class="blue" target="_blank" id="name'+list[i].uploadid +'" href="';
	   				if(uploadcontent=="jpg"||uploadcontent=="gif"||uploadcontent=="png"||uploadcontent=="bmp"){
	   					str+='<%=basePath%>orgUploadImage.shtml?uploadcontent='+list[i].uploadcontent;
	   				}else{
	   					str+='<%=basePath%>orgUploadImage!getOrgUploadImageFile.shtml?uploadcontent='+list[i].uploadcontent;
	   				}
	   				str+='">'+list[i].uploadname+'</a></td><td><input type="hidden" value="删除"></td></tr>';
		        	
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
		    			str += '<span class="gray">没有上传</span>';
		    		}else if(uploadtype == 2){
		    			str += '<span class="gray">没有上传</span>';
		    		}
		    		str += '';
		    	}
		    		
		    	matdiv.append(str);
		    	if(matdiv.html().indexOf("删除")>-1  && uploadtype != 3){
		    		matdiv.find(".btn-up").remove();
		    	}
		    	
		    //	alert($("#orgcodediv table tbody tr").attr("id").substring(2));
		    }
		</script>
	</head>
	
	<body>
	<div id="body">
		<form action="" id="dataForm" name="dataForm" method="post">
	        <table border="0" cellpadding="0" cellspacing="0">
	          <tr>
	            <td width="180" height="40" align="right">组织机构名称：</td>
	            <td width="230">
	            	<input type="text" class="inponly" name="orgname" id="orgname" maxlength="50"  readonly> <span class="red">*</span>
	            </td>
	            <td width="250"><label name="orgnameLab" id="orgnameLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
				<td height="40" align="right">组织机构简称：</td>
				<td>
	            	<input type="text" class="inponly" name="orgshortname" id="orgshortname" maxlength="50" readonly> <span class="red">*</span>
				</td>
				<td><label name="orgshortnameLab" id="orgshortnameLab" class="noico"></label></td>
	          </tr>
	          <tr>
				<td height="40" align="right">组织机构法人：</td>
				<td>
	            	<input type="text" class="inponly" name="masterman" id="masterman" maxlength="10" value="${requestScope.company.masterman }" readonly> <span class="red">*</span>
				</td>
				<td><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
	          </tr>
	          <tr>
				<td height="40" align="right">法人身份证号：</td>
				<td>
	            	<input type="text" class="inponly" name="identitycard" id="identitycard" maxlength="18"" value="${requestScope.company.identitycard }" readonly> <span class="red">*</span>
				</td>
				<td><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
	          </tr>
	         <tr>
				<td height="40" align="right">营业执照号：</td>
				<td>
	            	<input type="text" class="inponly" name="businesscode" id="businesscode" maxlength="100" readonly value="${requestScope.company.businesscode }"> <span class="red">*</span>
				</td>
				<td><label name="businesscodeLab" id="businesscodeLab" class="noico"></label></td>
	         </tr>
	         <tr>
	            <td height="40" align="right">营业执照：</td>
	             <td colspan="2" id="businesscodediv">
					<script type="text/javascript" language="javascript">
          		 		var org = parent.getArr("${zyctype}"-1);
            	 		if(!org || org.orgUpload1 == null || org.orgUpload1 == ""){
            	 			var oDivId = $('#businesscodediv',window.parent.document).find('tr').attr('id');
            	 			if(oDivId){
            	 				findByMaterial(oDivId.substring(2),1,0);
            	 			}else{
            	 				document.write('<span class="gray">没有上传</span>');
            	 			}
            	 		}else{
            	 			findByMaterial(org.orgUpload1,1,0);
            	 		}
					</script>
		       </td>
	         </tr> 
	         <tr>
				<td height="40" align="right">组织机构代码：</td>
				<td>
	            	<input type="text" class="inponly" name="orgcode" id="orgcode" maxlength="100" readonly value="${requestScope.company.orgcode }">
				</td>
				<td><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
	        </tr>
	         <tr>
	            <td height="40" align="right">组织机构代码证：</td>
	         	 <td colspan="2" id="orgcodediv">
		            <script type="text/javascript" language="javascript">
            	 		if(!org || org.orgUpload2 == null || org.orgUpload2 == ""){
            	 			var oDivId2 = $('#orgcodediv',window.parent.document).find('tr').attr('id');
            	 			if(oDivId2){
            	 				findByMaterial(oDivId2.substring(2),2,0);
            	 			}else{
            	 				document.write('<span class="gray">没有上传</span>');
            	 			}
            	 		}else{
            	 			findByMaterial(org.orgUpload2,2,0);
            	 		}
					</script>
	          	</td>
	         </tr> 
	         <tr>
	            <td height="40" align="right">其他证书证明：</td>
	            <td colspan="2" id="otherdiv">
		            <script type="text/javascript" language="javascript">
            	 		if(!org || org.orgUpload3 == null || org.orgUpload3 == ""){
            	 			var oDivId3 = $('#otherdiv',window.parent.document).find('tr');
            	 			if($(oDivId3).eq(0).attr('id')){
            	 			    $(oDivId3).each(function(i,o){
            	 			    	findByMaterial($(o).attr('id').substring(2),3,0);
            	 			    });
            	 			}else{
            	 				document.write('<span class="gray">没有上传</span>');
            	 			}
            	 		}else{
            	 			if(org.orgUpload3.indexOf(',')>-1)
            	 			{
            	 				var upId3 = org.orgUpload3.split(',');
            	 				$.each(upId3,function(o,i){
            	 					findByMaterial(o,3,0);
            	 				})
            	 			}else{
            	 				findByMaterial(org.orgUpload3,3,0);
            	 			}
            	 		}
					</script>
	          	</td>
	         </tr> 
	         <tr>
	            <td height="40" align="right">企业类型：</td>
	            <td colspan="2">
	            	<input type="text" class="inponly" name="type" id="type" maxlength="10" readonly> 
	            	<input type="hidden" class="inponly" name="zyctype" id="zyctype" maxlength="10" readonly> 
					<span class="red">*</span>
	            </td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">联系人：</td>
	            <td><input type="text" class="inponly" name="linkman" id="linkman" maxlength="10" value="${requestScope.company.linkman }" readonly> </td>
	            <td><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" width="120" align="right">移动电话：</td>
	            <td>
	            	<input type="text" class="inponly" name="mobile" id="mobile" maxlength="11" readonly value="${requestScope.company.mobile }"> <span class="red">*</span>
	            </td>
	            <td><label name="mobileLab" id="mobileLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">固定电话：</td>
	            <td>
	            	<input type="text" class="inponly" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);" value="${requestScope.company.telephone }" > <span class="red">*</span>
	            </td>
	            <td><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">传真：</td>
	            <td>
	            	<input type="text" class="inponly" name="officephone" id="officephone" maxlength="20" readonly value="${requestScope.company.officephone }"> <span class="red">*</span>
	            </td>
	            <td><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">电子邮箱：</td>
	            <td>
	            	<input type="text" class="inponly" name="email" id="email" maxlength="30" readonly value="${requestScope.company.email }">
	            </td>
	            <td><label name="emailLab" id="emailLab" class="noico"></label></td>
	          </tr>
	          <tr>
	            <td height="40" align="right">所属区域：</td>
	            <td colspan="2">
	            	<input type="text" name="province" id="province" readonly class="inponly" style="width:120px;">&nbsp;<input type="text" name="city" id="city" readonly class="inponly" style="width:120px;">&nbsp;<input type="text" name="area" id="area" readonly class="inponly" style="width:120px;">&nbsp;<span class="red">*</span>
	           	</td>
	          </tr>
	          <tr>
	            <td height="40" align="right">邮编：</td>
	            <td>
	            	<input type="text" class="inponly" name="postcode" id="postcode" maxlength="6" readonly > 
	            </td>
	            <td><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
                 </tr>
                 
	          <tr>
				<td height="40" align="right">经营地址：</td>
				<td>
	            	<input type="text" class="inponly" name="registeraddress" id="registeraddress" maxlength="50" readonly > <span class="red">*</span>
				</td>
				<td><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
	          </tr>
	          <tr>
				<td height="40" align="right">经度：</td>
				<td>
	            	<input type="text" class="inponly" name="longitude" id="longitude" maxlength="6" readonly>
				</td>
				<td></td>
	          </tr>
	          <tr>
				<td height="40" align="right">纬度：</td>
				<td>
	            	<input type="text" class="inponly" name="latitude" id="latitude" maxlength="6" readonly>
				</td>
				<td></td>
	          </tr>
	          <tr>
	          	<td></td>
	            <td colspan="2"><input type="button" value="确  认" class="sbt" onclick="showinfo()" id="finishcodebtn"></td>
	          </tr>
	        </table>
	    </form>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	    <script language="javascript" defer>
	    
			function checkCode(str){
				return /[\·\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
			}
	    	
			var gap='<tr><td height="40" align="right">GAP：</td><td><input type="text" class="inp" name="gapcode" id="gapcode" maxlength="50" onblur="checkVal(this.name)"></td><td><label name="gapcodeLab" id="gapcodeLab" class="noico"></label></td></tr>';
			var gmp='<tr><td height="40" align="right">GMP：</td><td><input type="text" class="inp" name="gmpcode" id="gmpcode" maxlength="50" onblur="checkVal(this.name)"> <span class="red">*</span></td><td><label name="gmpcodeLab" id="gmpcodeLab" class="noico"></label></td> </tr>';
			var gsp='<tr><td height="40" align="right">GSP：</td><td><input type="text" class="inp" name="gspcode" id="gspcode" maxlength="50" onblur="checkVal(this.name)"> <span class="red">*</span></td><td><label name="gspcodeLab" id="gspcodeLab" class="noico"></label></td> </tr>';
			function checkVal(name){
				var nameobj = $("#"+name);
				var nameval = $.trim(nameobj.val());
				var namelab = $("#"+name+"Lab");
				
				if(name=="gapcode"){
					if(nameval!=""){
						if(checkquotmarks_businesscode(nameval)){
							checkerror(name);
							namelab.html("非法字符！");
							return false;
						}
					}
					namelab.html("");
				}
				
				if(name=="gmpcode"){
					if(nameval==""){
						checkerror(name);
						namelab.html("GMP没有填写！");
						return false;
					}
					if(nameval!=""){
						if(checkquotmarks_businesscode(nameval)){
							checkerror(name);
							namelab.html("非法字符！");
							return false;
						}
					}
					namelab.html("");
				}
				
				if(name=="gspcode"){
					if(nameval==""){
						checkerror(name);
						namelab.html("GSP没有填写！");
						return false;
					}
					if(nameval!=""){
						if(checkquotmarks_businesscode(nameval)){
							checkerror(name);
							namelab.html("非法字符！");
							return false;
						}
					}
					namelab.html("");
				}
				
				return true;
			}
		
			/**
			*非集团下属机构和企业信息一样
			*/
			var corpzyctype;
			$(function(){
					corpzyctype = "${zyctype}";
					var arr = parent.getArr(corpzyctype-1);
					$("#orgname").val(parent.document.getElementById("corpname").value);
					$("#orgshortname").val(parent.document.getElementById("corpshortname").value);
					$("#masterman").val(parent.document.getElementById("masterman").value);
					$("#identitycard").val(parent.document.getElementById("identitycard").value);
					$("#businesscode").val(parent.document.getElementById("businesscode").value);
					$("#orgcode").val(parent.document.getElementById("orgcode").value);
					var zyctype;
					var type;
					if(corpzyctype == 5){
						type = "药材种植";
						zyctype = "10000000";
						$("table tr:last").before(gap);
					}else if(corpzyctype == 6){
						type = "药材经销商";
						zyctype = "01000000";
					}else if(corpzyctype == 7){
						type = "饮片生产";
						zyctype = "00100000";
						$("table tr:last").before(gmp);
					}else if(corpzyctype == 8){
						type = "饮片经销商";
						zyctype = "00010000";
						$("table tr:last").before(gsp);
					}else if(corpzyctype == 9){
						type = "药材市场";
						zyctype = "00001000";
					}else if(corpzyctype == 10){
						type = "医院/药店";
						zyctype = "00000100";
					}else if(corpzyctype == 11){
						type = "管理机构";
						zyctype = "00000010";
					}else if(corpzyctype == 12){
						type = "其他";
						zyctype = "00000001";
					}
					$("#type").val(type);
					$("#zyctype").val(zyctype);
					$("#linkman").val(parent.document.getElementById("linkman").value);
					$("#mobile").val(parent.document.getElementById("mobile").value);
					$("#telephone").val(parent.document.getElementById("telephone").value);
					$("#officephone").val(parent.document.getElementById("officephone").value);
					$("#email").val(parent.document.getElementById("email").value);
					$("#province").val(parent.document.getElementById("province").value);
					$("#city").val(parent.document.getElementById("city").value);
					$("#area").val(parent.document.getElementById("area").value);
					$("#postcode").val(parent.document.getElementById("postcode").value);
					$("#registeraddress").val(parent.document.getElementById("registeraddress").value);
					$("#longitude").val(parent.document.getElementById("longitude").value);
					$("#latitude").val(parent.document.getElementById("latitude").value);
					
					if(arr){
						$("#gapcode").val(arr.gapcode);
						$("#gmpcode").val(arr.gmpcode);
						$("#gspcode").val(arr.gspcode);
					}
					$('.inp, .inponly').css('padding',5);
			})
			
			/**
			*确认信息弹出框
			*/
			function showinfo(){
				var corpzyctype = "${zyctype}";
					//封装非集团下属单位的信息传回企业信息页面
					var obj = {"type":corpzyctype,"orgname":$("#orgname").val(),"orgshortname":$("#orgshortname").val()
					,"masterman":$("#masterman").val(),"identitycard":$("#identitycard").val(),"businesscode":$("#businesscode").val()
					,"orgcode":$("#orgcode").val(),"zyctype":$("#zyctype").val(),"linkman":$("#linkman").val()
					,"mobile":$("#mobile").val(),"telephone":$("#telephone").val(),"officephone":$("#officephone").val()
					,"email":$("#email").val(),"province":$("#province").val(),"city":$("#city").val()
					,"area":$("#area").val(),"postcode":$("#postcode").val(),"registeraddress":$("#registeraddress").val()
					,"longitude":$("#longitude").val(),"latitude":$("#latitude").val(),"uploadids":$("#uploadids").val()
					,"gapcode":$("#gapcode").val()?$("#gapcode").val():"","gmpcode":$("#gmpcode").val()?$("#gmpcode").val():""
					,"gspcode":$("#gspcode").val()?$("#gspcode").val():""};
					if(corpzyctype == 5){	
						if(checkVal("gapcode")){
							parent.closeRegisterOrg(corpzyctype-1,obj);
						}
					}else if(corpzyctype == 7){
						if(checkVal("gmpcode")){
							parent.closeRegisterOrg(corpzyctype-1,obj);
						}
					}else if(corpzyctype == 8){
						if(checkVal("gspcode")){
							parent.closeRegisterOrg(corpzyctype-1,obj);
						}
					}else{
						parent.closeRegisterOrg(corpzyctype-1,obj);
					}
			}
		</script>
	</body>
</html>