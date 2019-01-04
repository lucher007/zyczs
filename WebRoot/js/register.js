var arr = new Array(12);
var arrIndex=0;
var oper='新增';

$("input[name='typec']").click(function(){
	$('.typec li').removeClass('act');
	$('.typeb').hide();
	$(this).parents('li').addClass('act');
	
	if($(this).attr('checked')&&$(this).val()=='1'){
		$('#typebox-1').show();
		
		$('#typebox-1').find("input[type='checkbox']").click(function(){
			arrIndex = $(this).val()-1;
			if($(this).attr('checked')){
				if(arr[arrIndex]){
					oper = '修改';
				}else{
					oper='新增';
				}
				$('#typebox-1 tr:eq(1) td').eq(arrIndex).html('<div style="font-size:12px">已选择<a href="javascript:void;" class="addCorp red" id="addCorp'+($(this).val()-1)+'"  ai="'+$(this).val()+'">['+oper+']</a></div>');
				//openRegisterOrg(0,"CorpOrg.jsp",$(this).val());
			}else{
				$('#typebox-1 tr:eq(1) td').eq(arrIndex).html('');
			}
		}); 
	}else if($(this).attr('checked')&&$(this).val()=='2'){
		$('#typebox-2').show();
		
		$('#typebox-2').find("input[type='radio']").click(function(){
			
			$('#typebox-2 tr:eq(1) td').html('');
			$('#typebox-2 tr:eq(3) td').html('');
			
			if($(this).val() < 9){
				arrIndex = $(this).val()-5;
				if($(this).attr('checked')){
					if(arr[$(this).val()-1]){
						oper = '修改';
					}else{
						oper='新增';
					}
					$('#typebox-2 tr:eq(1) td').eq(arrIndex).html('<div style="font-size:12px">已选择<a href="javascript:void;" class="addNoCorp red" id="addNoCorp'+($(this).val()-1)+'" ai="'+$(this).val()+'">['+oper+']</a></div>');
					//openRegisterOrg(1,"NotCorpOrg.jsp",$(this).val());
				}
			}else{
				arrIndex = $(this).val()-9;
				if($(this).attr('checked')){
					if(arr[$(this).val()-1]){
						oper = '修改';
					}else{
						oper='新增';
					}
					//选择医药/药店需要单独在进行选择
					if($(this).val() == 10){
						$('#typebox-2 tr:eq(3) td').eq(arrIndex).html(' <div style="font-size:12px;padding: 5px">已选择<a href="javascript:void;" class="addNoCorp red" id="addNoCorp'+($(this).val()-1)+'" ai="'+$(this).val()+'">['+oper+']</a></br><input type="radio" name="rad_ishospital" id="rad1" value="0" checked="checked">医院&nbsp;<input type="radio" name="rad_ishospital" id="rad2" value="1">药店</div>');
					}else{
						$('#typebox-2 tr:eq(3) td').eq(arrIndex).html('<div style="font-size:12px">已选择<a href="javascript:void;" class="addNoCorp red" id="addNoCorp'+($(this).val()-1)+'" ai="'+$(this).val()+'">['+oper+']</a></div>');
					}
					//openRegisterOrg(1,"NotCorpOrg.jsp",$(this).val());
				}
			}
		}); 
		
	}
})

/**
*集团新增
*/
$('.addCorp').live('click',function(){
	var tIndex = $(this).attr('ai');
	openRegisterOrg(0,"CorpOrg.jsp",tIndex);
})		

/**
*非集团新增
*/
$('.addNoCorp').live('click',function(){
	var tIndex = $(this).attr('ai');
	openRegisterOrg(1,"NotCorpOrg.jsp",tIndex);
})	

	
/**
*弹出新建下属单位页面
*/
var t1;
function openRegisterOrg(corp,url,zyctype){
	$("html,body").animate({scrollTop:document.documentElement.scrollTop-1}, 500);
	t1=$.dialog({
		title:corp==0?'新建集团下属单位':'新建非集团下属单位',
		id:'registerOrg',
		lock:true,
		padding:0,
		height:958,
		top:194,
	    drag: false, 
	    resize: false,
		content: '<iframe frameborder="0" scrolling="no" name="orgFrame" width="650" height="958" id="orgFrame" src="'+url+"?zyctype="+zyctype+"&ischoice="+Math.random()+'"></iframe>'
	});
	
	$("div").each(function(){
		if($(this).find("table[class='ui_border']")){
			$(this).css('top',188);
			return false;
		}
	})
}
	
/**
*关闭新建下属单位页面
*/	
function closeRegisterOrg(resultArr,obj){
	arr[resultArr]=obj;	
	//alert("resultArr>>"+resultArr);
	t1.close();
	if(resultArr < 4){
		$("#addCorp"+resultArr).html("[修改]");
	}else{
		$("#addNoCorp"+resultArr).html("[修改]");
	}
}

function getArr(i){
	return arr[i];
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
		uphtml+='	<span>上传组织机构代证码</span>';
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
            'uploader'       : 'js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
            'script'         : 'orgUploadAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
            'cancelImg'      : 'js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
            'folder'         : 'uploads',//上传文件的目录
            'fileDataName'   : 'uploadify',//和input的name属性值保持一致就好，Struts2就能处理了
            'queueID'        : 'fileQueue',
            'scriptData'     : {'uploadtype':$("#uploadType").val(),'type':0,'tokenid':$("input[name='tokenid']").val()},//提交到action中的数据,type:0为企业附件 1为组织机构附件
            'auto'           : false,//是否选取文件后自动上传
            'multi'          : false,//是否支持多文件上传
            'simUploadLimit' : 2,//每次最大上传文件数
            'sizeLimit '     : 1024 * 1024 *2,
            //'buttonText'     : 'choice file',//按钮上的文字
            'width'          : 84,
            'height'         : 29,    			 
            'buttonImg'      : 'images/btnfile.png',
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
            'uploader'       : 'js/uploadify/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
            'script'         : 'orgUploadAjax!saveObjectFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action 
            'cancelImg'      : 'js/uploadify/cancel.png',//取消上传文件的按钮图片，就是个叉叉
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
            'buttonImg'      : 'images/btnfile.png',
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
	
	$("#corpname").focus();
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
	var url="orgUploadAjax!findByMaterial.shtml?rid="+Math.random();
	$.getJSON(url,data,function(data){
		findByMaterialReturn(data);
		resetH();
	});
}
var uploadids = "";
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
			str+='orgUploadImage.shtml?uploadcontent='+list[i].uploadcontent;
		}else{
			str+='orgUploadImage!getOrgUploadImageFile.shtml?uploadcontent='+list[i].uploadcontent;
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
			str += '<a href="javascript:void(0);" class="btn-up" onclick="return uploadInfo(2);">上传组织机构代码证</a>';
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
	data+="uploadid="+uploadidtemp+"&uploadtype="+uploadtypetemp;			
	var url="orgUploadAjax!deleteMaterial.shtml?rid="+Math.random();
	$.getJSON(url,data,function(data){
		//alert(data.model.uploadid+"   "+data.model.uploadtype);
		findByMaterial(data.model.uploadid,data.model.uploadtype,1);
	});
}
	
/*********************只能输入数字*****************************/
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
/***************************************/

/**
*邮箱验证
*/
function checkEmail(strEmail) {
	if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1){
		return true;
	}else{
		return false;
	}
}

/**
*手机验证
*/
function checkMoblie(ob){
	if((/^(13|15|18|17)[0-9]{9}$/.test(ob))){
		return true;
	}else{
		return false;
	}
}

/**
*只能输数字
*/
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

function check(ob){
	var pattern=/\w{4,20}/;
	var result = pattern.exec(ob);
	return result==ob;
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
				namelab.html("非法字符,只包括大小写字母中文！");
				ajaxFlag = false;
				return ajaxFlag;
			}
			
			if(getBytesLength(nameval) > 42){
				checkerror(name);
				namelab.html("企业名称超长");
				ajaxFlag = false;
				return ajaxFlag;
			}
			
			for(var i = 0 ; i< 4 ;i++){
				//alert(parent.getArr(i));
				if(arr[i] != null){
					if(nameval == arr[i].orgname){
						checkerror(name);
						namelab.html("企业名称已经存在");
						ajaxFlag = false;
						return ajaxFlag;
					}
				}
			}
			
			var url="companyAjax!findByExist.shtml?rid="+Math.random();
			$.getJSON(url,{'corpname':nameval}, function(data) {
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
				namelab.html("非法字符,只包括大小写字母中文！");
				return false;
			}
			checksuccess(name);
			return true;
		}
		
		if(name=="businesscode"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("营业执照号没有输入");
				return false;
	    	}
			if(checkquotmarks_businesscode(nameval)){
				checkerror(name);
				namelab.html("非法字符！");
				return false;
			}
			checksuccess(name);
			return true;
		}
		if(name=="masterman"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人没有输入");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("非法字符,只包括大小写字母中文！");
				return false;
			}
			checksuccess(name);
			return true;
		}
		if(name=="identitycard"){
			if(checkIdentityCard(nameval) == false || nameval==null||nameval==""){
				checkerror(name);
				namelab.html("法人身份证格式123456701010123");
				return false;
	    	}
			
			checksuccess(name);
			return true;
		}
		if(name=="linkman"){
			if(nameval!=""){
				if(checkquotmarks(nameval)){
					checkerror(name);
					namelab.html("非法字符,只包括大小写字母中文！");
					return false;
		    	}else{
		    		checksuccess(name);
		    		return true;
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var linkmanLab = $("#linkmanLab");
				linkmanLab.attr("class", "noico");
				return true;
			}
		}
		if(name=="mobile"){
			if(checkMoblie(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("移动电话格式13400000000");
				return false;
	    	}
			checksuccess(name);
			return true;
		}
		if(name=="telephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("固定电话格式028-31312111");
				return false;
	    	}
			checksuccess(name);
			return true;
		}
		if(name=="officephone"){
			if(checkPhone(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("传真格式0281-31312111");
				return false;
	    	}
			checksuccess(name);
			return true;
		}
		
		if(name=="email"){
			if(nameval!=""){
				if(checkEmail(nameval)==false||nameval==null||nameval==""){
					checkerror(name);
					namelab.html("电子邮箱格式21212112@qq.com");
					return false;
		    	}else{
		    		checksuccess(name);
		    		return true;
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var emailLab = $("#emailLab");
				emailLab.attr("class", "noico");
				return true;
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
		    		return true;
		    	}
			}else{
				var spanVal = $("label[id^=" + name + "]");
				spanVal.html("");
				var postcodeLab = $("#postcodeLab");
				postcodeLab.attr("class", "noico");
				return true;
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
			return true;
		}
		if(name=="orgcode"){
			if(nameval!=""){
				if(checkquotmarks_businesscode(nameval)){
					checkerror(name);
					namelab.html("非法字符！");
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
				return true;
			}
		}
		//$("#corpshortname").val($("#corpname").val());
		return true;
	}
	
	
/**
*确认信息弹出框
*/
function showinfo(){
		var orgHtml="";
		var typeId; 
		var arrObj;
		var corpFlag = false;
		var uploadids = "";
		var zyctype="";
		var orgnames="";
		$("a[id^='del']").each(function (i) {
			var currentId = $(this).attr("id").substr($(this).attr("id").length-3)+",";
			uploadids += currentId;
		});
		$("#uploadids").val(uploadids.substr(0,uploadids.length-1));
		
		if (!checkVal("corpshortname")) {
				return false;
		}
		if (!checkVal("businesscode")) {
				return false;
		}
		if (!checkVal("businesscode")) {
				return false;
		}
		if (!checkVal("masterman")) {
				return false;
		}
		if (!checkVal("identitycard")) {
				return false;
		}
		if (!checkVal("mobile")) {
				return false;
		}
		if (!checkVal("telephone")) {
				return false;
		}
		if (!checkVal("officephone")) {
				return false;
		}
		if (!checkVal("email")) {
				return false;
		}
		if (!checkVal("postcode")) {
				return false;
		}
		if (!checkVal("registeraddress")) {
				return false;
		}
		if (!checkVal("orgcode")) {
				return false;
		}
		
		//判断集团或者非集团下属单位输入信息
		if($("input[name='typec']:checked").length > 0){
			$("input[name='typec']").each(function(i){
				if($(this).attr("checked")){
					//判断集团下属单位信息录入
					if($(this).val()=="1"){
						$("#corp").val(0);
						 $("#ishospital").val("");
						//alert("集团");
						if($('#typebox-1').find("input[type='checkbox']:checked").length == 0){
							$.dialog.alert("请选择集团下属单位类型");
							return false;
						}
						$('#typebox-1').find("input[type='checkbox']").each(function(i){
								if($(this).attr("checked")){
									zyctype+="1";
									typeId = $(this).val();
									arrObj = arr[typeId-1];
									if(typeId == 1){
										if(!arrObj){
											$.dialog.alert("集团单位药材种植信息未录入");
											corpFlag = false;
											return corpFlag;
										}else{
											orgHtml+="<input type='hidden' name='orglist["+i+"].orgname' value='"+arrObj.orgname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgshortname' value='"+arrObj.orgshortname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].masterman' value='"+arrObj.masterman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].identitycard' value='"+arrObj.identitycard+"'>"
											       +"<input type='hidden' name='orglist["+i+"].businesscode' value='"+arrObj.businesscode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgcode' value='"+arrObj.orgcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].zyctype' value='"+arrObj.zyctype+"'>"
											       +"<input type='hidden' name='orglist["+i+"].linkman' value='"+arrObj.linkman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].mobile' value='"+arrObj.mobile+"'>"
											       +"<input type='hidden' name='orglist["+i+"].telephone' value='"+arrObj.telephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].officephone' value='"+arrObj.officephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].email' value='"+arrObj.email+"'>"
											       +"<input type='hidden' name='orglist["+i+"].province' value='"+arrObj.province+"'>"
											       +"<input type='hidden' name='orglist["+i+"].city' value='"+arrObj.city+"'>"
											       +"<input type='hidden' name='orglist["+i+"].area' value='"+arrObj.area+"'>"
											       +"<input type='hidden' name='orglist["+i+"].postcode' value='"+arrObj.postcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].registeraddress' value='"+arrObj.registeraddress+"'>"
											       +"<input type='hidden' name='orglist["+i+"].longitude' value='"+arrObj.longitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].latitude' value='"+arrObj.latitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].gapcode' value='"+arrObj.gapcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].uploadids' value='"+arrObj.orgUpload1+','+arrObj.orgUpload2+','+arrObj.orgUpload3+"'>"
											       +"<input type='hidden' name='orglist["+i+"].tokenid' value='"+arrObj.tokenid+"'>";
											orgnames += "'"+arrObj.orgname+"'"+",";        
											corpFlag = true;
										}
									}else if(typeId == 2){
										if(!arrObj){
											$.dialog.alert("集团单位药材经销商信息未录入");
											corpFlag = false;
											return corpFlag;
										}else{
											orgHtml+="<input type='hidden' name='orglist["+i+"].orgname' value='"+arrObj.orgname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgshortname' value='"+arrObj.orgshortname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].masterman' value='"+arrObj.masterman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].identitycard' value='"+arrObj.identitycard+"'>"
											       +"<input type='hidden' name='orglist["+i+"].businesscode' value='"+arrObj.businesscode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgcode' value='"+arrObj.orgcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].zyctype' value='"+arrObj.zyctype+"'>"
											       +"<input type='hidden' name='orglist["+i+"].linkman' value='"+arrObj.linkman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].mobile' value='"+arrObj.mobile+"'>"
											       +"<input type='hidden' name='orglist["+i+"].telephone' value='"+arrObj.telephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].officephone' value='"+arrObj.officephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].email' value='"+arrObj.email+"'>"
											       +"<input type='hidden' name='orglist["+i+"].province' value='"+arrObj.province+"'>"
											       +"<input type='hidden' name='orglist["+i+"].city' value='"+arrObj.city+"'>"
											       +"<input type='hidden' name='orglist["+i+"].area' value='"+arrObj.area+"'>"
											       +"<input type='hidden' name='orglist["+i+"].postcode' value='"+arrObj.postcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].registeraddress' value='"+arrObj.registeraddress+"'>"
											       +"<input type='hidden' name='orglist["+i+"].longitude' value='"+arrObj.longitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].latitude' value='"+arrObj.latitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].uploadids' value='"+arrObj.orgUpload1+','+arrObj.orgUpload2+','+arrObj.orgUpload3+"'>"
											       +"<input type='hidden' name='orglist["+i+"].tokenid' value='"+arrObj.tokenid+"'>";
											orgnames += "'"+arrObj.orgname+"'"+",";  
											corpFlag = true;
										}
									}else if(typeId == 3){
										if(!arrObj){
											$.dialog.alert("集团单位饮片生产信息未录入");
											corpFlag = false;
											return corpFlag;
										}else{
											orgHtml+="<input type='hidden' name='orglist["+i+"].orgname' value='"+arrObj.orgname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgshortname' value='"+arrObj.orgshortname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].masterman' value='"+arrObj.masterman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].identitycard' value='"+arrObj.identitycard+"'>"
											       +"<input type='hidden' name='orglist["+i+"].businesscode' value='"+arrObj.businesscode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgcode' value='"+arrObj.orgcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].zyctype' value='"+arrObj.zyctype+"'>"
											       +"<input type='hidden' name='orglist["+i+"].linkman' value='"+arrObj.linkman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].mobile' value='"+arrObj.mobile+"'>"
											       +"<input type='hidden' name='orglist["+i+"].telephone' value='"+arrObj.telephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].officephone' value='"+arrObj.officephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].email' value='"+arrObj.email+"'>"
											       +"<input type='hidden' name='orglist["+i+"].province' value='"+arrObj.province+"'>"
											       +"<input type='hidden' name='orglist["+i+"].city' value='"+arrObj.city+"'>"
											       +"<input type='hidden' name='orglist["+i+"].area' value='"+arrObj.area+"'>"
											       +"<input type='hidden' name='orglist["+i+"].postcode' value='"+arrObj.postcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].registeraddress' value='"+arrObj.registeraddress+"'>"
											       +"<input type='hidden' name='orglist["+i+"].longitude' value='"+arrObj.longitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].latitude' value='"+arrObj.latitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].gmpcode' value='"+arrObj.gmpcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].uploadids' value='"+arrObj.orgUpload1+','+arrObj.orgUpload2+','+arrObj.orgUpload3+"'>"
											       +"<input type='hidden' name='orglist["+i+"].tokenid' value='"+arrObj.tokenid+"'>";
											orgnames += "'"+arrObj.orgname+"'"+",";  
											corpFlag = true;
										}
									}else if(typeId == 4){
										if(!arrObj){
											$.dialog.alert("集团单位饮片生产经销信息未录入");
											corpFlag = false;
											return corpFlag;
										}else{
											orgHtml+="<input type='hidden' name='orglist["+i+"].orgname' value='"+arrObj.orgname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgshortname' value='"+arrObj.orgshortname+"'>"
											       +"<input type='hidden' name='orglist["+i+"].masterman' value='"+arrObj.masterman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].identitycard' value='"+arrObj.identitycard+"'>"
											       +"<input type='hidden' name='orglist["+i+"].businesscode' value='"+arrObj.businesscode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].orgcode' value='"+arrObj.orgcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].zyctype' value='"+arrObj.zyctype+"'>"
											       +"<input type='hidden' name='orglist["+i+"].linkman' value='"+arrObj.linkman+"'>"
											       +"<input type='hidden' name='orglist["+i+"].mobile' value='"+arrObj.mobile+"'>"
											       +"<input type='hidden' name='orglist["+i+"].telephone' value='"+arrObj.telephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].officephone' value='"+arrObj.officephone+"'>"
											       +"<input type='hidden' name='orglist["+i+"].email' value='"+arrObj.email+"'>"
											       +"<input type='hidden' name='orglist["+i+"].province' value='"+arrObj.province+"'>"
											       +"<input type='hidden' name='orglist["+i+"].city' value='"+arrObj.city+"'>"
											       +"<input type='hidden' name='orglist["+i+"].area' value='"+arrObj.area+"'>"
											       +"<input type='hidden' name='orglist["+i+"].postcode' value='"+arrObj.postcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].registeraddress' value='"+arrObj.registeraddress+"'>"
											       +"<input type='hidden' name='orglist["+i+"].longitude' value='"+arrObj.longitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].latitude' value='"+arrObj.latitude+"'>"
											       +"<input type='hidden' name='orglist["+i+"].gspcode' value='"+arrObj.gspcode+"'>"
											       +"<input type='hidden' name='orglist["+i+"].uploadids' value='"+arrObj.orgUpload1+','+arrObj.orgUpload2+','+arrObj.orgUpload3+"'>"
											       +"<input type='hidden' name='orglist["+i+"].tokenid' value='"+arrObj.tokenid+"'>";
											orgnames += "'"+arrObj.orgname+"'"+","; 
											corpFlag = true;
										}
									}
								}else{
									zyctype+="0";
								}
									
						});
								   zyctype+="0000";
								   $("#zyctype").val(zyctype);
					}else if($(this).val()=="2"){//判断非集团下属单位信息录入
						$("#corp").val(1);
						$("#ishospital").val("");
						//alert("非集团");
						//非集团下属单位信息和企业信息一致,只需要判断gap,gsp,gmp
						if($('#typebox-2').find("input[type='radio']:checked").length == 0){
							$.dialog.alert("请选择非集团下属单位类型");
							return false;
						}
						$('#typebox-2').find("input[type='radio']").each(function(){
							if($(this).attr("checked")){
								typeId = $(this).val();
								arrObj = arr[typeId-1];
								if(typeId == 5){
									if(!arrObj && $("#corpname").val() == ""){
										$.dialog.alert("请输入非集团药材种植单位GAP");
										corpFlag = false;
										return corpFlag;
									}else{
										if(arrObj){
											$("#gapcode").val(arrObj.gapcode);
											$("#zyctype").val(arrObj.zyctype);
										}else{
											$("#zyctype").val("10000000");
										}
										corpFlag = true;
										return corpFlag;
									}
								}else if(typeId == 7){
									if(!arrObj){
										$.dialog.alert("请输入非集团饮片生产单位GMP");
										corpFlag = false;
										return corpFlag;
									}else{
										$("#gmpcode").val(arrObj.gmpcode);
										$("#zyctype").val(arrObj.zyctype);
										corpFlag = true;
										return corpFlag;
									}
								}else if(typeId == 8){
									if(!arrObj){
										$.dialog.alert("请输入非集团饮片生产经销单位GSP");
										corpFlag = false;
										return corpFlag;
									}else{
										$("#gspcode").val(arrObj.gspcode);
										$("#zyctype").val(arrObj.zyctype);
										corpFlag = true;
										return corpFlag;
									}
								}else if(typeId == 10){
									if(arrObj){
										$("#zyctype").val(arrObj.zyctype);
										$("input[name='rad_ishospital']").each(function(){
											if($(this).attr('checked')){
												$("#ishospital").val($(this).val());
												corpFlag = true;
												return corpFlag;
											}
										});
									}else{
										corpFlag = false;
										return corpFlag;
									}
								}else{
									if($(this).attr("name")!='rad_ishospital'&& arrObj){
										$("#zyctype").val(arrObj.zyctype);
										corpFlag = true;
										return corpFlag;
									}
								}
							}
						});
					}
					return false;
				}
			});
		}else{                                                                                                                                                                                                                   
			$.dialog.alert("请选择企业类型");
			return false;
		}
		
		//alert(corpFlag);
		//alert(orgHtml);
		if(orgnames.length > 0){
		   $("#orgnames").val(orgnames.substring(0,orgnames.length-1));
		}
		
		
		//alert($("#ishospital").val()+"--------------"+$("#zyctype").val());
		//alert($("#orgnames").val());
		
		if(corpFlag && ajaxFlag){
			$("#orgdiv").html(orgHtml);
			$("#dataForm").submit();
		}
	}
	
window.onerror = function(){
	return true;
} 

forbg();
$(window).resize(function() {
	forbg();
});

function forbg(){
	var t = (($(window).width()-660)/2)%18;
	if(t!=0){$("body").css("background-position",t+"px top")};
}