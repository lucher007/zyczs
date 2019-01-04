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
		<title>待打印药材列表</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<object classid="clsid:0880401B-3338-475F-BB19-8897E2B40A10" name="neowerPrinter" id="neowerPrinter" width="0" height="0"></object>
	<div id="body">
	 	<div class="cur-pos">
			当前位置：库存管理 &gt; 打印赋码
		</div>
		<div class="seh-box">
			<form action="" method="post" id="searchform" name="searchform">
				<input type="hidden" name="filename" id="filename" value="" />
				<input type="hidden" name="filenametime" id="filenametime" value="" />
				<input type="hidden" name="cpccode" id="cpccode" value="" />
				<input type="hidden" name="medstorid" id="medstorid" value="" />
				请输入品名查询：<input maxlength="20" type="text" value="${medname}" class="inp" size="40" id="medname" name="medname">
				<input type="button" value="查询" class="sch" onclick="checkForm();" >
			</form>
			<span class="red">提示:离线印刷-导出TXT文档后离线印刷溯源码;在线打印 - 下载溯源码后在线打印溯源码;两种方式均可完整打印溯源码,可任选其一。</span>
		</div>

		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						品名
					</td>
					<td>
						批次号
					</td>
					<td>
						批次详情
					</td>
					<td>
						待打印重量(Kg)
					</td>
					<td>
						入库时间
					</td>
					<td>
						包装规格(Kg/包)
					</td>
					<td>
						包数
					</td>
					<td >
						操作
					</td>
					
				</tr>
				<c:forEach items="${list}" var="item">
					<tr class="lb-list">
						<td height="30">
							${item.medname }
						</td>
						<td>
			            	${(item.mednumber==null || item.mednumber =='')?'无':item.mednumber }&nbsp;
			            </td>
						<td>
							<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${item.cpcmed }${initParam.batchcpc_med}');" class="btn-look">查看</a>
						</td>
						<td>
							${item.medweight / 10000 }
						</td>
						<td>
							${item.addtime }
						</td>
						<td>
							${item.mednumweight /10000 }
						</td>
						<td>
							<SCRIPT type="text/javascript" language="javascript">
								var mednum = Math.ceil(${item.medweight/item.mednumweight })
								document.write(mednum);
							</SCRIPT>
						</td>
						<td>
							<a href="javascript:void(0);" id="downbtn${item.medstorid}" onclick="return chooseData(${item.medstorid},'${item.cpcmed }',${item.printstate },1)" class="btn-print" style="display:<c:if test="${item.downstate=='0'&&item.printstate=='0' }">inline;</c:if><c:if test="${item.printstate>'0' }">none;</c:if>">离线印刷</a>
							<a href="javascript:void(0);" id="printbtn${item.medstorid}" onclick="return chooseData(${item.medstorid},'${item.cpcmed }',${item.printstate },2);" class="btn-net" style="display:<c:if test="${item.downstate=='0'&&item.printstate=='0' }">inline;</c:if><c:if test="${item.downstate>'0' }">none;</c:if>">在线打印</a>
						</td>
						
					</tr>
				</c:forEach>
			</table>
			<div class="page">
				<cite>
				<pg:pager url="medStorage!findPrintCode.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="medname" value="${requestScope.medname }" />
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
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('品名不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medStorage!findPrintCode.shtml");
			$("#searchform").submit();
		}
	
		cMenu(2,3);

		function chooseData(storageidtemp,cpccodetemp,printstate,type){
			var printbtn = $("#printbtn"+storageidtemp);
			var downbtn = $("#downbtn"+storageidtemp);

			if(printbtn.css("display")=='inline'&&downbtn.css("display")=='inline'){
				var str="<div>您当前选择的操作为<span style='color:red'>";
				str+=type==1?"离线印刷":"在线打印";
				str+="</span>，另一操作"
				str+=type==1?"在线打印":"离线印刷";
				str+="将不可使用!<br />离线印刷，在线打印两功能二选其一，请确认!</div>";
				
				$.dialog({
					title:type==1?"离线印刷":"在线打印",
					id:'checkRepo',
					lock:true,
					content: str,
					okVal:'确定',
					ok:function(){
						if(type==1){				//离线印刷
							printbtn.css("display","none");
							downloadData_createFile(storageidtemp,cpccodetemp);
						}else{						//在线打印
							downbtn.css("display","none");
							printData_downData(storageidtemp,printstate);
						}
					},
					cancelVal: '关闭',
					cancel: true
				});
			}else{
				if(type==1){						//离线印刷
					downloadData_createFile(storageidtemp,cpccodetemp);
				}else{//在线打印
					printData_downData(storageidtemp,printstate);
				}
			}
		}
		//下载数据
		function downloadData_createFile(storageidtemp,cpccodetemp){
    		var url="<%=request.getContextPath()%>/printCodeAjax!createMedFile.shtml?rid="+Math.random();
    		$.getJSON(url,{'medstorid':storageidtemp,'cpccode':cpccodetemp}, function(data) {
	    		var loginForm = data;
		    	var filename = loginForm.model.filename;
		    	var filenametime = loginForm.model.filenametime;
		    	var cpccode = loginForm.model.cpccode;
		    	var medstorid = loginForm.model.medstorid;

				var str="";
		    	
		    	if(filename!=""&&filenametime!=""&&cpccode!=""&&medstorid!=""){
			    	str="<div>生成数据成功请点击下载按钮保存文件，</div><div>下载后,该下载功能将为您再保留三天时间,可重新下载!</div>"
		    		str+="<div><input type=\"button\" value=\"下载溯源码印刷文件\" id=\"down\" /></div>"
		    		$("#filename").val(filename);
			    	$("#filenametime").val(filenametime);
			    	$("#cpccode").val(cpccode);
			    	$("#medstorid").val(medstorid);
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
	    	$("#searchform").attr("action", "printCode!getMedFile.shtml");
	    	$("#searchform").submit();
	    }


		//打印数据
	    function printData_downData(storageidtemp,printstatetemp){
	    	var url="<%=request.getContextPath()%>/printCodeAjax!checkParam.shtml?rid="+Math.random();
    		$.getJSON(url,{'storageid':storageidtemp,'storagetype':0}, function(data) {
	    		var loginForm = data;
	    		var dataparam = loginForm.model.dataparam;
				if(dataparam=="该数据，已由其它用户操作请关闭!"){
					$.dialog({
						title:'数据下载',
						id:'checkRepo',
						lock:true,
						content: "<div>该数据，已由其它用户操作请关闭!</div>",
						cancelVal: '关闭',
						cancel: true
					});
					return false;
				}
				if(dataparam==null||dataparam==""||dataparam.length<1){
					$.dialog({
						title:'数据下载',
						id:'checkRepo',
						lock:true,
						content: "<div>数据下载错误,请退出重试!</div>",
						cancelVal: '关闭',
						cancel: true
					});
					return false;
				}
				try{
					if(printstatetemp==0||printstatetemp==1){
						var code = neowerPrinter.DownloadData(dataparam);						
						if(code=='OK'){
							printData_print(storageidtemp);
						}else{
							alert("数据下载错误,请退出重试!"+code);
						}
					}else if(printstatetemp==2){
						printData_print(storageidtemp);
					}
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
			});
			
	    }
	    function printData_downControl(num){
			if(num==32){
				window.location.href="js/setup32.exe"
			}else{
				window.location.href="js/setup64.exe"
			}
		}
	    function printData_print(storageidtemp){
			$.dialog({
				title:'在线打印',
				id:'medChos',
				lock:true,
				content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="800" height="600" src="<%=basePath %>printCode!findByStorageId_med.shtml?ischoice='+Math.random()+'&storageid='+storageidtemp+'&url=medStorage!findPrintCode.shtml"></iframe>',
				close:function(){
					 window.location.reload(); 
				}
			});	
		}
	    
	</script>	
	
	</body>
</html>
