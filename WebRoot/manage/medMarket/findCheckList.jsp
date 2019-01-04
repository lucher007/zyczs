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
		<base href="<%=basePath%>" target="_self" />   
		<meta charset="utf-8">
		<title>选择原药材</title>
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>

	<body>
	<div id="body">
		<div class="cur-pos">
			当前位置：检验管理 &gt; 检验管理
		</div>
	    <div class="seh-box">
	        <form action="" name="searchform" id="searchform" method="post">
		         请输入品名查询：<input maxlength="40" class="inp" type="text" name="medname" id="medname" value="${medname }" size="40"/>
		  		<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>品名</td>
	            <td>批次号</td>
	            <td>批次详情</td> 
	            <td>库存量(Kg)</td>
	            <td>操作</td>        
	          </tr>
	          <c:forEach items="${requestScope.list}" var="storlist">
		          <tr class="lb-list">
		            <td height="30">${storlist.medname }</td>
		            <td>
		            	${(storlist.mednumber==null || storlist.mednumber =='')?'无':storlist.mednumber }&nbsp;
		            </td>
		            <td>
		            	<a href="javascript:void(0);" onclick="openCpc('${initParam.batchcpc_url }${storlist.cpcmed }${initParam.batchcpc_med}');" class="btn-look">查看</a>
		            </td>
		            <td>${storlist.medweight / 10000}
		            </td>  
		            <td><a href="javascript:void(0);" onclick="doCheck('${storlist.medstorid}','${storlist.cpcmed}','${storlist.medname}','${storlist.medweight / 10000}','${storlist.harvesttime}','${storlist.medstate }')" class="doCheck btn-test">检验</a></td>          
		          </tr>
	          </c:forEach>           
	        </table>
			<div class="page">
				<cite>        
	            	<pg:pager
					    url="medStorage!findCheckList.shtml"
					    items="${requestScope.pager_count}"
					    index="center"
					    maxPageItems="10"
					    maxIndexPages="10"
					    isOffset="<%= true %>"
					    export="offset,currentPageNumber=pageNumber"
					    scope="request">			
						<pg:param name="index"/>
						<pg:param name="maxPageItems"/>
						<pg:param name="maxIndexPages"/>
						<pg:param name="medname" value="${medname}"/>
						<pg:param name="flag" value="medmarket"/>
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
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		cMenu(1,0);
		function checkForm(){
			$("#medname").val($.trim($("#medname").val()));
			if(checkquotmarks($("#medname").val())){
				$("#medname").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","medStorage!findCheckList.shtml?flag=medmarket");
			$("#searchform").submit();
		}
		function doCheck(medstorid,cpcmed,medname,medweight,harvesttime,medstate){
			//checkmattype, 检验报告表的类型(type), 为0是药材, 为1是饮片.
			$(".doCheck").attr("href","<%=basePath%>manage/check/medCheck.jsp?medstorid="+medstorid+"&cpcmed="+cpcmed+"&medname="+encodeURI(medname)+"&medweight="+medweight+"&harvesttime="+harvesttime+"&medstate="+medstate+"&flag=4&checkmattype=0");
		}
	</script>
</body>
</html>

