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
		<title></title>
   		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 农药信息添加</div>
		<div class="form-box">
    		<form action="<%=basePath %>pesticide!save.shtml" method="post" name="searchform" id="searchform">
    		<input type="hidden" name="oper" id="oper" value="${requestScope.oper }">
			<s:token></s:token>
    		<div class="fb-tit">农药信息添加</div>
        	<div class="fb-con">
				<input type="hidden" id="cpcplant" name="cpcplant" value="${requestScope.cpcplant }" />
				<input type="hidden" id="plantaddtime" value="${plant.plantaddtime }">
				<input type="hidden" id="pesticidename" name="pesticidename" />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
        				<td colspan="4" height="30">种子种苗植物名：${requestScope.plant.plantname }　　种植批次号：${requestScope.plant.cpcplant }　　	种植时间：${plant.plantaddtime}</td>
    				</tr>
					<tr>
						<td height="39" align="right" width="100">
							农药种类：
						</td>
						<td width="170">
									<select name="pesticidenameselect"  class="w158"
										id="pesticidenameselect" onchange="choseOther(this);">
										<option value="杀虫剂">
											杀虫剂
										</option>
										<option value="杀螨剂">
											杀螨剂
										</option>
										<option value="杀菌剂">
											杀菌剂
										</option>
										<option value="除草剂">
											除草剂
										</option>
										<option value="植物生长调节剂">
											植物生长调节剂
										</option>
										<option value="杀线虫剂">
											杀线虫剂
										</option>
										<option value="杀鼠剂">
											杀鼠剂
										</option>
										<option value="其它">
											其它
										</option>
									</select>
									<span class="red">*</span>
						</td>
						<td width="250">
							<span id="pesticidenamespan" class="hide">请输入其它种类：
									<input type="text" class="inp w120" maxlength="10" onblur="checkVal(this.name)" name="pesticidenameother" id="pesticidenameother" value="低毒农残" />
									<span class="red">*</span>
							</span>
						</td>
						<td>
							<label name="pesticidenameotherLab" id="pesticidenameotherLab" class="noico">请输入农药种类</label>
						</td>
					</tr>
					<tr>
						<td height="39" align="right">
							农药重量(Kg)：
						</td>
						<td>
							<input type="text"  name="pesticideweight" maxlength="6" class="inp w150"
								id="pesticideweight" 
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"
								/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="pesticideweightLab" id="pesticideweightLab" class="noico">
								农药重量未输入或输入错误
							</label>
						</td>
						<td></td>
					</tr>
					<tr>
						<td height="39" align="right">
							施药时间：
						</td>
						<td>
							<input type="text" class="inp w150" name="pesticidetime" id="pesticidetime"
								onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'plantaddtime\');}'});"
								onblur="onBlurCheck(this.name)"
								style="background: #ffffff url('images/growaddunittime.png') no-repeat right;"
								/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="pesticidetimeLab" id="pesticidetimeLab" class="noico">
								施药时间未输入
							</label>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
        	<div class="fb-bom">
        		<cite><input type="button" value="下一步" class="sbt" onclick="checkInfopesticide()"></cite>
        	</div>
			</form>
		</div>
		<div class="pop-box"  id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td width="30%" height="30" align="right" bgcolor="#EEEEEE">
							农药种类：
						</td>
						<td width="70%">
							<label id="l_pesticidenameselect" />
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							农药重量(Kg)：
						</td>
						<td>
							<label id="l_pesticideweight" />
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							施药时间：
						</td>
						<td>
							<label id="l_pesticidetime" />
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
		$("#pesticideweight").focus();
		cMenu(0,0);
		 function choseOther(obj){
	        if(obj.value=="其它"){
	            $("#pesticidenamespan").show();
	            $("#pesticidenameother").val("");
	            $("#pesticidenameother").focus();
	        }else{
	        	$("#pesticidenameotherImg").hide();
	        	$("#pesticidenamespan").hide();
	        	$("#pesticidenameother").val($("#pesticidenameselect").val());
	        	$("#pesticidenameotherLab").attr("class","noico")
	        }
	    }
	    
		function checkForm(){
			var pesticidename = $("#pesticidename");
			var pesticidenameselect = $("#pesticidenameselect");
			if(pesticidenameselect.val() == "其它" ){
				var pesticidenameother =$("#pesticidenameother");
				pesticidename.val(pesticidenameselect.val()+"|"+pesticidenameother.val());
	        }else{
	        	pesticidename.val(pesticidenameselect.val());
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
