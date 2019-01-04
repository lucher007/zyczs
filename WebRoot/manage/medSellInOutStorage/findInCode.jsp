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
<title>药材入库</title>
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
	
	
	
	<div class="cur-pos">当前位置：库存管理 > 药材入库</div>
	<div class="form-box">
    	
    	<div class="fb-tit">待入库药材 <b class="red f12">提示：输入溯源码后敲回车即可提交后台查询</b></div>
        <div class="fb-con">
        	<table width="736" border="0" cellpadding="0" cellspacing="0" class="com-sel">
              <tr>
              	<td align="right">溯源码：</td>
                <td>
                <input type="text" value="请手动输入或者使用扫码枪输入溯源码" id="boxcodes" maxlength="40" class="inp w250" style=" padding:7px;"  name="boxcodes" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);onKeyInput2(event)">
                <input type="button" value="查询" class="sbt" onclick="return onSubmit();">
                </td>
                
                
              </tr>
            </table>
            
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent">
              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>批次号</td>
	                <td>商品编码</td>
	                <td>包装规格(Kg/包)</td>
	                <td>包数</td>
	                <td>重量(Kg)</td>               
	          </tr>
            </table>
            
            <table width="734" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"></td>
                <td width="300"><cite><span>合计重量：<b style="color:red;" id="totalweight">0</b>(Kg)</span></cite></td>
                <td height="30" width="10"></td>
              </tr>
            </table>
        </div>
        <div class="fb-bom">
        	<cite class="gray"><input type="button" value="提交入库" class="sbt" onclick="checkForm();"></cite>
<%--            <input type="button" value="取 消" class="sbt">--%>
        </div>
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
				return;
			}
			
			if(codeArray.length>200){
				$.dialog.tips('入库溯源码不能超过200条',2,'alert.gif');
				return;
			}
			if(Arraycontains($("#boxcodes").val(),0)==true){						
				$.dialog.tips('该溯源码已存在',2,'alert.gif');
			}else{				
				getCode2($("#boxcodes").val());
			}			
	}
	
	function getCode2(boxcodes){
	//var tip =$.dialog.tips('数据查询中...',600,'loading.gif'); 
	
	var url="<%=request.getContextPath()%>/medSellInOut!findInCode.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("")
			$.getJSON(url,function(msg){
				if(msg.returnCode==1){
					$.dialog.tips(msg.returnInfo,1,'alert.gif');
				}else{
					var keyid=msg.stoVO.batchno+multiply(msg.stoVO.weight,10000);	
					var keyObj=document.getElementById("tr_"+keyid);
					if(keyObj!=null){	
						addData(msg.stoVO,msg.code);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}else{
						showData(msg.stoVO,msg.code);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}
					/*			
					if(Arraycontains(keyid,1)){
						addData(msg.stoVO,msg.code);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}else{
						showData(msg.stoVO,msg.code);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}	
					*/
					//tip.close();			
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
		var keyid=obj.batchno+multiply(obj.weight,10000);
		//规格
 		var htmlStr='<tr id="tr_'+keyid+'"><input type="hidden" id="groupInfo'+keyid+'"  value="'+code+','+obj.lasttime+'"/><input type="hidden" id="areacode'+keyid+'"  value="'+obj.areacode+'"/>';
 		htmlStr+='<td height="30" id="name'+keyid+'">'+obj.pname+'</td>';
 		htmlStr+='<td id="batchno'+keyid+'">'+obj.batchno+'</td>';
 		htmlStr+='<td id="pcode'+keyid+'">'+obj.pcode+'</td>';
 		htmlStr+='<td id="weight'+keyid+'">'+obj.weight+'</td> ';
 		htmlStr+='<td id="boxnum'+keyid+'">1</td>';
		htmlStr+='<td id="weightall'+keyid+'">'+obj.weight+'</td>';
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计				
		$("#totalweight").html(addtr($("#totalweight").html(),obj.weight));

	     resetH();
	}
	
	function addData(obj,code){
		var keyid=obj.batchno+multiply(obj.weight,10000);
		
		//追加该字段保存 溯源码、库存ID、等附件信息 每个属性以逗号隔开、 每组以分号分隔
		$('#groupInfo'+keyid).val($('#groupInfo'+keyid).val()+';'+code+','+obj.lasttime);
		
		//当前重量==规格
		var weight=obj.weight;
		//包数累计
		$('#boxnum'+keyid).html(addtr($('#boxnum'+keyid).html(),1));
		//累计重量	
		var weightall=$('#weightall'+keyid).html();		
		$('#weightall'+keyid).html(addtr(weightall,weight));			

		//合计重量-累计			
		$("#totalweight").html(addtr($("#totalweight").html(),weight));
	}
	
	function getOutList(){			
		var datastr="";
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);
			
			var groupInfo=$('#groupInfo'+num).val();		
				
			var prodname=$("#name"+num).text();
			var batchcpc=$("#batchno"+num).text();
			var prodcode=$("#pcode"+num).text();			
			
			var boxnumweight=jQuery.trim($("#weight"+num).text());
			if(boxnumweight != null && boxnumweight != ""){
				boxnumweight = multiply(boxnumweight,10000);
			}
			var boxitemnum=$("#boxnum"+num).text();
			
			var totalweight=jQuery.trim($("#weightall"+num).text());
			if(totalweight != null && totalweight != ""){
				totalweight = multiply(totalweight,10000);
			}
			
			var areacode=$('#areacode'+num).val();	//区域编码
			//var str=name+"~"+cpc+"~"+packnum+"~"+weight+"~"+weightall+"~"+weightreal+"~"+unitprice+"~"+totalprice+"~"+num+"|";
			datastr+='<input type="hidden" name="inOutStorList['+i+'].groupInfo" id="codeList['+i+'].groupInfo" value="'+groupInfo+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].prodname" id="codeList['+i+'].prodname" value="'+prodname+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].batchcpc" id="codeList['+i+'].batchcpc" value="'+batchcpc+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].prodcode" id="codeList['+i+'].prodcode" value="'+prodcode+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxnumweight" id="codeList['+i+'].boxnumweight" value="'+boxnumweight+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxitemnum" id="codeList['+i+'].boxitemnum" value="'+boxitemnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].totalweight" id="codeList['+i+'].totalweight" value="'+totalweight+'"/>';	
			datastr+='<input type="hidden" name="inOutStorList['+i+'].areacode" id="codeList['+i+'].areacode" value="'+areacode+'"/>';		
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
		
		
		$.dialog.confirm('确认要提交吗？', function(){
			var totalweight=$("#totalweight").text();			
			var totalweight=multiply(totalweight,10000);
			$("#totalweightval").val(totalweight);
			$('#dataDiv').html(datastr);//=========封装数据写入到action==========	
			$("#searchform").attr("action", "medSellInOut!addInCode.shtml");
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
</script>
	
</body>
</html>

