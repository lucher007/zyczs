<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false"%>
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
		<title>饮片基础列表</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
		<link type="text/css" rel="stylesheet" href="/js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
		<style type="text/css">
		.textcss1{
			border:0;
			width:50px;
			height:14px;
			line-height:14px; 
			background:transparent;
			padding:3px;
		}
		.textcss2{
			width:48px;
			height:14px; 
			line-height:14px; 
			border:solid #CCC 1px; 
			border-left:solid #999 1px; 
			border-top:solid #999 1px; 
			padding:3px;
		}
		</style>
	</head>

	<body>
	<form action=""  method="post" name="searchform" id="searchform">
	<div id="body">
	 	<div class="cur-pos">
			当前位置：绩效考核 &gt; 考核计算
		</div> 
		<div class="seh-box">
			<cite>
				<select name="year" style="width:120px;" onchange="checkForm();">
					<option value="2012" <c:if test="${requestScope.year=='2012' }">selected="selected"</c:if> >2012</option>
					<option value="2013" <c:if test="${requestScope.year=='2013' }">selected="selected"</c:if> >2013</option>
					<option value="2014" <c:if test="${requestScope.year=='2014' }">selected="selected"</c:if> >2014</option>
					<option value="2015" <c:if test="${requestScope.year=='2015' }">selected="selected"</c:if> >2015</option>
				</select>&nbsp;
		    	<select name="quarter" style="width:120px;" onchange="checkForm();">
					<option value="1" <c:if test="${quarter=='1' }">selected="selected"</c:if> >第一季度</option>
					<option value="2" <c:if test="${quarter=='2' }">selected="selected"</c:if> >第二季度</option>
					<option value="3" <c:if test="${quarter=='3' }">selected="selected"</c:if> >第三季度</option>
					<option value="4" <c:if test="${quarter=='4' }">selected="selected"</c:if> >第四季度</option>
				</select>
			</cite>
			<b style="color:red;font-size:12px;"> 提示：请先选择年份、季度查询出要统计的地区列表</b>
    	</div>
		<div class="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						地区编号
					</td>
					<td>
						区县名称
					</td>
					<td>
						种植基<br>地数量
					</td>
						
					<td>
						中药材经销<br>企业数量
					</td>
					<td>
						专业市场经<br>营企业数量
					</td>
					<td>
						饮片生产<br>企业数量
					</td>
					<td>
						饮片经销<br>企业数量
					</td>
					<td>
						饮片使用<br>单位数量
					</td>
				</tr>
				<c:forEach items="${requestScope.list}" var="list" varStatus="vs">
					<tr class="lb-list" id="tr_${list.id }">
						<td height="30">
							${list.areacode }
							<input type="hidden"  name="list[${vs.index }].id" value="${list.id }">
							<input type="hidden"  name="list[${vs.index }].updateorinsert" value="${list.updateorinsert }">
							<input type="hidden"  name="list[${vs.index }].areas" value="${list.areas }">
							<input type="hidden"  name="list[${vs.index }].areacode" value="${list.areacode }">
						</td>
						<td>
							${list.areas }&nbsp;
						</td>
						<td>	
							<input type="text" class="textcss1" maxlength="6" name="list[${vs.index }].medcount" id="medcount_${list.id }" value="${list.medcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
						</td>						
						<td>
							<input type="text" class="textcss1" maxlength="6" name="list[${vs.index }].medsellcount" id="medsellcount_${list.id }" value="${list.medsellcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
								
						</td>
						<td>
							<input type="text" class="textcss1" maxlength="6" name="list[${vs.index }].medmarketcount" id="medmarketcount_${list.id }" value="${list.medmarketcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
						</td>
						<td>
							<input type="text" class="textcss1" maxlength="6" name="list[${vs.index }].tabletcount" id="tabletcount_${list.id }" value="${list.tabletcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
						</td>
						<td>
							<input type="text" class="textcss1" maxlength="6"name="list[${vs.index }].tabletsellcount" id="tabletsellcount_${list.id }" value="${list.tabletsellcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
						</td>
						<td>
							<input type="text" class="textcss1" maxlength="6" name="list[${vs.index }].tablethospcount" id="tablethospcount_${list.id }" value="${list.tablethospcount }"  onfocus="inputConfirm1(this)" 
								onkeypress="onkeyupNum(this);"
								onkeyup="onkeyupNum(this);"
								onblur="onkeyupNum(this);checkConfirm1(this)">
						</td>		
					</tr>
				</c:forEach>
			</table>
			<br>
			<div class="page">
				<cite ><a id="calBut" href="javascript:calculate();" class="btn-a"><span class="new">开始计算</span></a></cite>
			</div>
		</div>
	</div>
	</form>
	<script type="text/javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript" src="/js/ajaxobj.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" src="<%=basePath%>js/plugin/poshytip/jquery.poshytip.min.js"></script>
	<script type="text/javascript">
		function checkForm(){			
			$("#searchform").attr("action","examine!calculateList.shtml");
			$("#searchform").submit();
		}
		function calculate(){
			
			$("#searchform").attr("action","examine!calculate.shtml");
			$("#searchform").submit();
		}
		
		function inputConfirm1(obj){
			$("#"+obj.id).attr("class","textcss2");		
		}
		
		
		function checkConfirm1(obj){
			
			if(obj.value==""||obj.value==" "||isNaN(obj.value)||obj.value<0){
				alert("必填项!");
				//$.dialog.alert('企业数量未填写完整!');
				document.getElementById(obj.id).focus();// 获取焦点   
				return false;
			}
			$("#"+obj.id).attr("class","textcss1");
		}
		function onkeyupNum(obj){
			
			obj.value=$.trim(obj.value);//去空格			
			obj.value=obj.value.replace(/\D/g,'');//保留数字	
			if(obj.value == 'undefined')
				obj.value='';
			
		}	
		$(".lb-list:first").find("td").eq(2).poshytip({
			className: 'tip-yellowsimple',
			content: '点击这里可以直接修改数量',
			showOn: 'none',
			alignTo: 'target',
			alignX: 'center',
			alignY: 'bottom',
			offsetX: 0,
			offsetY: 5
		}).poshytip("show");
		$(".lb-list:first").find("td").eq(2).click(function(){
			$(this).poshytip("destroy");
		});
	</script>	
	
	</body>
</html>
