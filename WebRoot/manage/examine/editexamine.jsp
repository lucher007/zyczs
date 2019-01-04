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
		<title>新建考核地区</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css"/>
	</head>

	<body onload="initPage();">
	<div id="body">
		<div class="cur-pos">当前位置：考核管理 > 考核地区修改</div>
		<div class="form-box">
	    	<form action="<%=basePath %>examine!update.shtml"  method="post" name="searchform" id="searchform">
	    	<input  type="hidden" name="id" value="${requestScope.examine.id }"/>
			<s:token></s:token>
			<div class="fb-tit">收获信息添加</div>
			<div class="fb-con">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="140" height="30" align="right">
							地区编号：
						</td>
						<td colspan="2">
							<input type="text" class="inponly" size="30" id="areacode1"  name="areacode1" readonly maxlength="30" value="${requestScope.examine.areacode }">
							
						</td>
						
					</tr>
	        		<tr>
						<td width="140" height="30" align="right">
							所属区域：
						</td>
						<td colspan="2">
							<input type="text" class="inponly" size="30" id="area"  name="area" readonly maxlength="30" value="${requestScope.examine.areas }">
							
						</td>
						
					</tr>
					<tr>
						<td width="140" height="30" align="right">
							种植基地数量：
						</td>
						<td width="140">
							<input type="text" class="inp w120" name="medcount" maxlength="6"
								id="medcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)" value="${examine.medcount }"/>
								<span class="red">*</span>
						</td>
						<td width="400">
						<label name="medcountLab" id="medcountLab" class="noico">
								请输入种植基地数量
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							中药材经销企业数量：
						</td>
						<td>
							<input type="text" class="inp w120" name="medsellcount" maxlength="6"
								id="medsellcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)" value="${examine.medsellcount }"/>
								<span class="red">*</span>
						</td>
						<td>
						<label name="medsellcountLab" id="medsellcountLab" class="noico">
								请输入中药材经销企业数量
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							专业市场经营企业数量：
						</td>
						<td>
							<input type="text" class="inp w120" name="medmarketcount" maxlength="6"
								id="medmarketcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)" value="${examine.medmarketcount }"/>
								<span class="red">*</span>
						</td>
						<td>
						<label name="medmarketcountLab" id="medmarketcountLab" class="noico">
								请输入专业市场经营企业数量
						</label>
						</td>
					</tr>				
					<tr>
						<td height="30" align="right">
							饮片生产企业数量：
						</td>
						<td>
							<input type="text" class="inp w120" name="tabletcount" maxlength="6"
								id="tabletcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)" value="${examine.tabletcount }"/>
								<span class="red">*</span>
						</td>
						<td>
						<label name="tabletcountLab" id="tabletcountLab" class="noico">
								请输入饮片生产企业数量
						</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							饮片经销企业数量：
						</td>
						<td>
							<input type="text" class="inp w120" name="tabletsellcount" maxlength="6"
								id="tabletsellcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)" value="${examine.tabletsellcount }"/>
								<span class="red">*</span>
						</td>
						<td>
						<label name="tabletsellcountLab" id="tabletsellcountLab" class="noico">
								请输入饮片经销企业数量
						</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							饮片使用单位数量：
						</td>
						<td>
							<input type="text" class="inp w120" name="tablethospcount" maxlength="6"
								id="tablethospcount"
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);onBlurCheck(this.name)"  value="${examine.tablethospcount }"/>
								<span class="red">*</span>
						</td>
						<td>
						<label name="tablethospcountLab" id="tablethospcountLab" class="noico">
								请输入饮片使用单位数量
						</label>
						</td>
					</tr>
				</table>
			</div>
	        <div class="fb-bom">
	        	<input type="button" value="返  回" class="sbt" onclick="findList()" id="btnfinish"/>
	        	<cite><input type="button" value="更  新" class="sbt" onclick="Onsubmit()" id="btnfinish"/></cite>
	        	<span class="red" style="font-size:16px;">${requestScope.returninfo }</span>
	        </div>
	        </form>
		</div>
		
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	
		<script type="text/javascript" language="javascript">
		function initPage(){
		
			var returninfo='${requestScope.returninfo }';
			if(returninfo=="添加成功!"){
				$('#medcount').val("");
				$('#medsellcount').val("");
				$('#medmarketcount').val("");
				$('#tabletcount').val("");
				$('#tabletsellcount').val("");
				$('#tablethospcount').val("");
				
			}
		}
		
		function onkeyupNum(obj){
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
					
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				obj.value=addtr(obj.value,0);
			}
			//大于0
			if(obj.value<1&&obj.value.length==1) {
				obj.value = "";
			}	
		}
		
		function Onsubmit(){
			
			
			var returnInfo="";
					
			if(!isNullIpu("medcount"))
			{
				returnInfo+="请输入种植基地数量 <br>";
			}
			if(!isNullIpu("medsellcount"))
			{
				returnInfo+="请输入中药材经销企业数量 <br>";
			}
			if(!isNullIpu("medmarketcount"))
			{
				returnInfo+="请输入专业市场经营企业数量 <br>";
			}
			if(!isNullIpu("tabletcount"))
			{
				returnInfo+="请输入饮片生产企业数量 <br>";
			}
			if(!isNullIpu("tabletsellcount"))
			{
				returnInfo+="请输入饮片经销企业数量 <br>";
			}
			if(!isNullIpu("tablethospcount"))
			{
				returnInfo+="请输入饮片使用单位数量 <br>";
			}
			if(returnInfo!=""){
				//$.dialog.alert(returnInfo);
				return;
			}	
			$("#searchform").submit();
    		$("#btnfinish").attr("disabled","disabled");
		}
		
		function findList(){
			window.location.href="examine!findByList.shtml";
		}
		
  		</script>
	</body>
</html>