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
	<input type="hidden" name="packcode" id="packcode" />

	<div id="dataDiv"></div>
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片包装</div>
	<div class="form-box">
    	<div class="fb-tit">待包装饮片 <b class="red f12">提示：输入溯源码后敲回车即可提交后台查询</b></div>
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
                <span style="font-size:13px;font-weight:bold;">合计：<b style="color:red;font-size:20px;" id="totalboxnum">0</b> 箱</span>
                <span>(<b  id="totalitemnum">0</b> 包、<b  id="totalweight">0</b> Kg) </span>
                </td>
                <td height="30" width="10">
                
                </td>
              </tr>
            </table>
            
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent">
              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>溯源码</td>
	                <td>小包装规格(g/包)</td>
	                <td>批次号</td>
	                <td>包装重量(Kg)</td>
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
		if(codeArray.length>200){
			$.dialog.tips('装袋箱码不能超过100条',2,'alert.gif');
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
	var curboxitemnum="";
	
	
	function getCode2(boxcodes){
		var type=boxcodes.substring(0,1);
		if(type=="5"){
			$.dialog.tips('该饮片不是中包装码、不能包装',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		//第一次不能输入大包装码	
		if(type=="7"&&curcpc==""&&curweight==""){
			$.dialog.tips('请先输入中包装码',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		
		var url="<%=request.getContextPath()%>/tabletSellInOut!findOutCode.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("");
		$.getJSON(url,function(msg){
			if(msg.returnCode==1){
				if(type=="7"){
					//确定绑定
					if(type=="7"&&curcpc!=""&&curweight!=""){
						var prodcode=$("#prodcode").val();	
						var prodcode2=boxcodes.substring(1,prodcode.length+1);
						//判断中包装产品编码和大包装产品编码是否一致
						if(prodcode!=prodcode2){
							$.dialog.tips('大包装码和列表中的商品编码不一致',2,'alert.gif');
							$("#boxcodes").val("");
							return;
						}else{	
							checkForm(boxcodes);
							return;
						}
						
					}
				}else{
					$.dialog.tips(msg.returnInfo,1,'alert.gif');
					$("#boxcodes").val("");
				}
				
			}else{
				//判断是否装袋--中袋
				var packcode=msg.stoVO.packcode;					
				if(packcode.length==35){
					$.dialog.tips('该箱饮片已经包装、不能重复操作',2,'alert.gif');
					$("#boxcodes").val("");
					return;
				}
				//判断当前输入大包装码是否已经绑定
				if(type=="7"){
					$.dialog.tips('该大包装码已经被使用、不能重复包装',2,'alert.gif');
					$("#boxcodes").val("");
					return;
				}
				
				
				//第一次装载
				if(curcpc==""&&curweight==""){
					curcpc=msg.stoVO.cpctablet;
					curweight=multiply(msg.stoVO.tabletnumweight,10000);
					curname=msg.stoVO.tabletname;
					curboxitemnum=msg.stoVO.boxitemnum;
					showData(msg.stoVO,msg.code);
					codeArray[codeArray.length]=new Array(msg.code);				
					$("#prodcode").val(msg.stoVO.prodcode);		

				}else{
					var cpc=msg.stoVO.cpctablet;
					var weight=multiply(msg.stoVO.tabletnumweight,10000);
					var name=msg.stoVO.tabletname;
					if(curname!=name){
						$.dialog.tips('非同一品名、该箱饮片不能包装',2,'alert.gif');
						$("#boxcodes").val("");
						return;
					}
					if(cpc!=curcpc){
						$.dialog.tips('非同一批次、该箱饮片不能包装',2,'alert.gif');
						$("#boxcodes").val("");
						return;
					}
					if(weight!=curweight){
						$.dialog.tips('非同一规格、该箱饮片不能包装',2,'alert.gif');
						$("#boxcodes").val("");
						return;
					}
					if(msg.stoVO.boxitemnum!=curboxitemnum){
						$.dialog.tips('每箱包数不一样、该箱饮片不能包装',2,'alert.gif');
						$("#boxcodes").val("");
						return;
					}
					
					showData(msg.stoVO,msg.code);
					codeArray[codeArray.length]=new Array(msg.code);
					
				}						
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
		var weightall=division(multiply(obj.tabletnumweight,obj.boxitemnum),10000);
		
 		var htmlStr='<tr id="tr_'+keyid+'">';	
 		htmlStr+='<input type="hidden" id="tabletstorid'+keyid+'"  value="'+obj.tabletstorid+'"/>';
 		htmlStr+='<input type="hidden" id="weight'+keyid+'"  value="'+obj.tabletnumweight+'"/>';
 		htmlStr+='<input type="hidden" id="boxitemnum'+keyid+'"  value="'+obj.boxitemnum+'"/>';
 		htmlStr+='<input type="hidden" id="prodcode'+keyid+'"  value="'+obj.prodcode+'"/>';
 		
 		htmlStr+='<td height="30" id="name'+keyid+'">'+obj.tabletname+'</td>'; //品名
 		htmlStr+='<td id="code'+keyid+'">'+code+'</td>'; //箱码
 		htmlStr+='<td id="weight_boxitemnum'+keyid+'">'+division(obj.tabletnumweight,10)+'*'+obj.boxitemnum+'</td>';//规格		
 		htmlStr+='<td id="cpctablet'+keyid+'">'+obj.cpctablet+'</td>';//批次
 		htmlStr+='<td id="weightall'+keyid+'" >'+weightall+'</td>';//包装重量
 		
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计		
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));
		$("#totalboxnum").html(addtr($("#totalboxnum").html(),1)); //总箱
		$("#totalitemnum").html(addtr($("#totalitemnum").html(),obj.boxitemnum));//总包

	    resetH();
	}
	
	
	
	function getOutList(){			
		var datastr="";
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);
			
			var code=$('#code'+num).text();	
			var tabletstorid=$('#tabletstorid'+num).val();				
			var name=$("#name"+num).text();
			var prodcode=$("#prodcode"+num).val();
			var cpc=$("#cpctablet"+num).text();				
			//规格
			var weight=jQuery.trim($("#weight"+num).val());		
			//每箱包数
			var boxitemnum=jQuery.trim($("#boxitemnum"+num).val());					
	
			//包装重量
			var weightall=jQuery.trim($("#weightall"+num).text());
			if(weightall != null && weightall != ""){
				weightall = multiply(weightall,10000);
			}
			
			
			datastr+='<input type="hidden" name="inOutStorList['+i+'].code" id="codeList['+i+'].code" value="'+code+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].inoutstorboxid" id="codeList['+i+'].inoutstorboxid" value="'+tabletstorid+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].prodname" id="codeList['+i+'].prodname" value="'+name+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].prodcode" id="codeList['+i+'].prodcode" value="'+prodcode+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].batchcpc" id="codeList['+i+'].batchcpc" value="'+cpc+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxnumweight" id="codeList['+i+'].boxnumweight" value="'+weight+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxitemnum" id="codeList['+i+'].boxitemnum" value="'+boxitemnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxnum" id="codeList['+i+'].boxnum" value="1"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].totalweight" id="codeList['+i+'].totalweight" value="'+weightall+'"/>';		
		
		});	
		
		return datastr;
	}
		
	function checkForm(packcode){
		
		var datastr=getOutList();
		//alert(datastr);
		if(datastr==""){
			$.dialog.alert('<div style="line-height:22px; width:160px; padding-left:20px;">请提交溯源码查询</div>');
			return false;
		}
		//合计重量
		var totalweightval = jQuery.trim($("#totalweight").html());
		if(totalweightval != null && totalweightval != ""){
			totalweightval = multiply(totalweightval,10000);
		}
		$("#totalweightval").val(totalweightval);		
		
				
		$.dialog.confirm('确认包装吗？', function(){ 
			var cm=$.dialog({
				title:'装袋打码',
				id:'pack',
				lock:true,
				content: '<div style="font-size:18px;color:red;padding:20px 50px">正在装袋,请稍等...等待时间超过2分钟,请关闭重试.</div>',
				min:false,
				max:false,
				cancel:false
			});	

			  $("#packcode").val(packcode);
			  $('#dataDiv').html(datastr);				
			  $("#searchform").attr("action", "tabletSellInOut!addBagCode.shtml");
			  $("#searchform").submit();

		}, function(){
				$("#boxcodes").val("");
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

