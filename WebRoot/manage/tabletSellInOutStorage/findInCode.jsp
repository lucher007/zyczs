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
<title>饮片入库</title>
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
	
	<div id="dataDiv"></div>
	
	
	
	<div class="cur-pos">当前位置：库存管理 > 饮片入库</div>
	<div class="form-box">
    	
    	<div class="fb-tit">待入库饮片 <b class="red f12">提示：输入溯源码后敲回车即可提交后台查询</b></div>
        <div class="fb-con">
        	<table width="736" border="0" cellpadding="0" cellspacing="0" class="com-sel">
              <tr>
              	<td align="right">溯源码：</td>
                <td><input type="text" value="请手动输入或者使用扫码枪输入溯源码" id="boxcodes" maxlength="40" class="inp w320" style=" padding:7px;"  name="boxcodes" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);onKeyInput2(event)">
                <input type="button" value="查询" class="sbt" onclick="return onSubmit();">
                </td>
                
                
              </tr>
            </table>
            
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent" style="display:none;">            
	          <tr class="fbc-tit">
                <td>品名</td>
                <td>批次号</td>
                <td>商品编码</td>
                <td>小包装规格(g/包)</td>
                <td>中包数</td>
                <td>小包数</td>
                <td>重量(g)</td>               
              </tr>
              
            </table>
            
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent2" style="display:none;">            
	          <tr class="fbc-tit">
                <td>大包装</td>
                <td>溯源码</td>
                <td>重量(g)</td>
                <td>详情</td>               
              </tr>
              
            </table>
            
            <table width="734" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"></td>
                <td width="300"><cite><span>合计重量：<b style="color:red;" id="totalweight">0</b>(g)</span></cite></td>
                <td height="30" width="10"></td>
              </tr>
            </table>
        </div>
        <div class="fb-bom">
        	<cite class="gray"><input type="button" value="提交入库" class="sbt" onclick="checkForm();"></cite>
<%--            <input type="button" value="取 消" class="sbt">--%>
        </div>
        <br/>
    </div>
    
    </form>
    
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
    
<script type="text/javascript">
	window.onerror=function(){
    	  return true;
    	}
    	
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
			$.dialog.tips('请输入正确的溯源码',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		if(codeArray.length>200){
			$.dialog.tips('入库溯源码不能超过200条',2,'alert.gif');
			$("#boxcodes").val("");
			return;
		}
		if(Arraycontains($("#boxcodes").val(),0)==true){						
			$.dialog.tips('该溯源码已存在',2,'alert.gif');
			$("#boxcodes").val("");
		}else{				
			getCode2($("#boxcodes").val());
		}				
	
	}
	
	function getCode2(boxcodes){
	//var tip =$.dialog.tips('数据查询中...',600,'loading.gif'); 
	var url="<%=request.getContextPath()%>/tabletSellInOut!findInCode.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("")
			$.getJSON(url,function(msg){
				if(msg.returnCode==1){
					$.dialog.tips(msg.returnInfo,1,'alert.gif');
					$("#boxcodes").val("");
				}else{
					var type=msg.code.substring(0,1);
					if(type=="8"){
						var keyid=msg.code;
						showData_8(msg.stoVO,msg.code,keyid,8);					
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}else if(type=="7"){
						var keyid=msg.code;
						showData(msg.stoVO,msg.code,keyid,7);					
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}else if(type=="5"){
						var keyid=msg.code;
						showData(msg.stoVO,msg.code,keyid,5);					
						codeArray[codeArray.length]=new Array(msg.code,keyid);
						
					}else if(type=="6"){
						var keyid=msg.stoVO.batchno+multiply(msg.stoVO.weight,10000);	
						var keyObj=document.getElementById("tr_"+keyid);
						if(keyObj!=null){	
							addData(msg.stoVO,msg.code,keyid);
							codeArray[codeArray.length]=new Array(msg.code,keyid);
						}else{
							showData(msg.stoVO,msg.code,keyid,6);
							codeArray[codeArray.length]=new Array(msg.code,keyid);
						}		
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
	function showData(obj,code,keyid,codeType){ 
		//var keyid=obj.batchno+multiply(obj.weight,10000);
		//当行总重量=规格X包数
		var weightall=0;
		if(codeType==7){
			weightall=multiply(obj.weight,(obj.boxnum*obj.boxitemnum));
		}else if(codeType==6){
			weightall=multiply(obj.weight,obj.boxitemnum);
		}else if(codeType==5){
			weightall=obj.weight;
		}
		
		
 		var htmlStr='<tr id="tr_'+keyid+'">';	
 		htmlStr+='<input type="hidden" id="groupInfo'+keyid+'"  value="'+code+','+obj.lasttime+','+obj.boxitemnum+'"/>';
 		htmlStr+='<input type="hidden" id="codetype'+keyid+'"  value="'+codeType+'"/>';	
 		htmlStr+='<input type="hidden" id="code'+keyid+'"  value="'+code+'"/>';
 		htmlStr+='<input type="hidden" id="boxsCode'+keyid+'"  value="'+obj.boxsCode+'"/>';	
 		//记录每箱包数
 		htmlStr+='<input type="hidden" id="tabletboxitemnum'+keyid+'" value="'+obj.boxitemnum+'"/>';	
 		htmlStr+='<td height="30" id="name'+keyid+'">'+obj.pname+'</td>';
 		htmlStr+='<td id="batchno'+keyid+'">'+obj.batchno+'</td>';
 		htmlStr+='<td id="pcode'+keyid+'">'+obj.pcode+'</td>';
 		htmlStr+='<td id="weight'+keyid+'">'+obj.weight+'</td> ';
 		if(codeType==5){
 			htmlStr+='<td id="boxnum'+keyid+'">0</td>';//箱数
 			htmlStr+='<td id="boxitemnum'+keyid+'" >1</td>';//包数	
 		}else{
 			htmlStr+='<td id="boxnum'+keyid+'">'+obj.boxnum+'</td>';//箱数
 			htmlStr+='<td id="boxitemnum'+keyid+'" >'+obj.boxitemnum+'</td>';//包数	
 		}
 		
		htmlStr+='<td id="weightall'+keyid+'">'+weightall+'</td>';
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计				
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));
		$("#listContent").attr("display","block");
	     resetH();
	}
	
	function showData_8(obj,code,keyid,codeType){ 
		//var keyid=obj.batchno+multiply(obj.weight,10000);
		//当行总重量=规格X包数
		var weightall=obj.weight;
		//division(obj.weight,10000);	
		
 		var htmlStr='<tr id="8r_'+keyid+'">';	
 		htmlStr+='<input type="hidden" id="groupInfo'+keyid+'"  value="'+code+','+obj.lasttime+'"/>';
 		htmlStr+='<input type="hidden" id="codetype'+keyid+'"  value="'+codeType+'"/>';	
 		htmlStr+='<input type="hidden" id="code'+keyid+'"  value="'+code+'"/>';
 		
 		//var jsons=JSON.stringify(obj.childList);
 		//jsons=jsons.replace(/\"/g, "");		
 		//alert(jsons);
		//htmlStr+='<input type="hidden" id="boxsCode'+keyid+'"  value="'+jsons+'"/>';	
		
 		htmlStr+='<td height="30" id="name'+keyid+'">小包装</td>';
 		htmlStr+='<td id="pcode'+keyid+'">'+code+'</td>';				
		htmlStr+='<td id="weightall'+keyid+'">'+weightall+'</td>';
		htmlStr+='<td id="" ><a class="btn-look" href="javascript:void(0);" onclick="javascript:showBoxList(\''+code+'\');">详情</a></td>';
		htmlStr+='</tr>';
		$("#listContent2").append(htmlStr).show();
		
		//合计重量-累计				
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));
		$("#listContent2")
		$("#listContent2").attr("display","block");
	     resetH();
	}
	
	function addData(obj,code){
		var keyid=obj.batchno+multiply(obj.weight,10000);
		//每箱包数
		var tabletboxitemnum=$("#tabletboxitemnum"+keyid).val();
		if(obj.boxitemnum>tabletboxitemnum){
			$("#tabletboxitemnum"+keyid).val(obj.boxitemnum)
		}
		
		//追加该字段保存 溯源码、溯源码时间戳、每箱包数附件信息 每个属性以逗号隔开、 每组以分号分隔
		$('#groupInfo'+keyid).val($('#groupInfo'+keyid).val()+';'+code+','+obj.lasttime+','+obj.boxitemnum);
		//当行总重量=规格X包数
		var weightall=multiply(obj.weight,obj.boxitemnum);
		
		//当前重量==规格
		var weight=obj.weight;
		//箱数累计
		$('#boxnum'+keyid).html(addtr($('#boxnum'+keyid).html(),1));
		//包数累计
		$('#boxitemnum'+keyid).html(addtr($('#boxitemnum'+keyid).html(),obj.boxitemnum));
		//累计重量		
		$('#weightall'+keyid).html(addtr($('#weightall'+keyid).html(),weightall));			
		
		//合计重量-累计			
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));
	}
	
	function getOutList(){			
		var datastr="";
		var index=0;
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);			
			var groupInfo=$('#groupInfo'+num).val();		
			var codetype=$('#codetype'+num).val();
			var code=$('#code'+num).val();	
			var boxsCode=$('#boxsCode'+num).val();	
			var prodname=$("#name"+num).text();
			var batchcpc=$("#batchno"+num).text();
			var prodcode=$("#pcode"+num).text();	
			//每箱包数
			var tabletboxitemnum=$("#tabletboxitemnum"+num).val();		
			
			var boxnumweight=jQuery.trim($("#weight"+num).text());//规格
			if(boxnumweight != null && boxnumweight != ""){
				boxnumweight = multiply(boxnumweight,10);
			}
			var boxnum=$("#boxnum"+num).text();//箱数
			var boxitemnum=$("#boxitemnum"+num).text();//总包数
			
			var totalweight=jQuery.trim($("#weightall"+num).text());//总重量
			if(totalweight != null && totalweight != ""){
				totalweight = multiply(totalweight,10);
			}
			
			
			//var str=name+"~"+cpc+"~"+packnum+"~"+weight+"~"+weightall+"~"+weightreal+"~"+unitprice+"~"+totalprice+"~"+num+"|";
			datastr+='<input type="hidden" name="inOutStorList['+index+'].boxsCode" id="codeList['+index+'].boxsCode" value="'+boxsCode+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].code" id="codeList['+index+'].code" value="'+code+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].codetype" id="codeList['+index+'].codetype" value="'+codetype+'"/>';	
			datastr+='<input type="hidden" name="inOutStorList['+index+'].groupInfo" id="codeList['+index+'].groupInfo" value="'+groupInfo+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].prodname" id="codeList['+index+'].prodname" value="'+prodname+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].batchcpc" id="codeList['+index+'].batchcpc" value="'+batchcpc+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].prodcode" id="codeList['+index+'].prodcode" value="'+prodcode+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].boxnumweight" id="codeList['+index+'].boxnumweight" value="'+boxnumweight+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].boxnum" id="codeList['+index+'].boxnum" value="'+boxnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].boxitemnum" id="codeList['+index+'].boxitemnum" value="'+boxitemnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].totalweight" id="codeList['+index+'].totalweight" value="'+totalweight+'"/>';	
			datastr+='<input type="hidden" name="inOutStorList['+index+'].tabletboxitemnum" id="codeList['+index+'].tabletboxitemnum" value="'+tabletboxitemnum+'"/>';	
			index++;
		});	
		//循环8级码
		$("tr[id^='8r_']").each(function (j) {
			var num = $(this).attr("id").substr(3);			
			var groupInfo=$('#groupInfo'+num).val();		
			var codetype=$('#codetype'+num).val();
			var code=$('#code'+num).val();	
			
			var totalweight=jQuery.trim($("#weightall"+num).text());//总重量
			if(totalweight != null && totalweight != ""){
				totalweight = multiply(totalweight,10);
			}
			
			datastr+='<input type="hidden" name="inOutStorList['+index+'].code" id="codeList['+index+'].code" value="'+code+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+index+'].codetype" id="codeList['+index+'].codetype" value="'+codetype+'"/>';	
			datastr+='<input type="hidden" name="inOutStorList['+index+'].groupInfo" id="codeList['+index+'].groupInfo" value="'+groupInfo+'"/>';			
			datastr+='<input type="hidden" name="inOutStorList['+index+'].totalweight" id="codeList['+index+'].totalweight" value="'+totalweight+'"/>';	
			index++;
		});	
		
		return datastr;
	}
		
	function checkForm(){
		var datastr=getOutList();
		
		if(datastr==""){
			$.dialog.alert('<div style="line-height:22px; width:160px; padding-left:20px;">请提交溯源码查询</div>');
			return false;
		}
		
		
		$.dialog.confirm('确认要提交吗？', function(){
			var totalweight=$("#totalweight").text();			
			var totalweight=multiply(totalweight,10);
			$("#totalweightval").val(totalweight);
			$('#dataDiv').html(datastr);//=========封装数据写入到action==========	
			$("#searchform").attr("action", "tabletSellInOut!addInCode.shtml");
   			$("#searchform").submit();	
   			$("#subBut").attr("disabled","disabled");
		}, function(){
   			//$.dialog.tips('执行取消操作');
		});
		
	}
	
	//只能输入数字
	function onkeyupNum(obj){
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined')
			obj.value='';	
	}
	
	function showBoxList(packcode){
		t1 = $.dialog({
			title:'子码列表',
			id:'medChos',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="<%=basePath%>tabletStorage!showInBoxList.shtml?packcode='+packcode+'&ischoice='+Math.random()+'"></iframe>',
			max:false,
			min:false
		});	
	}
</script>
	
</body>
</html>

