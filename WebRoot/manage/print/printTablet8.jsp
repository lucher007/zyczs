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
<title>打印</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body class="form-box" style="width:auto; border:0; padding:0;">
	<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
  	<form action="" method="post" name="searchform" id="searchform">
  	<input type="hidden" name="singledouble" id="singledouble" value="singlecode" />
	<div class="fb-con" style="width:auto; padding:0;">
        <div class="fbc-box">
            <div class="fbc-tit b f14">&nbsp;打印信息</div>
		</div>
      <div class="fbc-box mt5">
            <div class="fbc-tit b f14">&nbsp;打印操作</div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr class="fb-list b" align="center">
                <td height="30" bgcolor="#F3F3F3"  bgcolor="#F3F3F3" width="250">溯源码</td>
                <td bgcolor="#F3F3F3" width="120">厂家名称</td>
                <td bgcolor="#F3F3F3" width="120">打印时间</td>
                <td bgcolor="#F3F3F3" width="120">操作</td>
              </tr>
              <tr>
                <td colspan="4" style="padding:0;">
                	<div style="height:241px; overflow-y:scroll; overflow-x:hidden; text-align:center">
                	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="content">
                		<c:forEach items="${boxlist}" var="box">
                			<tr class="fb-list" id="tr${box.boxcode}">
                				<td width="250">${box.boxcode }</td>
                				<td width="120">${User.org.orgshortname}</td>
                				<td width="120">${fn:substring(box.addtime,0,11)}</td>
                				<td width="120" id="td${box.boxcode}">未打印</td>
                			</tr>
                		</c:forEach>
              		</table>
                    </div>
                  </td>
                </tr>
            </table>
            <div class="fbc-bom">
                <cite>打印类型：<b class="red">二维码打印</b> 总打印包数：<b class="red" id="number">0</b></cite>
                <input type="button" value="开始打印" class="sbt" id="start" onclick="return startprint();">
                <input type="button" value="暂停打印" class="sbt" id="stop" onclick="return stopprint();">
                <input type="button" value="打印测试" class="sbt" onclick="printcodetest()">
                
                <label id="returninfo" name="returninfo" style="color:red;font:bold 14px arial;">&nbsp;${requestScope.returninfo }</label>
                
            </div>
        </div>
        <div style="line-height:20px; padding:10px;">
        <table style="color:#666;" cellpadding="0" cellspacing="0">        	
			<tr><td style="color:#000;">操作说明：</td><td>1.安装控件(<a href="javascript:void(0);" onclick="printData_downControl(32);">下载(32位)</a>)并连接;</td></tr>
			<tr><td>&nbsp;</td><td>2.将已连接的条码打印机设置为默认打印机，并点击测试打印按钮进行测试，如打印成功，点击开始按钮;</td></tr>
			<tr><td>&nbsp;</td><td>3.采用分页打印技术，当前加载部份数据，系统会根据内容自动分页打印;</td></tr>
			<tr><td>&nbsp;</td><td>4.打印过程中，保证网络畅通，请勿关闭浏览器，如需暂停，请点击暂停按钮;</td></tr>
			<tr><td>&nbsp;</td><td>5.如数据加载太久，或分页打印时等待时间过长（超过5分钟）请关闭该页面重新打印;</td></tr>
         </table>
        </div>
    </div>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" language="javascript">
	var timeid;
	var i=0;
	var printtype=4;//打印 1为打第一个，2为第二个，3为第三个，4为全部
	function btnstart(){
		$("#start").attr("disabled","disabled");
		$("#stop").removeAttr("disabled");
		$("#singledouble").attr("disabled","disabled");
	}
	
	function btnstop(){
		$("#start").removeAttr("disabled");
		$("#stop").attr("disabled","disabled");
		$("#singledouble").removeAttr("disabled");
	}

	function btnall_disable(){
		$("#start").attr("disabled","disabled");
		$("#stop").attr("disabled","disabled");
	}

	function stopprint(){
		clearInterval(timeid);
		btnstop();
	}

	function startprint(){
	   	btnstart();
		timeid=setInterval(function(){printsource();},200);
	}
	
	var k;
	function printsource(){
		if(i >= $("#content tr").length){
			clearInterval(timeid);
			$("#returninfo").html("全部打印完成，请关闭");
			btnall_disable();
			var str="<div style='width:240px;height:30px;' id='abc'>全部打印完成，请点击确定按钮退出!</div>";
			$.dialog({
				title:"打印完毕",
				id:'checkRepo',
				lock:true,
				content: str,
				okVal:'确定',
				ok:function(){
					
				}
			});
		}else{
			var printtemp="*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(0).html()+"\n"+$("#content tr").eq(i).find("td").eq(0).html()+"\n\n\n\n厂商名称:"+$("#content tr").eq(i).find("td").eq(1).html()+"\n包装日期:"+$("#content tr").eq(i).find("td").eq(2).html();
			changecolor($("#content tr").eq(i).find("td").eq(0).html());
			i++;
			var boxcode = $("#content tr").eq(i).find("td").eq(0).html();
			if(boxcode==undefined){
				printsourceboxitem(printtemp,1);
				return;
			}else{
				printtemp+="|"+"*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(0).html()+"\n"+$("#content tr").eq(i).find("td").eq(0).html()+"\n\n\n\n厂商名称:"+$("#content tr").eq(i).find("td").eq(1).html()+"\n包装日期:"+$("#content tr").eq(i).find("td").eq(2).html();
				changecolor($("#content tr").eq(i).find("td").eq(0).html());
			}
			i++;
			boxcode = $("#content tr").eq(i).find("td").eq(0).html();
			if(boxcode==undefined){
    			printsourceboxitem(printtemp,2);
    			return;
    		}else{
    			printtemp+="|"+"*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(0).html()+"\n"+$("#content tr").eq(i).find("td").eq(0).html()+"\n\n\n\n厂商名称:"+$("#content tr").eq(i).find("td").eq(1).html()+"\n包装日期:"+$("#content tr").eq(i).find("td").eq(2).html();
    			changecolor($("#content tr").eq(i).find("td").eq(0).html());
    			printsourceboxitem(printtemp,4);
    		}
    		i++;
    		
		}
	}
	
	
	function changecolor(source){
		//alert(source);
		$("#number").html(parseInt($("#number").html())+1);
		$("#tr"+source).css("background","#3FBCEF");				
		$("#td"+source).html("已打印");
	}
	
	//打印
	function printcode(printtemp,printtype){
		//return 1;
		return neowerPrinter.printNew3(printtemp,"${initParam.printmachine }",printtype);
	}
	
	function printcodetest(){
		var k = neowerPrinter.printNew3("1234567890123456789012345678\n1234567890123456789012345678\n\n\n\n生产厂商:成都新荷花\n生产日期:2013年11月29日\n|1234567890123456789012345678\n1234567890123456789012345678\n\n\n\n生产厂商:成都新荷花\n生产日期:2013年11月29日\n|1234567890123456789012345678\n1234567890123456789012345678\n\n\n\n生产厂商:成都新荷花\n生产日期:2013年11月29日\n\n","POSTEK G2000",4);
	}

	function printData_downControl(num){
		if(num==32){
			window.location.href="<%=basePath%>js/setup32.exe"
		}else{
			window.location.href="<%=basePath%>js/setup64.exe"
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
		var k = neowerPrinter.printNew3(boxitemtemp,"${initParam.printmachine }",4);
		if(k == 0){
    		clearInterval(timeid);
			$("#returninfo").html("打印出错,请关闭重试");
			btnall_disable();
			return;
    	}
	}
	    
	    
</script>
