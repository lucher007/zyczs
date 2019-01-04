$(document).ready(function() {
    //刷新验证码
	$(".login-code img,.login-code a").click(function(){
		changeCode();
		return false;
	});
	//设置背景图片
	forbg();
	$(window).resize(function() {
		forbg();
	});
});

function changeCode(){
	$(".login-code img").attr("src","http://192.168.0.244:8080/AuthImgAction.shtml?requestFlag="+Math.random());
}

function forbg(){
	var t = (($(window).width()-944)/2)%18;
	if(t!=0){$("body").css("background-position","-"+(t+1)+"px top")};
}