<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
	    <base href="<%=basePath%>">    
	    <title>饮片检验</title>
	    <link href="<%=basePath%>js/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
	    <link type="text/css" rel="stylesheet" href="/style/plant.css"> 
	    <link type="text/css" rel="stylesheet" href="<%=basePath%>style/production.css" />
	    <style type="text/css">
			.filenamecss{
				display: inline-block;
				width:620px;
				height:18px;
				line-height:18px;
				padding:6px 0 0 20px;
				font:bold 14px arial;
				text-decoration:none;
				color:#000000;
				border:0px solid red;
				position: relative;
				top:-3px;
			}
			.filedeletecss{
				display: inline-block;
				width:24px;
				height:24px;
				border:0px solid red;
				cursor:hand;
				background:url('images/error.png') no-repeat center;
			}
		</style>
		<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	    <script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/ajaxobj.js" ></script>
		<script type="text/javascript" src="<%=basePath%>js/form.js" ></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
	    <script type="text/javascript" language="javascript">
	        //显示上传文件
			function showInfo(){
				$("#finishcodebtn").attr("disabled","disabled");
				var uphtml = '';
				uphtml+='<div class="albox">';
				uphtml+='<div class="alb-tit">';
				uphtml+='	<span>上传检验检测报告</span>';
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
	
				$.dialog({
					title:'文件上传',
					id:'upfile',
					lock:false,
					content: uphtml,
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
				$("#uploadify").uploadify({    			   		
		            'uploader'       : '<%=basePath%>js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
		            'script'         : '<%=basePath%>checkAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
		            'cancelImg'      : '<%=basePath%>js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
		            'folder'         : 'uploads',//上传文件的目录
		            'fileDataName'   : 'uploadify',//和input的name属性值保持一致就好，Struts2就能处理了
		            'queueID'        : 'fileQueue',
		            'auto'           : false,//是否选取文件后自动上传
		            'multi'          : true,//是否支持多文件上传
		            'simUploadLimit' : 2,//每次最大上传文件数
		            //'buttonText'     : 'choice file',//按钮上的文字
		            'width'          : 84,
		            'height'         : 29,    			 
		            'buttonImg'      : '<%=basePath%>images/tablet/btnfile.png',
		            'displayData'    : 'speed',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
		            'fileDesc'       : '支持格式:jpg/gif/png/bmp/xls/doc/docx/xlsx.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
		            'fileExt'        : '*.jpg;*.gif;*.png;*.xls;*.doc;*.bmp;*.docx;*.xlsx',//允许的格式                 
					'method'         : 'POST',         
		            'onComplete'     : function (event, queueID, fileObj, response, data){
		            	findByMaterial();
		            //$("#result").html(response);//显示上传成功结果                               
		            //var content = eval('(' + response + ')');                          
		            //document.getElementById("upcontent").innerHTML+=content.model.returnInfo;
		            //document.getElementById("materail").value+=content.model.matname+"€"+content.model.matcontent+"≡";
		            //setInterval("showResult()",2000);//两秒后删除显示的上传成功结果
		            }
		        });		
			}
		
		    //加载文件上传插件
			$(document).ready(function() {
				$(".upbtn").live('click',function(){
		        	$('#uploadify').uploadifySettings("scriptData",{'uploadType':$("#uploadType").val(),'tabletid':$("#tabletid").val(),'type':1,'orgid':'${sessionScope.User.orgid}','loginname':'${sessionScope.User.loginname}'});
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
		    
		    //检验3位小数
		    function checkPoint(str){
		  		var re=/^\d*\.?\d{0,3}$/gi;
		  		return re.test(str);
		  	}
		    
		    function checkForm(){
					var checkcondition = $("#checkcondition");
					if(checkcondition.val()==""||checkcondition.val()==" "||checkcondition.val().length>20){
						$.dialog.alert("贮藏条件未填写，不超过20字！",function(){
							checkcondition.focus();
						});
						return false;
					}
					if(checkcondition.val() != ""){
						if(checkquotmarks(checkcondition.val())){
							$.dialog.alert("贮藏条件有非法字符！",function(){
								checkcondition.focus();
							});
							return false;
						}
					}		
					
			    	var checkuser = $("#checkuser");
					if(checkuser.val()==""||checkuser.val()==" "||checkuser.val().length>20){
						$.dialog.alert("检验人员未填写或不超过20位！",function(){
							checkuser.focus();
						});
						return false;
					}
					if(checkuser.val() != ""){
						if(checkquotmarks(checkuser.val())){
							$.dialog.alert("检验人员有非法字符！",function(){
								checkuser.focus();
							});
							return false;
						}
					}	
		
					var checktime = $("#checktime");
					if(checktime.val()==""||checktime.val()==" "){
						$.dialog.alert("检验时间未填写！",function(){
							checktime.focus();
						});
						return false;
					}
					
					var tabletweight = $("#tabletweight");
					if(tabletweight.val()==""||tabletweight.val()==" "||isNaN(tabletweight.val())||tabletweight.val().length<1||tabletweight.val().length>7){
						$.dialog.alert("待检验重量未填写或填写不正确,最长6位数！",function(){
							tabletweight.focus();
						});
						return false;
					}
					if(checkPoint(tabletweight.val())==false){
						$.dialog.alert("待检验重量不正确，保留三位小数！",function(){
							tabletweight.focus();
						});
						return false;
				  	}
					
					var finishcodebtn = $("#finishcodebtn");
			        finishcodebtn.attr("disabled","disabled");
					
					var strTemp="<table width=100%>";
					strTemp+="<tr><td height=30 align=right width=110 bgcolor=#EEEEEE>饮片批次号：</td><td colspan=\"3\">${requestScope.vo.cpctablet }</td></tr>";
					strTemp+="<tr><td height=30 align=right bgcolor=#EEEEEE>品名：</td><td>${requestScope.vo.tabletname }</td><td align=right bgcolor=#EEEEEE width=110>药材使用重量(Kg)：</td><td width=110>${requestScope.vo.meduseweight/10000 }</td></tr>";
					strTemp+="</table>";
			
					var strTemp2="<table width=100%>";
					strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE width=110>执行标准：</td><td>"+$("#checkmethod").val()+"</td><td align=right bgcolor=#EEEEEE width=110>质量级别：</td><td width=110>"+$("#checkgrade").val()+"</td></tr>";
					strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE>贮藏条件：</td><td>"+$("#checkcondition").val()+"</td><td align=right bgcolor=#EEEEEE>检验人员：</td><td>"+$("#checkuser").val()+"</td></tr>";
					strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE>检验时间：</td><td>"+$("#checktime").val()+"</td><td align=right bgcolor=#EEEEEE>待检验重量(Kg)：</td><td>"+$("#tabletweight").val()+"</td></li>";
					strTemp2+="</table>";
					
					var strHtml ="<div class=\"fdbox\"><div class=\"fd-tit\"><span>饮片信息预览</span></div><div class=\"fd-con\">"+strTemp+"</div></div>";
					strHtml +="<div class=\"fdbox mt10\"><div class=\"fd-tit\"><span>检验信息预览</span></div><div class=\"fd-con\">"+strTemp2+"</div></div>";
					
					$.dialog({
						title:'检验确认信息',
						id:'sureCheck',
						lock:true,
						content: strHtml,
						okVal:'确认检验',
						ok:function(){
						    $("#finishcodebtn").removeAttr("disabled");
							$("#searchform").attr("action","check!saveCheck.shtml");
			        	    $("#searchform").submit();
						},
						cancelVal:'取消',
						cancel:function(){
							finishcodebtn.removeAttr("disabled");
						}
					});	
				}
				
			function findByMaterial(){
		    	var data="";
		    	data+="tabletid="+$("#tabletid").val()+"&orgid="+$("#orgid").val()+"&type=1";
				var url="<%=request.getContextPath()%>/checkAjax!findByMaterial.shtml?rid="+Math.random();
				$.getJSON(url,data,function(msg){
					findByMaterialReturn(msg);
				});	
		    }
		    
		    function findByMaterialReturn(responseText){
		    	var loginForm = responseText;    		
		    	var matlist = loginForm.model.materiallist;
		    	var matdiv= $("#matdiv");
		    	var mattable= $("#mattable");
		    	matdiv.html('');
		    	var str="";
		    	for(var i=0;i<matlist.length;i++){   
		    		if(i%2==0){    
			    		 	
		        		var matcont = matlist[i].matcontent;
		    			matcont=matcont.substring(matcont.length-3,matcont.length);
			    		if(matcont=="jpg"||matcont=="gif"||matcont=="png"||matcont=="bmp"){
		    				str+='<tr><td height=26><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
			    		}else{
			    			str+='<tr><td height=26><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
			    		}
			    		
			        	if(matlist[i].mattype==1){
			        		str+='<td>药材检验报告</td>';
			        	} else if(matlist[i].mattype==2){
			        		str+='<td>饮片检验报告</td>';
			        	} else if(matlist[i].mattype==3){
			        		str+='<td>产地报告</td>';
			        	}
			        	str+='<td><a href="javascript:void(0);" class="btn-del" id="del'+matlist[i].matid +'" onclick="deleteMaterial('+matlist[i].matid+');"></a></td></tr>';
			        }else{
				        
			        	var matcont = matlist[i].matcontent;
		    			matcont=matcont.substring(matcont.length-3,matcont.length);
			    		if(matcont=="jpg"||matcont=="gif"||matcont=="png"||matcont=="bmp"){
		    				str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
			    		}else{
			    			str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
			    		}
			    		
			        	if(matlist[i].mattype==1){
			        		str+='<td bgcolor=#EEEEEE>药材检验报告</td>';
			        	} else if(matlist[i].mattype==2){
			        		str+='<td bgcolor=#EEEEEE>饮片检验报告</td>';
			        	} else if(matlist[i].mattype==3){
			        		str+='<td bgcolor=#EEEEEE>产地报告</td>';
			        	}
			        	str+='<td bgcolor=#EEEEEE><a href="javascript:void(0);" class="btn-del" id="del'+matlist[i].matid +'" onclick="deleteMaterial('+matlist[i].matid+');"></a></td></tr>';
			        }
		    	}
		    	if(str==""){
		    		str = '<tr><td width="706" height="60" align="center" valign="middle"><span class="tip-warning">提示：检验检测报告从未上传</span></td></tr>';
		    	}
		    	matdiv.html(str);
		    	resetH();
			}
			
		    function deleteMaterial(matidtemp){
		    	var data="";
		    	$("#del"+matidtemp).hide();
		    	$("#name"+matidtemp).hide();
		    	data+="matid="+matidtemp;			
				var url="<%=request.getContextPath()%>/checkAjax!deleteMaterial.shtml?rid="+Math.random();
				$.getJSON(url,data,function(msg){
					findByMaterial();
				});
		    }
		    
		    /////////////////////对必要的输入框进行数字合法验证//////////////////////////
			function onkeypressCheck(obj){
				if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
					obj.value = obj.t_value;
				} else {
					obj.t_value = obj.value;
				}
				if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
					obj.o_value = obj.value;
				}
				if(obj.value.match(/^\d+\.\d{4}?$/)){
						obj.value = obj.value.substr(0,obj.value.length-1);
				} 
		}
		
		function onkeyupCheck(obj){
			if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
					obj.value = obj.t_value;
				} else {
					obj.t_value = obj.value;
				}
				if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
					obj.o_value = obj.value;
				}
				if (obj.value.match(/^\.$/)) {
					obj.value = "";
				}
				if (obj.value.match(/^\-$/)) {
					obj.value = "";
				}
				if (obj.value.match(/^00+/)) {
					obj.value = "";
				}
				if (obj.value.match(/^0\.000/)) {
					obj.value = "";
				}
				if (obj.value.match(/^0[1-9]/)) {
					obj.value = "";
				}
				if(obj.value.match(/^\d+\.\d{4}?$/)){
							obj.value = obj.value.substr(0,obj.value.length-1);
				} 
				if(obj.value == 'undefined'){
							obj.value='';
				}
		}
		
		function onkeyblurCheck(obj){
			if(obj.value=="0")
					obj.value='';
			if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
				obj.value = obj.o_value;
			}else {
				if (obj.value.match(/^\.\d+$/)) {
					obj.value = 0 + obj.value;
				}
				
				obj.o_value = obj.value;
			}
			if(!obj.value.match(/^\d+(\.\d{3})?$/)){
				obj.value = obj.value.substr(0,obj.value.indexOf(".")+4);
			} 
		}
		//////////////////////////////////////////////////////////////////////
		function checkData_downControl(){
			window.location.href="<%=basePath%>js/yp.doc";
		}
	    </script> 
	 </head>
	  
	<body>  
		<div id="body">
			<div class="cur-pos">当前位置：饮片生产管理 > 饮片检验</div>
			<div class="form-box">
				<form action="" method="post" name="searchform" id="searchform" enctype="multipart/form-data">
				    <s:token></s:token>
				  	<input type="hidden" name="tabletid" id="tabletid" value="${requestScope.vo.tabletid}" />
				  	<input type="hidden" name="cpctablet" id="cpctablet" value="${requestScope.vo.cpctablet}" />
				  	<input type="hidden" name="orgid" id="orgid" value="${requestScope.vo.orgid}" />
				  	<input type="hidden" name="createtime" id="createtime" value="${requestScope.vo.createtime}" />
				  	<input type="hidden" name="uploadType" id="uploadType" value="2" />
				  	<div class="fb-tit">检验入库</div>
					<div class="fb-con">
						<table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10">
			              <tr>
			                <td class="fbc-box" valign="top">
			                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
			                		<tr class="fbc-tit b">
				                        <td colspan="2">检验信息</td>
				                      </tr>
				                      <tr>
				                        <td height="24" class="b" colspan="2">基本信息</td>
				                      </tr>
				                      <tr>
				                        <td height="24">品名：${requestScope.vo.tabletname }</td>
				                        <td>生产批次号：${requestScope.vo.cpctablet }</td>
				                      </tr>
				                      <tr>
				                        <td height="24">生产规格：${requestScope.vo.tabletspec }</td>
				                        <td>生产时间: ${fn:substring(requestScope.vo.createtime, 0, 11)}</td>
				                      </tr>
				                      <tr>
				                        <td height="24" colspan="2">执行标准：${requestScope.vo.execstandard }</td>
				                      </tr>
				                      <tr>
				                        <td height="24" class="b" colspan="2">原药材</td>
				                      </tr>
				                      <tr>
				                        <td height="24">品名：${requestScope.vo.medname }</td>
				                        <td>批次号：${requestScope.vo.cpcmed }</td>
				                      </tr>
				                      <tr>
				                        <td height="24">使用重量(Kg)：${requestScope.vo.meduseweight/10000 }</td>
				                        <td>产地：${requestScope.vo.medaddress }</td>
				                      </tr>
				                      <!--<tr>
				                        <td height="24" colspan="2">工艺流程：切制,炮制,</td>
				                      </tr>-->
			                	</table>
			                </td>
			                <td width="188" valign="top">
			                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="fbc-box">
			                      <tr class="fbc-tit b"><td height="30">饮片溯源码</td></tr>
			                      <tr>
			                        <td height="150" valign="top" class="dcode">
			                        	<div style="width:150px;height:150px;margin-left:25px;" id="gpcodedivimg">
			                      			<img src="<%=basePath%>images/qrcode.png" height="150" width="150"/>
								  			<!-- <img src="${requestScope.vo.cpctabletimg }" height="150" width="150"/> -->
								  		</div>
								  		<div style="width:150px;height:25px;font:bold 14px arial;margin-left:25px;color:#56a805;text-align: center;" id="gpcodediv">
								  			
								  		</div>
			                        </td>
			                      </tr>
			                      <!--<tr>cpctabletimg
			                        <td height="26" align="center"><a href="#" class="blue">下载二维码</a></td>
			                      </tr>-->
			                    </table>
			                </td>
			               </tr>
			            </table>
			            <ul class="fb-ul">
			              <li class="fb-cbox mt10">
			                <div class="fb-ctit">检验内容</div>
			                <div class="fb-tab">
			                	<table border="0" cellpadding="0" cellspacing="0">
			                      <tr>
			                        <td height="30">执行标准：</td>
			                        <td>
			                        	<select class="w158" name="checkmethod" id="checkmethod">
			                        		<option value="企业标准">企业标准</option>
							  				<option value="中国药典">中国药典</option>
										</select>
			                        </td>
			                        <td>质量级别：</td>
			                        <td>
			                        	<select class="w158" name="checkgrade" id="checkgrade">
			                        		<option value="一级">一级</option>
					  						<option value="二级">二级</option>
					  						<option value="三级">三级</option> 
			                        	</select>
			                        </td>
			                      </tr>
			                      <tr>
			                        <td height="30">贮藏条件：</td>
			                        <td><input type="text" class="inp w150" name="checkcondition" id="checkcondition" value="药典标准" maxlength="20"> <span class="red">*</span></td>
			                        <td>检验人员：</td>
			                        <td><input type="text" class="inp w150" name="checkuser" id="checkuser" maxlength="20"> <span class="red">*</span></td>
			                      </tr>
			                      <tr>
			                        <td height="30">检验时间：</td>
			                        <td><input type="text" class="Wdate inp w150" name="checktime" id="checktime" 
			                        onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'createtime\');}'});"/> <span class="red">*</span></td>
			                        <td>待检验重量(Kg)：</td>
			                        <td><input type="text" class="inp w150" name="tabletweight" id="tabletweight" maxlength="6" onkeypress="onkeypressCheck(this);" onkeyup="onkeyupCheck(this);" onblur="onkeyblurCheck(this);"><span class="red">*</span></td>
			                      </tr>
			                    </table>
			                </div>
			              </li>
			              <li class="fb-cbox mt10">
			                <div class="fb-ctit"><cite><a href="javascript:void(0);" class="btn-up" onclick="return showInfo(1);">上传检验报告</a></cite><img src="../images/frame/upload.gif" class="fl"> &nbsp;检验报告<a href="javascript:void(0);" onclick="checkData_downControl();" style="font:normal 12px arial;margin-left:10px;">【模板下载】</a></div>
			                <div class="fb-tab">
			                	<table cellpadding="0" cellspacing="0" border="0" width="100%" id="matdiv" class='ml10'>
								  <tr>
									<td id="matdiv">
			 								请等待，正在努力为你加载...
									</td>
								  </tr>
									<script type="text/javascript">
										<c:if test="${requestScope.vo.tabletid != null && requestScope.vo.tabletid != '' }">
											findByMaterial();
										</c:if>
									</script>
								</table>
			                </div>
			              </li>
			            </ul>
			        </div>        	
					<div class="fb-bom">
			        	<cite class="gray"><input type="button" onclick="return checkForm();" id="finishcodebtn" value="下一步" class="sbt"/></cite>
			            <!--<input type="button" value="返回上一步" class="sbt">-->
			        </div>	
					
				</form>
			</div>
		</div>
		<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>
 