<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>药材出库</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
<script type="text/javascript">
function clear(){
	$("#boxcodes").val("");
}
</script>
</head>

<body>
<form action="" id="searchform" name="searchform" method="post">
<div id="body">
	<div class="cur-pos">当前位置：库存出库 > 药材出库</div>
	<div class="form-box">
    	<div class="fb-tit">药材出库 &nbsp;&nbsp;&nbsp; <b style="color:red;font-size:12px;"> 提示：输入溯源码、按回车提交查询</b></div>
        <div class="fb-con">
        	<input type="text" size="50" name="boxcodes" id="boxcodes" onkeypress="onKeyInput2(event)">
        </div>
        
    </div>
    <div class="form-box">
	    	
	    		
	    		<div class="fb-tit">待销售药材成功列表
	    		&nbsp;&nbsp;&nbsp;&nbsp;<b style="color:red;font-size:13px;">注：若因药材水分蒸发等因素导致出库时的实际重量和原包装重量有异，请重新填写</b>
	    		</div>
	        	<div class="fb-con">
		        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10" id="listContent">
		              <tr class="fbc-tit">
		                <td>品名</td>
		                <td>生产批次号</td>
		                <td>包数</td>
		                <td>规格(Kg/包)</td>
		                <td>总重量(Kg)</td>
		                <td>实际重量(Kg)</td>
		                <td>单价(元/Kg)</td>
		                <td>总价(元)</td>
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
		       
  
			</div>
    
    
</div>
</form>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
<script type="text/javascript">
	
	function onKeyInput2(e) {
			if (event.keyCode == 13) {
				if(Arraycontains($("#boxcodes").val(),0)==true){						
						$.dialog.tips('该溯源码已存在',2,'alert.gif');
					}else{				
						getCode2($("#boxcodes").val());
					}				
			}
		}
	
	
	function getCode2(boxcodes){
	var url="<%=request.getContextPath()%>/medSellInOut!findOutCode.shtml?boxcodes="+boxcodes+"&rid="+Math.random();
		$("#boxcodes").val("")
			$.getJSON(url,function(msg){
				if(msg.returnCode==1){
					$.dialog.tips(msg.returnInfo,1,'alert.gif');
				}else{
					var keyid=msg.stoVO.cpcmed+msg.stoVO.boxweight;				
					if(Arraycontains(keyid,1)){
						addData(msg.stoVO);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
					}else{
						showData(msg.stoVO);
						codeArray[codeArray.length]=new Array(msg.code,keyid);
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
	function showData(obj){ 
		var keyid=obj.cpcmed+obj.boxweight;
		//规格
		var boxweight=division(obj.boxweight,10000);
		
 		var htmlStr='<tr id="tr_'+keyid+'">';
 		htmlStr+='<td height="30" id="name${vs.index }">'+obj.medname+'<input type="hidden" name="keyid'+keyid+'" id="keyid'+keyid+'" value="'+keyid+'" /></td>';
 		htmlStr+='<td id="cpc'+keyid+'">'+obj.cpcmed+'</td>';
 		htmlStr+='<td id="packnum'+keyid+'">1</td>';
 		htmlStr+='<td id="weight'+keyid+'">'+boxweight+'</td>';
 		htmlStr+='<td id="weightall'+keyid+'">'+boxweight+'</td>';
 		htmlStr+='<td><input maxlength="6" type="text" class="inp" style="width:50px;" name="weightreal'+keyid+'" id="weightreal'+keyid+'"  onkeypress="onkeypressCheck2(this);checkprice();" onkeyup="onkeyupCheck2(this);checkprice();" onblur="onkeyblurCheck2(this);checkprice();" value="'+boxweight+'" /></td>';
		htmlStr+='<td><input maxlength="6" type="text" class="inp" style="width:50px;" name="unitprice'+keyid+'" id="unitprice'+keyid+'"  onkeypress="onkeypressCheck1(this);checkprice();" onkeyup="onkeyupCheck1(this);checkprice();" onblur="onkeyblurCheck1(this);checkprice();"  /></td>';
		htmlStr+='<td name="totalprice'+keyid+'" id="totalprice'+keyid+'"></td>';
		htmlStr+='</tr>';
		$("#listContent").append(htmlStr).show();
		
		//合计重量-累计		
		
		$("#totalweight").html(addtr($("#totalweight").html(),boxweight));

	     resetH();
	}
	
	function addData(obj){
		var keyid=obj.cpcmed+obj.boxweight;
		//当前重量==规格
		var boxweight=division(obj.boxweight,10000);
		//包数累计
		$('#packnum'+keyid).html(addtr($('#packnum'+keyid).html(),1));
		//上次总重量
		var weightall=$('#weightall'+keyid).html();		
		//总重量
		$('#weightall'+keyid).html(addtr(weightall,boxweight));			
		//实际重量
		$('#weightreal'+keyid).val(addtr(weightall,boxweight));
		
		
		//单价
		var unitprice=$('#unitprice'+keyid).val();
		if(unitprice!=null&&unitprice!=""){
			//当行历史总价
			var totalprice_old=$('#totalprice'+keyid).html();
			//总金额
			var totalmoney=$('#totalmoney').html();
			//当前最新总价
			$('#totalprice'+keyid).html(multiply($('#weightreal'+keyid).val(),unitprice));
			//alert(totalprice+'---'+totalmoney);
			
			//重置总金额
			$('#totalmoney').html(addtr(subtr(totalmoney,totalprice_old),multiply($('#weightreal'+keyid).val(),unitprice)))
			
			
		}
		
		//合计重量-累计			
		$("#totalweight").html(addtr($("#totalweight").html(),boxweight));
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
		/////////////////////对必要的输入框进行数字合法验证////////小数三位//////////////////
		function onkeypressCheck2(obj){
			if (!obj.value.match(/^[1-9]?\d*?\.?\d*?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?)?$/)) {
				obj.o_value = obj.value;
			}
			if(obj.value.match(/^\d+\.\d{4}?$/)){
					obj.value = obj.value.substr(0,obj.value.length-1);
			} 
		}
		
		function onkeyupCheck2(obj){
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
				if(obj.value.match(/^\d+\.\d{4}?$/)){
							obj.value = obj.value.substr(0,obj.value.length-1);
				} 
				if(obj.value == 'undefined'){
							obj.value='';
				}
		}
		
		function onkeyblurCheck2(obj){
			if(obj.value==0){
					obj.value='';
			}
			if (!obj.value.match(/^(?:[1-9]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
				obj.value = obj.o_value;
			}else {
				if (obj.value.match(/^\.\d+$/)) {
					obj.value = 0 + obj.value;
				}
				
				obj.o_value = obj.value;
			}
			if(!obj.value.match(/^\d+(\.\d{3})?$/)){
				obj.value = obj.value.substr(0,obj.value.indexOf(".")+4);
			} 
		}
		//////////////////////////////////////////////////////////////////////
		
		function checkprice(){
			var totalmoney =0;	//价格总计
			var totalweight =0; //重量总计
			$("tr[id^='tr_']").each(function (i) {
				var num = $(this).attr("id").substr(3);
	
				var weightreal=$("#weightreal"+num).val();
				var unitprice = $("#unitprice"+num).val();

				if(weightreal!=null&&weightreal!=""&&!isNaN(weightreal)){				
					weightreal=multiply(weightreal,10000);
					totalweight = addtr(totalweight,weightreal);	//重量总计
				}
			
				if(unitprice!=null&&unitprice!=""&&weightreal!=null&&weightreal!=""){
					var weightrealtemp  = division(multiply(weightreal,unitprice),10000);
					$("#totalprice"+num).html(weightrealtemp);		//单行总价
					
					totalmoney=addtr(totalmoney,weightrealtemp);	//价格总计
				}else{
					$("#totalprice"+num).html("");
				}
				
			});
			totalweight =division(totalweight,10000);
			$("#totalmoney").html(totalmoney);
			$("#totalweight").html(totalweight);
		}
		
		/*
		var divNum;
		function showDiv(code,state)
		{	
				var oDiv = document.createElement("DIV"); 
				oDiv.id = divNum; 
				oDiv.style.visibility = 'visible'; 
				oDiv.innerHTML="<font color='red'>"+code+"&nbsp;&nbsp;&nbsp;&nbsp;</font> &nbsp;&nbsp;&nbsp;"+state;	
				document.getElementById("showAttachPath").appendChild(oDiv); 
				divNum++;		
		}
		*/
</script>
</body>
</html>

