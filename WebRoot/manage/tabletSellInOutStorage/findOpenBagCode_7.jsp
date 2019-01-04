<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>饮片包装</title>
<link type="text/css" rel="stylesheet" href="/style/plant.css">
<link type="text/css" rel="stylesheet" href="/style/production.css">	
<script type="text/javascript">
function clear(){
	$("#boxcodes").val("");
}
</script>
</head>

<body>
<div id="body">
	<form action="" name="searchform" id="searchform" method="post">
	<s:token></s:token>
	<input type="hidden" name="totalweightval" id="totalweightval" />
	<input type="hidden" name="prodcode" id="prodcode" />
	

	<div id="dataDiv"></div>
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片拆包</div>
	<div class="form-box">
    	<div class="fb-tit">待拆包饮片 <b class="red f12">提示：输入溯源码后敲回车即可提交后台查询</b></div>
        <div class="fb-con">
        	<table width="736" border="0" cellpadding="0" cellspacing="0" class="com-sel">
              <tr>
              	<td align="right">溯源码：</td>
                <td><input type="text" value="请手动输入或者使用扫码枪输入溯源码" id="boxcodes" maxlength="40" class="inp w250" style=" padding:7px;"  name="boxcodes" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);onKeyInput2(event)">
                <input type="button" value="查询" class="sbt" onclick="onSubmit();">
                </td>
                <td width="70" align="right"></td>
                <td width="216"></td>
              </tr>
            </table>
            
            <table width="734" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"></td>
                <td width="300">
                <span style="font-size:13px;font-weight:bold;">合计：<b style="color:red;font-size:20px;" id="totalboxnum">0</b> 袋</span>
<%--                <span>(<b  id="totalitemnum">0</b> 包、<b  id="totalweight">0</b> kg) </span>--%>
                </td>
                <td height="30" width="10">
                <input type="button" value="拆包" id="subBut" class="sbt" onclick="checkForm();">
                </td>
              </tr>
            </table>
            
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent">
              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>溯源码</td>
	                <td>小包装规格(g/包)</td>
	                <td>中包数</td>
	                <td>批次号</td>
	                <td>总重量(Kg)</td>
	                <td>操作</td>
	              </tr>
            </table>
            
            
        </div>
        
    </div>
    </form>
</div>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" src="/js/comtools.js"></script>
<script type="text/javascript">
	
    	
	inp("#boxcodes","请手动输入或者使用扫码枪输入溯源码");
	$(document).ready(function(){ $("#boxcodes").focus();})
	$(".com-sel a").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
		var t = $(".com-sel a").index(this);
		$(".com-list table").eq(t).attr("class","show");
		t==0?$(".com-list table").eq(1).attr("class","hide"):$(".com-list table").eq(0).attr("class","hide");
	});
	
	function onKeyInput2(e) {
			if (event.keyCode == 13) {
				onSubmit();	
			}
		}
	
	function onSubmit(){
		if(jQuery.trim($("#boxcodes").val())==""||$("#boxcodes").val().length<20||jQuery.trim($("#boxcodes").val())=="请手动输入或者使用扫码枪输入溯源码"){
			$.dialog.tips('请输入正确的箱码',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		if(codeArray.length>5){
			$.dialog.tips('每次拆袋不能超过5条',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		if(Arraycontains($("#boxcodes").val(),0)==true){						
			$.dialog.tips('该溯源码已存在',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}else{				
			getCode2($("#boxcodes").val());
		}			
		
	}
	
	var curcpc="";
	var curweight="";
	var curname="";
	
	function getCode2(boxcodes){
		var type=boxcodes.substring(0,1);
		if(type=="5"||type=="6"){
			$.dialog.tips('该饮片不是袋码、不能拆袋',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}	
		var url="<%=request.getContextPath()%>/tabletSellInOut!findOpenBugCode_8.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("");
		$.getJSON(url,function(msg){
			if(msg.returnCode==1){
				$.dialog.tips(msg.returnInfo,1,'alert.gif');
				$("#boxcodes").val("");
			}else{
				//判断是否装袋
				var packcode=msg.stoVO.packcode;					
				if(packcode.length==35){
					$.dialog.tips('该箱饮片已经装袋、不能重复操作',2,'alert.gif');
					$("#boxcodes").val("");
					return;
				}
				
				showData(msg.stoVO,msg.code);
				codeArray[codeArray.length]=new Array(msg.code);										
			}
		});
	}
	
	var codeArray=new Array();	
	function Arraycontains(chvalue,index)
	{
		var falgs=false;
		for(var i=0;i<codeArray.length;i++)
		{
			if(codeArray[i][index]==chvalue)
			{
				 falgs=true;
				 break;
			}
		}
		return falgs;
	}
	
	//添加一列药材
	function showData(obj,code){ 
		//var keyid=obj.cpctablet+multiply(obj.tabletnumweight,10000);
		var keyid=code;
		//当前包装重量
		var boxweight=division(obj.boxweight,10000);
		
 		var htmlStr='<tr id="tr_'+keyid+'">';	
 		htmlStr+='<input type="hidden" id="tabletstorid'+keyid+'"  value="'+obj.tabletstorid+'"/>';
 		//htmlStr+='<input type="hidden" id="weight'+keyid+'"  value="'+obj.tabletnumweight+'"/>';
 		//htmlStr+='<input type="hidden" id="boxitemnum'+keyid+'"  value="'+obj.boxitemnum+'"/>';
 		//htmlStr+='<input type="hidden" id="prodcode'+keyid+'"  value="'+obj.prodcode+'"/>';
 		
 		htmlStr+='<td height="30" id="name'+keyid+'">'+obj.tabletname+'</td>'; //品名
 		htmlStr+='<td id="code'+keyid+'">'+code+'</td>'; //袋码
 		htmlStr+='<td id="weight'+keyid+'">'+division(obj.tabletnumweight,10)+'</td>';//规格	
 		htmlStr+='<td id="boxitemnum'+keyid+'">'+obj.boxitemnum+'</td>';//箱数	
 		htmlStr+='<td id="cpctablet'+keyid+'">'+obj.cpctablet+'</td>';//批次
 		htmlStr+='<td id="weightall'+keyid+'" >'+boxweight+'</td>';//重量
 		htmlStr+='<td id="" ><a class="btn-look" href="javascript:void(0);" onclick="javascript:showBoxList(\''+code+'\');">详情</a></td>';
 		
 		
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计		
		//$("#totalweight").html(addtr($("#totalweight").html(),weightall));
		$("#totalboxnum").html(addtr($("#totalboxnum").html(),1)); //总袋
		//$("#totalitemnum").html(addtr($("#totalitemnum").html(),obj.boxitemnum));//总包

	    resetH();
	}
	
	
	
	function getOutList(){			
		var datastr="";
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);			
			var code=$('#code'+num).text();	
			var tabletstorid=$('#tabletstorid'+num).val();						
			datastr+='<input type="hidden" name="inOutStorList['+i+'].code" id="codeList['+i+'].code" value="'+code+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].inoutstorboxid" id="codeList['+i+'].inoutstorboxid" value="'+tabletstorid+'"/>';	
		
		});	
		
		return datastr;
	}
		
	function checkForm(){
		
		var datastr=getOutList();
		//alert(datastr);
		if(datastr==""){
			$.dialog.alert('<div style="line-height:22px; width:160px; padding-left:20px;">请提交溯源码查询</div>');
			return false;
		}
		//合计重量
		//var totalweightval = jQuery.trim($("#totalweight").html());
		//if(totalweightval != null && totalweightval != ""){
		//	totalweightval = multiply(totalweightval,10000);
		//}
		//$("#totalweightval").val(totalweightval);		
		
				
		$.dialog.confirm('确认要提交吗？', function(){ 
			var cm=$.dialog({
				title:'拆袋操作',
				id:'pack',
				lock:true,
				content: '<div style="font-size:18px;color:red;padding:20px 50px">正在拆袋,请稍等...等待时间超过2分钟,请关闭重试.</div>',
				min:false,
				max:false,
				cancel:false
			});	
			$('#dataDiv').html(datastr);				
			$("#searchform").attr("action", "tabletSellInOut!addOpenBagCode.shtml");
			$("#searchform").submit();	
			$("#subBut").attr("disabled","disabled");
			//$("#backBut").attr("disabled","disabled");
		}, function(){
				
		});		
		
	}
	
	
	function showBoxList(packcode){
		t1 = $.dialog({
			title:'箱码列表',
			id:'medChos',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>tabletStorage!showBoxList.shtml?packcode='+packcode+'&ischoice='+Math.random()+'"></iframe>',
			max:false,
			min:false
		});	
	}
	
	//只能输入数字
	function onkeyupNum(obj){
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined')
			obj.value='';	
	}
	
	
	function onKeyInput2(e) {
			if (event.keyCode == 13) {
				onSubmit();	
			}
		}

</script>

</body>
</html>

