<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String medstate = request.getParameter("medstate");
pageContext.setAttribute("medstate", medstate);
%>

<!doctype html>
<html>		
  	<head>
	    <base href="<%=basePath%>" target="_self" />   
		<meta charset="utf-8">
	    <title></title>    	
	    
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
	   	<link type="text/css" rel="stylesheet" href="<%=basePath%>js/uploadify/uploadify.css" />
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
		<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/uploadify/swfobject.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/form.js"></script>
	    <script type="text/javascript" language="javascript">
    	//cMenu(1,0);
	  	//多项选择checkbox开始
		function chooseRole(obj){
			OnclickBox(obj);
		}
		var arraycheck=new Array();
		function OnclickBox(obj){
			if(obj.checked){						
				arraycheck[arraycheck.length]=obj.value;	
			}else{			
				if(Arraycontains(arraycheck,obj.value)){
					arraycheck.splice(getindex(arraycheck,obj.value),1);
				}
			}
		}		
		function Arraycontains(arraychecks,chvalue){
			var falgs=false;
			for(var i=0;i<arraychecks.length;i++){
				if(arraychecks[i]==chvalue){
					falgs=true;
					break;
				}
			}
			return falgs;
		}
		function getindex(array,objvalue){
			var index;
			for(var i=0;i<array.length;i++){
			if(array[i]==objvalue){
				index=i;
				break;
				}
			}
			return index;
		}
		//多项选择checkbox结束
	
		//弹出警告
		//uploadType 上传的文件类型  1检验报告 3产地证明
		function showInfo(uploadType){
		    uploadType = $("#mattype").val();
			$("#uploadType").val(uploadType);
			$("#finishcodebtn").attr("disabled","disabled");	
			var uphtml = '';
			uphtml+='<div class="albox">';
			uphtml+='<div class="alb-tit">';
			
			if(uploadType == 1 || uploadType == 2){
				uphtml+='	<span>上传质量检测报告</span>';
			}else if(uploadType == 3){
				uphtml+='	<span>上传产地报告</span>';
			}else if(uploadType == 4){
				uphtml+='	<span>上传环境监测报告</span>';
			}else if(uploadType == 5){
				uphtml+='	<span>其他报告</span>';
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
	            'scriptData'     : {'medstorid':$("#medstorid").val(),'type':$("#checkmattype").val(),'uploadType':$("#uploadType").val(),'flag':$("#flag").val(),'orgid':$("#flag").val()==4?'${sessionScope.comuser.orgid}':'${sessionScope.User.orgid}','loginname':$("#flag").val()==4?'${sessionScope.comuser.loginname}':'${sessionScope.User.loginname}'},
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
	            	findByMaterial("${medstate}");
	            //$("#result").html(response);//显示上传成功结果                               
	            //var content = eval('(' + response + ')');                          
	            //document.getElementById("upcontent").innerHTML+=content.model.returnInfo;
	            //document.getElementById("materail").value+=content.model.matname+"€"+content.model.matcontent+"≡";
	            //setInterval("showResult()",2000);//两秒后删除显示的上传成功结果
	            }
	        });
		}

		$(document).ready(function() {
	        $(".upbtn").live('click',function(){
	        	$('#uploadify').uploadifySettings("scriptData",{'uploadType':$("#uploadType").val()});
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
    
	    function findByMaterial(medstate){
	    	var data="";
	    	data+="medstorid="+$("#medstorid").val()+"&type="+$("#checkmattype").val()+"&flag="+$("#flag").val();			
			var url="<%=request.getContextPath()%>/checkAjax!findByMaterial.shtml?rid="+Math.random();
			//doActon("POST",url,findByMaterialReturn,data);
			$.getJSON(url,data,function(data){
				findByMaterialReturn(data, medstate);
			});
	    }
	    function findByMaterialReturn(responseText, medstate){
	    	var loginForm = responseText;    		
	    	var matlist = loginForm.model.materiallist;
	    	var matdiv= $("#matdiv");
	    	var mattable= $("#mattable");
	    	matdiv.html("");
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
	    			
		        	if(matlist[i].mattype==1 || matlist[i].mattype==2){
		        		str+='<td>质量检测报告</td>';
		        	} else if (matlist[i].mattype==3){
		        		str+='<td>产地证明</td>';
		        	} else if (matlist[i].mattype==4){
		        		str+='<td>环境监测报告</td>';
		        	} else if (matlist[i].mattype==5){
		        		str+='<td>其他报告</td>';
		        	} 
		        	str+='<td><a href="javascript:void(0);" class="btn-del" id="del'+matlist[i].matid +'" onclick="deleteMaterial('+matlist[i].matid+');">删除</a></td></tr>';
	    		}else{
		    		
	    			var matcont = matlist[i].matcontent;
	    			matcont=matcont.substring(matcont.length-3,matcont.length);
		    		if(matcont=="jpg"||matcont=="gif"||matcont=="png"||matcont=="bmp"){
	    				str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
		    		}else{
		    			str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
		    		}
		    		
		        	if(matlist[i].mattype==1 || matlist[i].mattype==2){
		        		str+='<td bgcolor=#EEEEEE>质量检测报告</td>';
		        	}else if(matlist[i].mattype==3){
		        		str+='<td bgcolor=#EEEEEE>产地证明</td>';
		        	}else if (matlist[i].mattype==4){
		        		str+='<td bgcolor=#EEEEEE>环境监测报告</td>';
		        	} else if (matlist[i].mattype==5){
		        		str+='<td bgcolor=#EEEEEE>其他报告</td>';
		        	} 
		        	str+='<td bgcolor=#EEEEEE><a href="javascript:void(0);" class="btn-del" id="del'+matlist[i].matid +'" onclick="deleteMaterial('+matlist[i].matid+');">删除</a></td></tr>';
	    		}
	        	
	    	}
	    	if(str==""){
	    		str = '<tr><td width="706" height="60" align="center" valign="middle">';
	    		if(medstate == "1"){
	    			str += '<span class="tip-warning">提示：检验检测报告从未上传</span>';
	    		}else{
	    			str += '<span class="tip-warning">提示：检验检测报告从未上传</span>';
	    		}
	    		str += '</td></tr>';
	    	}
	    	matdiv.html(str);
	    	resetH();
	    }
	    function deleteMaterial(matidtemp){
	    	if(!confirm("是否删除?")){
	    		return ;
	    	}
	    
	    	var data="";
	    	$("#del"+matidtemp).hide();
	    	$("#name"+matidtemp).hide();
	    	data+="matid="+matidtemp;			
			var url="<%=request.getContextPath()%>/checkAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				findByMaterial("${medstate}");
			});
	    }
	
	    function checkForm(){
	    	$("#finishcodebtn").removeAttr("disabled");
			$("#searchform").attr("action","check!saveCheck.shtml");
			$("#searchform").submit();
		}
	
	  	//弹出警告
		function showInfo1(){
			var finishcodebtn = $("#finishcodebtn");
			finishcodebtn.attr("disabled","disabled");
			
			var roleIdStrTemp="";
	    	if(arraycheck.length>0){			
		 		for(var i = 0 ;i<arraycheck.length;i++){
		 			roleIdStrTemp+=arraycheck[i]+"|"
		 		}
			}
			$("#checkthickmethod").val(roleIdStrTemp);
			var checkthickmethod = $("#checkthickmethod");
	    	var othervalue = $("#othervalue");
	    	
	    	if(checkthickmethod.val()!=""&&othervalue.val()!=""){
	    		checkthickmethod.val(checkthickmethod.val()+othervalue.val());
	    	}
			if(checkthickmethod.val()==""&&othervalue.val()!=""){
	    		checkthickmethod.val(othervalue.val());
	    	}
	    	
	    	if(!checkInput()){
				finishcodebtn.removeAttr("disabled");
				return ;
			}
			$.dialog.tips('- 正在关闭 -',0,'alert.gif');
	    	
			var strTemp="<table width=100%>";
			strTemp+="<tr><td height=30 align=right width=110 bgcolor=#EEEEEE>批次号：</td><td colspan=\"3\"><%=request.getParameter("cpcmed")%></td></tr>";
			strTemp+="<tr><td height=30 align=right bgcolor=#EEEEEE>品名：</td><td><%=request.getParameter("medname")%></td><td align=right bgcolor=#EEEEEE width=110>重量(Kg)：</td><td width=110><%=request.getParameter("medweight")%></td></tr>";
			strTemp+="</table>";
	
			var strTemp2="<table width=100%>";
			strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE width=110>贮藏条件：</td><td>"+$("#checkcondition").val()+"</td><td align=right bgcolor=#EEEEEE width=110>执行标准：</td><td width=110>"+$("#checkmethod").val()+"</td></tr>";
			strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE>检验人员：</td><td>"+$("#checkuser").val()+"</td><td align=right bgcolor=#EEEEEE>检验时间：</td><td>"+$("#checktime").val()+"</td></tr>";
			strTemp2+="<tr><td height=30 align=right bgcolor=#EEEEEE>粗加工方法：</td><td width=\"360\" colspan=\"3\">"+$("#checkthickmethod").val()+"</td></li>";
			strTemp2+="</table>";
			
			var strHtml ="<div class=\"fdbox\"><div class=\"fd-tit\"><span>种植信息预览</span></div><div class=\"fd-con\">"+strTemp+"</div></div>";
			strHtml +="<div class=\"fdbox mt10\"><div class=\"fd-tit\"><span>检验信息预览</span></div><div class=\"fd-con\">"+strTemp2+"</div></div>";
			
			$.dialog({
				title:'检验确认信息',
				id:'sureCheck',
				lock:true,
				content: strHtml,
				okVal:'确认检验',
				ok:function(){
					checkForm();
				},
				cancelVal:'取消',
				cancel:function(){
					finishcodebtn.removeAttr("disabled");
				}
			});					
		}
		
		function checkquotmarks2(str){
			return /[\'\"\~\`\_\!\@\#\$\%\^\&\*\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
		}
		//检验输入字段
		function checkInput(){
			var checkthickmethod = $.trim($("#checkthickmethod").val());
			if(checkthickmethod == ""){
				$("#othervalue").focus();
				$.dialog.tips('粗加工方法未选择！',3,'alert.gif');
				return false;
			}
			
			var othervalue = $.trim($("#othervalue").val());
			if(othervalue != ""){
				if(checkquotmarks2(othervalue)){
					
					$("#othervalue").focus();
					$.dialog.tips('方法不能包含~ # *等字符！',3,'alert.gif');
					return false;
				}
			}
			
			var checkcondition = $.trim($("#checkcondition").val());
			if(checkcondition == ""){
				$("#checkcondition").focus();
				$.dialog.tips('贮藏条件未填写！',3,'alert.gif');
				return false;
			}else{
				if(checkquotmarks(checkcondition)){
					$("#checkcondition").focus();
					$.dialog.tips('贮藏条件有非法字符！',3,'alert.gif');
					return false;
				}
			}
			
			var checktime = $.trim($("#checktime").val());
			if(checktime == ""){
				$("#checktime").focus();
				$.dialog.tips('检验时间未选择！',3,'alert.gif');
				return false;
			}

			var checkuser = $.trim($("#checkuser").val());
			if(checkuser == ""){
				$("#checkuser").focus();
				$.dialog.tips('检验人员未填写！',3,'alert.gif');
				return false;
			}else{
				if(checkquotmarks(checkuser)){
					$("#checkuser").focus();
					$.dialog.tips('人名不能包含~ # *等字符！',3,'alert.gif');
					return false;
				}
			}
			
			return true;
		}

		function checkData_downControl(){
			window.location.href="<%=basePath%>js/yc.doc";
		}
  		</script> 
  	</head>
  
  	<body>
  	<div id="body">
  		<%
  			String flag = request.getParameter("flag");
  			request.setAttribute("flag", flag);
  		%>
  		<c:if test="${flag == 1 }"> 
		  	<div class="cur-pos">当前位置：药材库存 > 药材检验</div>
  		</c:if>
  		<c:if test="${flag == 0 || flag == 3 || flag == 4}">
		  	<div class="cur-pos">当前位置：检验管理 > 药材检验</div>
  		</c:if>
  		<c:if test="${flag == 2 }">
		  	<div class="cur-pos">当前位置：库存销售 > 药材检验</div>
  		</c:if>
	  	<%
	  		String medname = URLDecoder.decode(request.getParameter("medname"),"UTF-8");
	  		pageContext.setAttribute("medname", medname);
	  	%>
	  	<div class="form-box">
		  	
		  	<form action="" method="post" name="searchform" id="searchform" enctype="multipart/form-data">
		  		<s:token></s:token>
			  	<input type="hidden" name="checkthickmethod" id="checkthickmethod" />
			  	<input type="hidden" name="uploadType" id="uploadType"/>
			  	<input type="hidden" name="medstorid" id="medstorid" value="<%=request.getParameter("medstorid")%>" />
			  	<input type="hidden" name="cpcmed" id="cpcmed" value="<%=request.getParameter("cpcmed")%>" />
			  	<input type="hidden" name="orgid" id="orgid" value="${sessionScope.User.orgid}" />
			  	<input type="hidden" name="flag" id="flag" value="<%=request.getParameter("flag")%>" />
			  	<input type="hidden" name="harvesttime" id="harvesttime" value="<%=request.getParameter("harvesttime")%>" />
			  	<!-- checkmattype, 检验报告表的类型(type), 为0是药材, 为1是饮片. -->
			  	<input type="hidden" name="checkmattype" id="checkmattype" value="<%=request.getParameter("checkmattype")%>" />
				<div class="fb-tit">
					药材检验　<span>
								品名：${medname }　　
								待检重量(Kg)：<%=request.getParameter("medweight")%>　　
								批次号：<%=request.getParameter("cpcmed")%>
							</span>
				</div>
				<div class="fb-con">
		        	<ul class="fb-ul">
		              <li class="fb-cbox">
		                <div class="fb-ctit"><img src="../images/frame/st.png" class="fl"> &nbsp;粗加工方法</div>
		                <div class="fb-tab">
		                <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                  <tr>
		                    <td width="50">&nbsp;</td>
		                    <td width="30"><input type="checkbox" value="清洗" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="57">清洗</td>
		                    <td width="30"><input type="checkbox" value="修整" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="61">修整</td>
		                    <td width="30"><input type="checkbox" value="发汗" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="61">发汗</td>
		                    <td width="30"><input type="checkbox" value="蒸" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="75">蒸</td>
		                    <td width="30"><input type="checkbox" value="煮" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="61">煮</td>
		                    <td width="30"><input type="checkbox" value="汤" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td width="75">汤</td>
		                    <td width="30">&nbsp;</td>
		                    <td width="59">&nbsp;</td>
		                  </tr>
		                  <tr>
		                    <td class="b">净选：</td>
		                    <td><input type="checkbox" value="去皮" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td>去皮</td>
		                    <td><input type="checkbox" value="去壳" id='method2' name='method2' onclick='chooseRole(this)'></td>
		                    <td>去壳</td>
		                    <td><input type="checkbox" value="去瓤" id='method2' name='method3' onclick='chooseRole(this)'></td>
		                    <td>去瓤</td>
		                    <td><input type="checkbox" value="去芦头" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td>去芦头</td>
		                    <td><input type="checkbox" value="去核" id='method2' name='method2' onclick='chooseRole(this)'></td>
		                    <td>去核</td>
		                    <td><input type="checkbox" value="去须根" id='method2' name='method3' onclick='chooseRole(this)'></td>
		                    <td>去须根</td>
		                    <td><input type="checkbox" value="去心" id='method2' name='method3' onclick='chooseRole(this)'></td>
		                    <td>去心</td>
		                  </tr>
		                  <tr>
		                    <td class="b">切制：</td>
		                    <td><input type="checkbox" value="切片" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td>切片</td>
		                    <td><input type="checkbox" value="切块" id='method2' name='method2' onclick='chooseRole(this)'></td>
		                    <td>切块</td>
		                    <td><input type="checkbox" value="切段" id='method2' name='method3' onclick='chooseRole(this)'></td>
		                    <td>切段</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                  </tr>
		                  <tr>
		                    <td class="b">干燥：</td>
		                    <td><input type="checkbox" value="烘干" id='method1' name='method1' onclick='chooseRole(this)'></td>
		                    <td>烘干</td>
		                    <td><input type="checkbox" value="阴干" id='method2' name='method2' onclick='chooseRole(this)'></td>
		                    <td>阴干</td>
		                    <td><input type="checkbox" value="晒干" id='method2' name='method3' onclick='chooseRole(this)'></td>
		                    <td>晒干</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                  </tr>
		                  <tr>
		                    <td class="b">其它：</td>
		                    <td colspan="14"><input maxlength="40" size="50" type="text" name="othervalue" id="othervalue" class="inp" value="">（多种方法用"|"隔开）<span style="font-size: 18px; color: red;">*</span></td>
		                  </tr>
		                </table>
		                </div>
		              </li>
		              <li class="fb-line">执行标准：
		              	<select class="w150" name="checkmethod" id="checkmethod">
		              		<option value="企业标准">企业标准</option>
		  					<option value="中国药典">中国药典</option>
		  			
		  				</select>
		  				<span style="font-size: 18px; color: red;">*</span>
		  			  </li>
		              <li class="fb-cbox">
		              	<div class="fb-ctit">
		              		<img src="../images/frame/upload.gif" class="fl"> &nbsp;
		              		<c:choose>
		              			<c:when test="${medstate == 1}">
				              		检验检测报告
		              			</c:when>
		              			<c:otherwise>
		              				检验检测报告
		              			</c:otherwise>
		              		</c:choose>
		              		<a href="javascript:void(0);" onclick="checkData_downControl();" style="font:normal 12px arial;margin-left:10px;">【模板下载】</a>
		              		
		              		<span style="margin-left: 250px"  class="btn-up">报告类型：</span>
							<select name="mattype" id="mattype">
								<option value="1">质量检验报告</option>
								<option value="3">产地证明</option>
								<option value="4">环境检测报告</option>
								<option value="5">其他报告</option>
							</select>
		              		
		              		<c:choose>
		              			<c:when test="${medstate == 1}">
                                <!-- <a href="javascript:void(0);" class="btn-up" onclick="return showInfo(3);">上传产地证明</a>-->
									<a href="javascript:void(0);"  class="btn-up" onclick="return showInfo(1);">上传报告</a>
		              			</c:when>
		              			<c:otherwise>
									<a href="javascript:void(0);" class="btn-up" onclick="return showInfo(1);">上传报告</a>
		              			</c:otherwise>
		              		</c:choose>
		              	</div>
		                <div class="fb-tab">
							<table cellpadding="0" cellspacing="0" border="0" width="100%" id="matdiv" class='ml10'>
							  <tr>
								<td id="matdiv">
		 								请等待，正在努力为你加载...
								</td>
							  </tr>
								<%
									request.setAttribute("medstorid", request.getParameter("medstorid"));
								%>
								<script type="text/javascript" language="javascript">
									<c:if test="${medstorid != '' && medstorid != null}">
										findByMaterial("${medstate}");
									</c:if>
								</script>
							</table>
		                </div>
		              </li>
		              <li class="fb-line">
		                	贮藏条件：<input maxlength="20" type="text" class="inp" name="checkcondition" id="checkcondition" value="药典标准" />
				  			<span style="font-size: 18px; color: red;">*</span>
					                     检验时间：<input type="text" class="Wdate inp" name="checktime" id="checktime" onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,dateFmt:'yyyy-MM-dd'});">
					               	<span style="font-size: 18px; color: red;">*</span>  
					                     检验人员：<input maxlength="20" type="text" class="inp" name="checkuser" id="checkuser" >
			                <span style="font-size: 18px; color: red;">*</span>  
		              </li>
		              <li class="fb-line"><input type="text" style="color: red; border: 0;" id="errorinfo" value=""></li>
		            </ul>
		    	</div>
				<div class="fb-bom">
		        	<cite><input type="button" value="下一步" class="sbt" id="finishcodebtn" onclick="return showInfo1();"></cite>
		        </div>
			</form>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
  	</body>
</html>
