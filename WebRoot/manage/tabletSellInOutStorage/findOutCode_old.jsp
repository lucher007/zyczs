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
<title>饮片出库</title>
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
	<input type="hidden" name="totalmoneyval" id="totalmoneyval" />
	<input type="hidden" name="buycorpname" id="buycorpname" />
	<input type="hidden" name="zstype" id="zstype" value="0"/>
	<div id="dataDiv"></div>
	<div class="cur-pos">当前位置：库存管理 > 饮片出库</div>
	<div class="form-box">
    	<div class="fb-tit">待出库饮片 <b class="red f12">提示：输入溯源码后敲回车即可提交后台查询</b></div>
        <div class="fb-con">
        	<table width="736" border="0" cellpadding="0" cellspacing="0" class="com-sel">
              <tr>
              	<td align="right">溯源码：</td>
                <td><input type="text" value="请手动输入或者使用扫码枪输入溯源码" id="boxcodes" maxlength="40" class="inp w250" style=" padding:7px;"  name="boxcodes" onkeyup="onkeyupNum(this);" onkeypress="onkeyupNum(this);onKeyInput2(event)">
                <input type="button" value="查询" class="sbt" onclick="onSubmit();">
                </td>
                <td width="70" align="right">采购企业：</td>
                <td width="216"><a href="javascript:chooseComp(1);">非溯源企业</a><a href="javascript:chooseComp(0);" class="current">溯源企业</a></td>
              </tr>
            </table>
            <div class="com-list">
            	<%-- 非溯源企业--%>
            	<table width="100%" class="hide" border="0">
                    <tr>
                      <td width="148" align="right" height="30">采购企业名称（必填）：</td>
                      <td width="400">	                    
                          <input type="text" id="buycorpname1" name="buycorpname1" class="inp w250 fl"   maxlength="20" onblur="onBlurCheck(this.name);" >
                          <a href="javascript:void(0);" onclick="selCompany(1);" id="xzyp3" class="btn-xzs fl">选择历史采购企业</a><span class="red">&nbsp;*</span>	  
                      </td>
                      <td colspan="2">
                          <label name="buycorpname1Lab" id="buycorpname1Lab" class="noico">
                              必填项
                          </label>
                     </td>
                    </tr>
                    <tr>
                      <td align="right" height="30">联系电话：</td>
                      <td>
                          <input type="text" class="inp w250" name="mobile" id="mobile" maxlength="20" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);">
                      </td>
                      <td colspan="2">
                          <label name="mobileLab" id="mobileLab" class="noico">
                          </label>
                      </td>
                    </tr>
                    <tr>
                      <td align="right" height="30">经营地址：</td>
                      <td colspan="3"><input type="text" class="inp w250" name="address" id="address" maxlength="20"></td>
                    </tr>
                </table>
				<%-- 溯源企业--%>
                <table width="100%" class="show" border="0">
                  <tr>
                    <td width="148" align="right" height="30">采购企业名称（必填）：</td>
                     <td colspan="3">	                
                    <input type="text" id="buycorpname0" name="buycorpname0" class="inp w250 fl" maxlength="20" onblur="onBlurCheck(this.name);" >
                    <a href="javascript:void(0);" onclick="selCompany(0);" id="xzyp" class="btn-xzs fl">选择采购企业</a> 
                    <a href="javascript:void(0);" onclick="selCompany(2);" id="xzyp2" class="btn-xzs fl">选择历史采购企业</a> 
                    <span class="red">&nbsp;*</span>              
                    </td>
                    
                  </tr>
                  <tr>
                    <td align="right" height="30">采购企业CPC码（必填）：</td>
                    <td colspan="3">
                    <input type="text" class="inp w120" name="cpccorp" id="cpccorp" maxlength="14" onkeyup="onkeyupCheck(this);" onkeypress="onkeyupCheck(this);"  onblur="onkeyupCheck(this);">
                    <span class="red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <td height="30">&nbsp;</td>
                    <td colspan="3" class="red">注：企业CPC码14位数字编号、若填写，请确保填写正确。若填写错误，将导致采购企业无法入库。</td>
                  </tr>
                </table>
                <table>
                  <tr align="right" height="30">
		        	<td width="148" align="right">出库操作人：</td>
		            <td align="left" colspan="3"><input type="text" class="inp" name="operator" id="operator" maxlength="11" value="${sessionScope.User.username}"></td>
		          </tr>
                </table>
            </div>
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt5" id="listContent">
              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>批次号</td>
	                <td>小包装规格(g/包)</td>
	                <td>小包数</td>
	                <td>中包数</td>
	                <td>包装重量(Kg)</td>
	                <td>单价(元/Kg)</td>
	                <td>总价(元)</td>
	                <td>操作</td>
	              </tr>
            </table>
            
            <table width="734" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"></td>
                <td width="300"><span>合计重量(Kg)：<b style="color:red;" id="totalweight">0</b></span><cite>总计(元)：<b class="red" id="totalmoney">0</b></cite></td>
                <td height="30" width="10"></td>
              </tr>
            </table>
        </div>
        <div class="fb-bom">
        	<cite class="gray"><input type="button" value="提交" class="sbt" onclick="checkForm();"></cite>
<%--            <input type="button" value="取 消" class="sbt">--%>
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
			return;
		}else{				
			getCode2($("#boxcodes").val());
		}			
		
	}
	
	function getCode2(boxcodes){
		//var tip =$.dialog.tips('数据查询中...',600,'loading.gif'); 
		var url="<%=request.getContextPath()%>/tabletSellInOut!findOutCode.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("");
		$.getJSON(url,function(msg){
			if(msg.returnCode==1){
				$.dialog.tips(msg.returnInfo,1,'alert.gif');
				$("#boxcodes").val("");
			}else{
			
				//判断是否装袋
				var packcode=msg.stoVO.packcode;					
				if(packcode.length==35){
					$.dialog.tips('该箱饮片已经装袋、不能单独出库',2,'alert.gif');
					$("#boxcodes").val("");
					return;
				}
				//袋装
				if(packcode=="7"){
					var keyid=boxcodes;
					showData(msg.stoVO,msg.code,keyid,packcode,msg.stoVO.tabletboxnum);
					codeArray[codeArray.length]=new Array(msg.code,keyid);	
				}else if (packcode=="5"){
					var keyid=boxcodes;
					showData(msg.stoVO,msg.code,keyid,packcode,0);
					codeArray[codeArray.length]=new Array(msg.code,keyid);	
				}else{
					//箱装规格相同的合并
					var keyid=(msg.stoVO.cpctablet+multiply(msg.stoVO.tabletnumweight,10000));			
					var keyObj=document.getElementById("tr_"+keyid);
					if(keyObj!=null){	
						addData(msg.stoVO,msg.code,keyid);
						codeArray[codeArray.length]=new Array(msg.code,keyid);	
					}else{
						showData(msg.stoVO,msg.code,keyid,6,1);
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
	function showData(obj,code,keyid,codetype,boxnum){ 
		//var keyid=obj.cpctablet+multiply(obj.tabletnumweight,10000);
		//当前包装重量
		var weightall=division(multiply(obj.tabletnumweight,obj.boxitemnum),10000);
		
 		var htmlStr='<tr id="tr_'+keyid+'"><input type="hidden" id="groupInfo'+keyid+'"  value="'+code+','+obj.tabletstorid+','+obj.boxitemnum+'"/>';
 		htmlStr+='<input type="hidden" id="codetype'+keyid+'"  value="'+codetype+'"/>';	
 		htmlStr+='<input type="hidden" id="code'+keyid+'"  value="'+code+'"/>';
 		htmlStr+='<input type="hidden" id="inoutstorboxid'+keyid+'"  value="'+obj.tabletstorid+'"/>';	
 		htmlStr+='<td height="30" id="name'+keyid+'">'+obj.tabletname+'</td>';
 		htmlStr+='<td id="cpc'+keyid+'">'+obj.cpctablet+'</td>';
 		htmlStr+='<td id="weight'+keyid+'">'+division(obj.tabletnumweight,10)+'</td>';//规格
 		htmlStr+='<td id="boxitemnum'+keyid+'">'+obj.boxitemnum+'</td>';//包数		
 		htmlStr+='<td id="boxnum'+keyid+'">'+boxnum+'</td>';//箱数
 		htmlStr+='<td id="weightall'+keyid+'" >'+weightall+'</td>';//包装重量
		htmlStr+='<td><input maxlength="6" type="text" class="inp" style="width:50px;" name="unitprice'+keyid+'" id="unitprice'+keyid+'" onkeypress="onkeypressCheck1(this);checkprice();" onkeyup="onkeyupCheck1(this);checkprice();" onblur="onkeyblurCheck1(this);checkprice();"/></td>';
		htmlStr+='<td id="totalprice'+keyid+'"></td>';
		if(codetype=="7"){
			htmlStr+='<td id="" ><a class="btn-look" href="javascript:void(0);" onclick="javascript:showBoxList(\''+code+'\');">详情</a></td>';
		}
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计		
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));

	    resetH();
	}
	
	function addData(obj,code){
		var keyid=obj.cpctablet+multiply(obj.tabletnumweight,10000);
		//当前包装重量
		var weightall=division(multiply(obj.tabletnumweight,obj.boxitemnum),10000);
		//追加溯源码

		//追加该字段保存 溯源码、库存ID、等附件信息 每个属性以逗号隔开、 每组以分号分隔
		$('#groupInfo'+keyid).val($('#groupInfo'+keyid).val()+';'+code+','+obj.tabletstorid+','+obj.boxitemnum);		
		//包数
		$('#boxitemnum'+keyid).html(addtr($('#boxitemnum'+keyid).html(),obj.boxitemnum));
		//箱数
		$('#boxnum'+keyid).html(addtr($('#boxnum'+keyid).html(),1));
		
		//包装累计重量
		var weightall_old=$('#weightall'+keyid).html();
		$('#weightall'+keyid).html(addtr(weightall_old,weightall));
			
		//单价
		var unitprice=$('#unitprice'+keyid).val();
		if(unitprice!=null&&unitprice!=""){
			//当行历史总价
			var totalprice_old=$('#totalprice'+keyid).html();
			//总金额
			var totalmoney=$('#totalmoney').html();
			//当前最新总价
			$('#totalprice'+keyid).html(multiply($('#weightall'+keyid).html(),unitprice).toFixed(2));

			var currmoney=addtr(subtr(totalmoney,totalprice_old),multiply($('#weightall'+keyid).html(),unitprice));
			//重置总金额
			$('#totalmoney').html(currmoney.toFixed(2));
			
		}
		$("#totalweight").html(addtr($("#totalweight").html(),weightall));
	}
	
	function getOutList(){			
		var datastr="";
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);
			
			var groupInfo=$('#groupInfo'+num).val();		
			var name=$("#name"+num).text();
			var cpc=$("#cpc"+num).text();
			
			var code=$('#code'+num).val();	
			var codetype=$('#codetype'+num).val();	
			var inoutstorboxid=$('#inoutstorboxid'+num).val();
			//规格
			var weight=jQuery.trim($("#weight"+num).text());
			if(weight != null && weight != ""){
				weight = multiply(weight,10);
			}
			//包数
			var boxitemnum=jQuery.trim($("#boxitemnum"+num).text());					
			//箱数
			var boxnum=jQuery.trim($("#boxnum"+num).text());
			//包装重量
			var weightall=jQuery.trim($("#weightall"+num).text());
			if(weightall != null && weightall != ""){
				weightall = multiply(weightall,10000);
			}
			//单价
			var unitprice=jQuery.trim($("#unitprice"+num).val());
			if(unitprice != null && unitprice != ""){
				unitprice = multiply(unitprice,10000);
			}
			//总价
			var totalprice=jQuery.trim($("#totalprice"+num).text());
			if(totalprice != null && totalprice != ""){
				totalprice = multiply(totalprice,10000);
			}
			
			//var str=name+"~"+cpc+"~"+packnum+"~"+weight+"~"+weightall+"~"+weightreal+"~"+unitprice+"~"+totalprice+"~"+num+"|";
			datastr+='<input type="hidden" name="inOutStorList['+i+'].groupInfo" id="codeList['+i+'].groupInfo" value="'+groupInfo+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].code" id="codeList['+i+'].code" value="'+code+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].codetype" id="codeList['+i+'].codetype" value="'+codetype+'"/>';	
			datastr+='<input type="hidden" name="inOutStorList['+i+'].inoutstorboxid" id="codeList['+i+'].inoutstorboxid" value="'+inoutstorboxid+'"/>';			
			datastr+='<input type="hidden" name="inOutStorList['+i+'].prodname" id="codeList['+i+'].prodname" value="'+name+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].batchcpc" id="codeList['+i+'].batchcpc" value="'+cpc+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxnumweight" id="codeList['+i+'].boxnumweight" value="'+weight+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxitemnum" id="codeList['+i+'].boxitemnum" value="'+boxitemnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].boxnum" id="codeList['+i+'].boxnum" value="'+boxnum+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].totalweight" id="codeList['+i+'].totalweight" value="'+weightall+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].realtotalweight" id="codeList['+i+'].realtotalweight" value="'+weightall+'"/>';		
			datastr+='<input type="hidden" name="inOutStorList['+i+'].price" id="codeList['+i+'].price" value="'+unitprice+'"/>';
			datastr+='<input type="hidden" name="inOutStorList['+i+'].totalmoney" id="codeList['+i+'].totalmoney" value="'+totalprice+'"/>';		
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
		var totalweightval = jQuery.trim($("#totalweight").html());
		if(totalweightval != null && totalweightval != ""){
			totalweightval = multiply(totalweightval,10000);
		}
		$("#totalweightval").val(totalweightval);
		
		//总计价格
		var totalmoneyval = jQuery.trim($("#totalmoney").html());
		if(totalmoneyval != null && totalmoneyval != ""){
			totalmoneyval = multiply(totalmoneyval,10000);
		}
		$("#totalmoneyval").val(totalmoneyval);
		
		var errorInfo="";
		if($("#zstype").val()==1){
			if ($("#buycorpname1").val()==null||$("#buycorpname1").val()==""){
				errorInfo+="采购企业名称没有输入!<br>";
			}
			if(isStrIpuabc("buycorpname1")){	
				errorInfo+="采购企业名称存在非法字符！<br>";
			}
			if($("#mobile").val() != '' && checkNumber($("#mobile").val())==false){
				errorInfo+="联系电话输入不正确!<br>";
			}
			
			if(isStrIpuabc("address")){	
				errorInfo+="经营地址存在非法字符！<br>";
			}
  			$("#buycorpname").val(jQuery.trim($("#buycorpname1").val()));
		}else{		
			if ($("#buycorpname0").val()==null||$("#buycorpname0").val()==""){
				errorInfo+="采购企业名称没有填写!<br>";
			}
			if($("#cpccorp").val()==null||$("#cpccorp").val()==""){
				errorInfo+="采购企业CPC码没有填写!<br>";
			}		
			$("#buycorpname").val(jQuery.trim($("#buycorpname0").val()));
		}
		
		if(isStrIpuabc("operator")){	
			errorInfo+="出库操作人存在非法字符！<br>";
		}		
		
		if(errorInfo!="")
		{
			$.dialog.alert('<div style="line-height:22px; width:160px; padding-left:20px;">'+errorInfo+'</div>');
			return false;
		}
		
		var cpccorp=$.trim($("#cpccorp").val());
		var corpname =$.trim($("#buycorpname0").val());
		if($("#zstype").val()==0&&cpccorp!="")
		{
			var cm=$.dialog({
				title:'验证企业CPC码',
				id:'pack',
				lock:true,
				content: '<div style="font-size:18px;color:red;padding:20px 50px">正在验证采购企业CPC码,请稍等...等待时间超过2分钟,请关闭重试.</div>',
				min:false,
				max:false,
				cancel:false
			});
			corpname = encodeURI(corpname);
			var url="<%=request.getContextPath()%>/company!findByCpccorp.shtml?cpccorp="+cpccorp+"&corpname="+corpname+"&rid="+Math.random();
			$.getJSON(url,function(msg){
				if(msg.state=="")
				{
					$.dialog.confirm('验证成功、确认要提交吗？', function(){ 
						cm.close();	
						$('#dataDiv').html(datastr);//=========封装数据写入到action==========					
						$("#searchform").attr("action", "tabletSellInOut!addOutCode.shtml");
						$("#searchform").submit();	
						$("#subBut").attr("disabled","disabled");
						//$("#backBut").attr("disabled","disabled");
					}, function(){
						cm.close();		
					});
				}else{	
					cm.close();					
					$.dialog.alert(msg.state);
				}
			});
		}else{
			$.dialog.confirm('确认要提交吗？', function(){ 
				$('#dataDiv').html(datastr);//=========封装数据写入到action==========				
				$("#searchform").attr("action", "tabletSellInOut!addOutCode.shtml");
				$("#searchform").submit();	
				$("#subBut").attr("disabled","disabled");
				//$("#backBut").attr("disabled","disabled");
			}, function(){
			});
		}
		
		
	}
	
	function chooseComp(selValue){
		$('#zstype').val(selValue);
	}
	
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		if(name=="mobile"&&nameval!=""){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("联系电话输入不正确!");
				return false;
	    	}
			checksuccess(name);
		}
	}
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d)?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[1-9]?\d*?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	}

	/////////////////////对必要的输入框进行数字合法验证/////小数一位/////////////////////
	function onkeypressCheck1(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
			obj.o_value = obj.value;
		}
		if(obj.value.match(/^\d+\.\d{2}?$/)){
				obj.value = obj.value.substr(0,obj.value.length-1);
		} 
	}
	
	function onkeyupCheck1(obj){
		if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^00+/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0\.000/)) {
				obj.value = "";
			}
			if (obj.value.match(/^0[1-9]/)) {
				obj.value = "";
			}
			if(obj.value.match(/^\d+\.\d{2}?$/)){
						obj.value = obj.value.substr(0,obj.value.length-1);
			} 
			if(obj.value == 'undefined'){
						obj.value='';
			}
	}
	
	function onkeyblurCheck1(obj){
		if(obj.value=="0")
				obj.value='';
		if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
			obj.value = obj.o_value;
		}else {
			if (obj.value.match(/^\.\d+$/)) {
				obj.value = 0 + obj.value;
			}
			
			obj.o_value = obj.value;
		}
		if(!obj.value.match(/^\d+(\.\d{1})?$/)){
			obj.value = obj.value.substr(0,obj.value.indexOf(".")+2);
		} 
	}
	//只能输入数字
	function onkeyupNum(obj){
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined')
			obj.value='';	
	}
	function checkprice(){
		var totalmoney =0;	//价格总计
		$("tr[id^='tr_']").each(function (i) {
			var num = $(this).attr("id").substr(3);

			var weightall=multiply($("#weightall"+num).text(),10000);//重量
			var unitprice = multiply($("#unitprice"+num).val(),10000);//单价
			if(unitprice!=null&&unitprice!=""&&weightall!=null&&weightall!=""){
				var weightalltemp  = division(multiply(weightall,unitprice),100000000);
				$("#totalprice"+num).html(weightalltemp.toFixed(2));	//单行总价
				totalmoney=addtr(totalmoney,weightalltemp);	//价格总计
			}
		});
		$("#totalmoney").html(totalmoney.toFixed(2));
	}
	
	var orgid='${sessionScope.User.orgid}';		
	//采购企业查询列表
	function selCompany(setype){
		if(setype==1){//非溯源企业查询
			t1 = $.dialog({
				title:'选择历史采购企业',
				id:'comChos',
				lock:true,	
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="550" height="230" src="<%=basePath%>tabletSellInOut!companyOtherChoice.shtml?orgid='+orgid+'&ischoice='+Math.random()+'"></iframe>',
				max:false,
				min:false
			});	
		}else if(setype==2){//溯源企业历史查询
			t1 = $.dialog({
				title:'选择历史采购企业',
				id:'comChos',
				lock:true,	
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="550" height="230" src="<%=basePath%>tabletSellInOut!companyChoice.shtml?type=1&stortype=1&orgid='+orgid+'&ischoice='+Math.random()+'"></iframe>',
				max:false,
				min:false
			});	
		}else{//新的采购企业查询
			t1 = $.dialog({
					title:'选择采购企业',
					id:'comChos',
					lock:true,	
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="550" height="300" src="<%=basePath%>org!chooseOrg.shtml?ischoice='+Math.random()+'"></iframe>',
					max:false,
					min:false
				});	
		}	
	}
	function closeDG(s){
		if($("#zstype").val()==0){
			$("#buycorpname0").val(s[1]);
			$("#cpccorp").val(s[2]);
		}else{
			$("#buycorpname1").val(s[1]);
			$("#mobile").val(s[2]);
			$("#address").val(s[3]);
		}
		t1.close();
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
</script>

</body>
</html>

