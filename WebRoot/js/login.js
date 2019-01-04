$(document).ready(function() {
	//设置背景图片
	forbg();
	$(window).resize(function() {
		forbg();
	});
});


function forbg(){
	var t = (($(window).width()-944)/2)%18;
	if(t!=0){$("body").css("background-position",(t+1)+"px top")};
}