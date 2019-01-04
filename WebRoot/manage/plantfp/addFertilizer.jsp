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
		<title>施肥信息添加</title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 施肥信息添加</div>
		<div class="form-box">
			<form action="<%=basePath %>fertilizer!save.shtml" method="post" name="searchform" id="searchform">
			<input type="hidden" name="oper" id="oper" value="${requestScope.oper }">
			<s:token></s:token>
    		<div class="fb-tit">施肥信息添加</div>
        	<div class="fb-con">
				<input type="hidden" id="cpcplant" name="cpcplant" value="${requestScope.cpcplant }" />
				<input type="hidden" id="plantaddtime" value="${plant.plantaddtime }">
				<input type="hidden" id="fertilizername" name="fertilizername" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="4" height="30">种子种苗植物名：${requestScope.plant.plantname }　　种植批次号：${requestScope.plant.cpcplant }　　	种植时间：${plant.plantaddtime}</td>
   					</tr>
					<tr>
						<td height="39" width="120" align="right">肥料种类：</td>
						<td width="170">
									<select name="fertilizernameselect"  class="w158"
										id="fertilizernameselect" onchange="choseOther(this);">
										<option value="尿素">
											尿素
										</option>
										<option value="磷酸二氢钾">
											磷酸二氢钾
										</option>
										<option value="硫酸钾">
											硫酸钾
										</option>
										<option value="过磷酸钙">
											过磷酸钙
										</option>
										<option value="复合肥">
											复合肥
										</option>
										<option value="农家肥">
											农家肥
										</option>
										<option value="其它">
											其它
										</option>
									</select>
									<span class="red">*</span>
						</td>
						<td width="220">
							<span id="fertilizernamespan" class="hide">请输入其它种类：
								<input type="text" class="inp w100" maxlength="10" onblur="checkVal(this.name)" name="fertilizernameother" id="fertilizernameother" value="尿素">
								<span class="red">*</span>
							</span>
						</td>
						<td width="196">
							<label name="fertilizernameotherLab" id="fertilizernameotherLab" class="noico">请输入肥料种类</label>
						</td>
					</tr>
					<tr>
						<td height="39" align="right">
							肥料重量(Kg)：
						</td>
						<td>
							<input type="text"  name="fertilizerweight" maxlength="6" class="inp w150"
								id="fertilizerweight" 
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"
								 />
							<span class="red">*</span>
						</td>
						<td>
							<label name="fertilizerweightLab" id="fertilizerweightLab" class="noico">
								肥料重量未输入或输入错误
							</label>
						</td>
						<td></td>
					</tr>
					<tr>
						<td height="39" align="right">
							施肥时间：
						</td>
						<td>
							<input type="text" class="inp w150" name="fertilizertime" id="fertilizertime"
								onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'plantaddtime\');}'});"
								style="background: #ffffff url('images/growaddunittime.png') no-repeat right;"
								onblur="onBlurCheck(this.name)"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="fertilizertimeLab" id="fertilizertimeLab" class="noico">
								施肥时间未输入
							</label>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<div class="fb-bom">
				<cite><input type="button" value="下一步" class="sbt" onclick="checkInfoFertilizer()"></cite>
			</div>
			</form>
  		</div>
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td width="30%" height="25" bgcolor="#EEEEEE" align="right">
							肥料种类：
						</td>
						<td width="70%">
							<label id="l_fertilizernameselect" />
						</td>
					</tr>
					<tr></tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right">
							肥料重量(Kg)：
						</td>
						<td>
							<label id="l_fertilizerweight" />
						</td>
					</tr>
					<tr>
						<td height="25" bgcolor="#EEEEEE" align="right">
							施肥时间：
						</td>
						<td>
							<label id="l_fertilizertime" />
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
	            $("#fertilizernamespan").show();
	            $("#fertilizernameother").val("");
	            $("#fertilizernameother").focus();
	        }else{
	        	$("#fertilizernameotherImg").hide();
	        	$("#fertilizernamespan").hide();
	        	$("#fertilizernameother").val($("#fertilizernameselect").val());
	        	$("#fertilizernameotherLab").attr("class","noico");
	        }
	    }
	    
		function checkForm(){
			var fertilizername = $("#fertilizername");
			var fertilizernameselect = $("#fertilizernameselect");
			if(fertilizernameselect.val() == "其它" ){
				var fertilizernameother =$("#fertilizernameother");
				fertilizername.val(fertilizernameselect.val()+"|"+fertilizernameother.val());
	        }else{
	        	fertilizername.val(fertilizernameselect.val());
	        }
	        $("#searchform").submit();
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
  	</script>
	</body>
</html>

