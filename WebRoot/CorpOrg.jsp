<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
		<style>
		body{ font-size:14px; padding:20px 0;}
		td{ padding:0;}
		.inp, .inps , .inponly{ width:200px;}
		</style>
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
		<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
		<script type="text/javascript" language="javascript">
		/**
		*uploadType 上传的文件类型  1营业执照 2组织机构代证码 3其他证书
		*/
		function uploadInfo(uploadType){
			//alert("bb"+$("#uploadTokenid").val());
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':1,'tokenid':$("#uploadTokenid").val()},//提交到action中的数据,type:0为企业附件 1为组织机构附件
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':1,'tokenid':$("#uploadTokenid").val()},//提交到action中的数据
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
		    	str+='<tr'+(matdiv.html().indexOf("删除")>-1?' class="upLbline"':'')+' id="tr'+list[i].uploadid +'"><td height=26>&nbsp;<a class="blue" target="_blank" id="name'+list[i].uploadid +'" href="';
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
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(1);">上传营业执照</a>';
	    		}else if(uploadtype == 2){
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(2);">上传组织机构代证码</a>';
	    		}
	    		str += '';
	    	}
	    		
	    	matdiv.append(str);
	    	if(matdiv.html().indexOf("删除")>-1  && uploadtype != 3){
	    		matdiv.find(".btn-up").remove();
	    	}
	    	
	    //	alert($("#orgcodediv table tbody tr").attr("id").substring(2));
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
	    	data+="uploadid="+uploadidtemp+"&uploadtype="+uploadtypetemp;			
			var url="<%=request.getContextPath()%>/orgUploadAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				//alert(data.model.uploadid+"   "+data.model.uploadtype);
				findByMaterial(data.model.uploadid,data.model.uploadtype,1);
			});
	    }
		</script>
	</head>
	
	<body>
		<form action="" id="dataForm" name="dataForm" method="post">
			<s:token id="tokenid" name="tokenid"></s:token>
			<input type="hidden" name="uploadType" id="uploadType"/>
			<input type="hidden" name="uploadTokenid" id="uploadTokenid"/>
			<div id="tit" class="red" style="text-align: center"></div>
	        <table border="0" cellpadding="0" cellspacing="0">
	          <tr>
	            <td width="180" height="30" align="right">组织机构名称：</td>
	            <td width="230">
	            	<input type="text" class="inp" name="orgname" id="orgname" maxlength="50" onblur="checkVal(this.name);"> <span class="red">*</span>
	            </td>
	            <td width="250"><label name="orgnameLab" id="orgnameLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
				<td height="40" align="right">组织机构简称：</td>
				<td>
	            	<input type="text" class="inps" name="orgshortname" id="orgshortname" maxlength="50" onblur="checkVal(this.name);"> <span class="red">*</span>
				</td>
				<td><label name="orgshortnameLab" id="orgshortnameLab" class="noico"></label></td>
	          </tr>
	          
	          
	         
	          <tr>
				<td height="40" align="right">组织机构法人：</td>
				<td>
	            	<input type="text" class="inps" name="masterman" id="masterman" maxlength="10" onblur="checkVal(this.name);"> <span class="red">*</span>
				</td>
				<td><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
				<td height="40" align="right">法人身份证号：</td>
				<td>
	            	<input type="text" class="inps" name="identitycard" id="identitycard" maxlength="18" onblur="checkVal(this.name);"> <span class="red">*</span>
				</td>
				<td><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
	          </tr>
	          
	          
	         <tr>
				<td height="40" align="right">营业执照号：</td>
				<td>
	            	<input type="text" class="inps" name="businesscode" id="businesscode" maxlength="100" onblur="checkVal(this.name);"> <span class="red">*</span>
				</td>
				<td><label name="businesscodeLab" id="businesscodeLab" class="noico"></label></td>
	         </tr>
	          
	         <tr>
	            <td height="40" align="right">营业执照：</td>
	            <td colspan="2" id="businesscodediv">
		            	 <script type="text/javascript" language="javascript">
		            	 		var org = parent.getArr("${zyctype}"-1);
		            	 		if(!org || org.orgUpload1 == null || org.orgUpload1 == ""){
		            	 			document.write('<a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(1);">上传营业执照</a>');
		            	 		}else{
		            	 			findByMaterial(org.orgUpload1,1,1);
		            	 		}
						</script>
	          	</td>
	         </tr>
		          
		          
	         <tr>
				<td height="40" align="right">组织机构代码：</td>
				<td>
	            	<input type="text" class="inps" name="orgcode" id="orgcode" maxlength="100" onblur="checkVal(this.name);">
				</td>
				<td><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
	        </tr>
	        
	         <tr>
	            <td height="40" align="right">组织机构代码证：</td>
	         	 <td colspan="4" id="orgcodediv">
		           	 <script type="text/javascript" language="javascript">
		           	 			if(!org || org.orgUpload2 == null || org.orgUpload2 == ""){
		            	 			document.write('<a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(2);">上传组织机构代码证</a>');
		            	 		}else{
		            	 			findByMaterial(org.orgUpload2,2,1);
		            	 		}
					</script>
	          	</td>
	         </tr>
	         
	         <tr>
	            <td height="40" align="right">其他证书证明：</td>
	            <td colspan="2" id="otherdiv">
		           	 <script type="text/javascript" language="javascript">
		           	 			document.write('<a href="javascript:void(0);" class="btn-up" onclick="uploadInfo(3);">上传其他证书</a>');
		           	 			if(!org || org.orgUpload3 == null || org.orgUpload3 == ""){
		            	 			
		            	 		}else{
		            	 			if(org.orgUpload3.indexOf(',')>-1)
		            	 			{
		            	 				var upId3 = org.orgUpload3.split(',');
		            	 				for(var i=0;i<upId3.length;i++){
		            	 					findByMaterial(upId3[i],3,1);
		            	 				}
		            	 			}else{
		            	 				findByMaterial(org.orgUpload3,3,1);
		            	 			}
		            	 		}
					</script>
	          	</td>
	         </tr>
		          
	          <tr>
	            <td height="40" align="right">选择企业类型：</td>
	            <td colspan="2">
	            	<input type="text" class="inponly" name="type" id="type" maxlength="10" readonly> 
	            	<input type="hidden" class="inponly" name="zyctype" id="zyctype" maxlength="10" readonly> 
					<span class="red">*</span>
	            </td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">联系人：</td>
	            <td><input type="text" class="inps" name="linkman" id="linkman" maxlength="10"  onblur="checkVal(this.name);"> </td>
	            <td><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" width="120" align="right">移动电话：</td>
	            <td width="170">
	            	<input type="text" class="inps" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" > <span class="red">*</span>
	            </td>
	            <td><label name="mobileLab" id="mobileLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">固定电话：</td>
	            <td>
	            	<input type="text" class="inps" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);" > <span class="red">*</span>
	            </td>
	            <td><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">传真：</td>
	            <td>
	            	<input type="text" class="inps" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);" > <span class="red">*</span>
	            </td>
	            <td><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
	          </tr>
	          
	          <tr>
	            <td height="40" align="right">电子邮箱：</td>
	            <td>
	            	<input type="text" class="inps" name="email" id="email" maxlength="30" onblur="checkVal(this.name);" >
	            </td>
	            <td><label name="emailLab" id="emailLab" class="noico"></label></td>
	          </tr>
	          <tr>
	            <td height="40" align="right">所属区域：</td>
	            <td colspan="2">
	            	<select name="province" id="province"  style="width:120px;"></select>
					<select name="city" id="city"></select>
					<select name="area" id="area"></select>
	            	<span class="red">*</span>
	           	</td>
	          </tr>
	          <tr>
	            <td height="40" align="right">邮编：</td>
	            <td>
	            	<input type="text" class="inps" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> 
	            </td>
	            <td><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
	                </tr>
	                
	          <tr>
				<td height="40" align="right">经营地址：</td>
				<td>
	            	<input type="text" class="inps" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);" > <span class="red">*</span>
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
				<td><input type="button" value="选取经纬度" class="sbt" id="lonlat" onclick="openMap()"></td>
	          </tr>
	          <tr>
	            <td></td>
	            <td><input type="button" value="确  认" class="sbt" onclick="showinfo();" id="finishcodebtn" disabled="disabled" style="width:120px; height:40px; font-weight: bolder; font-size:14px;"></td>
	            <td></td>
	          </tr>
	        </table>
	    </form>
	</body>
</html>
	<script type="text/javascript" language="javascript" src="/js/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
    <script language="javascript" defer>
    
   	function checkCode(str){
			return /[\·\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
	}
	
    var gap='<tr><td height="40" align="right">GAP：</td><td><input type="text" class="inp" name="gapcode" id="gapcode" maxlength="50" onblur="checkVal(this.name)"></td><td><label name="gapcodeLab" id="gapcodeLab" class="noico"></label></td></tr>';
	var gmp='<tr><td height="40" align="right">GMP：</td><td><input type="text" class="inp" name="gmpcode" id="gmpcode" maxlength="50" onblur="checkVal(this.name)"> <span class="red">*</span></td><td><label name="gmpcodeLab" id="gmpcodeLab" class="noico"></label></td> </tr>';
	var gsp='<tr><td height="40" align="right">GSP：</td><td><input type="text" class="inp" name="gspcode" id="gspcode" maxlength="50" onblur="checkVal(this.name)"> <span class="red">*</span></td><td><label name="gspcodeLab" id="gspcodeLab" class="noico"></label></td> </tr>';
    /**
	*非集团下属机构和企业信息一样
	*/
	var corpzyctype;
	$(function(){
		$("#orgname").focus();
		corpzyctype = "${zyctype}";
		var arr = parent.getArr(corpzyctype-1);
		//alert("corpzyctype>"+corpzyctype+" arr>"+arr);
		//如果企业有输入信息
		if(!arr){
			$("#masterman").val(parent.document.getElementById("masterman").value);
			$("#identitycard").val(parent.document.getElementById("identitycard").value);
			$("#businesscode").val(parent.document.getElementById("businesscode").value);
			$("#orgcode").val(parent.document.getElementById("orgcode").value);
			var zyctype;
			var type;
			if(corpzyctype == 1){
				type = "药材种植"
				zyctype = "10000000";
				$("table tr:last").before(gap);
			}else if(corpzyctype == 2){
				type = "药材经销商"
				zyctype = "01000000";
			}else if(corpzyctype == 3){
				type = "饮片生产"
				zyctype = "00100000";
				$("table tr:last").before(gmp);
			}else if(corpzyctype == 4){
				type = "饮片经销商"
				zyctype = "00010000";
				$("table tr:last").before(gsp);
				$("#tit").html("注册饮片经销企业,同时可以进行药材买卖");
			}
			$("#type").val(type);
			$("#zyctype").val(zyctype);
			$("#linkman").val(parent.document.getElementById("linkman").value);
			$("#mobile").val(parent.document.getElementById("mobile").value);
			$("#telephone").val(parent.document.getElementById("telephone").value);
			$("#officephone").val(parent.document.getElementById("officephone").value);
			$("#email").val(parent.document.getElementById("email").value);
			$("#postcode").val(parent.document.getElementById("postcode").value);
			$("#registeraddress").val(parent.document.getElementById("registeraddress").value);
			$("#longitude").val(parent.document.getElementById("longitude").value);
			$("#latitude").val(parent.document.getElementById("latitude").value);
			$("#uploadTokenid").val($("input[name='tokenid']").val());
		}else{
			$("#orgname").val(arr.orgname);
			$("#orgshortname").val(arr.orgshortname);
			$("#masterman").val(arr.masterman);
			$("#identitycard").val(arr.identitycard);
			$("#businesscode").val(arr.businesscode);
			$("#orgcode").val(arr.orgcode);
			var zyctype;
			var type;
			if(corpzyctype == 1){
				type = "药材种植"
				zyctype = "10000000";
				$("table tr:last").before(gap);
			}else if(corpzyctype == 2){
				type = "药材经销商"
				zyctype = "01000000";
			}else if(corpzyctype == 3){
				type = "饮片生产"
				zyctype = "00100000";
				$("table tr:last").before(gmp);
			}else if(corpzyctype == 4){
				type = "饮片经销商"
				zyctype = "00010000";
				$("table tr:last").before(gsp);
			}
			$("#type").val(type);
			$("#zyctype").val(zyctype);
			$("#linkman").val(arr.linkman);
			$("#mobile").val(arr.mobile);
			$("#telephone").val(arr.telephone);
			$("#officephone").val(arr.officephone);
			$("#email").val(arr.email);
			$("#province").attr("v",arr.province);
			$("#city").attr("v",arr.city);
			$("#area").attr("v",arr.area);
			$("#postcode").val(arr.postcode);
			$("#registeraddress").val(arr.registeraddress);
			$("#longitude").val(arr.longitude);
			$("#latitude").val(arr.latitude);
			$("#gapcode").val(arr.gapcode);
			$("#gmpcode").val(arr.gmpcode);
			$("#gspcode").val(arr.gspcode);
			$("#uploadTokenid").val(arr.tokenid);
		}
		
		//alert("aa"+$("#uploadTokenid").val());
		$('.inp, .inps , .inponly').css('padding',5);
	})
	
	
	window.onerror = function(){
		return true;
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
	var ajaxOrgFlag = false;
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="orgname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("组织机构名称没有输入");
				ajaxOrgFlag = false;
				return ajaxOrgFlag;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文!");
				ajaxOrgFlag = false;
				return ajaxOrgFlag;
			}
			
			
			if(getBytesLength(nameval) > 42){
				checkerror(name);
				namelab.html("组织机构名称超长");
				ajaxOrgFlag = false;
				return ajaxOrgFlag;
			}
			
			if(nameval==parent.document.getElementById("corpname").value){
				checkerror(name);
				namelab.html("组织名称已经存在!");
				ajaxOrgFlag = false;
				return ajaxOrgFlag;
			}
			
			for(var i = 0 ; i< 3 ;i++){
				//alert(parent.getArr(i));
				if(parent.getArr(i) != null){
					if(i == corpzyctype -1){
						continue;
					}
					
					if(nameval == parent.getArr(i).orgname){
						checkerror(name);
						namelab.html("组织名称已经存在!");
						ajaxOrgFlag = false;
						return ajaxOrgFlag;
					}
				}
			}
			
			var url="<%=request.getContextPath()%>/orgAjax!findByExist.shtml?rid="+Math.random();
			$.getJSON(url,{'orgname':$("#orgname").val()}, function(data) {
				$("#orgname").attr("disabled","disabled");
				if(data.model.returncode != 0 ){
					checkerror(name);
					namelab.html(data.model.returninfo);
					$("#orgname").removeAttr("disabled");
					ajaxOrgFlag = false;
					return ajaxOrgFlag;
				}else{
					$("#orgname").removeAttr("disabled");
					checksuccess(name);
					ajaxOrgFlag = true;
					return ajaxOrgFlag;
				}
			});
		}
		
		if(name=="orgshortname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("组织机构简称没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文!");
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
		if(name=="businesscode"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("营业执照号没有输入");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="masterman"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("组织机构法人没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文！");
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
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文！");
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
				if(checkEmail(nameval)==false||nameval==null||nameval==""){
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
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文！");
				return false;
			}
			checksuccess(name);
		}
		if(name=="gapcode"){
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
				var gapcodeLab = $("#gapcodeLab");
				gapcodeLab.attr("class", "noico");
			}
		}
		
		if(name=="gmpcode"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("GMP没有填写！");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("非法字符！");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="gspcode"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("GSP没有填写！");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("非法字符！");
				return false;
			}
			checksuccess(name);
		}
	}

	var orgUpload3 = "";
	function showinfo(){
		$("#otherdiv").find("a[id^='del']").each(function (i) {
			var currentId = $(this).attr("id").substr($(this).attr("id").length-3)+",";
			orgUpload3 += currentId;
		});
		orgUpload3=orgUpload3.substr(0,orgUpload3.length-1);
		var flag=0;
		$("input").each(function(){
			if($(this).attr("name")!="orgname"){
			    if(checkVal($(this).attr("name"))==false){
				    flag =1;
					return false;
				}
			}
		});
		//alert("flag:"+flag+"ajaxOrgFlag:"+ajaxOrgFlag);
		if(flag==0 && ajaxOrgFlag){
			//封装集团下属单位的信息传回企业信息页面
			var up1 = $("#businesscodediv table tbody tr").eq(0).attr('id')?$("#businesscodediv table tbody tr").eq(0).attr("id").substring(2):0;
			var up2 = $("#orgcodediv table tbody tr").eq(0).attr('id')?$("#orgcodediv table tbody tr").eq(0).attr("id").substring(2):0;
			var upId3 = $("#otherdiv").find('tr');
			var up3 = '';
			for(var i=0;i<$(upId3).length;i++){
				if($(upId3).eq(i).attr('id')){
					up3 = up3 + $(upId3).eq(i).attr('id').substring(2) + ',';
				}
			};
			if(up3.lastIndexOf(',')>-1){
				up3 = up3.substring(0, up3.lastIndexOf(',')) + up3.substring(up3.lastIndexOf(',') + 1, up3.length)
			}
			var obj = {"type":corpzyctype,"orgname":$("#orgname").val(),"orgshortname":$("#orgshortname").val()
			,"masterman":$("#masterman").val(),"identitycard":$("#identitycard").val(),"businesscode":$("#businesscode").val()
			,"orgcode":$("#orgcode").val(),"zyctype":$("#zyctype").val(),"linkman":$("#linkman").val()
			,"mobile":$("#mobile").val(),"telephone":$("#telephone").val(),"officephone":$("#officephone").val()
			,"email":$("#email").val(),"province":$("#province").val(),"city":$("#city").val()
			,"area":$("#area").val(),"postcode":$("#postcode").val(),"registeraddress":$("#registeraddress").val()
			,"longitude":$("#longitude").val(),"latitude":$("#latitude").val(),"uploadids":$("#uploadids").val()
			,"gapcode":$("#gapcode").val()?$("#gapcode").val():"","gmpcode":$("#gmpcode").val()?$("#gmpcode").val():""
			,"gspcode":$("#gspcode").val()?$("#gspcode").val():"","orgUpload1":up1,"orgUpload2":up2,"orgUpload3":up3
			,"tokenid":$("#uploadTokenid").val()};
			//alert(obj);
			parent.closeRegisterOrg(corpzyctype-1,obj);
		}
	}

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

