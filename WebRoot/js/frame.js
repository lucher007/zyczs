$(document).ready(function(e) {
	//顶部菜单JS效果
    $(".m-list div a").click(function(){
    	var mt = $(this).attr('tc');
   		if(mt!=''&&mt+""!='undefined'){
			showCard(mt);
			return false;
		};
		$(".m-list div a").removeClass("act");
		$(this).addClass("act");
		var t = $(".m-list div a").index(this);
		$(".ml-menu").removeClass("hide").addClass("hide");
		$(".ml-menu").eq(t).removeClass("hide");
		if($(".ml-menu").eq(t).find("a:eq(0)").attr("href")!="javascript:void(0);"){
			$(".ml-menu").eq(t).find("a").removeClass("act");
			$(".ml-menu").eq(t).find("a:eq(0)").addClass("act");
		}
		var url = $(".ml-menu").eq(t).find("a[class=act]").attr("href");
		$("#MainFrame").attr("src",url);
		return false;
		/*$(".m-list div a").removeClass("act");
		$(this).addClass("act");
		var t = $(".m-list div a").index(this);
		$(".ml-menu").removeClass("hide").addClass("hide");
		$(".ml-menu").eq(t).removeClass("hide");
		var url = $(".ml-menu").eq(t).find("a.act").attr("href");
		$("#MainFrame").attr("src",url);
		return false;*/
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
	
	$("#down").live('click',function(){
		$("#MainFrame")[0].contentWindow.downloadData_downFile();
    });
});

function showCard(m){
	location.href='/manage/medMarket/selectSwipingCard.jsp?mt='+m;
};

function cMenu(n1,n2){
	$("#menu .m-list div a").removeClass("act");
	$("#menu .m-list div a").eq(n1).addClass("act");
	$("#main .ml-menu").removeClass("hide").addClass("hide");
	$("#main .ml-menu").eq(n1).removeClass("hide");
	$("#main .ml-menu").eq(n1).find("a").removeClass("act");
	$("#main .ml-menu").eq(n1).find("a").eq(n2).addClass("act");
	var url = $(".ml-menu").eq(n1).find("a.act").attr("href");
	$("#MainFrame").attr("src",url);
}

function printData_downControl(num){
	if(num==32){
		window.location.href="js/setup32.exe"
	}else{
		window.location.href="js/setup64.exe"
	}
}
var check=function(e){ 
	e=e||window.event;
	if((e.which||e.keyCode)==116){ 
		if(e.preventDefault){ 
			e.preventDefault(); 
			window.frames["MainFrame"].location.reload(); 
		} else{
			event.keyCode = 0; 
			e.returnValue=false;
			window.frames["MainFrame"].location.reload(); 
		} 
	} 
} 
if(document.addEventListener){ 
	document.addEventListener("keydown",check,false); 
} else{ 
	document.attachEvent("onkeydown",check); 
}