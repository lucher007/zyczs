<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
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
</head>

<body>
<div id="body">
	<form action="" name="searchform" id="searchform" method="post">
	<s:token></s:token>
	<input type="hidden" name="datastr" id="datastr" />
	<input type="hidden" name="totalweightval" id="totalweightval" />
	<input type="hidden" name="totalmoneyval" id="totalmoneyval" />
	
	<input type="hidden" name="buycorpname" id="buycorpname" />
	<input type="hidden" name="codestr" id="codestr" value="${requestScope.codestr }" />
	<input type="hidden" name="uncodestr" id="uncodestr" value="${requestScope.uncodestr }" />
	<div id="content1" style="display:block;">
		<div class="cur-pos">当前位置：库存管理 > 饮片出库</div>
		<div class="form-box">
	    	<c:if test="${fn:length(sessionScope.tabletSellOutStoragemap)>0}">
	    	<div class="fb-tit">待销售饮片成功列表</div>
	        <div class="fb-con">
	        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10" id="content">
	              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>批次号</td>
	                <td>规格(g/包)</td>
	                <td>包数</td>
	                <td>箱数</td>
	                <td>包装重量(Kg)</td>
	                <td>单价(元/Kg)</td>
	                <td>总价(元)</td>
	              </tr>
	              <c:set var="totalweightall" value="0" scope="request" />
	              <c:forEach items="${sessionScope.tabletSellOutStoragemap}" var="outstoragemap" varStatus="vs">
	              	<tr id="tr_${vs.index }">
	              	<c:set var="boxsweightall" value="0" scope="request" />
	              	<c:set var="boxitemnumall" value="0" scope="request" />
	              	
	              	
	              	<c:forEach items="${outstoragemap.value}" var="list">
		              <c:set var="tabletname" value="${list.tabletname }" />
		              <c:set var="cpctablet" value="${list.cpctablet }" />
		              <c:set var="tabletnumweight" value="${list.tabletnumweight }" scope="request" /> <!--饮片规格,每包重量 -->
		              	<%
	              		Object tabletnumweight=request.getAttribute("tabletnumweight");
	              		 %> 
		              <c:set var="boxitemnum" value="${list.boxitemnum}" />   <!-- 每箱实际包数 -->
		              
					<%--包数--%>
		              <c:if test="${fn:length(outstoragemap.value)==1}"><!-- 只有箱数的情况，只加一次 -->
		              	<c:set var="boxitemnumall" value="${boxitemnum}" scope="request" />
		              </c:if> 	
		              	              
		              <c:if test="${fn:length(outstoragemap.value)>1}"><!-- 箱数，就是累加 -->
		              	<c:set var="boxitemnumall" value="${boxitemnumall+boxitemnum}" scope="request" /> <!-- 包数，每箱包数累加 -->
		              </c:if> 	
		              	<%
	              		Object boxitemnumall=request.getAttribute("boxitemnumall");
	              		 %>
	              		 
		              <%--重量========规格乘以包数========--%>		             
		              	<c:set var="boxsweightall" value="<%=Tools.multiply(tabletnumweight.toString(),boxitemnumall.toString()) %>" scope="request" />
		              		              
	              	</c:forEach>	
	              		<c:set var="weightall" value="${boxsweightall}" scope="request" />
	              		 <%
	              		Object weightall=request.getAttribute("weightall");
	              		
	              		Object totalweightall=request.getAttribute("totalweightall");
	              		 %>   
	              		<c:set var="totalweightall" value="<%=Tools.addtr(totalweightall.toString(),weightall.toString()) %>" scope="request" />  
	              		           		  		
	              		 
	              		<td height="30" id="name${vs.index }">${tabletname }<input type="hidden" name="keyid${vs.index }" id="keyid${vs.index }" value="${outstoragemap.key}" /></td>
		                <td id="cpc${vs.index }">${cpctablet }</td>
		                <td id="weight${vs.index }">${tabletnumweight/10 }</td>	<!-- 规格 -->	                		                               
		                <td id="boxitemnum${vs.index }">${boxitemnumall}</td> <!-- 包数 -->
		                <td id="boxnum${vs.index }">${fn:length(outstoragemap.value)}</td><!-- 箱数 -->
		                <td id="weightall${vs.index }" ><%=Tools.scienceToString(Tools.division(weightall.toString(),"10000"))%></td>
		                <td><input maxlength="6" type="text" class="inp" style="width:50px;" name="unitprice${vs.index }" id="unitprice${vs.index }" onkeypress="onkeypressCheck1(this);checkprice();" onkeyup="onkeyupCheck1(this);checkprice();" onblur="onkeyblurCheck1(this);checkprice();"/></td>
		                <td name="totalprice${vs.index }" id="totalprice${vs.index }"></td>
	              	</tr>
	              </c:forEach>
	              
	              
	            </table>
	            <%
	              	Object totalweightall=request.getAttribute("totalweightall");             	
	             %>
	            <table width="734" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="30"></td>
	                <td width="300"><span>合计重量(Kg)：<b style="color:red;" id="totalweight"><%=Tools.scienceToString(Tools.division(totalweightall.toString(),"10000"))%></b></span><cite>总计(元)：<b class="red" id="totalmoney">0</b></cite></td>
	                <td height="30" width="10"></td>
	              </tr>
	            </table>     
	        </div>
	        </c:if>
	        
	        <c:if test="${fn:length(requestScope.failList)>0}">	
	        <div class="fb-tit tpline">待销售饮片失败列表</div>
	        <div class="fb-con">
	        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10" id="content">
	              <tr class="fbc-tit">
	                <td width="50%" class="line-r">溯源码</td>
	                <td>失败原因</td>
	              </tr>
	              
	              <c:forEach items="${requestScope.failList}" var="failList">              
	              <tr class="fb-list">
	                <td height="30" class="line-r">${failList.code}</td>
	                <td class="red">
<%--	                	<c:if test="${failList.reason=='0'}">溯源码不存在</c:if>--%>
							${failList.reasonMap}
	                </td>
	              </tr>
              	  </c:forEach>
	            </table>
	            <table width="734" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="30"> 
	               <b style="color:red;"> 提示：查询失败的溯源码将不会出库。</b>
	                </td>                
	              </tr>
	            </table>
	        </div>
	        </c:if>
	                
	        <div class="fb-bom">
	        	<c:if test="${fn:length(sessionScope.tabletSellOutStoragemap)>0}">
	        	<cite class="gray"><input type="button" value="下一步" class="sbt" onclick="displayforward(2);"></cite>
	            </c:if>
	            
	            <input type="button" value="取 消" class="sbt" onclick="goBack();">
	        </div>
	       
	    </div>
    </div>
    
    <div id="content2" style="display:none;">
    	<div class="cur-pos">当前位置：库存销售 > 药材出库</div>
		<div class="form-box">
	    	<div class="fb-tit">选择销售去向</div>
	        <div class="fb-con">
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td align="right" height="30">企业类型：</td>
	                <td colspan="3"><select onchange="chooseUser(this);" name="zstype" id="zstype"><option value="0">溯源企业</option><option value="1">非溯源企业</option></select></td>
	              </tr>
	              
	              
	              <!-- 溯源企业时显示-->
	              <tbody id="tbody1" style="display:block;">
<%--	              <tr>--%>
<%--	                <td align="right" height="30">最近联系客户（选填）：</td>--%>
<%--	                <td colspan="3"><select><option>选择后自动补填</option><option>新荷花制药厂</option></select></td>--%>
<%--	              </tr>--%>
	              <tr>
	                <td align="right" height="30">采购企业名称（必填）：</td>
	                <td colspan="3">
	                <input type="text" id="buycorpname0" name="buycorpname0" class="inp w320 fl"   maxlength="20" >
					<a href="javascript:void(0);" onclick="selCompany(0);" id="xzyp" class="btn-xzs fl">选择采购企业</a>
					<a href="javascript:void(0);" onclick="selCompany(2);" id="xzyp2" class="btn-xzs fl">选择历史采购企业</a> 
	                <span class="red">&nbsp;*</span>    
	                </td>
	              </tr>
	              <tr>
	                <td align="right" height="30">采购企业CPC码（必填）：</td>
	                <td colspan="3">
	                <input type="text" class="inp w120" name="cpccorp" id="cpccorp" maxlength="14" onkeyup="onkeyupCheck(this);" onkeypress="onkeyupCheck(this);"  onblur="onkeyupCheck(this);">
	                <span class="red">&nbsp;*</span>    
	                </td>
	              </tr>
	              <tr>
	                <td height="30">&nbsp;</td>
	                <td colspan="3" class="red">注：14位数字编号、若填写，请确保填写正确。若填写错误，将导致采购企业无法入库。</td>
	              </tr>
	              </tbody>
	              <!-- 溯源企业时显示-->
	              
	              
	              <!-- 非溯源企业时显示-->
	              <tbody id="tbody2" style="display:none;">
	              <tr>
	                <td width="148" align="right" height="30">采购企业名称：</td>
	                <td width="380">
	                	<input type="text" id="buycorpname1" name="buycorpname1" class="inp w250 fl"   maxlength="20" onblur="onBlurCheck(this.name);" >
						<a href="javascript:void(0);" onclick="selCompany(1);" id="xzyp3" class="btn-xzs fl">选择历史采购企业</a><span class="red">*</span>	  
	                </td>
	                <td colspan="2">
						<label name="buycorpname1Lab" id="buycorpname1Lab" class="noico">
							采购企业名称没有输入
						</label>
					</td>
	              </tr>
	              <tr>
	                <td align="right" height="30">联系电话：</td>
	                <td ><input type="text" class="inp w250" name="mobile" id="mobile" maxlength="20" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"></td>
	                <td colspan="2">
						<label name="mobileLab" id="mobileLab" class="noico">
							
						</label>
					</td>
	              </tr>
	              <tr>
	                <td align="right" height="30">经营地址：</td>
	                <td colspan="3"><input type="text" class="inp w250" name="address" id="address" maxlength="20"></td>
	              </tr>
	              </tbody>
	              <!-- 非溯源企业时显示-->
	              
	              <tr align="right" height="30">
		                <td>出库操作人：</td>
		                <td align="left" colspan="3"><input type="text" class="inp" name="operator" id="operator" maxlength="11"></td>
<%--						<td align="right">出库时间：</td>--%>
<%--	                	<td align="left"><input type="text" class="Wdate inp" name="opertime" id="opertime" onFocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"> <span class="red">*</span></td>--%>
		          </tr>
	            </table>
	    	</div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="确认出库" id="subBut" class="sbt" onclick="checkForm();"></cite>
	            <input type="button" value="返回上一步" id="backBut" class="sbt" onclick="displayback(1);">
	        </div>
	    </div>
    </div>
    </form>
</div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
<%--    <script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>--%>
    <script type="text/javascript">
    	window.onerror=function(){
    	  return true;
    	}
    	
		inp(".outarea","请使用扫描抢进行扫码或者请输入出库饮片溯源码箱码");
		function goBack(){
			window.location="<%=basePath %>/manage/tabletSellInOutStorage/findOutStorage.jsp";
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
				selectcorp('searchform.cpccorp','searchform.buycorpname0');
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

		function checkprice(){
			var totalmoney =0;	//价格总计
			$("tr[id^='tr_']").each(function (i) {
				var num = $(this).attr("id").substr(3);
	
				var weightall=multiply($("#weightall"+num).text(),10000);//重量
				var unitprice = multiply($("#unitprice"+num).val(),10000);//单价
				if(unitprice!=null&&unitprice!=""&&weightall!=null&&weightall!=""){
					var weightalltemp  = division(multiply(weightall,unitprice),100000000);
					$("#totalprice"+num).html(weightalltemp);	//单行总价
					totalmoney=addtr(totalmoney,weightalltemp);	//价格总计
				}
			});
			$("#totalmoney").html(totalmoney);
		}

		function displayforward(num){
			if(num==2){
				var datastr="";
				$("tr[id^='tr_']").each(function (i) {
					var num = $(this).attr("id").substr(3);

					var key =$("#keyid"+num).val();
					var name=$("#name"+num).text();
					var cpc=$("#cpc"+num).text();

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
					datastr+=name+"~"+cpc+"~"+weight+"~"+boxitemnum+"~"+boxnum+"~"+weightall+"~"+unitprice+"~"+totalprice+"~"+key+"|";
				});
				
				
				if(datastr.length<0){
					return false;
				}
				//出库明细字符串
				$("#datastr").val(datastr);
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
				
				
				$("#content1").css("display","none");
				$("#content2").css("display","block");
				resetH();
			}
		}
		
		
		function displayback(num){
			if(num==1){
				$("#content1").css("display","block");			
				$("#content2").css("display","none");
				resetH();
			}
		}

		function chooseUser(obj){
				if(obj.value==0){
					$("#tbody1").css("display","block");			
					$("#tbody2").css("display","none");
				}else{
					$("#tbody2").css("display","block");			
					$("#tbody1").css("display","none");
				}
		}

		function checkForm(){
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
   
				$("#buycorpname").val($("#buycorpname1").val());
			}else{		
				if ($("#buycorpname0").val()==null||$("#buycorpname0").val()==""){
					errorInfo+="采购企业名称没有填写!<br>";
				}
				if(isStrIpuabc("buycorpname0")){	
					errorInfo+="采购企业名称存在非法字符！<br>";
				}
				if($("#cpccorp").val()==null||$("#cpccorp").val()==""){
					errorInfo+="采购企业CPC码没有填写!<br>";
				}
				
				$("#buycorpname").val($("#buycorpname0").val());
			}
			
			if(isStrIpuabc("operator")){	
				errorInfo+="出库操作人存在非法字符！<br>";
			}
			
			/*if ($("#opertime").val()==null||$("#opertime").val()==""){
				errorInfo+="出库时间没有填写!\r\n";
				return;
			}*/
			
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
							$("#searchform").attr("action", "tabletSellInOut!addOutStorage.shtml");
							$("#searchform").submit();	
							$("#subBut").attr("disabled","disabled");
							$("#backBut").attr("disabled","disabled");
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
					$("#searchform").attr("action", "tabletSellInOut!addOutStorage.shtml");
					$("#searchform").submit();	
					$("#subBut").attr("disabled","disabled");
					$("#backBut").attr("disabled","disabled");
				}, function(){
				});
			}
			
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
		resetH();
	</script>
	
	<script language="javascript" type="text/javascript" src="/js/window.js"></script>
	<script type="text/javascript">
	document.domain="${initParam.outstorage_domain}";
	var Window = new Window;
	function OpenWin(url)
	{
		Window.Method="open";
		Window.Href=url;
		Window.Width="800";
		Window.Height="600";
		Window.ToolBar="no";
		Window.MenuBar="no";
		Window.ScrollBar="yes";
		Window.UrlBar="no";
		Window.Status="no";
		Window.Resize="yes";
		Window.Place="center";
		Window.Init();
		Window.Open();
	}
	
	function selectcorp(corpcpccode,corpname){
		var zyczstype="${sessionScope.User.org.zyctype}";
		var type="";
		if(zyczstype.substring(0,1)=='1'){
			type="01100000";
		}else if(zyczstype.substring(1,2)=='1'){
			type="01100000";
		}else if(zyczstype.substring(2,3)=='1'){
			type="00010100";
		}else if(zyczstype.substring(3,4)=='1'){
			type="00010100";
		}else if(zyczstype.substring(4,5)=='1'){
			type="01100000";
		}
		
		OpenWin("${initParam.outstorage_url}userName=${initParam.operatename}&password=${initParam.operatepwd}&typezyc="+type);
	}
	function getvalue(value1,value2){
		document.getElementById('cpccorp').value=value1;
		document.getElementById('buycorpname0').value=value2;
	}

	</script>
</body>
</html>
