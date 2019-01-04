<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：设备管理 > 设备规格配置</div>
		<form action="" method="post" id="searchform" name="searchform">
		<input type="hidden" name="confid" id="confid" value="${requestScope.deviceconf.confid }"/>
	    <div class="form-box">
    		<div class="fb-tit">设备规格修改</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		            <tr >
		            <td height="30" align="right" >厂商名称：</td>
		            <td >
		            	<input type="text" class="inp" size="39" name="companyname" id="companyname" maxlength="10" value="${requestScope.deviceconf.companyname }">
		            </td>
		          </tr>
		          <tr >
		            <td height="30" align="right">规格型号：</td>
		            <td>
		            	<input type="text" class="inp" size="39" name="normname" id="normname" maxlength="20" value="${requestScope.deviceconf.normname }">
		            </td>
		          </tr>
		          <tr>
		            <td height="30"  align="right"> 设备类型：</td>
		            <td>
		            	<select id="conftype" name="conftype" class="w100" >
	                   		<option value="1" <c:if test="${requestScope.deviceconf.conftype == 1 }">selected</c:if>>打印机</option>
	                   		<option value="2" <c:if test="${requestScope.deviceconf.conftype == 2 }">selected</c:if>>扫描设备</option>
	                   		<option value="3" <c:if test="${requestScope.deviceconf.conftype == 3 }">selected</c:if>>移动终端</option>
	                   		<option value="4" <c:if test="${requestScope.deviceconf.conftype == 4 }">selected</c:if>>IC卡</option>
	                   		<option value="5" <c:if test="${requestScope.deviceconf.conftype == 5 }">selected</c:if>>查询机</option>
	                   		<option value="6" <c:if test="${requestScope.deviceconf.conftype == 6 }">selected</c:if>>耗材</option>
	                   		<option value="7" <c:if test="${requestScope.deviceconf.conftype == 7 }">selected</c:if>>计算机</option>
	                   		<option value="8" <c:if test="${requestScope.deviceconf.conftype == 8 }">selected</c:if>>读写卡器</option>
	                   		<option value="9" <c:if test="${requestScope.deviceconf.conftype == 9 }">selected</c:if>>其他设备</option>
	                   	 </select>
		            </td>
		            <td></td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
		        <cite><input type="button" value="保存" class="sbt" onclick="updateDeviceConf();" id="btnfinish"></cite>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	//验证查询框不能输入以下字符
	function checkChars(str){
		return /[\·\'\"\~\`\!\@\#\$\%\^\&\*\|\(\)\{\}\[\]\+\=\;\:\?\<\>\,\.\/\\]/.test(str);
	}
	
	function updateDeviceConf(){
	    $("#companyname").val($.trim($("#companyname").val()));
		if($("#companyname") != undefined && $("#companyname").val() == ""){
			$.dialog.tips("厂商名称必须填写！",1,'alert.gif');
			$("#companyname").focus();
			return false;
		}
		
		if(checkChars($("#companyname").val())){
			$("#companyname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			$("#companyname").focus();
			return false;
	    }
		
		$("#normname").val($.trim($("#normname").val()));
		if($("#normname") != undefined && $("#normname").val() == ""){
			$.dialog.tips("规格型号必须填写！",1,'alert.gif');
			$("#normname").focus();
			return false;
		}
		
		if(checkChars($("#normname").val())){
			$("#normname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			$("#normname").focus();
			return false;
	    }
		
		$("#searchform").attr("action", "<%=basePath%>deviceConf!update.shtml");
		$("#searchform").submit();
	}
</script>   
</body>
</html>
