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
  	<input type="hidden" name="storageid" id="storageid" value="${requestScope.tabletstorage.tabletstorid }" />
  	<input type="hidden" name="province" id="province" value="${requestScope.tabletstorage.province }" />
  	<input type="hidden" name="city" id="city" value="${requestScope.tabletstorage.city }" />
  	<input type="hidden" name="tabletnumber" id="tabletnumber" value="${requestScope.tablet.tabletnumber }" />
  	<input type="hidden" name="orgshortname" id="orgshortname" value="${sessionScope.User.org.orgshortname }" />
  	<input type="hidden" name="createtime" id="createtime" value="${fn:replace(fn:substring(requestScope.tablet.createtime, 0, 10),'-','.')}" />
  	<input type="hidden" name="tabletboxitemnum" id="tabletboxitemnum" value="${requestScope.tabletstorage.tabletboxitemnum}" />
  	<input type="hidden" name="codeareashortname" id="codeareashortname" value="${requestScope.codeareashortname }" />
	<div class="fb-con" style="width:auto; padding:0;">
        <div class="fbc-box">
            <div class="fbc-tit b f14">&nbsp;打印信息</div>
            <table width="100%">
              <tr>
                <td align="right" height="30" bgcolor="#EEEEEE" width="120">品名：</td><td>${requestScope.tabletstorage.tabletname }<input type="hidden" name="name" id="name" value="${requestScope.tabletstorage.tabletname }" /></td>
                <td bgcolor="#EEEEEE" align="right" width="150">批次号：</td><td>${requestScope.tabletstorage.cpctablet }<input type="hidden" name="cpc" id="cpc" value="${requestScope.tabletstorage.cpctablet }" /></td>
                <td bgcolor="#EEEEEE" align="right" width="80">入库时间：</td><td>${fn:substring(requestScope.tabletstorage.addtime, 0, 11)}</td>
              </tr>
              <tr>
                <td align="right" height="30" bgcolor="#EEEEEE">重量（g）：</td><td>${requestScope.tabletstorage.tabletweight/10 }</td>
                <td bgcolor="#EEEEEE" align="right">包装规格(g/每包)：</td><td>${requestScope.tabletstorage.tabletnumweight/10 }<input type="hidden" name="weight" id="weight" value="${requestScope.tabletstorage.tabletnumweight/10 }" /></td>
                <td bgcolor="#EEEEEE" align="right">包数：</td><td>${requestScope.tabletstorage.tabletnum }</td>
              </tr>
            </table>
		</div>
      <div class="fbc-box mt5">
            <div class="fbc-tit b f14">&nbsp;打印操作</div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr class="fb-list b" align="center">
                <td height="30" bgcolor="#F3F3F3" width="150">品名</td>
                <td bgcolor="#F3F3F3" width="90">类型</td>
                <td bgcolor="#F3F3F3" width="250">批次</td>
                <td bgcolor="#F3F3F3" width="250">溯源码</td>
                <td bgcolor="#F3F3F3" width="80">状态</td>
              </tr>
              <tr>
                <td colspan="6" style="padding:0;">
                	<div style="height:241px; overflow-y:scroll; overflow-x:hidden; text-align:center">
                	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="content">
              		</table>
                    </div>
                  </td>
                </tr>
            </table>
            <div class="fbc-bom">
                <cite>打印类型：<b class="red">二维码打印</b> 总打印包数：<b class="red" id="number">0</b></cite>
                <input type="button" value="开始打印" class="sbt" id="start" onclick="return startprint();">
                <input type="button" value="暂停打印" class="sbt" id="stop" onclick="return stopprint();">
                <input type="button" value="打印测试" class="sbt" onclick="printcodetest();">
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
	var i;
	var printtype=4;//打印 1为打第一个，2为第二个，3为第三个，4为全部
	var printtypedata;//打印是否三列
	function btnstart(){
		$("#start").attr("disabled","disabled");
		$("#stop").removeAttr("disabled");
	}
	
	function btnstop(){		
		$("#start").removeAttr("disabled");
		$("#stop").attr("disabled","disabled");
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
		var storageid= $("#storageid");	
		if(storageid.val()==""||storageid.val()==" "||storageid.val()==null||storageid.val()==0){
			$("#returninfo").html("获取库存ID失败，请关闭重试！");
			return false;
		}	
		timeid=setInterval(function(){printsource(1);},200);
	}
	//请求数据
	function findByBoxItem(){
		i=0;
		var method = "${sessionScope.User.orgid} "+$("#storageid").val()+" 102";
		var boxitemlisttemp=neowerPrinter.GetNumber(method);
		if(boxitemlisttemp!=""&&boxitemlisttemp.length!=0&&boxitemlisttemp.length>1){
			var boxitemlist = boxitemlisttemp.split("|");
			$("#content tr").remove();
			for(var j=0;j<boxitemlist.length;j++){
				var boxitem = boxitemlist[j].split(",");
				var boxtype=boxitem[1]=='1'?"中包":"小包";
				var str="";
				str+="<tr class=\"fb-list\" id=\"tr"+boxitem[0]+"\">";
				str+="<td height=\"30\" width=\"150\">"+$("#name").val()+"</td>";
				str+="<td width=\"90\">"+boxtype+"</td>";
				str+="<td width=\"250\">"+$("#cpc").val()+"</td>";
				str+="<td width=\"250\">"+boxitem[0]+"</td>";
				str+="<td width=\"80\" id=\"td"+boxitem[0]+"\">未打印</td>";
				str+="</tr>";
				$("#content").append(str);
			}
			printtypedata = $("#content tr").length%3;
			timeid=setInterval(function(){printsource(1);},200);
			printsource(1);
		}else{
			$("#returninfo").html("全部打印完成，请关闭");
			updateObject();
			btnall_disable();
		}
	}
	function printsource(type){
		if(i<$("#content tr").length){
			if(type==1){
				var num=0;
				var boxitemtemp="";
				var boxtype = $("#content tr").eq(i).find("td").eq(1).html();
				if(boxtype==undefined){
					return;
				}
				if(boxtype=="中包"){
					printsourcebox($("#content tr").eq(i).find("td").eq(3).html());
					return;
				}else{
					boxitemtemp+="*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#name").val()+" "+$("#weight").val()+"g\n"+$("#codeareashortname").val()+"\n"+$("#createtime").val()+"\n批号:"+$("#tabletnumber").val()+"\n厂家:"+$("#orgshortname").val()+"\n|";
					changecolor($("#content tr").eq(i).find("td").eq(3).html());
				}

				i++;
				var boxtype = $("#content tr").eq(i).find("td").eq(1).html();
				if(boxtype==undefined){
					printsourceboxitem(boxitemtemp,1);
					return;
				}
				if(boxtype=="中包"){
					printsourceboxitem(boxitemtemp,1);
					printsourcebox($("#content tr").eq(i).find("td").eq(3).html());
					return;
				}else{
					boxitemtemp+="*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#name").val()+" "+$("#weight").val()+"g\n"+$("#codeareashortname").val()+"\n"+$("#createtime").val()+"\n批号:"+$("#tabletnumber").val()+"\n厂家:"+$("#orgshortname").val()+"\n|";
					changecolor($("#content tr").eq(i).find("td").eq(3).html());
				}

				i++;
				var boxtype = $("#content tr").eq(i).find("td").eq(1).html();
				if(boxtype==undefined){
					printsourceboxitem(boxitemtemp,2);
					return;
				}
				if(boxtype=="中包"){
					printsourceboxitem(boxitemtemp,2);
					printsourcebox($("#content tr").eq(i).find("td").eq(3).html());
					return;
				}else{
					boxitemtemp+="*CPC*ZYCZS"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#content tr").eq(i).find("td").eq(3).html()+"\n"+$("#name").val()+" "+$("#weight").val()+"g\n"+$("#codeareashortname").val()+"\n"+$("#createtime").val()+"\n批号:"+$("#tabletnumber").val()+"\n厂家:"+$("#orgshortname").val()+"\n\n";
					changecolor($("#content tr").eq(i).find("td").eq(3).html());
				}

				i++;
				var boxtype = $("#content tr").eq(i).find("td").eq(1).html();
				if(boxtype==undefined){
					printsourceboxitem(boxitemtemp,3);
					return;
				}
				if(boxtype=="中包"){
					printsourceboxitem(boxitemtemp,3);
					printsourcebox($("#content tr").eq(i).find("td").eq(3).html());
					return;
				}else{
					printsourceboxitem(boxitemtemp,3);
				}
			}else if(type==2){
				//WriteRFID(itemArray[i][0],itemArray[i][1]);
			}
			
		}else{
			clearInterval(timeid);
			findByBoxItem();
		}						
	}

	function printsourcebox(source){
		var boxtemp="*CPC*ZYCZS"+source+"\n"+source+"\n"+$("#name").val()+"\n"+$("#weight").val()+"g\*"+$("#tabletboxitemnum").val()+"包\n"+$("#codeareashortname").val()+"\n"+$("#createtime").val()+"\n批号:"+$("#tabletnumber").val()+"\n厂家:"+$("#orgshortname").val();
		boxtemp+="\n|"+boxtemp+"\n|"+boxtemp+"\n\n";
		var k=printcode(boxtemp,2);
		if(k==1){
			$("#number").html(parseInt($("#number").html())+1);		
			$("#tr"+source).css("background","#3FBCEF");				
			$("#td"+source).html("已打印");
		}else{
			$("#returninfo").html("打印失败，请退出重新打印!");
			btnstop();
			clearInterval(timeid);
		}
		i++;	
		return;
	}

	function printsourceboxitem(source,num){
		var boxitemtemp="";
		if(num==1){
			boxitemtemp=source+"\n\n|\n\n";
		}else if(num==2){
			boxitemtemp=source+"\n\n";
		}else if(num==3){
			boxitemtemp=source;
		}
		var k=printcode(boxitemtemp,4);
		if(k==1){
			
		}else{
			$("#returninfo").html("打印失败，请退出重新打印!");
			btnstop();
			clearInterval(timeid);
		}
	}

	function changecolor(source){
		$("#number").html(parseInt($("#number").html())+1);
		$("#tr"+source).css("background","#3FBCEF");				
		$("#td"+source).html("已打印");
	}
	
	//打印
	function printcode(printtemp,printtype){
		//alert(printtemp+"\n=="+printtype);
		//return 1;
		return neowerPrinter.printNew3(printtemp,"${initParam.printmachine }",printtype);
	}
	function printcodetest(){
		var k = neowerPrinter.printNew3("*CPC*ZYCZS12345678901234567890123456789011111\n82345678908234567890123456789022111\n三七 20g*2袋\n云南文山市\n2012.09.18\n批号:887966530187G\n中药材有限公司\n|*CPC*ZYCZS12345678901234567890123456789011111\n82345678908234567890123456789022111\n三七 20g\n云南文山市\n2012.09.18\n批号:887966530187G\n中药材有限公司\n|*CPC*ZYCZS12345678901234567890123456789011111\n82345678908234567890123456789022111\n三七 20g\n云南文山市\n2012.09.18\n批号:887966530187G\n中药材有限公司\n\n","${initParam.printmachine }",4)
	}

	//更新库存
	function updateObject(){
		var url="<%=request.getContextPath()%>/printCodeAjax!updateObject_tablet.shtml?rid="+Math.random();
		$.getJSON(url,{'storageid':$("#storageid").val()}, function(data) {
			var str="<div style='width:240px;height:30px;' id='abc'>全部打印完成，请点击确定按钮退出!</div>";
			$.dialog({
				title:"打印完毕",
				id:'checkRepo',
				lock:true,
				content: str,
				okVal:'确定',
				ok:function(){
					$("#MainFrame",parent.document).attr("src","${requestScope.url }"+"?rid="+Math.random());
					$("#ldg_lockmask",parent.document).remove();
					$(".ui_border",parent.document).parents("div").remove();
				}
			});
			
			var userAgent = window.navigator.userAgent.toLowerCase();
			var msie10 = $.browser.msie && /msie 10\.0/i.test(userAgent);
			if(msie10==true){
				$("#abc").parents("div[class='ui_inner']").css("margin-left","-10px");
				$("#abc").parents("table").find("td[class='ui_lt']").css("background-position-x","10px");
				$("#abc").parents("table").find("td[class='ui_l']").css("background-position-x","10px");
				$("#abc").parents("table").find("td[class='ui_lb']").css("background-position-x","10px");
			}
			
		});
	}
	function printData_downControl(num){
		if(num==32){
			window.location.href="<%=basePath%>js/setup32.exe"
		}else{
			window.location.href="<%=basePath%>js/setup64.exe"
		}
	}
</script>