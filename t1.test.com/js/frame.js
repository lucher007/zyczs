$(document).ready(function(e) {
	//顶部菜单JS效果
    $(".m-list div a").click(function(){
		$(".m-list div a").removeClass("act");
		$(this).addClass("act");
		var t = $(".m-list div a").index(this);
		$(".ml-menu").removeClass("hide").addClass("hide");
		$(".ml-menu").eq(t).removeClass("hide");
		var url = $(".ml-menu").eq(t).find("a.act").attr("href");
		$("#MainFrame").attr("src",url);
		return false;
	});
	//左侧菜单JS效
	$(".ml-menu li a").click(function(){
		$(this).parents(".ml-menu").find("a").removeClass("act");
		$(this).addClass("act");
	});
	$(".mlm-tit a").click(function(){
		$(".mlm-list ul").addClass("hide");
		$(this).parents(".mlm-list").find("ul").removeClass("hide");
		$(this).parents(".mlm-list").find("ul a").removeClass("act");
		$(this).parents(".mlm-list").find("ul a:first").addClass("act");
		var url = $(this).parents(".mlm-list").find("ul a:first").attr("href");
		$("#MainFrame").attr("src",url);
	});
});