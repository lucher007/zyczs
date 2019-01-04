<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>诚信评价</title>   
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
	    <div class="cur-pos">当前位置：诚信评价 > 诚信等级</div>
	    <div class="seh-box">
	        <form action="" method="post" name="searchform" id="searchform">
				企业名称： <input maxlength="20" type="text" name="corpname" id="corpname" value="${requestScope.corpname }" class="inp w250"/>
				<select name="addtime" id="addtime">
					<c:if test="${fn:length(requestScope.addtimelist)<1}">
					<option value="-1" <c:if test="${requestScope.addtime=='-1' }">selected</c:if>>全部</option>
					</c:if>
					<c:forEach items="${requestScope.addtimelist}" var="addtimelist">
						<option value="${addtimelist }" <c:if test="${requestScope.addtime==addtimelist }">selected</c:if>>${fn:substring(addtimelist, 0, 4)}</option>
					</c:forEach>
					
				</select>
	        	<input type="button" value="查询" class="sch" onclick="checkForm();"/>
	        </form>
	    </div>
	    
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	            <td>企业CPC</td>
	            <td>企业名称</td>
	            <td>诚信等级</td>
	            <td>得分</td>
	            <td>加分</td>
	            <td>扣分</td>
	            <td>操作</td>
	          </tr>
	          <c:forEach items="${requestScope.scorefinallist}" var="scorefinallist">
			  	  <tr class="lb-list">
			  		<td height="30">${scorefinallist.cpccorp }</td>
			  		<td>${scorefinallist.corpname }</td>
			  		<td>
			  			<script type="text/javascript">
			  				<c:set var="varscore" value="${0}" />
			          	  	<c:if test="${scorefinallist.dscore!=null&&scorefinallist.dscore!=0}">
			          	  	<c:set var="varscore" value="${scorefinallist.score/100-(scorefinallist.deductscore/100+scorefinallist.dscore)}" />
			          	  	</c:if>
					  	  	<c:if test="${scorefinallist.dscore==null||scorefinallist.dscore==0}">${scorefinallist.score/100 }
					  	  	<c:set var="varscore" value="${scorefinallist.score/100 }" />
					  	  	</c:if>
			  				var scoretemp="${varscore}";
			  				var star = 1;
			  				if(scoretemp>=80&&scoretemp<=100){
			  					star=5;
			  				}else if(scoretemp>=60&&scoretemp<=80){
			  					star=4;
			  				}else if(scoretemp>=40&&scoretemp<=60){
			  					star=3;
			  				}else if(scoretemp>=20&&scoretemp<=40){
			  					star=2
			  				}else{
			  					star=1
			  				}
			  				for(var i=0;i<star;i++){
				  				document.write("<img src=\"/images/star.png\" width=\"16\" height=\"16\" />");
			  				}
			  			</script>
			  		</td>
			  		<td>
			  			<c:if test="${scorefinallist.dscore!=null&&scorefinallist.dscore!=0}">
			  				${fn:substring(scorefinallist.score/100-(scorefinallist.deductscore/100+scorefinallist.dscore),0,fn:indexOf(scorefinallist.score/100-(scorefinallist.deductscore/100+scorefinallist.dscore), "."))}
			  			</c:if>
			  			<c:if test="${scorefinallist.dscore==null||scorefinallist.dscore==0}">
			  				${fn:substring(scorefinallist.score/100,0,fn:indexOf(scorefinallist.score/100, "."))}
			  			</c:if>
			  		</td>
			  		<td>
			  			${fn:substring(scorefinallist.addscore/100,0,fn:indexOf(scorefinallist.addscore/100, "."))}
			  		</td>
			  		<td >
			  			<div style='line-height:30px;<c:if test="${(scorefinallist.dscore!=null&&scorefinallist.dscore!=0)||(scorefinallist.deductscore!=null&&scorefinallist.deductscore!=0)}">background:red;color:white;</c:if>'>
			  			${fn:substring(scorefinallist.deductscore+scorefinallist.dscore,0,fn:indexOf(scorefinallist.deductscore+scorefinallist.dscore, "."))} 
			  			</div>
			  		</td>
			  		<td><a href="javascript:findByListScoreDeduct('${scorefinallist.orgid }','${scorefinallist.addtime }');" class="btn-look">扣分详情</a></td>
			  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="scoreFinal!findByList.shtml"
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
						<pg:param name="addtime" value="${requestScope.addtime }"/>
						
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
    <script type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
    <script type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script type="text/javascript">
		function checkForm(){
			$("#corpname").val($.trim($("#corpname").val()));
			if(checkquotmarks($("#corpname").val())){
				$("#corpname").focus();
				$.dialog.tips('不能包含~ # *等字符！',1,'alert.gif');
				return;
			}
			$("#searchform").attr("action","scoreFinal!findByList.shtml");
			$("#searchform").submit();
		}
		function findByListScoreDeduct(orgid,addtime){
			$("#searchform").attr("action","scoreDeduct!findByList.shtml?orgid="+orgid+"&addtime="+addtime);
			$("#searchform").submit();
		};
    </script>   
	</body>
</html>
 