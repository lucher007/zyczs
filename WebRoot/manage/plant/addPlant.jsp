<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<base href="<%=basePath%>" >
		<title>新建种植</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 新建种植</div>
		<div class="form-box">
  		  	<form action="plant!savePlant.shtml" method="post" name="myform" id="myform">
			<s:token></s:token>
    		<div class="fb-tit">新建种植任务</div>
        	<div class="fb-con">
				<input type="hidden" name="harvestmedwei" id="harvestmedwei">
			   	<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="200" height="30" align="right">
							种子(种苗)植物名：
						</td>
						<td width="170">
							<input type="text" class="inp" name="plantname" maxlength="20"  readonly="readonly"
								id="plantname" onblur="onBlurCheck(this.name)" onclick="selPlantBase();"/>
							<span class="red">*</span>
						</td>
						<td width="330">
							<label name="plantnameLab" id="plantnameLab" class="noico">
								植物名未输入
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							企业内部种植批次号：
						</td>
						<td>
							<input type="text" class="inp" name="plantnumber"
								id="plantnumber" maxlength="15" value="${plantnumber}" onblur="checkVal(this.name)"/>
						</td>
						<td>
							<label name="plantnumberLab" id="plantnumberLab" class="noico">
								企业内部种植批次未输入
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植面积(亩)：
						</td>
						<td>
							<input type="text" class="inp" name="plantarea" maxlength="6"
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"
								id="plantarea" value="${plantarea }"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="plantareaLab" id="plantareaLab" class="noico">
								面积只能填写数字
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种子(种苗)来源：
						</td>
						<td>
							<select id="plantsource" name="plantsource"
								style="width:155px">
								<option value="自购">
									自购
								</option>
								<option value="栽培">
									栽培
								</option>
								<option value="野生">
									野生
								</option>
							</select>
							<span class="red">*</span>
						</td>
						<td>
							<label name="plantsourceLab" id="plantsourceLab"
								class="noico"></label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种子(种苗)重量(Kg)：
						</td>
						<td>
							<input type="text" class="inp" name="plantweight"  maxlength="6"
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"
								id="plantweight" value="${plantweight}"
							/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="plantweightLab" id="plantweightLab" class="noico">
								重量只能填写数字
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植负责人：
						</td>
						<td>
							<input type="text" class="inp" name="plantusername" maxlength="7"
								id="plantusername" onblur="checkVal(this.name)" value="${plantusername }"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="plantusernameLab" id="plantusernameLab" class="noico">
								种植负责人未输入
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植时间：
						</td>
						<td>
							<input type="text" class="inp" name="plantaddtime"
								id="plantaddtime"
								onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd'});"
								onblur="onBlurCheck(this.name)"
								style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" />
							<span class="red">*</span>
						</td>
						<td>
							<label name="plantaddtimeLab" id="plantaddtimeLab" class="noico">
								种植时间未选择
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植周期(月)：
						</td>
						<td>
							<input type="text" class="inp" name="plantcycle"  maxlength="3"
								id="plantcycle"
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)" value="${plantcycle }"
								/>
						</td>
						<td>
						</td>
					</tr>
			        <tr>
			            <td height="26"><a id="addMed" href="javascript:void(0)" class="blue" onClick="addGrowMed()">+新建产出药材</a></td>
			            <td colspan="2"><span id="s_addMed" class="red hide">新建产出药材未输入</span></td>
			        </tr>
					<tr>
						<td colspan="3">
							<div id="growMedList" class="plant-yc">
								<div id="growMed_0">
									预计产出药材：<input type="text" id="med0" name="med0"  AUTOCOMPLETE="OFF" onblur="onBlurCheck(this.name)" maxlength="20" class="inp" onclick="selMedBase(this);" readonly="readonly">
									<span class="red">*</span>
									<span name="s_med0" class="red"></span> 预计产量总计(Kg)：<input type="text" name="weight0"  maxlength="6"
											onkeypress="onkeypressCheck(this);"
											onkeyup="onkeyupCheck(this);"
											onblur="onkeyblurCheck(this);onBlurCheck(this.name)" class="inp">
									<span class="red">*</span>
									<span name="s_weight0" class="red"></span>
									<a href="javascript:void(0)" class="delMed">删除</a>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="fb-bom">
		        <cite><input type="button" value="下一步" onclick="checkInfo()" class="sbt" id="next"></cite>
		    </div>
			<div class="pop-box" id="pop-div">
				<div id="divTitle">
					<table width="500">
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种子（种苗）植物名：
							</td>
							<td>
								<label id="l_plantname" />
							</td>
							<td bgcolor="#EEEEEE" align="right">企业内部种植批次号：</td>
							<td>
								<label id="l_plantnumber" />
							</td>
						</tr>
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种植面积(亩)：
							</td>
							<td>
								<label id="l_plantarea"></label>
								<span></span>
							</td>
							<td bgcolor="#EEEEEE" align="right">
								种子（种苗）来源：
							</td>
							<td>
								<label id="l_plantsource" />
							</td>
						</tr>
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种子（种苗）重量(Kg)：
							</td>
							<td>
								<label id="l_plantweight"></label>
								<span></span>
							</td>
							<td bgcolor="#EEEEEE" align="right">
								种植时间：
							</td>
							<td>
								<label id="l_plantaddtime" />
							</td>
						</tr>
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种植负责人：
							</td>
							<td>
								<label id="l_plantusername" />
							</td>
							<td bgcolor="#EEEEEE" align="right">
								种植周期(月)：
							</td>
							<td>
								<label id="l_plantcycle"></label>
								<span></span>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div id="l_growMedList" style="padding-top: 10px; line-height:26px;">
								</div>
							</td>
						</tr>
						<tr >
							<td align="center" colspan="4" height="60" class="red">
									保存后信息将无法更改，请仔细核对种植任务信息
							</td>
						</tr>
					</table>
				</div>
			</div>
			</form>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
		var errmsg = "${requestScope.Returninfo }";
		if(errmsg!=""){
			$.dialog.tips(errmsg,1,'alert.gif');	
		}
		cMenu(0,1);
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
		/**
		*选择种子种苗植物
		*/
		function selPlantBase(){
				$("#returninfo_lastcheck").html("");
				t1 = $.dialog({
					title:'选择种子种苗植物',
					id:'plantChos',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>plantBase!plantBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
				});
			}
	
		function closePlant(s){
					$("#plantname").val(s[1]);
					$("#plantname").focus();
					t1.close();
		}
		
	</script>
	</body>
</html>