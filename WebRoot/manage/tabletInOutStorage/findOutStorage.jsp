<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>饮片出库</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
<script type="text/javascript">

</script>
</head>

<body>
<form action="" id="searchform" name="searchform" method="post">
<div id="body">
	<div class="cur-pos">当前位置：饮片库存销售 > 饮片出库</div>
	<div class="form-box">
    	<div class="fb-tit">待出库饮片 &nbsp;&nbsp;&nbsp; <b style="color:red;font-size:12px;"> 提示：出库溯源码不能超过200条、每条以换行分隔</b></div>
        <div class="fb-con">
        	<textarea class="outarea hide" id="boxcodes" name="boxcodes" >${requestScope.boxcodes }</textarea>
        </div>
        <div class="fb-bom">        	
        	<cite class="gray"><label style="color:red;" id="returninfo">${requestScope.returninfo }</label><input type="button" value="下一步" class="sbt" onclick="return checkForm();"></cite>        	
            <input type="reset" value="重置" class="sbt"/>      
        </div>
    </div>
    
</div>
</form>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/plugin/curposBak.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>

<script type="text/javascript">
	//inp(".outarea","请使用扫描抢进行扫码或者请输入出库溯源药材码");
	function checkForm(){
		if(jQuery.trim($("#boxcodes").val())==""||$("#boxcodes").val().length<36||jQuery.trim($("#boxcodes").val())=="请使用扫描抢进行扫码或者请输入出库溯源药材码"){
			$("#returninfo").html("请输入正确的溯源码!");
			return false;
		}
		var boxcodearray =$("#boxcodes").val().split("BR");
		if(boxcodearray.length>200){
			$("#returninfo").html("出库溯源码不能超过200条!");
			return false;
		}
		for(var i=0;i<boxcodearray.length;i++){
			if(boxcodearray[i].length>40){
				$("#returninfo").html("单条溯源码太长!");
				return false;
			}
		}
		$("#searchform").attr("action", "tabletStorage!findOutStorage.shtml");
		$("#searchform").submit();
	}
	
	function clear(){
	$("#boxcodes").val("");
	}
	
	function writeflashobject() { 
		var html = "";
		html+="<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\ width=\"726\" height=\"212\" id=\"FlashVars\" align=\"middle\"\>\n"; 
		html+="<param name=\"allowscriptAccess\" value=\"sameDomain\" /\>\n"; 
		html+="<param name=\"movie\" value=\"\/images\/textarea.swf\" /\>\n";
		html+="<param name=\"quality\" value=\"high\" /\>\n";
		html+="<embed src=\"\/images\/textarea.swf\" quality=\"high\" bgcolor=\"#ffffff\" width=\"726\" height=\"212\" name=\"FlashVars\" align=\"middle\" allowscriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /\>"; 
		html+="</object\>";
		$(".fb-con").css("padding-left","10px").append(html);
	}
	writeflashobject();
	function setTxtVal(x){
		$("#boxcodes").html(removeHTMLTag(x));
	}		
	function removeHTMLTag(str) {
		str = str.replaceAll("</P>",'</P>BR'); //去除HTML tag
		str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
		str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
		str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
		str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
		return str;
	}
	String.prototype.replaceAll = function(s1,s2){    
		return this.replace(new RegExp(s1,"gm"),s2);    
	}
	
</script>
</body>
</html>

