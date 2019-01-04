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
		<base href="<%=basePath%>" target="_self">   
		<meta charset="utf-8">
		<title>选择原药材</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body style="width:650px; padding:0;">
	<div id="body">
	    <div class="seh-box" style="margin-top:3px;">
	        <form name="searchform" id="searchform" action="<%=request.getContextPath()%>/medStorage!medStorageChoice2.shtml" method="post">
	        <table cellpadding="0" cellspacing="0" width="100%" >
	  			<tr>
	  				<td height="26">请输入品名查询：</td>
	  				<td><input type="text" maxlength="20" class="inp" size="45" name="medname" id="medname" value="${requestScope.medname }" /></td>
	  				<td>&nbsp;</td>  				
	  				<td><input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
	  				<td></td>
	  			</tr>
	  	
	  		</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>选择</td>
	            <td>药材名</td>
	            <td>药材内部批次号</td>
	            <td>药材重量</td>
	            <td>入库时间</td>        
	          </tr>
	          <c:forEach items="${requestScope.list}" var="storlist">
	          <tr class="lb-list">
	            <td width="" height="30">
	            <input type="radio"  name="_selKey"  value="${storlist.medstorid }">
	            <input type="hidden" id="medname_${storlist.medstorid }" value="${storlist.medname }" >
	            <input type="hidden" id="cpcmed_${storlist.medstorid }" value="${storlist.cpcmed }" > 
	            <input type="hidden" id="mednumber_${storlist.medstorid }" value="${storlist.mednumber }" >          
	            <input type="hidden" id="medweight_${storlist.medstorid }" value="${storlist.medweight/10000 }" >	
	            <input type="hidden" id="address_${storlist.medstorid }" value="${storlist.province}${storlist.city}${storlist.area}" >		
	            </td>
	            <td>${storlist.medname }&nbsp;</td>
	            <td>${storlist.mednumber }&nbsp;</td>
	            <td width="100">${storlist.medweight/10000 }&nbsp;</td>
	            <td width="100">${storlist.addtime }&nbsp;</td>          
	          </tr>
	         </c:forEach>     
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
				    url="medStorage!medStorageChoice2.shtml"
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
					<pg:param name="plantname" value="${requestScope.medname }"/>									  			
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	function checkForm(){
		$("#medname").val($.trim($("#medname").val()));
		if(checkquotmarks($("#medname").val())){
			$("#medname").focus();
			$.dialog.tips('不要输入非法字符',1,'alert.gif');
			return false;
		}
		
		$("#searchform").submit();
	}
	
	$(".lb-list").click(function(){
		var t = $(this).find("input[type=radio]").val();
		var selArray=new Array(6);
		selArray[0]=t;
		selArray[1]=$("#medname_"+t).val();
		selArray[2]=$("#cpcmed_"+t).val();
		selArray[3]=$("#medweight_"+t).val();
		selArray[4]=$("#address_"+t).val();
		selArray[5]=$("#mednumber_"+t).val();
		parent.closeDGS(selArray);
	});
	</script>
	</body>
</html>

