<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
			当前位置：饮片生产管理 > 饮片品名列表
		</div>
		<div class="seh-box">
		<form action="" method="post" id="searchform" name="myform">
		<input type="hidden" name="chkid" id="chkid" value="${requestScope.chkid}"/>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>				
	    			请输入饮片品名：<input maxlength="20" type="text"  name="mcontent" id="mcontent" value="${requestScope.mcontent}"  class="inp" size="35"> 
	    			
	    			<input type="button" value="查询" class="sch" onclick="return checkForm();"> 
					</td>
					<td>已选择</td>
					<td>		
					<span id="totalkg"></span>
					</td>
					<td>
					<cite><a href="javascript:addBase();"  onclick="return confirm('确认要添加吗?');"  class="btn-a"><span class="new">确认添加</span></a></cite>
					</td>
				</tr>
			</table>
			<span class="red">提示：勾选饮片以后、需要"确认添加"才会保存成功!</span>
	    </form>
    	</div>

		<div class="lst-box" id="lst-box">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						选择/取消
						<input type="checkbox" id="chk_all" onclick="chkall(this);">
					</td>
					<td>
						饮片中文名称
					</td>
					<td>
						饮片英文名称
					</td>
					<td>
						最近更新时间
					</td>
						
					<td>
						状态
					</td>
					
				</tr>
				<c:forEach items="${requestScope.list}" var="list">
					<tr class="lb-list">
						<td height="30">
							<input type="checkbox" name="chk_list" value="${list.id }" onclick="chk(this);">
						</td>
					
						<td height="30">
							${list.name }&nbsp;
						</td>
						<td>
							${list.keyword }&nbsp;
						</td>
						<td>						
							${fn:substring(list.lasttime, 0, 11)}&nbsp;
						</td>						
						<td>
							<c:if test="${list.enabled==1}">
							可用
							</c:if>
							<c:if test="${list.enabled==0}">
							不可用
							</c:if>&nbsp;
						</td>						
									
					</tr>
				</c:forEach>
			</table>
			
			<div class="page" id="page">
				<cite>
				<pg:pager url="tabletBase!findByList_un.shtml"
					items="${requestScope.pager_count}" index="center" maxPageItems="10"
					maxIndexPages="5" isOffset="<%=true%>"
					export="offset,currentPageNumber=pageNumber" scope="request">
					<pg:param name="index" />
					<pg:param name="maxPageItems" />
					<pg:param name="maxIndexPages" />
					<pg:param name="mcontent" value="${requestScope.mcontent }" />
					<pg:param name="chkid" value="${requestScope.chkid }" />
					
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
			$("#mcontent").val($.trim($("#mcontent").val()));
			if(checkquotmarks($("#mcontent").val())){
				$("#mcontent").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","tabletBase!findByList_un.shtml");
			$("#searchform").submit();
		}
		
		function addBase(){
			var chkid=$("#chkid").val();
			
			if(chkid==""){
				$.dialog.tips('您未选中要添加的饮片!',1,'alert.gif');
				return;
			}
			$.dialog({
					title:'新增饮片',
					id:'pack',
					lock:true,
					content: '<div style="font-size:18px;color:red;padding:20px 50px">选中的饮片品名需向中央接口申请编码,请稍等...</div>',
					min:false,
					max:false,
					cancel:false
			});
			$("#searchform").attr("action","tabletBase!saveObject.shtml");
			$("#searchform").submit();
		}
		
		var chkArray=new Array();
		
		var chkid='${requestScope.chkid}';
		if(chkid!=null&&chkid!="")
		{
			chkArray=chkid.split(",");
		}
		
		var chkCount=0;
						
		//加载选中
		if(chkArray!=null&&chkArray.length>0){
			$("input[name='chk_list']").each(function(){ 				
					if (Arraycontains(chkArray,$(this).val())&&!$(this).attr("checked")) {
						$(this).attr("checked",true);
						chkCount++;
					} 
			});
		}
		//全选-勾选
		if(chkCount==10){
			$("#chk_all").attr("checked",true);
		}
		
		
		$("#totalkg").text(chkArray.length);
		
		//选g
		function Arraycontains(arraychecks,chvalue)
		{
			var falgs=false;
			for(var i=0;i<arraychecks.length;i++)
			{
				if(arraychecks[i]==chvalue)
				{
					 falgs=true;
					 break;
				}
			}
			return falgs;
		}
		
		
		//新增
		function addArr(objvalue)
		{
			var falgs=false;
			for(var i=0;i<chkArray.length;i++)
			{
				if(chkArray[i]==objvalue)
				{
					 falgs=true;
					break;
				}
			}
			if(falgs==false){
				chkArray[chkArray.length]=objvalue;
			}
		}
		
		//删除
		function delArr(objvalue)
		{	
			for(var i=0;i<chkArray.length;i++)
			{
				if(chkArray[i]==objvalue)
				{
					chkArray.splice(i,1);
				}
			}	
		}
		
		//多选
		function chkall(obj){
			if(obj.checked){
				$("input[name='chk_list']").each(function(){ 
					if (!$(this).attr("checked")) {
						$(this).attr("checked",obj.checked)
						addArr($(this).val());
					} 
				});
			}else{
				$("input[name='chk_list']").each(function(){ 
					if ($(this).attr("checked")) {
						$(this).attr("checked",obj.checked)
						delArr($(this).val());
					} 
				});
			}
					
			$("#totalkg").text(chkArray.length);			
			$("#chkid").val(chkArray.join(","));
			getPage(chkArray.join(","));
			//alert($("#chkid").val());
		}
		//单选
		function chk(obj){
			if(obj.checked){
				addArr(obj.value);
			}else
				delArr(obj.value);
			
			$("#totalkg").text(chkArray.length);
			$("#chkid").val(chkArray.join(","));
			//alert($("#chkid").val());
			
			getPage(chkArray.join(","));
		}
		
		//获取所有分页连接
		function getPage(chkid)
		{
			$('#page a').each(function(){
				var href=$(this).attr("href");				
				var f=href.substr(0,href.indexOf("chkid"));			
				var m=href.substr(href.indexOf("chkid"));
				var n="";
				if(m.indexOf("&")!=-1){
					n=m.substr(m.indexOf("&")+1);
				}					
				//alert(f+n+"&chkid="+chkid);				
				$(this).attr("href",f+n+"&chkid="+chkid);	
			});
		}
		
		
	</script>	
	
	</body>
</html>
