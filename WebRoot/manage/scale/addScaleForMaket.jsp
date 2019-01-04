<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head> 
		<base href="<%=basePath%>">
		<meta charset="utf-8"> 
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/market.css">
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
   	 	<script type="text/javascript" language="javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    	
    	<script type="text/javascript">
    		var i = 0;
			//
			/**
			 *页面初始化隐藏所有以id为lab结尾的span标签
			 */
			$(function () {
				$("label[id$='Lab']").each(function () {
					if (this != null) {
						//$(this).hide();
					}
				});
				//删除一列选中的秤
				$(".delMed").live("click",function() {
					if (i <= -1) {
						return;
					}
					i--;
					$(this).parent().remove();
				  	//当不存在预计产物后,提示必须输入预计产物,并将全局变量改成false,不让弹出层
					if (i == -1) {
						bool2 = false;
						$("#s_addMed").show(1000);
					} else {
						bool2 = true;
						$("#s_addMed").hide(1000);
					}
					resetH();
				});
			});
			    		
    		//添加一个溯源秤
			function addGrowMed() {
				if (i == -1) {
					bool2 = false;
					$("#s_addMed").show(1000);
				}else if(i == 5){
					$.dialog.tips("每个经营户最多有6个溯源秤",1,'alert.gif');	
					return;
				} else {
					bool2 = true;
					$("#s_addMed").hide(1000);
				}
				i++;
				var str = "<div id=\"growMed_" + i + "\">溯源秤编号&nbsp;&nbsp;<input type=\"text\" class=\"inp\" size=\"32\" maxlength=\"32\" id=\"scalecode" + i + "\" name=\"scaleList[" 
						+ i + "].scalecode\"" + "onkeypress=\"onkeyCheck(this.value);\" onkeyup=\"onkeyCheck(this.value);\" onblur=\"onkeyCheck(this.value);\" AUTOCOMPLETE=\"OFF\"/>&nbsp;<span class=\"red\">*</span>&nbsp;<span  class=\"red\" name=\"s_med" 
						+ i + "\"" + "></span>溯源秤规格&nbsp;&nbsp;<select id=\"cellType\" name=\"scaleList["+i+"].scalenorm\" style=\"width:172px\">"
						+ "<c:forEach items="${requestScope.scaleConfMap}" var="scaleMap" varStatus="s"><option value="+'${scaleMap.key},${scaleMap.value}'+">"+ '${scaleMap.value}'+" </option></c:forEach></select>&nbsp;<span class=\"red\">*</span>&nbsp;<span class=\"red\" name=\"s_weight" + i 
						+ "\"" + "></span><a href=\"javascript:void(0)\" class=\"delMed\">删除</a></div>";
				$("#growMedList").append(str);
				resetH(); 
			}
			
			function checkNumberChar(ob){
				if(/^\d+$/.test(ob)){
					return true;
				}else{
					return false;
				}
			}
			
			function checkIsNull(){
				for(var i=0;i<=5;i++){
					if($("#scalecode" + i) != undefined && $("#scalecode" + i).val() == ""){
						$.dialog.tips("溯源秤编号必须填写！",1,'alert.gif');
						$("#scalecode" + i).focus();
						return;
					}
					if($("#scalecode" + i).val() != undefined){
						if(!checkNumberChar($("#scalecode" + i).val())){
							$.dialog.tips("溯源秤编号必须为数字！",1,'alert.gif');
							$("#scalecode" + i).focus();
							return;
						}
					}
				}
				$("#searchform").attr("action", "<%=basePath%>scaleAction!saveScale.shtml");
				$("#searchform").submit();
			}
			
			
			function onkeyCheck(scalecode){
				if(scalecode == ""){
					return;
				}
				for(var i=0;i<=5;i++){
					for(var j = i+1;j<=5;j++){
						if($("#scalecode" + i) != undefined && $("#scalecode" + i).val() != undefined 
							&& $("#scalecode" + j) != undefined && $("#scalecode" + j).val() != undefined){
							if($("#scalecode" + i).val() == $("#scalecode" + j).val()){
								$.dialog.tips("溯源秤号有重复！",2,'alert.gif');
								document.getElementById("next").disabled=true;
								return;
				    		}else{
				    			document.getElementById("next").disabled=false;
				    		}
						}
					}
				}
				
				$.ajax({
			    	url: "<%=basePath%>scaleAction!checkScaleCode.shtml?scalecode=" + scalecode,
			    	type: 'post',
			    	success: function(html){
			    		if(html != ""){
			    			$.dialog.tips(html,2,'alert.gif');
			    			document.getElementById("next").disabled=true;
			    		}else{
			    			document.getElementById("next").disabled=false;
			    		}
			  		}
				});
			}
			
    	</script>
	</head>
	<body> 
		<div id="body">
			<div class="cur-pos">
				当前位置：溯源秤管理 > 溯源秤发放 
			</div>
			<div class="form-box">
				<form action="scaleAction!saveScale.shtml" method="post" id="searchform" name="searchform">
					<s:token></s:token>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
					  <td height="30">
							商户名称：${scale.userName }
							<input type="hidden" value="${scale.usercode }" name="usercode">
							<input type="hidden" value="${scale.userName }" name="userName">
					  </td>
					</tr>
				</table>
					
					<div class="fb-tit">
						添加新溯源秤
					</div>
					<div class="fb-con">
						<a id="addMed" href="javascript:void(0)" class="blue"
							onClick="addGrowMed()">+新建溯源秤</a>
						<span id="s_addMed" class="red hide">新建溯源秤未输入</span>
						<div id="growMedList" class="plant-yc">
							<div id="growMed_0">
								溯源秤编号&nbsp;
								<input type="text" name="scaleList[0].scalecode" id="scalecode0" 
								
								onblur="onkeyCheck(this.value);"  AUTOCOMPLETE="OFF" size="32" maxlength="32" class="inp">
								<span class="red">*</span>
								
								<span name="s_med0" class="red"></span> 溯源秤规格&nbsp;
								<select name="scaleList[0].scalenorm" width="172px">
									<c:forEach items="${requestScope.scaleConfMap}" var="scaleMap" varStatus="s">
								 		<option value="${scaleMap.key},${scaleMap.value}">${scaleMap.value}</option>;
									</c:forEach>
								</select>
								
								<span class="red">*</span>
								<span name="s_weight0" class="red"></span>
							</div>
						</div>
					</div>
					<div class="fb-bom">
						<cite><input type="button" id="next" name="next" onclick="checkIsNull()"  value="提交" class="sbt">
						</cite>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
