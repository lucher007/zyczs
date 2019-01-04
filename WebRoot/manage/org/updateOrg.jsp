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
		window.onerror = function(){
			return true;
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':1,'id':$("#orgid").val()},//提交到action中的数据
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
		            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':1,'id':$("#orgid").val()},//提交到action中的数据
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
	    	data+="uploadid="+uploadidtemp+"&uploadtype="+uploadtypetemp+"&type=1";			
			var url="<%=request.getContextPath()%>/orgUploadAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				findByMaterial($("#orgid").val(),data.model.uploadtype,1);
			});
	    }
	    
			
		</script>
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：下属单位管理 > 编辑下属单位</div>
		
		<form action="org!update.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="orgid" id="orgid" value="${requestScope.org.orgid }" />
		<input type="hidden" name="uploadType" id="uploadType"/>
		<input type="hidden" name="uploadids" id="uploadids" value="${uploadids}"/>
		<input type="hidden" name="supercpccode" id="supercpccode" value="${org.supercpccode}"/>
		<input type="hidden" name="zyctype" id="zyctype" value="${org.zyctype}"/>
		<input type="hidden" name="areacode" id="areacode" value="${org.areacode}"/>
		<input type="hidden" name="cpccorp" id="cpccorp" value="${org.cpccorp}"/>
		<input type="hidden" name="identitycard" id="identitycard" value="${org.identitycard}"/>
		<input type="hidden" name="masterman" id="masterman" value="${org.masterman}"/>
	    <div class="form-box">
	    	<div class="fb-tit">编辑下属单位</div>
        	<div class="fb-con">
		        <table border="0" cellpadding="0" cellspacing="0">
		         
		          <tr>
		            <td height="30" align="right">组织机构名称：</td>
		            <td>
		            	<input type="text" class="inponly" readonly name="orgname" id="orgname" maxlength="50" onblur="checkVal(this.name);" value="${requestScope.org.orgname }"> <span class="red">*</span>
		            </td>
		            <td><label name="orgnameLab" id="orgnameLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">组织机构简称：</td>
		            <td>
		            	<input type="text" class="inponly" readonly name="orgshortname" id="orgshortname" maxlength="50" onblur="checkVal(this.name);" value="${requestScope.org.orgshortname }"> <span class="red">*</span>
		            </td>
		            <td><label name="orgnameLab" id="orgnameLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">企业类型：</td>
		            <td colspan="2" id="td_zyctype">
		            	<c:if test="${fn:substring(requestScope.org.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		            </td>
		          </tr>
		          
		           <tr>
			            <td height="30" align="right">营业执照号：</td>
			            <td>
				            <input type="text" class="inps" name="businesscode" id="businesscode" maxlength="100" onblur="checkVal(this.name);" value="${requestScope.org.businesscode }"> <span class="red">*</span>
						</td>
			            <td><label name="businesscodeLab" id="businesscodeLab" class="noico"></label>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">营业执照：</td>
			            <td colspan="2" id="businesscodediv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${org.orgid != null}">
									findByMaterial("${org.orgid}",1,1);
								</c:if>
							</script>
			          	</td>
			          </tr>
			           
			          
			          <tr>
			            <td height="30" align="right">组织机构代码：</td>
			            <td><input type="text" class="inps" name="orgcode" id="orgcode" maxlength="100" value="${requestScope.org.orgcode }" onblur="checkVal(this.name);"> </td>
			            <td><label name="orgcodeLab" id="orgcodeLab" class="noico"></label></td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">组织机构代码证：</td>
			            <td colspan="2" id="orgcodediv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${org.orgid != null}">
									findByMaterial("${org.orgid}",2,1);
								</c:if>
							</script>
			          	</td>
			          </tr>
			          
			          <tr>
			            <td height="30" align="right">其他证书：</td>
			            <td colspan="2" id="otherdiv">
			          		 <script type="text/javascript" language="javascript">
								<c:if test="${org.orgid != null}">
									findByMaterial("${org.orgid}",3,1);
								</c:if>
							</script>
			          	</td>
			          </tr>
			          
			          
		          <tr>
		            <td height="30" align="right">联系人：</td>
		            <td><input type="text" class="inps" name="linkman" id="linkman" maxlength="10" value="${requestScope.org.linkman }" onblur="checkVal(this.name);"> </td>
		            <td><label name="linkmanLab" id="linkmanLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" width="120" align="right">移动电话：</td>
		            <td width="170">
		            	<input type="text" class="inps" name="mobile" id="mobile" maxlength="11" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${requestScope.org.mobile }"> <span class="red">*</span>
		            </td>
		            <td  width="370"><label name="mobileLab" id="mobileLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">固定电话：</td>
		            <td>
		            	<input type="text" class="inps" name="telephone" id="telephone" maxlength="20" onblur="checkVal(this.name);"  value="${requestScope.org.telephone }"> <span class="red">*</span>
		            </td>
		            <td><label name="telephoneLab" id="telephoneLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">传真：</td>
		            <td>
		            	<input type="text" class="inps" name="officephone" id="officephone" maxlength="20" onblur="checkVal(this.name);"  value="${requestScope.org.officephone }"> <span class="red">*</span>
		            </td>
		            <td><label name="officephoneLab" id="officephoneLab" class="noico"></label></td>
		          </tr>
		          
		          <tr>
		            <td height="30" align="right">电子邮箱：</td>
		            <td>
		            	<input type="text" class="inps" name="email" id="email" maxlength="30" onblur="checkVal(this.name);" value="${requestScope.org.email }"> 
		            </td>
		            <td><label name="emailLab" id="emailLab" class="noico"></label></td>
		          </tr>
		           <tr>
		            <td height="30" align="right">所属区域：</td>
		            <td colspan="2">
		            	<input type="text" name="province" id="province" value="${requestScope.org.province }" class="inponly" readonly="readonly" />
		            	<input type="text" name="city" id="city" value="${requestScope.org.city }" class="inponly" readonly="readonly" />
		            	<input type="text" name="area" id="area" value="${requestScope.org.area }" class="inponly" readonly="readonly" />
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">邮编：</td>
		            <td>
		            	<input type="text" class="inps" name="postcode" id="postcode" maxlength="6" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);" value="${requestScope.org.postcode }"> 
		            </td>
		            <td><label name="postcodeLab" id="postcodeLab" class="noico"></label></td>
                  </tr>
                  
		          <tr>
					<td height="30" align="right">经营地址：</td>
					<td>
		            	<input type="text" class="inps" name="registeraddress" id="registeraddress" maxlength="50" onblur="checkVal(this.name);" value="${requestScope.org.registeraddress }"> <span class="red">*</span>
					</td>
					<td colspan="3"><label name="registeraddressLab" id="registeraddressLab" class="noico"></label></td>
		          </tr>
		          <tr>
					<td height="30" align="right">经度：</td>
					<td>
		            	<input type="text" class="inps" name="longitude" id="longitude" maxlength="6" readonly value="${requestScope.org.longitude }">
					</td>
					<td></td>
		          </tr>
		          <tr>
					<td height="30" align="right">纬度：</td>
					<td>
		            	<input type="text" class="inps" name="latitude" id="latitude" maxlength="6" readonly value="${requestScope.org.latitude }">
					</td>
					<td><input type="button" value="选取经纬度" class="sbt" id="lonlat" onclick="openMap()"></td>
		          </tr>
		        </table>
	        </div>
	        
	        <div class="fb-bom">
	        	 <c:if test="${requestScope.returninfo=='更新成功!' }">
		        	<cite><input type="button" value="返回备案信息列表" onclick="goFindCompany();" class="sbt"></cite>
		        </c:if>
		        <c:if test="${requestScope.returninfo!='更新成功!'||requestScope.returninfo==null }">
		        	<cite><input type="button" value="更新信息" class="sbt" onclick="return showinfo();" id="finishcodebtn"></cite>
		        </c:if>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
	    <div class="pop-box" id="pop-div">
			<div id="divTitle" >
				<table width="500" >
					<tr>
						<td width="140px;" height="30" bgcolor="#EEEEEE" align="right">选择所属区域：</td><td><label id="l_region" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">组织机构名称：</td><td><label id="l_orgname" /></td>
					</tr>
					<tr>
						<td height="30" bgcolor="#EEEEEE" align="right">组织机构简称：</td><td><label id="l_orgshortname" /></td>
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
						<td height="30" bgcolor="#EEEEEE" align="right">企业类型：</td><td colspan="3"><label id="l_td_zyctype" /></td>
					</tr>
				</table>
			</div>
		</div>
	    </form>
	</div>
	</body>
    <script language="javascript" defer>
	var gap = '<tr><td height="30" align="right">GAP：</td><td><input type="text" class="inponly" name="gapcode"  id="gapcode"   maxlength="50" value="${org.gapcode}"></tr>';
	var gsp = '<tr><td height="30" align="right">GSP：</td><td><input type="text" class="inponly" name="gspcode" id="gspcode"     maxlength="50" value="${org.gspcode}"></tr>';
	var gmp = '<tr><td height="30" align="right">GMP：</td><td><input type="text" class="inponly" name="gmpcode" id="gmpcode"  maxlength="50" value="${org.gmpcode}"></tr>';
	
	var lgap = '<tr><td height="30" bgcolor="#EEEEEE" align="right">GAP：</td><td colspan="3"><label id="l_gapcode" /></td></tr>';
	var lgsp = '<tr><td height="30" bgcolor="#EEEEEE" align="right">GSP：</td><td colspan="3"><label id="l_gspcode" /></td></tr>';
	var lgmp = '<tr><td height="30" bgcolor="#EEEEEE" align="right">GMP：</td><td colspan="3"><label id="l_gmpcode" /></td></tr>';
	/**
    *页面加载完毕根据选中企业类型判断追加gap,gsp,gmp
    */
    $(function(){
    	var select = $("#zyctype").val();
    //	alert(select);
    	if(select == "10000000"){
    		$(".fb-con table").find("tr:last").after(gap);
    		$(".pop-box").find("tr:last").after(lgap);
    	}else if(select == "00100000"){
    		$(".fb-con table").find("tr:last").after(gmp);
    		$(".pop-box").find("tr:last").after(lgmp);
    	}else if(select == "00010000"){
    		$(".fb-con table").find("tr:last").after(gsp);
    		$(".pop-box").find("tr:last").after(lgsp);
    	}
    });
	
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
	
	//验证查询框不能输入以下字符
	function checkorgname(str){
		return /[\·\'\"\~\`\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
	}
	
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="orgname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("组织机构名称没有输入");
				return false;
	    	}
			if(checkorgname(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符,只包括大小写字母中文!");
				return false;
			}
			checksuccess(name);
		}
		
		if(name=="orgshortname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("组织机构简称没有输入");
				return false;
	    	}
			if(checkorgname(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符,只包括大小写字母中文!");
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
					namelab.html("组织机构代码证输入不正确");
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
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
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
		
		$("#l_region").text($("#province").val()+$("#city").val()+$("#area").val());
		$("#l_zyctype").text($("#zyctype").text());
		$("#l_td_zyctype").text($("#td_zyctype").html());
		editSure();
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
		$("#province").val("");
		$("#city").val("");
		$("#area").val("");
		$("#dataForm").attr("action", "company!findByList.shtml");
		$("#dataForm").submit();
	}
	
	</script>
</html>
