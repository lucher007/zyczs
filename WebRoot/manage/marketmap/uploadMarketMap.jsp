<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cpccorp = request.getParameter("cpccorp");
	String id = request.getParameter("id");
	String area = request.getParameter("area");
	String floor = request.getParameter("floor");
	request.setAttribute("cpccorp",cpccorp);
	request.setAttribute("id",id);
	request.setAttribute("area",area);
	request.setAttribute("floor",floor);
	
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>平面图添加</title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
   		<link type="text/css" rel="stylesheet" href="/js/uploadify/uploadify.css" />
		<script type="text/javascript" src="/js/common/jquery.js"></script>
	    <script type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen&self=true"></script>
		<script type="text/javascript" src="/js/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="/js/plugin/imgzoom/shiftzoom.js"></script>
		<script type="text/javascript" src="/js/uploadify/swfobject.js"></script>
		<script type="text/javascript" src="/js/form.js"></script>
		<script type="text/javascript" src="/js/comtools.js"></script>
		<script type="text/javascript">
		window.onerror = function(){
			return true;
		} 
		if(document.images&&document.createElement&&document.getElementById){
		    document.writeln('<style type="text/css">'); 
		    document.writeln('img.shiftzoom { visibility: hidden; }'); 
		    document.writeln('<\/style>'); 
		}
		shiftzoom.defaultCurpath = '/js/plugin/imgzoom/images/cursors/';
		function uploadInfo(){
			var uphtml = '';
			uphtml+='<div class="albox">';
			uphtml+='<div class="alb-tit">';
			uphtml+='	<span>最佳分辨率为 712x405 像素</span>';
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
			uphtml+='				<span>注意:单个文件小于2M的<br />jpg,gif,png,bmp文件</span>';
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
				}
			});	
			$("#uploadify").uploadify({    			   		
	            'uploader'       : '<%=basePath%>js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
	            'script'         : '<%=basePath%>marketMapAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
	            'cancelImg'      : '<%=basePath%>js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
	            'folder'         : 'uploads',//上传文件的目录
	            'fileDataName'   : 'uploadify',//和input的name属性值保持一致就好，Struts2就能处理了
	            'queueID'        : 'fileQueue',
	            'scriptData'     : {'id':$("#id").val()},
	            'auto'           : false,//是否选取文件后自动上传
	            'multi'          : false,//是否支持多文件上传
	            'simUploadLimit' : 2,//每次最大上传文件数
	            //'buttonText'     : 'choice file',//按钮上的文字
	            'width'          : 84,
	            'height'         : 29,    			 
	            'buttonImg'      : '<%=basePath%>images/btnfile.png',
	            'displayData'    : 'speed',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
	            'fileDesc'       : '支持格式:jpg/gif/png/bmp', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
	            'fileExt'        : '*.jpg;*.gif;*.png;*.bmp;',//允许的格式                 
				'method'         : 'POST',         
	            'onComplete'     : function (event, queueID, fileObj, response, data){
	            	findByMaterial("${id}");
	            	dia.close();
	            	var content = eval('(' + response + ')');   
	            	var returninfo = content.model.returninfo;
	            	if(returninfo.indexOf("712")>-1){
	            		alert("请上传最佳分辨率为 712x405 像素的图片!");
	            	}
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
	        	//$('#uploadify').uploadifySettings("scriptData",{'uploadType':$("#uploadType").val()});
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
    
	    function findByMaterial(id){
	    	var data="";
	    	data+="id="+$("#id").val();			
			var url="<%=request.getContextPath()%>/marketMapAjax!findByMaterial.shtml?rid="+Math.random();
			//doActon("POST",url,findByMaterialReturn,data);
			$.getJSON(url,data,function(data){
				findByMaterialReturn(data);
			});
	    }
	    function findByMaterialReturn(responseText){
	    	var loginForm = responseText;    		
	    	var list = loginForm.model.list;
	    	var matdiv= $("#matdiv");
	    	matdiv.html("");
	    	var str="";
	    	for(var i=0;i<list.length;i++){
	    			var mapcontent = list[i].mapcontent;
	    			mapcont = mapcontent.substring(mapcontent.length-3,mapcontent.length);
	    			str+='<a href="javascript:void(0);" class="btn-del" id="del'+list[i].id +'" onclick="deleteMaterial('+list[i].id+');">× 删除</a><img class="shiftzoom" id="caribbean" width="712" height="405" src="<%=basePath%>marketMapImage.shtml?mapcontent='+list[i].mapcontent+'" onLoad="shiftzoom.add(this,{showcoords:true,zoom:100});">';
	    	}
	    	if(str==""){
	    		str = '';
	    		str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo();">请上传最佳分辨率的平面图 [最佳分辨率 712x405 像素]</a>';
	    		str += '';
	    	}
	    	matdiv.html(str);
	    	resetH();
	    }
	    function deleteMaterial(id){
	    	if(!confirm("是否删除?")){
	    		return ;
	    	}
	    
	    	var data="";
	    	$("#del"+id).hide();
	    	data+="id="+id;			
			var url="<%=request.getContextPath()%>/marketMapAjax!deleteMaterial.shtml?rid="+Math.random();
			$.getJSON(url,data,function(data){
				findByMaterial("${id}");
			});
	    }
  	</script>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：市场平面图管理 > 设置平面图</div>
		<div class="form-box">
			<form action="<%=basePath %>marketMap!updateAreaFloor.shtml" method="post" name="searchform" id="searchform">
			<s:token></s:token>
    		<div class="fb-tit">设置平面图</div>
        	<div class="fb-con">
				<input type="hidden" id="cpccorp" name="cpccorp" value="${cpccorp }" />
				<input type="hidden" id="id" name="id" value="${id }" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="39" align="right" width="170">
							名称(楼)：
						</td>
						<td width="170">
							<input type="text"  class="inponly" readonly name="area" value="${area }"
								id="area" maxlength="6" onblur="checkVal(this.name)"/>
							<span class="red">*</span>
						</td>
						<td width="376"><label name="areaLab" id="areaLab" class="noico"></label></td>
					</tr>
					<tr>
						<td height="39" align="right">
							名称(区)：
						</td>
						<td>
							<input type="text" class="inps"  name="floor" maxlength="1"
								id="floor" value="${floor }"
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="checkVal(this.name);"
								/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="floorLab" id="floorLab" class="noico">
							</label>
						</td>
					</tr>
				    <tr>
						<td colspan="3" width="726">
							<div id="matdiv" class="mapImg">请等待，正在努力为你加载...</div>
						</td>
				  	</tr>
				</table>
					<script type="text/javascript" language="javascript">
							<c:if test="${id != '' && id != null}">
								findByMaterial("${id}");
							</c:if>
					</script>
			</div>
			<div class="fb-bom hide">
				<cite><input type="button" value="确定" id="finishbtn" class="sbt" onclick="checkInfoMarketMap()"></cite>
			</div>
			</form>
  		</div>
  		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right" width="120">
							区名称：
						</td>
						<td>
							<label id="l_area" />
						</td>
					</tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right">
							楼名称：
						</td>
						<td>
							<label id="l_floor" />
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2" height="60" class="red">
							确定后信息将无法更改，请仔细核对任务信息
						</td>
					</tr>
				</table>
			</div>
		</div>
  	</div>
	<script type="text/javascript" language="javascript">
	var area = '${area }';
	var floor = '${floor }';
	/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9])?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?$/)) {
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
	
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	
	function check(ob){
		var pattern=/\w{1,6}/;
		var result = pattern.exec(ob);
		return result==ob;
	} 
	
	/**
	*验证市场区域
	*/
	function checkVal(name) {
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		
		if(name=="area"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("名称没有填写!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("名称填写不正确!使用中文,字母,数字！");
				return false;
	    	}
	    	if(area==nameval&&floor==$("#floor").val()){
	    		if($(".fb-bom").attr("class").indexOf("hide")<=-1){
	    			$(".fb-bom").addClass("hide");
	    			resetH();
	    		}
				return false;
	    	}else{
	    		if($(".fb-bom").attr("class").indexOf("hide")>-1){
	    			$(".fb-bom").removeClass("hide");
	    			resetH();
	    		}
	    	}
	    	   checksuccess(name);
	    	   return true;
		}
		if(name=="floor"){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("名称没有输入！");
				return false;
	    	}
	    	if(floor==nameval&&area==$("#area").val()){
	    		if($(".fb-bom").attr("class").indexOf("hide")<=-1){
	    			$(".fb-bom").addClass("hide");
	    			resetH();
	    		}
				return false;
	    	}else{
	    		checkload(name);
	    		namelab.html("数据验证中，请稍后...");
		    	var url="<%=request.getContextPath()%>/marketMapAjax!findExist.shtml?rid="+Math.random();
		    	var param = "cpccorp="+$("#cpccorp").val()+"&area="+encodeURIComponent($.trim($("#area").val()))+"&floor="+$("#floor").val();
				$.getJSON(url,param, function(data) {
					if(data.model.returninfo==1){
						checkerror(name);
						//$.dialog.tips($("#area").val()+"区"+$("#floor").val()+"楼名称已经被使用!请重新填写楼名称",1,'alert.gif');
						namelab.html($("#floor").val()+"名称已经被使用,请重新填写名称！");
						if($(".fb-bom").attr("class").indexOf("hide")<=-1){
			    			$(".fb-bom").addClass("hide");
			    			resetH();
			    		}
						return false;
					}else{
						if($(".fb-bom").attr("class").indexOf("hide")>-1){
			    			$(".fb-bom").removeClass("hide");
			    			resetH();
			    		}
			    		checksuccess(name);
					}
					return true;
				});
	    	}
		}
	}
	
	function checkInfoMarketMap(){
		if(!checkVal("area")){
			return false;
		}
		if($("#floor").val()==null||$("#floor").val()==""){
			$("#floorLab").html("名称没有输入！");
			return false;
		}
		if(checkquotmarks($("#floor").val())){
			checkerror("floor");
			$("#floorLab").html("名称没有输入非法！");
			return false;
    	}
    	checksuccess("floor");
    	var url="<%=request.getContextPath()%>/marketMapAjax!findExist.shtml?rid="+Math.random();
    	var param = "cpccorp="+$("#cpccorp").val()+"&area="+encodeURIComponent($.trim($("#area").val()))+"&floor="+$("#floor").val();
		$.getJSON(url,param, function(data) {
			if(data.model.returninfo==1){
				checkerror("floor");
				//$.dialog.tips($("#area").val()+"区"+$("#floor").val()+"楼名称已经被使用!请重新填写楼名称",1,'alert.gif');
				$("#floorLab").html($("#floor").val()+"名称已经被使用,请重新填写名称！");
				return false;
			}else{
				checksuccess("floor");
				editSure();
			}
		});
	}
	//////////////////////////////////////////////////////////////////////
  	</script>
	</body>
</html>

