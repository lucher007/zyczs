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
		<link type="text/css" rel="stylesheet" href="/style/user.css">
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
				var str = "<div id=\"growMed_" + i + "\">溯源秤编号&nbsp;&nbsp;<input type=\"text\" class=\"inp\" size=\"32\" maxlength=\"32\" id=\"chengcode" + i + "\" name=\"chengList[" 
						+ i + "].chengcode\"" + "onkeypress=\"onkeyCheck(this.value);\" onkeyup=\"onkeyCheck(this.value);\" onblur=\"onkeyCheck(this.value);\" AUTOCOMPLETE=\"OFF\"/>&nbsp;<span class=\"red\">*</span>&nbsp;<span  class=\"red\" name=\"s_med" 
						+ i + "\"" + "></span>溯源秤规格&nbsp;&nbsp;<select id=\"cellType\" name=\"chengList["+i+"].confid\" style=\"width:172px\">"
						+ "<c:forEach items="${requestScope.chengconfmap}" var="chengMap" varStatus="s"><option value="+'${chengMap.key}'+">"+ '${chengMap.value}'+" </option></c:forEach></select>&nbsp;<span class=\"red\">*</span>&nbsp;<span class=\"red\" name=\"s_weight" + i 
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
				    $("#chengcode" + i).val($.trim($("#chengcode" + i).val()));
					if($("#chengcode" + i) != undefined && $("#chengcode" + i).val() == ""){
						$.dialog.tips("溯源秤编号必须填写！",1,'alert.gif');
						$("#chengcode" + i).focus();
						return;
					}
					if(checkquotmarks($("#chengcode" + i).val())){
						$("#chengcode" + i).focus();
						$.dialog.tips('不要输入非法字符',1,'alert.gif');
						return false;
					}
					
					if($("#chengcode" + i).val() != undefined){
						if(!checkNumberChar($("#chengcode" + i).val())){
							$.dialog.tips("溯源秤编号必须为数字！",1,'alert.gif');
							$("#chengcode" + i).focus();
							return;
						}
					}
				}
				$("#searchform").attr("action", "<%=basePath%>chengAction!saveCheng.shtml");
				$("#searchform").submit();
			}
			
			
			function onkeyCheck(chengcode){
				if(chengcode == ""){
					return;
				}
				for(var i=0;i<=5;i++){
					for(var j = i+1;j<=5;j++){
						if($("#chengcode" + i) != undefined && $("#chengcode" + i).val() != undefined 
							&& $("#chengcode" + j) != undefined && $("#chengcode" + j).val() != undefined){
							if($("#chengcode" + i).val() == $("#chengcode" + j).val()){
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
			    	url: "<%=basePath%>chengAction!checkChengCode.shtml?chengcode=" + chengcode,
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
				<form action="chengAction!saveCheng.shtml" method="post" id="searchform" name="searchform">
					<s:token></s:token>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
					  <td height="30">
							商户名称：${requestScope.cpcname }
							<input type="hidden" value="${requestScope.cpccorp }" name="cpccorp">
							<input type="hidden" value="${requestScope.cpcname }" name="cpcname">
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
								<input type="text" name="chengList[0].chengcode" id="chengcode0" 
								
								onblur="onkeyCheck(this.value);"  AUTOCOMPLETE="OFF" size="32" maxlength="32" class="inp">
								<span class="red">*</span>
								
								<span name="s_med0" class="red"></span> 溯源秤规格&nbsp;
								<select name="chengList[0].confid" width="172px">
									<c:forEach items="${requestScope.chengconfmap}" var="chengMap" varStatus="s">
								 		<option value="${chengMap.key}">${chengMap.value}</option>;
									</c:forEach>
								</select>
								
								<span class="red">*</span>
								<span name="s_weight0" class="red"></span>
							</div>
						</div>
					</div>
					<div class="fb-bom">
						<cite>
							<input type="button" id="next" name="next" onclick="checkIsNull()"  value="保存" class="sbt">
						</cite>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
