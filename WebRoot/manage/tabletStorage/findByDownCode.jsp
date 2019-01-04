<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>饮片基础列表</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body>
	<div id="body">
	 	<div class="cur-pos">
			当前位置：饮片生产管理 > 大包装打码
		</div>
		<div class="seh-box">
			<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
			
			<form action="" method="post" id="searchform" name="myform">
			
			<input type="hidden" name="filename" id="filename" value="" />
			<input type="hidden" name="filenametime" id="filenametime" value="" />
			<input type="hidden" name="pname" id="pname" value="" />
			<input type="hidden" name="cpccode" id="cpccode" value="" />
			<input type="hidden" id="downCount" value="0">

		
	    	请输入饮片品名：<input maxlength="20" type="text"  name="tabletname" id="tabletname" value="${requestScope.tabletname}"  class="inp" size="45"> 
	    	&nbsp;&nbsp;
	    	<input type="button" value="查询" class="sch" onclick="return checkForm();"> 
	    	</form>
    	</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						饮片品名
					</td>
					
					<td>
						饮片编码
					</td>
					<td>
						操作
					</td>
				</tr>
				<c:forEach items="${requestScope.tabletStoragelist}" var="list">
					<tr class="lb-list">
						<td height="30">
							${list.tabletname }&nbsp;
						</td>
						<td>
							${list.prodcode}&nbsp;
						</td>
						
						<td>

							<a href="javascript:void(0);"  onclick="downloadData_createFile('${list.tabletname }','${list.prodcode}',1);" class="btn-print" style="display:">离线印刷</a>
							<a href="javascript:void(0);" id="" onclick="downloadData_createFile('${list.tabletname }','${list.prodcode}',2);" class="btn-net">在线打印</a>
			
						</td>
									
					</tr>
				</c:forEach>
			</table>
			
			<div class="page">
				<cite>
				<pg:pager url="tabletStorage!findByDownCode.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="mcontent" value="${requestScope.mcontent }" />
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
							<a href="<%=pageUrl%>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
							<a href="<%=prevPageUrl%>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
							<%
								if (pageNumber == currentPageNumber) {
							%><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a>
							<%
								} else {
							%><a href="<%=pageUrl%>"><%=pageNumber%></a>
							<%
								}
							%>
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
							<a href="<%=nextPageUrl%>" title="下一页" class="next">&nbsp;</a>
						</pg:next>
						<pg:last>
							<a href="<%=pageUrl%>">末页</a>
						</pg:last>
					</pg:index>
				</pg:pager>
				</cite>
			</div>
		</div>
	</div>	
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/comtools.js"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#mcontent").val($.trim($("#mcontent").val()));
			if(checkquotmarks($("#mcontent").val())){
				$("#mcontent").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletStorage!findByDownCode.shtml");
			$("#searchform").submit();
		}
		
		//下载数据
		function downloadData_createFile(pname,cpccode,type){	
			$("#cpccode").val(cpccode);
			$("#pname").val(pname);
    		t2=$.dialog({
    			title:pname,
			    lock: true,
			    content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="300" height="120"  src="<%=basePath%>manage/tabletStorage/inputCodeCount.jsp?type='+type+'&ischoice='+Math.random()+'"></iframe>',
			    min:false,
				max:false
			});
	    }
	    
		
	    function closeDG(s){
			$("#downCount").val(s[0]);
			var type=s[1];
			t2.close();
			if(type=="1"){
				downloadData_createFile2();
			}else{
				printcode();
			}
			
		}
	    
	    function downloadData_createFile2(){
	    	var url="<%=request.getContextPath()%>/printCodeAjax!createTabletFile_packCode.shtml?rid="+Math.random();
    		
	    	var downCount=$("#downCount").val();
	    	var cpccode=$("#cpccode").val();
	    	
	    	$.getJSON(url,{'downCount':downCount,'cpccode':cpccode}, function(data) {
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
	    		var url="<%=request.getContextPath()%>/printCodeAjax!createTabletFile_packCodeList.shtml?rid="+Math.random();	
		    	var downCount=$("#downCount").val();
		    	var cpccode=$("#cpccode").val();	
		    	var pname=$("#pname").val();
		    	$.getJSON(url,{'downCount':downCount,'cpccode':cpccode}, function(data) {
		    		var loginForm = data;
			    	var cpccode = loginForm.model.cpccode;
					var codes=cpccode.split(",");
					var printtype=2;
			    	for(var i=0;i<codes.length;i++){
			    		var printtemp = "*CPC*ZYCZS"+codes[i]+"\n溯源码:"+codes[i]+"\n品 名:"+pname+"\n";
			    		i++;
			    		//alert(codes[i]);
			    		if(codes[i]==undefined){
			    			printtemp+="|"+printtemp+"\n\n";
			    			printtype=1;
			    		}else{
			    			printtemp+="|"+"*CPC*ZYCZS"+codes[i]+"\n溯源码:"+codes[i]+"\n品 名:"+pname+"\n\n";
			    			printtype=3;
			    		}
			    		//alert(printtemp+"===="+printtype);
			    		var k = neowerPrinter.printNew(printtemp,"${initParam.printmachine }",printtype);
			    		if(k == 0){
			    			return;
			    		}
			    	}
					
			    	
				});
				
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
	    
	    function onkeyupNum2(obj){
	    	alert(obj);
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字
					
			if(obj.value == 'undefined')
				obj.value='';
			if(obj.value!='')
			{
				//obj.value=addtr(obj.value,0);
			}
			//大于0
			if(obj.value<1&&obj.value.length==1) {
				obj.value = "";
			}	
		}
	    
	</script>	
	
	</body>
</html>
