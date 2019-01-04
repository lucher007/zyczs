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
		<title>更新种植任务</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">当前位置：种植管理 > 更新种植任务</div>
		<div class="form-box">
	  		<form action="plant!updatePlant.shtml" method="post" name="myform" id="myform">
			<s:token></s:token>
	    	<div class="fb-tit">更新种植任务</div>
	        <div class="fb-con">
				<input type="hidden" name="cpcplant" id="cpcplant" value="${plant.cpcplant}" />
				<input type="hidden" name="cpcplantimg" id="cpcplantimg" value="${plant.cpcplantimg}" />
				<input type="hidden" name="harvestmedwei" id="harvestmedwei" value="${plant.harvestmedwei}" />
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="30" align="right">
							种子(种苗)植物名：
						</td>
						<td>
							<input type="text" class="inp" name="plantname"
								id="plantname" value="${plant.plantname}" readonly="readonly"
								 />
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right" width="200">
							企业内部种植批次：
						</td>
						<td  width="155">
							<input type="text" class="inp" name="plantnumber"
								id="plantnumber" maxlength="15" value="${plant.plantnumber}" onblur="checkVal(this.name)" />
						</td>
						<td width="400">
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
							<input type="text" class="inp" name="plantarea"
								id="plantarea" value="${plant.plantarea}"  readonly="readonly" />
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right">
							种子(种苗)来源：
						</td>
						<td>
							<input type="text" class="inp" name="plantsource"
								id="plantsource" value="${plant.plantsource}"  readonly="readonly"
								 /> 
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right">
							种子(种苗)重量(Kg)：
						</td>
						<td>
							<input type="text" class="inp" name="plantweight"
								id="plantweight" value="${plant.plantweight/10000}"  readonly="readonly"/>
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植负责人：
						</td>
						<td>
							<input type="text" class="inp" name="plantusername"  readonly="readonly"
								id="plantusername" value="${plant.plantusername}" />
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right">
							种植时间：
						</td>
						<td>
							<input type="text" class="inp" name="plantaddtime"  readonly="readonly"
								id="plantaddtime" value="${plant.plantaddtime }" />
						</td>
						<td><span class="gray">不可更新</span></td>
					</tr>
					<tr>
						<td height="30" align="right" width="150">
							种植周期(月)：
						</td>
						<td>
							<input type="text" class="inp" name="plantcycle" id="plantcycle" value="${plant.plantcycle}"  maxlength="3"
								 onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value"
								 onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value"
								 onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}"
							/>
						</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="growMedList" class="plant-yc">
								<c:forEach items="${plantlist}" var="plant" varStatus="status">
									<div id="growMed_${status.index}">
										预计产物
										<input type="text" name="med${status.index}"
											disabled="disabled" value="${plant.harvestmed}" class="inp" />
										<span name="s_med${status.index}"></span> 预计产量
										<input type="text" name="weight${status.index}"
											disabled="disabled" value="${plant.harvestwei}" class="inp" />
										<span>(Kg)</span>
										<span name="s_weight${status.index}"></span> 
										<span class="gray">不可更新</span>
									</div>
								</c:forEach>
							</div>
							<div id="auto"></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="fb-bom">
		        <cite><input type="button" value="下一步" onclick="checkUpdate()" id="btnNext" class="sbt"></cite>
		    </div>
			<div class="pop-box" id="pop-div">
				<div id="divTitle">
					<div style="text-align: center">
					</div>
					<table width="500">
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种子（种苗）植物名：
							</td>
							<td>
								<label id="l_plantname" />
							</td>
							<td bgcolor="#EEEEEE" align="right">
								企业内部种植批次：
							</td>
							<td>
								<label id="l_plantnumber" />
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td height="25" bgcolor="#EEEEEE" align="right">
								种植面积：
							</td>
							<td>
								<label id="l_plantarea"></label><span>(亩)</span>
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
								种子（种苗）重量：
							</td>
							<td>
								<label id="l_plantweight" ></label><span>(Kg)</span>
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
								种植周期：
							</td>
							<td>
								<label id="l_plantcycle"></label><span>(月)</span>
							</td>
						</tr>
						<tr>
							<td colspan="4" height="40">
								<div id="l_growMedList" style="line-height:30px">
								</div>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="4" height="60" class="red">
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
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
		cMenu(0,0);
		$("#plantcycle,#plantnumber").css("color","#333");
	</script>
	</body>
</html>
