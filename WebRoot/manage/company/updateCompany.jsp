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
		<link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
		<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
		<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
		<script type="text/javascript">
			//uploadType 上传的文件类型  1营业执照 2组织机构代证码 3其他证书
		function uploadInfo(uploadType){
			$("#uploadType").val(uploadType);
			$("#btnfinish").attr("disabled","disabled");	
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
					$("#btnfinish").removeAttr("disabled");
					
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':0,'id':$("#companyid").val()},//提交到action中的数据
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
		         		$("#btnfinish").removeAttr("disabled");
		         		if(fileObj.size>1024*1024*2){
		         			alert("单个文件小于2M!");		
		         			return;
		         		}
			            var content = eval('(' + response + ')');    
			            //alert(content.model.id+"  "+content.model.uploadtype+"  "+content.model.type);            
		            	findByMaterial(content.model.id,content.model.uploadtype,content.model.type);
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':0,'id':$("#companyid").val()},//提交到action中的数据
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
		            	findByMaterial(content.model.id,content.model.uploadtype,content.model.type);
		            },
		            'onAllComplete' : function(event,data){
		            	dia.close();
		         		$("#btnfinish").removeAttr("disabled");
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
    	*根据企业id,类型查询已经上传的附件
    	*/
	    function findByMaterial(id,uploadtype,type){
	    	//alert(id+" "+uploadtype+" "+type);
	    	var data="";
	    	data+="id="+id+"&uploadtype="+uploadtype+"&type="+type;			
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
	    	var str = '<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox">';
    		if(uploadtype == 1){
        		matdiv = $("#businesscodediv");
        	}
        	else if(uploadtype == 2){
        		matdiv = $("#orgcodediv");
        	}
        	else if(uploadtype == 3){
        		matdiv = $("#otherdiv");
        		str = '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(3);">上传其他证书</a>';
        		str +='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox2">';
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
        			$(".uploadbox2").html(str);
        			return;
        		};
        	}else{
        		str+='</table>';
        	}
	    	if(str=='<table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox"></table>'||str=='<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(3);">上传其他证书</a><table width="80%" cellpadding="0" cellspacing="0" border="0" class="uploadbox2"></table>'){
	    		str = '';
	    		if(uploadtype == 1){
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(1);">上传营业执照</a>';
	    		}else if(uploadtype == 2){
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(2);">上传组织机构代码证</a>';
	    		}else{
	    			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(3);">上传其他证书</a>';
	    		}
	    		str += '';
	    	}
	    		
	    	matdiv.html(str);
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
	    	data+="uploadid="+uploadidtemp+"&uploadtype="+uploadtypetemp+"&type=0";			
			var url="<%=request.getContextPath()%>/orgUploadAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				findByMaterial($("#companyid").val(),data.model.uploadtype,0);
			});
	    }
	    
			
		</script>
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：备案管理 > 备案编辑</div>
		<form action="company!update.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="companyid" id="companyid" value="${requestScope.company.companyid }">
		<input type="hidden" name="zyctype" id="zyctype" value="${requestScope.company.zyctype }">
		<input type="hidden" name="areacode" id="areacode" value="${requestScope.company.areacode }">
		<input type="hidden" name="cpccorp" id="cpccorp" value="${requestScope.company.cpccorp }">
		<!-- <input type="hidden" name="corpshortname" id="corpshortname" value="${requestScope.company.corpshortname }"> -->
		<input type="hidden" name="uploadType" id="uploadType"/>
		<input type="hidden" name="uploadids" id="uploadids"/>
		<input type="hidden" name="corp" id="corp" value="${requestScope.company.corp }"/>
		<div class="form-box">
				<div class="fb-tit">备案编辑</div>
			    <div class="reg-box mt10">
			        <table width="100%" border="0" cellpadding="0" cellspacing="0">
			          <tr>
			            <td height="30" align="right">企业类型：</td>
			           	<td colspan="4" id="zyctypetd">
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 0, 1)=='1'}">药材种植 &nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 1, 2)=='1'}">药材经销商 &nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 2, 3)=='1'}">饮片生产&nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 3, 4)=='1'}">饮片经销商&nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 4, 5)=='1'}">药材市场 &nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 5, 6)=='1'}">医院 &nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 6, 7)=='1'}">管理机构 &nbsp;&nbsp;</c:if>
			           		<c:if test="${fn:substring(requestScope.company.zyctype, 7, 8)=='1'}">其他 &nbsp;&nbsp;</c:if>
			           	</td>
                      </tr>
                      <c:if test="${fn:substring(requestScope.company.zyctype, 0, 1)=='1'}">
                      <tr>
			            <td width="150" height="30" align="right">GAP：</td>
			            <td width="170">
			            	<input type="text" class="inponly" id="gapcode"  name="gapcode" readonly maxlength="50" value="${requestScope.company.gapcode }">
			            </td>
			            <td >&nbsp;</td>
			          </tr>
			          </c:if>
			          <c:if test="${fn:substring(requestScope.company.zyctype, 2, 3)=='1'}">
			          <tr>
			            <td width="150" height="30" align="right">GMP：</td>
			            <td width="170">
			            	<input type="text" class="inponly" id="gmpcode"  name="gmpcode" readonly maxlength="50" value="${requestScope.company.gmpcode }">
			            </td>
			            <td>&nbsp;</td>
			          </tr>
			          </c:if>
			          <c:if test="${fn:substring(requestScope.company.zyctype, 3, 4)=='1'}">
			          <tr>
			            <td width="150" height="30" align="right">GSP：</td>
			            <td width="170">
			            	<input type="text" class="inponly" id="gspcode"  name="gspcode" readonly maxlength="50" value="${requestScope.company.gspcode }">
			            </td>
			            <td>&nbsp;</td>
			          </tr>
			          </c:if>
			          <tr>
			            <td width="150" height="30" align="right">企业名称：</td>
			            <td width="170">
			            	<input type="text" class="inponly" id="corpname"  name="corpname" readonly maxlength="50" value="${requestScope.company.corpname }">
			            </td>
			            <td width="370"><label name="corpnameLab" id="corpnameLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td width="150" height="30" align="right">企业简称：</td>
			            <td width="170">
			            	<input type="text" class="inponly" id="corpshortname"  name="corpshortname" readonly maxlength="50" value="${requestScope.company.corpshortname }">
			            </td>
			            <td width="370"><label name="corpshortnameLab" id="corpshortnameLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">营业执照号：</td>
			            <td>
				            <input type="text" class="inps" name="businesscode" id="businesscode" maxlength="100" onblur="checkVal(this.name);" value="${requestScope.company.businesscode }"> <span class="red">*</span>
						</td>
			            <td><label name="businesscodeLab" id="businesscodeLab" class="noico"></label>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">营业执照：</td>
			            <td colspan="2" id="businesscodediv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${company.companyid != null}">
									findByMaterial("${company.companyid}",1,0);
								</c:if>
							</script>
			          	</td>
			          </tr>
			           
			          
			          <tr>
			            <td height="30" align="right">组织机构代码：</td>
			            <td><input type="text" class="inps" name="orgcode" id="orgcode" maxlength="100" value="${requestScope.company.orgcode }" onblur="checkVal(this.name);"> </td>
			            <td><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">组织机构代码证：</td>
			            <td colspan="2" id="orgcodediv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${company.companyid != null}">
									findByMaterial("${company.companyid}",2,0);
								</c:if>
							</script>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">其他证书：</td>
			            <td colspan="2" id="otherdiv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${company.companyid != null}">
									findByMaterial("${company.companyid}",3,0);
								</c:if>
							</script>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">法人：</td>
			            <td>
			            	<input type="text" class="inps" name="masterman" id="masterman" maxlength="10" onblur="checkVal(this.name);" value="${requestScope.company.masterman }"> <span class="red">*</span>
						</td>
			            <td><label name="mastermanLab" id="mastermanLab" class="noico"></label></td>
			          </tr>
			          
                      <tr>
			          	<td height="30" align="right">法人身份证：</td>
			          	<td><input type="text" class="inps" name="identitycard" id="identitycard" maxlength="18" onblur="checkVal(this.name);" value="${requestScope.company.identitycard }"> <span class="red">*</span></td>
			          	<td><label name="identitycardLab" id="identitycardLab" class="noico"></label></td>
                      </tr>
                      
                      <tr>
			            <td height="30" align="right">联系人：</td>
                        <td><input type="text" class="inps" name="linkman" id="linkman" maxlength="10" value="${requestScope.company.linkman }" onblur="checkVal(this.name);"> </td>
                        <td><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">移动电话：</td>
			            <td>
			            	<input type="text" class="inps" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${requestScope.company.mobile }"> <span class="red">*</span>
						</td>
			            <td><label name="mobileLab" id="mobileLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">固定电话：</td>
			            <td>
			            	<input type="text" class="inps" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);"  value="${requestScope.company.telephone }"> <span class="red">*</span>
						</td>
			            <td><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">传真：</td>
			            <td>
			            	<input type="text" class="inps" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);"   value="${requestScope.company.officephone }"> <span class="red">*</span>
						</td>
			            <td><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
			          </tr>
			          
			          
			          <tr>
			            <td height="30" align="right">电子邮箱：</td>
			            <td>
			            	<input type="text" class="inps" name="email" id="email" maxlength="30" onblur="checkVal(this.name);" value="${requestScope.company.email }"> 
						</td>
						<td><label name="emailLab" id="emailLab" class="noico"></label></td>
			          </tr>
			          <tr>
			            <td height="30" align="right">所属区域：</td>
			            <td colspan="4">
			            	<input type="text" name="province" id="province" value="${requestScope.company.province }" class="inponly" readonly />
		            		<input type="text" name="city" id="city" value="${requestScope.company.city }" class="inponly" readonly />
		            		<input type="text" name="area" id="area" value="${requestScope.company.area }" class="inponly" readonly />
			           	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">邮编：</td>
			            <td>
			            	<input type="text" class="inps" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${requestScope.company.postcode }"> 
			            </td>
			            <td><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
                      </tr>
                      
			          <tr>
						<td height="30" align="right">经营地址：</td>
						<td>
			            	<input type="text" class="inps" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);" value="${requestScope.company.registeraddress }"> <span class="red">*</span>
						</td>
						<td ><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
			          </tr>
			          <tr>
						<td height="30" align="right">经度：</td>
						<td>
			            	<input type="text" class="inps" name="longitude" id="longitude" maxlength="6" readonly value="${requestScope.company.longitude }">
						</td>
						<td colspan="3"></td>
			          </tr>
			          <tr>
						<td height="30" align="right">纬度：</td>
						<td>
			            	<input type="text" class="inps" name="latitude" id="latitude" maxlength="6" readonly value="${requestScope.company.latitude }">
						</td>
						<td colspan="3"><input type="button" value="选取经纬度" class="sbt" id="lonlat" onclick="openMap()"></td>
			          </tr>
			          <!-- 
			          <tr>
			            <td height="30" align="right">需要申请CA证书个数：</td>
			            <td>
			            	<input type="text" class="inps" name="canum" id="canum" maxlength="3" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${requestScope.company.canum }"> <span class="red">*</span>
						</td>
			            <td><label name="canumLab" id="canumLab" class="noico"></label></td>
			          </tr>
			         -->  
			        </table>
				</div>
				<div class="fb-bom">

			        
			        <c:if test="${requestScope.returninfo=='更新成功!' }">
			        	<cite><input type="button" value="返回备案信息列表" onclick="goFindCompany();" class="sbt"></cite>
			        </c:if>
			        <c:if test="${requestScope.returninfo!='更新成功!'||requestScope.returninfo==null }">
			        	<cite><input type="button" value="更新信息" onclick="return showinfo();" class="sbt" id="btnfinish"></cite>
			        </c:if>
			        <span class="red">${requestScope.returninfo }</span>
			    </div>
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
					<!-- 
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">CA个数：</td><td colspan="3"><label id="l_canum" /></td>
					</tr>
					 -->
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	window.onerror = function(){
		return true;
	} 
	
	
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
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
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
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
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
		if(name=="orgcode"){
			if(nameval!=""){
				if(checkquotmarks_businesscode(nameval)){
					checkerror(name);
					namelab.html("不要输入非法字符！");
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
		if(name=="canum"){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("CA证书没有输入");
				return false;
	    	}
			checksuccess(name);
		}
	}

	function showinfo(){
		var uploadids = "";
		$("a[id^='del']").each(function (i) {
			var currentId = $(this).attr("id").substr($(this).attr("id").length-3)+",";
			uploadids += currentId;
		});
		$("#uploadids").val(uploadids.substr(0,uploadids.length-1));
		
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
		
		$("#l_region").text($("#province").val()+$("#city").val()+$("#area").val());
		$("#l_zyctypedisplay").text($("#zyctypetd").text());
		editSure();
		$("#btnfinish").attr("disabled","disabled");
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
	function goFindCompany(){
		$("#corpname").val("");
		$("#province").val("");
		$("#city").val("");
		$("#area").val("");
		$("#dataForm").attr("action", "company!findByList.shtml");
		$("#dataForm").submit();
	}
	
	    
	</script>
	
	</body>
</html>