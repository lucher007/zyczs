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
			当前位置：库存销售 &gt; 打印赋码
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
						批次号
					</td>
					<td>
						品名
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
							${item.cpcmed }
						</td>
						<td>
							${item.medname }
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
							${item.mednum }
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
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medStorage!findPrintCode.shtml");
			$("#searchform").submit();
		}
	
		cMenu(2,4);

		
	</script>	
	
	</body>
</html>
