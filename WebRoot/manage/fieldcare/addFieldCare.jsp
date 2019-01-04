<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<title>田间管理信息添加</title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 田间管理信息添加</div>
		<div class="form-box">
			<form action="<%=basePath %>fieldCare!save.shtml" method="post" name="searchform" id="searchform">
			<input type="hidden" name="oper" id="oper" value="${requestScope.oper }">
			<s:token></s:token>
    		<div class="fb-tit">田间管理信息添加</div>
        	<div class="fb-con">
				<input type="hidden" id="cpcplant" name="cpcplant" value="${requestScope.cpcplant }" />
				<input type="hidden" id="plantaddtime" value="${plant.plantaddtime }">
				<input type="hidden" id="fieldcarename" name="fieldcarename" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="4" height="30">种子种苗植物名：${requestScope.plant.plantname }　　种植批次号：${requestScope.plant.cpcplant }　　	种植时间：${plant.plantaddtime}</td>
   					</tr>
					<tr>
						<td height="39" width="120" align="right">操作类型：</td>
						<td width="170">
							<select id="fieldcaretype" name="fieldcaretype" class="w158">	
								<option value="施肥">施肥</option>
								<option value="农药">农药</option>
								<option value="浇水">浇水</option>
								<option value="中耕">中耕</option>
								<option value="除草">除草</option>
								<option value="其它">其它</option>
							</select>
							<span class="red">*</span>
						</td>
						<td width="220">
						</td>
						<td width="196">
						</td>
					</tr>
					
					
					<tr id="tr_fieldcarename">
						<td height="39" width="120" align="right" id="td_fieldcarename">肥料种类：</td>
						<td width="170">
							<select name="fieldcarenameselect"  class="w158"
								id="fieldcarenameselect" onchange="choseOther(this);">
								<option value="尿素">尿素</option>
								<option value="磷酸二氢钾">磷酸二氢钾</option>
								<option value="硫酸钾">硫酸钾</option>
								<option value="过磷酸钙">过磷酸钙</option>
								<option value="复合肥">复合肥</option>
								<option value="农家肥">农家肥</option>
								<option value="其它">其它</option>
							</select>
							<span class="red">*</span>
						</td>
						<td width="220">
							<span id="fieldcarenamespan" class="hide">请输入其它种类：
								<input type="text" class="inp w100" maxlength="10" onblur="checkVal(this.name)" name="fieldcarenameother" id="fieldcarenameother" value="">
								<span class="red">*</span>
							</span>
						</td>
						<td width="196">
							<label name="fieldcarenameotherLab" id="fieldcarenameotherLab" class="noico">请输入肥料种类</label>
						</td>
					</tr>
					
					<tr id="tr_fieldcareweight">
						<td height="39" align="right" id="td_fieldcareweight">
							肥料重量(Kg/亩)：
						</td>
						<td>
							<input type="text"  name="fieldcareweight" maxlength="6" class="inp w150"
								id="fieldcareweight" 
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"
								 />
							<span class="red">*</span>
						</td>
						<td>
							<label name="fieldcareweightLab" id="fieldcareweightLab" class="noico">
								重量只能填写数字
							</label>
						</td>
						<td></td>
					</tr>
					
					<tr>
						<td height="39" align="right">
							操作时间：
						</td>
						<td>
							<input type="text" class="inp w150" name="fieldcaretime" id="fieldcaretime"
								onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'plantaddtime\');}'});"
								style="background: #ffffff url('images/growaddunittime.png') no-repeat right;"
								onblur="onBlurCheck(this.name)"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="fieldcaretimeLab" id="fieldcaretimeLab" class="noico">
								操作时间未选择
							</label>
						</td>
						<td></td>
					</tr>
					
					<tr>
						<td height="39" align="right">
							备注：
						</td>
						<td>
							<input type="text"  name="remark" maxlength="30" id="remark" onblur="checkVal(this.name)" class="inp w150" />
							<span class="" id="span_remark">操作用途说明：如底肥、追肥等</span>
						</td>
						<td>
							<label name="remarkLab" id="remarkLab" class="noico">
								不能包含~@等字符
							</label>
						</td>
						<td></td>
					</tr>
					
				</table>
			</div>
			<div class="fb-bom">
				<cite><input type="button" value="下一步" class="sbt" onclick="checkFieldCare()"></cite>
			</div>
			</form>
  		</div>
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td width="30%" height="25" bgcolor="#EEEEEE" align="right">
							操作类型：
						</td>
						<td width="70%">
							<label id="l_fieldcaretype" />
						</td>
					</tr>
					<tr id="tr_l_fieldcarenameselect">
						<td width="30%" height="25" bgcolor="#EEEEEE" align="right" id="td_l_fieldcarenameselect">
							肥料种类：
						</td>
						<td width="70%">
							<label id="l_fieldcarenameselect" />
						</td>
					</tr>
					<tr></tr>
					<tr id="tr_l_fieldcareweight">
						<td height="25" bgcolor="#EEEEEE" align="right" id="td_l_fieldcareweight">
							肥料重量(Kg/亩)：
						</td>
						<td>
							<label id="l_fieldcareweight" />
						</td>
					</tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right" id="">
							操作时间：
						</td>
						<td>
							<label id="l_fieldcaretime" />
						</td>
					</tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right">
							备注：
						</td>
						<td>
							<label id="l_remark" />
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2" height="60" class="red">
							确定后信息将无法更改，请仔细核对任务信息
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
		$("#fertilizerweight").focus();
		cMenu(0,0);
		function choseOther(obj){
	        if(obj.value=="其它"){
	            $("#fieldcarenamespan").show();
	            $("#fieldcarenameother").val("");
	            $("#fieldcarenameother").focus();
	        }else{
	        	$("#fieldcarenameotherImg").hide();
	        	$("#fieldcarenamespan").hide();
	        	$("#fieldcarenameother").val($("#fieldcarenameselect").val());
	        	$("#fieldcarenameotherLab").attr("class","noico");
	        }
	    }
	    
	
	/////////////////////对必要的输入框进行数字合法验证 只能输入>1的正数//////////////////////////
		function onkeypressCheck(obj){
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
		
		function onkeyupCheck(obj){
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
				if (obj.value.match(/^0\.00/)) {
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
		
		function onkeyblurCheck(obj){
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
	//农药
	var pesticide ='<option value="杀虫剂">杀虫剂</option><option value="杀螨剂">杀螨剂</option><option value="杀菌剂">杀菌剂</option><option value="除草剂">除草剂</option><option value="植物生长调节剂">植物生长调节剂</option><option value="杀线虫剂">杀线虫剂</option>option value="杀鼠剂">杀鼠剂</option><option value="其它">其它</option>';
	//化肥	
	var fertilizer = '<option value="尿素">尿素</option><option value="磷酸二氢钾">磷酸二氢钾</option><option value="硫酸钾">硫酸钾</option><option value="过磷酸钙">过磷酸钙</option><option value="复合肥">复合肥</option><option value="农家肥">农家肥</option><option value="其它">其它</option>';
	/**
	*操作类型的动态改变显示
	*/
	$("#fieldcaretype").change(function(){
		
		$("#fieldcarenameotherImg").hide();
       	$("#fieldcarenamespan").hide();
       	$("#fieldcarenameother").val($("#fieldcarenameselect").val());
       	$("#fieldcarenameotherLab").attr("class","noico");
		var type = $(this).val();
		if(type == '施肥'){
			$("#fieldcarenameselect").html(fertilizer);
			$("#td_fieldcarename").html("肥料种类：");
			$("#td_fieldcareweight").html("肥料重量(Kg/亩)：");
			$("#tr_fieldcareweight").show();
			$("#tr_fieldcarename").show();
			$("#span_remark").html("操作用途说明：如底肥、追肥等");
			$("#td_l_fieldcarenameselect").show();
			$("#td_l_fieldcarenameselect").html("肥料种类：");
			$("#td_l_fieldcareweight").html("肥料重量(Kg/亩)：");
			$("#tr_l_fieldcarenameselect").show();
			$("#tr_l_fieldcareweight").show();
		}else if(type == '农药'){
			$("#fieldcarenameselect").html(pesticide);
			$("#td_fieldcarename").html("农药种类：");
			$("#td_fieldcareweight").html("农药重量(Kg/亩)：");
			$("#tr_fieldcareweight").show();
			$("#tr_fieldcarename").show();
			$("#span_remark").html("操作用途说明：如除虫、杀菌等");
			$("#td_l_fieldcarenameselect").show();
			$("#td_l_fieldcarenameselect").html("农药种类：");
			$("#td_l_fieldcareweight").html("农药重量(Kg/亩)：");
			$("#tr_l_fieldcarenameselect").show();
			$("#tr_l_fieldcareweight").show();
		}else{
			
			$("#tr_fieldcareweight").hide();
			$("#tr_fieldcarename").hide();
			$("#span_remark").html("&nbsp;");
			$("#tr_fieldcarename").hide();
			$("#tr_l_fieldcarenameselect").hide();
			$("#tr_l_fieldcareweight").hide();
		}
	
	});
  	</script>
	</body>
</html>

