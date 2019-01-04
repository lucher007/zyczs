<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<body style="width:650px; padding:0;">
	<div id="body">
		
	    <div class="seh-box">
	    	
	        <form action="org!findByListChoice.shtml" method="post" id="searchform" name="searchform">
	        <input type="hidden" name="zyctype" value="${requestScope.zyctype }"/> 
      		所属： 	<select name="province" id="province" v="${province }">
                   	 </select>
                   	 <select name="city" id="city"  v="${city }">
                   	 </select>
        			 <select name="area" id="area"   v="${area }">
        			 </select>
	        	</br>	 
	单位名称：<input type="text" value="${requestScope.orgname }" class="inp" id="orgname" name="orgname" maxlength="40"> 
	        <input type="button" value="查询" class="sch" onclick="return checkForm();">
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	          	<td width="60">选择</td>
	            <td>企业代码</td>
	            <td>所属区域</td>
	            <td>单位名称</td>
	            <td>备案日期</td>
	          </tr>
	          <c:forEach items="${requestScope.orglist}" var="orglist">
	          <tr class="lb-list">
	          	<td>
	          	<input type="radio"  name="_selKey" id="_selKey_${orglist.orgid }" value="${orglist.orgid }">
	            <input type="hidden" id="orgname_${orglist.orgid }" value="${orglist.orgname }" >
	            <input type="hidden" id="cpccorp_${orglist.orgid }" value="${orglist.cpccorp }" >	
	          	</td>
	            <td height="30">	            
	            ${orglist.cpccorp }&nbsp;
	            </td>
	            <td>${orglist.province }${orglist.city }${orglist.area }&nbsp;</td>
	            <td>${orglist.orgname }&nbsp;</td>
	            <td>${orglist.addtime }&nbsp;</td>
	            
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="org!findByListChoice.shtml"
					    items="${requestScope.pager_count}"
					    index="center"
					    maxPageItems="5"
					    maxIndexPages="5"
					    isOffset="<%= true %>"
					    export="offset,currentPageNumber=pageNumber"
					    scope="request">			
						<pg:param name="index"/>
						<pg:param name="maxPageItems"/>
						<pg:param name="maxIndexPages"/>
						<pg:param name="orgname" value="${requestScope.orgname }"/>
						<pg:param name="province" value="${requestScope.province }"/>
						<pg:param name="city" value="${requestScope.city }"/>
						<pg:param name="area" value="${requestScope.area }"/>
						<pg:param name="zyctype" value="${requestScope.zyctype }"/>
						
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
	        </div>
	    </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
		
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(3);
		selArray[0]=t;
		selArray[1]=$("#orgname_"+t).val();
		selArray[2]=$("#cpccorp_"+t).val();
		selArray[3]=$("#_selKey_"+t).val();
		parent.closeORG(selArray);
	});
	
	function checkForm(){
		$("#orgname").val($.trim($("#orgname").val()));
		if(checkquotmarks($("#orgname").val())){
			$("#orgname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		$("#searchform").attr("action","org!findByListChoice.shtml");
		$("#searchform").submit();
	}
	</script>
	</body>
</html>
