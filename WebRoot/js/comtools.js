var clickId;
/**
*选择药材名称
*/
 function selMedBase(obj){
 			clickId = $(obj).attr("id").substr("3");
			$("#returninfo_lastcheck").html("");
			t2 = $.dialog({
				title:'选择药材名称',
				id:'medChos',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		});
}
	
function closeDG(s){
			$("#med"+clickId).val(s[1]);
			$("#med"+clickId).focus();
			t2.close();
}

/**
*页面跳转
*/
function goToURL(url) {
	window.location.href = url;
}
var bool1 = false;//全局变量存放文本框是否验证通过
var bool2 = false;//全局变量存放药材框是否验证通过
/**
 *新增页面项未输入提示
 */
function onBlurCheck(name) {
	//获取页面输入框
	var inputVal = $.trim($("input[name="+name+"]").val());
	//获取对应的提示span提示信息
	var spanVal = $("label[id^=" + name + "]");
	
 	//判断输入框是否填写
	if (inputVal == null || inputVal == "") {
		spanVal.attr("class","errico");
		return false;
	} else {
		spanVal.attr("class","okico");
		return true;
	}
}
 ////验证文本框是否是正数////
//onkeypress 
function isN(obj) {
	if (!obj.value.match(/^[1-9]?\\d*?\\.?\\d*?$/)) {
		obj.value = obj.t_value;
	} else {
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?)?$/)) {
		obj.o_value = obj.value;
	}
}
//onkeyup
function isU(obj) {
	if (!obj.value.match(/^[1-9]?\\d*?\\.?\\d*?$/)) {
		obj.value = obj.t_value;
	} else {
		obj.t_value = obj.value;
	}
	if (obj.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?)?$/)) {
		obj.o_value = obj.value;
	}
	if (obj.value.match(/^\\.$/)) {
		obj.value = "";
	}
	if (obj.value.match(/^\\-$/)) {
		obj.value = "";
	}
	if (obj.value.match(/^00+/)) {
		obj.value = "";
	}
	if (obj.value.match(/^0\\.00/)) {
		obj.value = "";
	}
	if (obj.value.match(/^0[1-9]/)) {
		obj.value = "";
	}
}
///onblur
function isB(obj) {
	if (obj.value.match(/^0/)) {
		obj.value = "";
	}
	if (!obj.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?|\\.\\d*?)?$/)) {
		obj.value = obj.o_value;
	} else {
		if (obj.value.match(/^\\.\\d+$/)) {
			obj.value = 0 + obj.value;
		}
		obj.o_value = obj.value;
	}
}

//////////////////////////////
//验证输入框是否为空
function isNullIpu(name)
{
	var inputVal = $.trim($("input[name="+name+"]").val());
	if(inputVal == null || inputVal == ""){
		return false;
	}else
	return true;
}

function isStrIpuabc(name)
{
	var inputVal = $.trim($("input[name="+name+"]").val());
	return /[\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(inputVal);
}
function checkload(name){
	var spanVal = $("label[id^="+name+"]");
	spanVal.attr("class","loadico");
	return false;
}
function checkerror(name){
	var spanVal = $("label[id^="+name+"]");
	spanVal.attr("class","errico");
	return false;
}
function checksuccess(name){
	var spanVal = $("label[id^="+name+"]");
	spanVal.attr("class","okico");
	return true;
}
////验证文本框是否是正数////
function isNatural(obj){

}
//////////////////////////////

////验证电子邮箱////
function isEmail(obj){
	if(!obj.value.match(/^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$/))obj.value=obj.o_value;
	obj.o_value=obj.value;
}
//////////////////////////////
//验证输入框是否为空
function isNullIpu(name)
{
	var inputVal = jQuery.trim($("input[name="+name+"]").val());
	if(inputVal == null || inputVal == ""){
		$("#"+name).focus();
		return false;
	}else{
		return true;
	}
}
var i = 0;
//
/**
 *页面初始化隐藏所有以id为lab结尾的span标签
 */
$(function () {
	$("label[id$='Lab']").each(function () {
		if (this != null) {
			//$(this).hide();
		}
	});
	
	//删除一列选中的药材
	$(".delMed").live("click",function() {
		if (i <= -1) {
			return;
		}
		i--;
		$(this).parent().remove();
	  	//当不存在预计产物后,提示必须输入预计产物,并将全局变量改成false,不让弹出层
		if (i == -1) {
			bool2 = false;
			$("#s_addMed").show(1000);
		} else {
			bool2 = true;
			$("#s_addMed").hide(1000);
		}
		resetH();
	});
});

//添加一列药材
function addGrowMed() {
	if (i == -1) {
		bool2 = true;
		$("#s_addMed").hide(1000);
	}else if(i == 5){
		$.dialog.tips("每种植物最多产出6种药材",1,'alert.gif');	
		return;
	}
	i++;
	var str = "<div id=\"growMed_" + i + "\">预计产出药材：<input type=\"text\" class=\"inp\"  maxlength=\"20\" id=\"med" + i +"\""+ "name=\"med" + i + "\"" + " AUTOCOMPLETE=\"OFF\" onclick=\"selMedBase(this);\" readonly=\"readonly\" />&nbsp;<span class=\"red\">*</span>&nbsp;<span  class=\"red\" name=\"s_med" + i + "\"" + "></span>预计产量总计(kg)：<input type=\"text\" class=\"inp\" name=\"weight" + i + "\"  maxlength=\"6\" onkeypress=\"if(!this.value.match(/^[1-9]?\\d*?\\.?\\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?)?$/))this.o_value=this.value;if(this.value.match(/^\\d+\\.\\d{4}?$/)){this.value = this.value.substr(0,this.value.length-1);}\"  onkeyup=\"if(!this.value.match(/^[1-9]?\\d*?\\.?\\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?)?$/))this.o_value=this.value;if(this.value.match(/^\\.$/))this.value='';if(this.value.match(/^\\-$/))this.value='';if(this.value.match(/^00+/))this.value='';if(this.value.match(/^0\\.00/))this.value='';if(this.value.match(/^0[1-9]/))this.value='';if(this.value == 'undefined')this.value='';if(this.value.match(/^\\d+\\.\\d{4}?$/)){this.value = this.value.substr(0,this.value.length-1);}\"  onblur=\"if(this.value==0){this.value='';}if(!this.value.match(/^(?:[1-9]?\\d+(?:\\.\\d+)?|\\.\\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\\.\\d+$/))this.value=0+this.value;this.o_value=this.value;}if(!this.value.match(/^\\d+(\\.\\d{3})?$/)){this.value = this.value.substr(0,this.value.indexOf('\.')+4);}\"/>&nbsp;<span class=\"red\">*</span>&nbsp;<span class=\"red\" name=\"s_weight" + i + "\"" + "></span><a href=\"javascript:void(0)\" class=\"delMed\">删除</a></div>";
	$("#growMedList").append(str);
	resetH();
}
    	
//药材信息集合
var growMedList_str = "";
/**
*检验种植任务
*/
function checkInfo() {
	if (!onBlurCheck("plantname")) {
		return false;
	}
	if(!checkVal("plantnumber")){
		return false;
	}
	if (!onBlurCheck("plantarea")) {
		return false;
	}
	if (!onBlurCheck("plantweight")) {
		return false;
	}
	if(!checkVal("plantusername")){
		return false;
	}
	if (!onBlurCheck("plantaddtime")) {
		return false;
	}
	//获取所有id以growMed开头的div集合
	$("div[id^='growMed_']").each(function (i) {
		var currentId = $(this).attr("id").substr($(this).attr("id").length-1);
		var growMed_str;
		//获取预计药材名称
		var medStr = "input[name='med" + currentId + "']";
		var medChild = $(this).children(medStr);
		var medChild_str = medChild.val();
		
		//获取预计产物span标签 用于输入提示
		var spanMed = "span[name='s_med" + currentId + "']";
		var spanMedChild = $(this).children(spanMed);
	
		
		//获取药材预计产量
		var weightStr = "input[name='weight" + currentId + "']";
		var weightChild = $(this).children(weightStr);
		var weightChild_str = weightChild.val();
		
		//获取预计产物产量span标签 用于输入提示
		var spanWeight = "span[name='s_weight" + currentId + "']";
		var spanWeightChild = $(this).children(spanWeight);
		if (medChild_str == null || medChild_str == "") {
			spanMedChild.text("预计产出药材未输入");
			bool2 = false;
			return false;
		} else {
			spanMedChild.text("");
			bool2 = true;
		}
		if (weightChild_str == null || weightChild_str == "") {
			spanWeightChild.text(medChild_str + "产量未输入或输入错误");
			bool2 = false;
			return false;
		} else {
			spanWeightChild.text("");
			bool2 = true;
		}
		//组装成一条药材信息
		growMed_str = medChild_str + "@" + weightChild_str + "~";
		growMedList_str += growMed_str;
	});
	if (bool2) {
	 		//为预计产物动态赋值
		var harverMed="";
		$("div[id^='growMed_']").each(function (i) {
			var currentId = $(this).attr("id").substr($(this).attr("id").length-1);
			var growMed_str;
						//获取预计药材名称
			var medStr = "input[name='med" + currentId+ "']";
			var medChild = $(this).children(medStr);
			var medChild_str = medChild.val();
					
						//获取药材预计产量
			var weightStr = "input[name='weight" + currentId + "']";
			var weightChild = $(this).children(weightStr);
			var weightChild_str = weightChild.val();
			harverMed += "<div id=\"l_growMed_0\"><span>预计产出药材：</span><label id=\"l_med0\">" + medChild_str + "</label><span>   预计产量总计(kg)：</span><label id=\"l_weight0\">" + weightChild_str + "</label></div>";
		});
		$("#l_growMedList").html(harverMed);
			//为种植来源赋值
		$("#l_plantsource").text($("#plantsource").val());
		 	//将预计产物的信息拼装成字符串后放入页面hidden进行提交
		$("#harvestmedwei").val(growMedList_str);
		editSure();
	}
}
/**
*隐藏弹出层
*/
function hidePop() {
	$("#l_growMedList").empty();
	$("#pop-div").hide("1000");
}
/**
*弹出信息确认层
*/
function editSure() {
	//先给确认框赋值
	$("input").each(function () {
		var nameVal = $(this).attr("name");
		var currentLabel = "#l_" + nameVal;
		$(currentLabel).text($(this).val());
	});
	var showinfo = $.dialog({
		title:'确认信息',
		id:'sureInfo',
		lock:true,
		content: $("#pop-div").html(),
		ok: function(){
			$.dialog({
				id:'commit',
				title:'操作中',
				content: '<div style="font-size:18px;color:red;padding:20px 50px">正在进行处理,请稍等...如果等待时间超过5分钟,请关闭重试.</div>', 
				lock: true,
				parent:this,
				max:false,
				min:false,
				cancel:false
			});
			$("form").submit();
			return false;
			
		},
		cancelVal: '返回修改',
		cancel:function(){
			$("#btnfinish").removeAttr("disabled");
			//将填出div层的药材列表清空
			$("#l_growMedList").empty();
			//将保存药材预计产物和产量信息清空
			growMedList_str = "";
		}
	});
}
/**
*隐藏弹出层
*/
function hideDiv(div_id) {
	//将填出div层的药材列表清空
	$("#l_growMedList").empty();
	//将保存药材预计产物和产量信息清空
	growMedList_str = "";
	$("#mask").remove();
	$("#coverDiv").css("display", "none");
	$("#" + div_id).animate({left:300, top:20, opacity:"hide"}, "1000");
}
/**
*验证化肥
*/
function checkInfoFertilizer() {
	if(!checkVal("fertilizernameother")){
		return false;
	}
	if (!onBlurCheck("fertilizerweight")) {
		return false;
	}
	if (!onBlurCheck("fertilizertime")) {
		return false;
	}
   		//为肥料赋值
	if ($("#fertilizernameselect").val() == "其它") {
		$("#l_fertilizernameselect").text($("#fertilizernameother").val());
	} else {
		$("#l_fertilizernameselect").text($("#fertilizernameselect").val());
	}
	var fertilizername = $("#fertilizername");
	var fertilizernameselect = $("#fertilizernameselect");
	if(fertilizernameselect.val() == "其它" ){
			var fertilizernameother =$("#fertilizernameother");
			fertilizername.val(fertilizernameselect.val()+"|"+fertilizernameother.val());
       }else{
       		fertilizername.val(fertilizernameselect.val());
       }
	editSure();
}
/**
*验证农药
*/
function checkInfopesticide() {
	if(!checkVal("pesticidenameother")){
		return false;
	}
	if (!onBlurCheck("pesticideweight")) {
		return false;
	}
	if (!onBlurCheck("pesticidetime")) {
		return false;
	}
   		//为肥料赋值
	if ($("#pesticidenameselect").val() == "其它") {
		$("#l_pesticidenameselect").text($("#pesticidenameother").val());
	} else {
		$("#l_pesticidenameselect").text($("#pesticidenameselect").val());
	}
	var pesticidename = $("#pesticidename");
	var pesticidenameselect = $("#pesticidenameselect");
	if(pesticidenameselect.val() == "其它" ){
			var pesticidenameother =$("#pesticidenameother");
			pesticidename.val(pesticidenameselect.val()+"|"+pesticidenameother.val());
       }else{
    	   	pesticidename.val(pesticidenameselect.val());
       }
	editSure();
}
/**
  *新增收获页面
  */
function checkInfoMed() {
	if (!onBlurCheck("medweight")) {
		return false;
	}
	if (!onBlurCheck("harvesttime")) {
		return false;
	}
	if(!checkVal("mednumber")){
		return false;
	}
	$("#btnfinish").attr("disabled","disabled");
	editSure();
}
/**
页面级联
*/
function changepredictweight(value) {
	var strArr = value.split("@");
	$("#medname").val(strArr[0]);
	$("#predictweight").val(strArr[1]);
}
/**
*关闭种植任务
*/
function makeSure(cpcplant) {
	if (window.confirm("种植任务关闭后，无法再修改，添加数据。确定要关闭吗?")) {
		goToURL("plant!updateStateByCpcPlant.shtml?cpcplant=" + cpcplant);
	}
}
/**
*更新种植任务更新
*/
function checkUpdate() {
	if(!checkVal("plantnumber")){
		return false;
	}
 			//为预计产物动态赋值
	$("div[id^='growMed_']").each(function (i) {
		var growMed_str;
				//获取预计药材名称
		var medStr = "input[name='med" + i + "']";
		var medChild = $(this).children(medStr);
		var medChild_str = medChild.val();
			
				//获取药材预计产量
		var weightStr = "input[name='weight" + i + "']";
		var weightChild = $(this).children(weightStr);
		var weightChild_str = weightChild.val();
		var harverMed = "<div id=\"l_growMed_0\"><span>预计产出药材:</span><label id=\"l_med0\">" + medChild_str + "</label><span>    预计产量总计:</span><label id=\"l_weight0\">" + weightChild_str + "</label>(KG)</div>";
		$("#l_growMedList").append(harverMed);
	});
		
	 	//将预计产物的信息拼装成字符串后放入页面hidden进行提交
	//$("#harvestmedwei").val(growMedList_str);
	editSure();
}

//分包加、减、乘、除*********************************************

//加
function addtr(arg1,arg2){    
        var r1,r2,m;    
        try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}    
        try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}    
        m=Math.pow(10,Math.max(r1,r2));    
        return (arg1*m+arg2*m)/m;    
    }  
//减
function subtr(arg1,arg2){
	var r1,r2,m,n;
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	m=Math.pow(10,Math.max(r1,r2));
	n=(r1>=r2)?r1:r2;
	return ((arg1*m-arg2*m)/m).toFixed(n);
}
//乘 
function multiply(arg1,arg2){    
    arg1=String(arg1);var i=arg1.length-arg1.indexOf(".")-1;i=(i>=arg1.length)?0:i;    
    arg2=String(arg2);var j=arg2.length-arg2.indexOf(".")-1;j=(j>=arg2.length)?0:j;    
    return arg1.replace(".","")*arg2.replace(".","")/Math.pow(10,i+j);    
}
//除  
function division(arg1,arg2){    
    var t1=0,t2=0,r1,r2;    
    try{t1=arg1.toString().split(".")[1].length}catch(e){}    
    try{t2=arg2.toString().split(".")[1].length}catch(e){}    
    with(Math){    
        r1=Number(arg1.toString().replace(".",""));    
        r2=Number(arg2.toString().replace(".",""));     
        return (r1/r2)*pow(10,t2-t1);    
    }    
}



function checkVal(name){
			var nameobj = $("#"+name);
			var nameval = $.trim(nameobj.val());
			var namelab = $("#"+name+"Lab");
			
			if(name=="plantnumber"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("批次号不能包含~ # *等字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
				}else{
					var spanVal = $("label[id^=" + name + "]");
					spanVal.html("");
					var plantnumberLab = $("#plantnumberLab");
					plantnumberLab.attr("class", "noico");
					return true;
				}
			}
			
			if(name=="plantusername"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("人名不能包含~ # *等字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("种植负责人未输入");
						return false;
					}
			}
				
			if(name=="fertilizernameother"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("肥料种类含有非法字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("请输入肥料种类");
						return false;
					}
			}
			
		   if(name=="pesticidenameother"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("农药种类含有非法字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("请输入农药种类");
						return false;
					}
			}
			
			 if(name=="fieldcarenameother"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("种类含有非法字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("请输入种类");
						return false;
					}
			}
			
			if(name=="remark"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("不能包含~ # *等字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
				}else{
					var spanVal = $("label[id^=" + name + "]");
					spanVal.html("");
					var plantnumberLab = $("#plantnumberLab");
					plantnumberLab.attr("class", "noico");
					return true;
				}
			}
			
			 if(name=="fieldcarename1"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("种类含有非法字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("请输入种类");
						return false;
					}
			}
			
			if(name=="mednumber"){
				if(nameval!=""){
					if(checkquotmarks(nameval)==true){
						checkerror(name);
						namelab.html("批次号不能包含~ # *等字符");
						return false;
			    	}else{
			    		checksuccess(name);
			    		return true;
			    	}
			    	}else{
			    		checkerror(name);
						namelab.html("企业内部收获批次号未输入");
						return false;
					}
			}
	}

	function openMap(){
			$("#lonlat").attr("disabled","disabled");
			//创建地址解析器
			var myGeo = new BMap.Geocoder();
			//解析详细地址
			myGeo.getPoint($("#registeraddress").val(),function(point){
				if(point){
					$("#longitude").val(point.lng);
					$("#latitude").val(point.lat);			
				}
				t1 = $.dialog({
				title:'标注所在区域',
				id:'lonlat',
				lock:true,
				padding:0,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="600" height="400" src="'+"mapBase!mapBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>',
				cancelVal: "确定",
				cancel:function(){}
			});
			},$("#province").val());
		}
		
	function closeMap(s){
				$("#lonlat").removeAttr("disabled");
				$("#longitude").val(s[1]);
				$("#latitude").val(s[2]);
	}
	
/**
*打开市场楼层图
*/
var sa="";
var t1;
function openMarketMap(cpccorp){
	t1 = $.dialog({
		title:'绑定商铺位置',
		id:'lonlat',
		lock:true,
		padding:0,
		content: '<iframe frameborder="0" scrolling="no" name="MarketMapFrame" id="MarketMapFrame" width="748" height="441" src="'+"marketMap!findMarketMapByCpc.shtml?cpccorp="+cpccorp+"&ischoice="+Math.random()+'"></iframe>',
		button: [{
			id:'bind',
	        name: '开始绑定',
	        callback: function () {
	        	bindButton("1");
				return false;
	        },
	        focus: true
	    },{
	        name: '确定',
	        callback: function () {
	        	if(sa.length>0){
					$("#partion").val(sa[0]);
					$("#coordinate").val(sa[1]);
				}
	        },
	        focus: true
	    },{
	        name: '市场全景图',
	        callback: function () {
		        $.dialog({
					title:'市场全景图',
					id:'panorama',
					lock:true,
					padding:0,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="748" height="500" src="'+"marketMap!findFloorByCpc.shtml?cpccorp="+cpccorp+"&ischoice="+Math.random()+'"></iframe>',
					parent:this,
					max:false,
					min:false
				});
				return false;
	        },
	        focus: true
	    }]
	});
}

function bindButton(str){
	var obj = $(".ui_buttons input").eq(0);
	if(obj.val().indexOf("开始")>-1&&str!=""){
		obj.val('取消绑定');
		$("#MarketMapFrame")[0].contentWindow.bindPoint();
	}else{
		obj.val('开始绑定');
		$("#MarketMapFrame")[0].contentWindow.unBindPoint();
	}
}
/**
*关闭市场楼层图
*/
function closeMarketMap(s){
	sa=s;
}



//Textarea-光标定位到最后
function locateTextarea(obj){ 
	var aCtrl = document.getElementById(obj); 
	var   o=aCtrl.createTextRange();    
	o.move("character",aCtrl.value.length);    
	o.select();    		
} 

function subTextarea(obj,maxLen){
	var flag=false;  
    var curLength=$("#"+obj).val().length;   
    if(curLength>maxLen){  
        //var num=$("#"+obj).val().substr(0,maxLen);  
        //$("#"+obj).val(num); 
        flag=true;  
        //$.dialog.tips('输入内容不能超过'+maxLen+'个字符!',2,'alert.gif');  
        //定位光标        
        //locateTextarea(obj); 
    } 
    return flag; 
}  


/**
*田间管理下一步
*/
function checkFieldCare(){
	var fieldcaretype = $("#fieldcaretype").val();
	var fieldcarenameselect = $("#fieldcarenameselect");
	//为田间管理其他类型
   	$("#l_fieldcaretype").text(fieldcaretype);
	var fieldcarename = $("#fieldcarename");
	
	if(fieldcaretype != '施肥' && fieldcaretype != '农药'){
		fieldcarename.val("");
	}else{
		if(fieldcarenameselect.val() == '其它'){
			if(!checkVal("fieldcarenameother")){
				return false;
			}
			var fieldcarenameother =$("#fieldcarenameother");
			fieldcarename.val(fieldcarenameselect.val()+"|"+fieldcarenameother.val());
			$("#l_fieldcarenameselect").text($("#fieldcarenameother").val());
		}else{
    	   	fieldcarename.val(fieldcarenameselect.val());
    	   	$("#l_fieldcarenameselect").text($("#fieldcarenameselect").val());
   		 }
		if (!onBlurCheck("fieldcareweight")) {
			return false;
		}
	}
	
	if (!onBlurCheck("fieldcaretime")) {
		return false;
	}
	if(!checkVal("remark")){
		return false;
	}
	editSure();
}