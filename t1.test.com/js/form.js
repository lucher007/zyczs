$(document).ready(function(e) {
	$(".inp").focus(function(){ $(this).css("color","#333");});
	//让父框架自适应子框架高度
	resetH();
	$(".lb-list").hover(function(){
		$(this).find("td").css("background","#e9e9dd");
	},function(){
		$(this).find("td").css("background","#FFF");
	});
	$(".fbt-tab a").click(function(){
		$(this).addClass("act").siblings().removeClass("act");
		$(".fbc-box").hide();
		$(".fbc-box").eq($(".fbt-tab a").index(this)).show();
	});
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