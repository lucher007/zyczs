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
		<base href="<%=basePath%>" />
		<title>新建收获任务</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css"/>
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 收获信息添加</div>
		<div class="form-box">
	    	<form action="<%=basePath %>med!save.shtml"  method="post" name="searchform" id="searchform">
			<s:token></s:token>
			<div class="fb-tit">收获信息添加</div>
			<div class="fb-con">
				<input type="hidden" id="medname" name="medname" value="${plantlist[0].harvestmed }"/>
				<input type="hidden" id="cpcplant" name="cpcplant" value="${plant.cpcplant }" />
				<input type="hidden" id="plantaddtime" value="${plant.plantaddtime }">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
        				<td colspan="3" height="30">种子种苗植物名：${requestScope.plant.plantname }　　
        				种植批次号：${requestScope.plant.cpcplant }　　	
        				种植时间：${plant.plantaddtime}</td>
    				</tr>
					<tr>
						<td width="140" height="30" align="right">
							品名：
						</td>
						<td width="170">
							<select onchange="changepredictweight(this.value)" class="w158">
								<c:forEach items="${plantlist}" var="plant">
									<c:if test="${plant != null}">
										<option value="${plant.harvestmed}${'@'}${plant.harvestwei}">
											${plant.harvestmed}
										</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
						<td width="400">&nbsp;</td>
					</tr>
					<tr>
						<td height="30" align="right">
							预计产量(Kg)：
						</td>
						<td>
							<input type="text" class="inp w150" name="predictweight"
								id="predictweight" readonly="readonly"
								value="${plantlist[0].harvestwei }" style="background:#CCC"/>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td height="30" align="right">
							实际产量(Kg)：
						</td>
						<td>
							<input type="text" class="inp w150" name="medweight" maxlength="6"
								id="medweight"
								onkeypress="onkeypressCheck(this);"
								onkeyup="onkeyupCheck(this);"
								onblur="onkeyblurCheck(this);onBlurCheck(this.name)"/>
								<span class="red">*</span>
						</td>
						<td>
							<label name="medweightLab" id="medweightLab" class="noico">
								产量只能填写数字
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							收获时间：
						</td>
						<td>
							<input type="text" class="inp w150" name="harvesttime"
								onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'plantaddtime\');}'});"
								id="harvesttime" onblur="onBlurCheck(this.name)"
								style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" />
							<span class="red">*</span>
						</td>
						<td>
							<label name="harvesttimeLab" id="harvesttimeLab" class="noico">
								收获时间未选择
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							企业内部收获批次号：
						</td>
						<td>
							<input type="text" class="inp w150" name="mednumber"
								id="mednumber" maxlength="20" onblur="checkVal(this.name)"/>
							<span class="red">*</span>
						</td>
						<td>
							<label name="mednumberLab" id="mednumberLab" class="noico">
								批次号不能包含~ # *等字符
							</label>
						</td>
					</tr>
				</table>
			</div>
	        <div class="fb-bom">
	        	<cite><input type="button" value="下一步" class="sbt" onclick="checkInfoMed()" id="btnfinish"/></cite>
	        </div>
	        </form>
		</div>
		<div class="pop-box" id="pop-div">
			<div id="divTitle">
				<table width="500">
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE" width="160">
							品名：
						</td>
						<td width="320">
							<label id="l_medname" />
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							预计产量(Kg)：
						</td>
						<td>
							<label id="l_predictweight" /></label>
							
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							实际产量(Kg)：
						</td>
						<td>
							<label id="l_medweight"></label>
							
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							收获时间：
						</td>
						<td>
							<label id="l_harvesttime" />
						</td>
					</tr>
					<tr>
						<td height="30" align="right" bgcolor="#EEEEEE">
							企业内部收获批次号：
						</td>
						<td>
							<label id="l_mednumber" />
						</td>
					</tr>
					<tr height="60">
						<td align="center" colspan="2" class="red">
								保存后信息将无法更改，请仔细核对种植任务信息
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