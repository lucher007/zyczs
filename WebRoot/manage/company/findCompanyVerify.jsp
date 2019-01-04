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
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：备案管理 > 备案审核</div>
	    <div class="seh-box">
	    	<form action="company!findByListVerify.shtml" method="post" id="searchform" name="searchform">
	        	<input type="hidden" name="companyidstr" id="companyidstr"  />
		    	<table width="100%">
		    		<tr><td align="right" width="80">所属区域：</td><td><select name="province" id="province" v="${province }"></select>
						<select name="city" id="city" v="${city }"></select>
						<select name="area" id="area" v="${area }"></select></td>
						<td width="130"></a></td></tr>
		    		<tr><td align="right">企业名称：</td><td><input type="text" value="${requestScope.corpname }" class="inp w250" id="corpname" name="corpname" maxlength="40">&nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"></td><td><a href="manage/company/addCompany.jsp" class="btn-a"><span class="new">新建企业备案</span></td></tr>
		    	</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
<%--	          	<td>批量审核</td>--%>
	          	<td>企业名称</td>
	            <td>所属区域</td>
	            <td>备案日期</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.companylist}" var="companylist">
	          <tr class="lb-list">
<%--	          	<td><input type="checkbox" name="chk" id="chk${companylist.companyid}" value="${companylist.companyid}" onclick="chooseRole(this)"/></td>--%>
	         	<td height="30" title="${companylist.corpname}">${fn:substring(companylist.corpname,0,20)}</td>
	           <td width="80" title="${companylist.province }${companylist.city }${companylist.area }"><div class="w80 ho">${companylist.province }${companylist.city }${companylist.area }</div></td>
	            <td>${companylist.addtime }</td>
	            <td>
	            	<a href="javascript:updateInit(${companylist.companyid },${ companylist.opertype});" class="btn-test">审核</a>
	            	<a href="javascript:deleteObj(${companylist.companyid },${ companylist.opertype});" class="btn-del">删除</a>
	            </td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page pt10">
	        	<cite>
	            	<pg:pager
					    url="company!findByListVerify.shtml"
					    items="${requestScope.pager_count}"
					    index="center"
					    maxPageItems="10"
					    maxIndexPages="5"
					    isOffset="<%= true %>"
					    export="offset,currentPageNumber=pageNumber"
					    scope="request">			
						<pg:param name="index"/>
						<pg:param name="maxPageItems"/>
						<pg:param name="maxIndexPages"/>
						<pg:param name="corpname" value="${requestScope.corpname }"/>
						<pg:param name="province" value="${requestScope.province }"/>
						<pg:param name="city" value="${requestScope.city }"/>
						<pg:param name="area" value="${requestScope.area }"/>
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
							<a href="<%=pageUrl %>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
						  	<a href="<%= prevPageUrl %>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
			   				<%if (pageNumber == currentPageNumber) { 
						        %><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a><%
						      } else { 
						        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
						      }
						    %>  
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
						  	<a href="<%= nextPageUrl %>" title="下一页" class="next">&nbsp;</a>
						</pg:next>
						<pg:last>
						  	<a href="<%=pageUrl %>">末页</a>
						</pg:last>
						</pg:index>
				  		</pg:pager>
	            </cite>
<%--	            <a href="manage/company/addCompany.jsp" class="btn-a"><span class="new">审核备案</span></a>--%>
	        </div>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	/**
	*companyid 公司id
	*opertype 注册类型 0后台添加 1前台注册
	*/
	function updateInit(companyid,opertype){
		if(opertype==0){
			$("#searchform").attr("action", "company!updateInitVerify.shtml?companyid="+companyid);
		}else{
			$("#searchform").attr("action", "company!updateInitRegVerify.shtml?companyid="+companyid);
		}
		$("#searchform").submit();
	}
	
	/**
	*删除未审核或者是审核失败的企业
	*/
	function deleteObj(companyid,opertype){
		$.dialog.confirm('确认是否删除？', function(){ 
			if(opertype==0){
				$("#searchform").attr("action", "company!deleteCompany.shtml?companyid="+companyid);
			}else{
				$("#searchform").attr("action", "company!deleteComOrgUser.shtml?companyid="+companyid);
			}
			$("#searchform").submit();
		}, function(){
					});
		
	}
	
	
	function checkForm(){
		$("#corpname").val($.trim($("#corpname").val()));
		if(checkquotmarks($("#corpname").val())){
			$("#corpname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","company!findByListVerify.shtml");
		$("#searchform").submit();
	}

	/*function checkVerify(){
		if(!confirm("确认审核吗?")){
			return false;
		}
		if(arraycheck.length>0){
			var roleIdStrTemp="";
	 		for(var i = 0 ;i<arraycheck.length;i++){		 		
	 			roleIdStrTemp+=arraycheck[i]+","
	 		}
	 		$("#companyidstr").val(roleIdStrTemp.substring(0,roleIdStrTemp.length-1)); 		
		}else{
			alert("请勾选要审核的任务！");
			return false;
		}
		
		$("#searchform").attr("action","company!updateVerifyBatch.shtml");
		$("#searchform").submit();
	}
	//多项选择checkbox开始
	function chooseRole(obj){
		OnclickBox(obj);
	}
	var arraycheck=new Array();
	function OnclickBox(obj){
		if(obj.checked){	
			arraycheck[arraycheck.length]=obj.value;	
			var tagname=obj.name;
		}else{
			if(Arraycontains(arraycheck,obj.value)){
			arraycheck.splice(getindex(arraycheck,obj.value),1);
			}
		}			  	
	}		
	function Arraycontains(arraychecks,chvalue){
		var falgs=false;
		for(var i=0;i<arraychecks.length;i++){
		if(arraychecks[i]==chvalue){
			falgs=true;
			break;
			}
		}
	return falgs;
	}
	function getindex(array,objvalue){
		var index;
		for(var i=0;i<array.length;i++){
		if(array[i]==objvalue){
			index=i;
			break;
			}
		}
		return index;
	}
	//多项选择checkbox结束
	*/
	</script>
	</body>
</html>
