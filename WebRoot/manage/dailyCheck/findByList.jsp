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
		<base href="<%=basePath%>" />
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：日常检查管理 > 日常检查列表</div>
	    <div class="seh-box">
	        <form action="dailyCheck!findByList.shtml" method="post" id="searchform" name="searchform">
	        	<table width="100%">
		    		<tr>
		    			<td height="30">
		    			<table width="100%" cellspacing="0" cellspadding="0" border="0">
		    				<tr>
				    			<td>检查项目：
				    				<select name="checkproject" id="checkproject">
				    					<option value="-1" <c:if test="${requestScope.checkproject == -1 }">selected</c:if>>--请选择--</option>
				    					<option value="1" <c:if test="${requestScope.checkproject == 1 }">selected</c:if>>安全</option>
				    					<option value="2" <c:if test="${requestScope.checkproject == 2 }">selected</c:if>>质量</option>
				    					<option value="3" <c:if test="${requestScope.checkproject == 3 }">selected</c:if>>卫生</option>
				    					<option value="4" <c:if test="${requestScope.checkproject == 4 }">selected</c:if>>价格</option>
				    					<option value="5" <c:if test="${requestScope.checkproject == 5 }">selected</c:if>>其他</option>
				    				</select>
				    			</td>
				    			<td>检查结果：
				    					<select name="checkresult" id="checkresult">
				    					<option value="-1"  <c:if test="${requestScope.checkresult == -1 }">selected</c:if>>--请选择--</option>
				    					<option value="1"  <c:if test="${requestScope.checkresult == 1 }">selected</c:if>>合格</option>
				    					<option value="2"  <c:if test="${requestScope.checkresult == 2 }">selected</c:if>>不合格</option>
				    				    <option value="3"  <c:if test="${requestScope.checkresult == 3 }">selected</c:if>>检查中</option>
				    				</select>
								</td>
								<td>检查时间：
									<input type="text" name="startcheckdate" id="startcheckdate" value="${fn:substring(startcheckdate,0,11)}" class="Wdate inp w100" 
									onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'endcheckdate\');}'});"/>
									到
									<input type="text" name="endcheckdate" id="endcheckdate" value="${fn:substring(endcheckdate,0,11)}" class="Wdate inp w100" 
									onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'startcheckdate\');}'});"/>
									&nbsp;
								</td>
							</tr>
						</table>
						</td>
					</tr>
		    			<tr>
		    				<td height="30">
		    				<table width="100%" cellspacing="0" cellspadding="0" border="0">
		    					<tr>
			    					<td width="240">所属市场：
			    						<input type="text" value="${marketname }"  id="marketname" class="inp" name="marketname" maxlength="40">
				    				</td>
				    				<td width="292">执行单位：
				    					<input type="text" value="${opername }"  id="opername" class="inp" name="opername" maxlength="40">
				    				</td>
				    				<td align="center"><input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
		    					</tr>
		    				</table>
		    			</tr>
		    	</table>
	        </form>
	    </div>
	    <div class="lst-box">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr class="lb-tit">
	           	<td>商户名称</td>
	            <td>所属市场</td>
	            <td>检查项目</td>
	            <td>检查结果</td>
	            <td>检查扣分</td>
	            <td>执行人员</td>
	            <td>执行单位</td>
	            <td>检查时间</td>
	            <td>检查详情</td>
	          </tr>
	          <c:forEach items="${list}" var="item">
	          <tr class="lb-list">
	           	<td height="30" width="80" title="${item.orgname }"><div class="w80 ho">${item.orgname}</div></td>
	         	<td height="30" width="80" title="${item.marketname }"><div class="w80 ho">${item.marketname}</div></td>
	            <td>
	            	<c:if test="${item.checkproject == 1}">安全</c:if>
	            	<c:if test="${item.checkproject == 2}">质量</c:if>
	            	<c:if test="${item.checkproject == 3}">卫生</c:if>
	            	<c:if test="${item.checkproject == 4}">价格</c:if>
	            	<c:if test="${item.checkproject == 5}">其它</c:if>
	            </td>
	            <td>
	           		 <c:if test="${item.checkresult == 1}">合格</c:if>
	           		 <c:if test="${item.checkresult == 2}">不合格</c:if>
	           		 <c:if test="${item.checkresult == 3}">检查中</c:if>	
	            </td>
	            <td>${item.deductscore }</td>
	            <td>${item.checkperson }</td>
	            <td>${item.opername }</td>
	            <td>${fn:substring(item.checkdate,0,11)}</td>
	            <td><a href="javascript:findById(${item.id });" class="btn-edit">详情</a></td>
	          </tr>
	          </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
	            	<pg:pager
					    url="dailyCheck!findByList.shtml"
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
						<pg:param name="checkproject" value="${requestScope.checkproject }"/>
						<pg:param name="checkresult" value="${requestScope.checkresult }"/>
						<pg:param name="startcheckdate" value="${requestScope.startcheckdate }"/>
						<pg:param name="endcheckdate" value="${requestScope.endcheckdate }"/>
						<pg:param name="marketname" value="${requestScope.marketname }"/>
						<pg:param name="opername" value="${requestScope.opername }"/>
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
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
	cMenu(0,0);
	function checkForm(){
		$("#marketname").val($.trim($("#marketname").val()));
		$("#opername").val($.trim($("#opername").val()));
		if(checkquotmarks($("#marketname").val())){
			$("#marketname").focus();
			$.dialog.tips('市场不能包含~ # *等字符',1,'alert.gif');
			return false;
		}
		if(checkquotmarks($("#opername").val())){
			$("#opername").focus();
			$.dialog.tips('单位不能包含~ # *等字符',1,'alert.gif');
			return false;
		}
		
		$("#searchform").attr("action","dailyCheck!findByList.shtml");
		$("#searchform").submit();
	}
	
	function findById(id){
		$("#searchform").attr("action", "dailyCheck!findById.shtml?id="+id);
		$("#searchform").submit();
	}
	
	</script>
	</body>
</html>
