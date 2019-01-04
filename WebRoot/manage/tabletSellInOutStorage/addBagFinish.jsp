<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>饮片包装</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<div id="body">
	<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
	<div class="cur-pos">当前位置：饮片生产管理 > 饮片包装</div>
	<div class="form-box">
    	<form action="" method="post" id="searchform" name="searchform">
    	<input type="hidden" name="filename" id="filename" value="" />
		<input type="hidden" name="filenametime" id="filenametime" value="" />
		<input type="hidden" name="cpccode" id="cpccode" value="${requestScope.returninfo }" />
				
				
    	<c:if test="${requestScope.returninfo==null||requestScope.returninfo==''}">
    		<div class="fb-tit">操作失败</div>
	        <div class="fb-con">
	        	<div class="fb-msg">
	            <img src="/images/frame/err.png">
	            <b class="green">没有获取到要包装的数据</b>     
	    	</div>
    	</c:if>
    	
    	<c:if test="${requestScope.returninfo!=null&&requestScope.returninfo!=''}">
    	
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/dui.png">
            <b class="green">${requestScope.returninfo }</b>   
            
							  
    	</div>
    	
    	
    	</c:if>
    	
    	
    	<div class="fb-bom">
    		<cite><input type="button" value="继续饮片包装" class="sbt" onclick="gotoMedOut();"></cite>
<%--    		<input type="button" value="查询入库记录" class="sbt" onclick="gotoOutData();">--%>
    	</div>
    	
        </form>
    </div>
</div>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" src="/js/comtools.js"></script>


<script type="text/javascript">
	var zyczstype="${sessionScope.User.org.zyctype}";
	
	function gotoMedOut(){
		$("#searchform").attr("action", "<%=basePath%>manage/tabletSellInOutStorage/findBagCode.jsp");
		$("#searchform").submit();
	}
	
	//下载数据
		function downloadData_createFile(){
    		var url="<%=request.getContextPath()%>/printCodeAjax!createTabletFile_packCode.shtml?rid="+Math.random();
    		var cpccode=$("#cpccode").val();
    		
    		$.getJSON(url,{'cpccode':cpccode}, function(data) {
	    		var loginForm = data;
		    	var filename = loginForm.model.filename;
		    	var filenametime = loginForm.model.filenametime;
		    	var cpccode = loginForm.model.cpccode;

				var str="";
		    	
		    	if(filename!=""&&filenametime!=""&&cpccode!=""){
			    	str="<div>生成数据成功请点击下载按钮保存文件，</div><div>下载后,该下载功能将为您再保留三天时间,可重新下载!</div>"
		    		str+="<div><input type=\"button\" value=\"下载溯源码印刷文件\"  id=\"down\" onclick=\"downloadData_downFile();\"/></div>"
		    		$("#filename").val(filename);
			    	$("#filenametime").val(filenametime);
		    	}else{
		    		str="<div>生成数据失败</div>"
		    	}
		    	
				$.dialog({
					title:'离线印刷',
					id:'checkRepo',
					lock:true,
					content: str,
					cancelVal: '关闭',
					cancel: true
				});
		    	
			});
	    }
	    function downloadData_downFile(){
	    	$("#searchform").attr("target","_self");
	    	$("#searchform").attr("action", "printCode!getTabletFile.shtml");
	    	$("#searchform").submit();
	    }
	    
	    function printcode(){
	    	try{
				var k = neowerPrinter.printNew("*CPC*ZYCZS${requestScope.returninfo}\n溯源码:${requestScope.returninfo}\n\n","${initParam.printmachine }",3);
			}catch(e){
				var str="";
				str+="<div>您尚未安装打印控件，请根据系统情况下载相应控件!<br />请安装后重新登录平台!</div><br />";
				str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载32位控件' onclick='printData_downControl(32);' />  ";
				//str+="<input type='button' style='border:1px solid #C1C1C1;width:100px;height:20px;cursor:hand;' value='下载64位控件' onclick='printData_downControl(64);' />  ";
				$.dialog({
					title:'下载控件',
					id:'checkRepo',
					lock:true,
					content: str,
					cancelVal: '关闭',
					cancel: true
				});
				return false;
			}
		}
		function printData_downControl(num){
			if(num==32){
				window.location.href="js/setup32.exe"
			}else{
				window.location.href="js/setup64.exe"
			}
		}
</script>

</body>
</html>
