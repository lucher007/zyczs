$(document).ready(function(e) {
	$(".inp").live('focus',function(){ $(this).css("color","#333");});
	//让父框架自适应子框架高度
	resetH();
	$(".lb-list,.fb-list").hover(function(){
		$(this).find("td").css("background","#e9e9dd");
	},function(){
		$(this).find("td").css("background","#FFF");
	});
	/*$(".fbt-tab a").click(function(){
		$(this).addClass("act").siblings().removeClass("act");
		$(".fbc-box").hide();
		$(".fbc-box").eq($(".fbt-tab a").index(this)).show();
	});*/
	$("#searchform").submit(function(){
		if($(this).attr("action")==""){
			return false;
		};
	});
	
	if($('.remarkClass').length > 0){
		//标题title浮动样式
		$('.remarkClass').poshytip({
			className: 'tip-yellowsimple',
			alignTo: 'target',
			alignX: 'center',
			alignY: 'bottom',
			offsetX: 0,
			offsetY: 3,
			fade: false,
			slide: false
		}); 
	};
	//函数作用：验证输入框只能输入数字
	$(".onlynum").keyup(function(){
		checkNum($(this));
	}).keypress(function(){
		checkNum($(this));
	}).blur(function(){
		checkNum($(this));
	}).live('keyup',function(){
		checkNum($(this));
	}).live('keypress',function(){
		checkNum($(this));	
	}).live('blur',function(){
		checkNum($(this));
	});
	
	
	if($.dialog){$.dialog.setting.drag = false;};
});
//控制搜索词效果
function inp(obj,str){
	$(obj).focus(function(){
		$(this).css("color","#333");
		if($(this).val()==str){
			$(this).val('');
		}
	}).blur(function(){
		if($(this).val()==str||$(this).val()==''){
			$(this).css("color","#999");
			$(this).val(str);
		}
	});
}
//根据子框架高度重新设置父框架高度
function resetH(){
	var h = $("#body").height();
	if(h>420){
		h=h+40;
	}else{
		h=460;
	}
	$('#MainFrame',window.parent.document).height(h);
}
//实现Tab切换效果
function showTab(thi,menu,list,cls){
	$(thi).addClass(cls).siblings().removeClass(cls);
	$(list).eq($(menu).index(thi)).show().siblings().hide();
}
//验证查询框不能输入以下字符
function checkquotmarks(str){
	return /[\·\'\"\~\`\_\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\-\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
}

//营业执照验证
function checkquotmarks_businesscode(str){
	return /[\'\"\!\$\%]/.test(str);
}
//控制父框架菜单样式
function cMenu(n1,n2){
	/*$("#menu .m-list div a",parent.document).removeClass("act");
	$("#menu .m-list div a",parent.document).eq(n1).addClass("act");
	$("#main .ml-menu",parent.document).removeClass("hide").addClass("hide");
	$("#main .ml-menu",parent.document).eq(n1).removeClass("hide");
	$("#main .ml-menu",parent.document).eq(n1).find("a").removeClass("act");
	$("#main .ml-menu",parent.document).eq(n1).find("a").eq(n2).addClass("act");*/
}

//查询药材批次信息
function openCpc(cpc){
	var index = cpc.lastIndexOf('=');
	var type = cpc.substring(index+1); //根据type值来判断弹出的是药材CPC还是饮片CPC
	var height = 500;
	if('medicine' == type){
		height = '450';
	}else if('pieces' == type){
		height = '650';
	}
	$.dialog({
		title:'查询批次',
		id:'cpc',
		lock:true,
		content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="720" height="'+ height +'" src="'+cpc+'"></iframe>'
	});
}

function checkNum(obj){
	if(!checkNumberChar(obj.val())){
    	obj.val("");
    }
}
//1.js验证只能输入数字.
function checkNumberChar(ob){
	if(/^\d+$/.test(ob)){
		return true;
	}else{
		return false;
	}
}

/**
*获取字节数
*/
function getBytesLength(str) {
	return str.replace(/[^\x00-\xff]/g, 'xx').length;
}
