<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
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

<link type="text/css" rel="stylesheet" href="/style/plant.css">
<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body>
	<div id="body">
	 	<div class="cur-pos">
			当前位置：饮片生产管理 > 大包装打码
		</div>
		
		<div class="form-box">
    	<div class="fb-tit"><b class="red f12">提示：输入溯源码数量后、选择离线印刷或者在线打印</b></div>
    	<form action="" method="post" id="searchform" name="searchform">
    	<input type="hidden" name="filename" id="filename" value="" />
			<input type="hidden" name="filenametime" id="filenametime" value="" />
			<input type="hidden" name="pname" id="pname" value="" />
			<input type="hidden" name="cpccode" id="cpccode" value="" />
        <div class="fb-con">
        	<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
			
			
			
			


		<br/>
	    	&nbsp;&nbsp;请输入溯源码数量：<input maxlength="5" type="text"  name="downCount" id="downCount"  class="inp" size="6" onkeyup="onkeyupNum2(this);" onkeypress="onkeyupNum2(this);"  onblur="onkeyupNum2(this);"> 
	    	&nbsp;&nbsp;
	    	<a href="javascript:void(0);"  onclick="downloadData_createFile();" class="btn-print" style="display:">离线印刷</a>
			<a href="javascript:void(0);" id="" onclick="printcode();" class="btn-net">在线打印</a> 
	    	
           <br/>  
           <br/>    
        </div>
        </form>
    </div>
    
		
		
			
			
	</div>	
	
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/js/frame.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	
	

		function onkeyupNum2(obj){    	
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
		
		  
	    
	    function downloadData_createFile(){
	    	var downCount=$.trim($("#downCount").val());
	    	if(downCount==""){
	    		alert("请输入溯源码数量!");
	    		return;
	    	}
	    	if(downCount > 2000){
	    			alert("溯源码数量应该小于2000!");
		    		return;
	    		}
	    		
	    	var url="<%=request.getContextPath()%>/printCodeAjax!createTabletFile_packCode_8.shtml?rid="+Math.random(); 		
	    	
	    	$.getJSON(url,{'downCount':downCount}, function(data) {
	    		var loginForm = data;
		    	var filename = loginForm.model.filename;
		    	var filenametime = loginForm.model.filenametime;
		    	//var cpccode = loginForm.model.cpccode;
				var str="";
		    	if(filename!=""&&filenametime!=""){
			    	str="<div>生成数据成功请点击下载按钮保存文件，</div><div>下载后,该下载功能将为您再保留三天时间,可重新下载!</div>"
		    		str+="<div><input type=\"button\" value=\"下载溯源码印刷文件\"  id=\"down\" /></div>"
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
	    		var today=new Date(); 
	    		var d =today.getFullYear();    
				var y =today.getMonth()+1;  
				var tian =today.getDate();
				var time = d+"年"+y+"月"+tian+"日";
				
	    		var downCount=$.trim($("#downCount").val());
		    	if(downCount==""){
		    		alert("请输入溯源码数量!");
		    		return;
	    		}
	    		
	    		if(downCount > 2000){
	    			alert("溯源码数量应该小于2000!");
		    		return;
	    		}
	    		
	    		$.dialog({
					title:'标签选择',
					id:'towOrThree',
					lock:true,
					content: '请选择打印的标签类型 <br /><img src=\"<%=basePath%>images/printtagstyle.png\" width=\"490"\ height=\"360\" />',
					button: [
				        {
				            name: '打印三列',
				            callback: function(){
				            		//$("#searchform").attr("action","printCode!createTabletFile_packCodeList_8.shtml?printcol=3");
				            		//$("#searchform").submit();
				            		printData_print(3,downCount);
				            		return false;
				            },
				            focus: true
				        },
				        {
				            name: '打印二列',
				            callback: function(){
				            	//$("#searchform").attr("action","printCode!createTabletFile_packCodeList_8.shtml?printcol=2");
				            	//$("#searchform").submit();
				            	printData_print(2,downCount);
				            	return false;
				            }
				        }
				    ]
				});
	    	}	
	    		
	    		
	    		
	    function printData_downControl(num){
			if(num==32){
				window.location.href="js/setup32.exe"
			}else{
				window.location.href="js/setup64.exe"
			}
		}
	    
	    function printsourceboxitem(source,num){
			var boxitemtemp="";
			if(num==1){
				boxitemtemp=source+"\n\n|\n\n";
			}else if(num==2){
				boxitemtemp=source+"\n\n";
			}else if(num==4){
				boxitemtemp=source;
			}
			var k=print(boxitemtemp,4);
		}
	    
	    //打印
		function print(printtemp,printtype){
			//alert(printtemp+"\n=="+printtype);
			//return 1;
			return neowerPrinter.printNew3(printtemp,"${initParam.printmachine }",printtype);
		}
	    
	    
	    function printData_print(printcol,downCount){
	    	$.dialog({
				title:'在线打印',
				id:'tabletChos',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="800" height="580" src="<%=basePath%>printCode!createTabletFile_packCodeList_8.shtml?ischoice='+Math.random()+'&printcol='+printcol+'&downCount='+downCount+'"></iframe>',
				close:function(){
					 window.location.reload(); 
				}
			});	
		}
	</script>	
	
	</body>
</html>
