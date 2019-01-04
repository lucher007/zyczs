<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
   	    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：日常检查管理 > 日常检查详情</div>
		<form action="company!update.shtml" id="dataForm" name="dataForm" method="post">
			<div class="form-box">
					<div class="fb-tit">详情</div>
				    <div class="reg-box mt10">
				        <table width="100%" border="0" cellpadding="0" cellspacing="0">
				          <tr>
				            <td width="150" height="30" align="right">经营户编号：</td>
				            <td>
				            	<input type="text" class="inponly" id="cpccorp"  name="cpccorp" readonly maxlength="20" value="${requestScope.form.cpccorp }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">经营户编号名称：</td>
				            <td>
				            	<input type="text" class="inponly" id="orgname"  name="orgname" readonly maxlength="20" value="${requestScope.form.orgname }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">所属市场：</td>
				            <td>
				            	<input type="text" class="inponly" id="marketname"  name="marketname" readonly maxlength="20" value="${requestScope.form.marketname }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">检查项目：</td>
				            <td>
				            	<input type="text" class="inponly" id="checkproject"  name="checkproject" readonly maxlength="20" 
				            		value='<c:if test="${requestScope.form.checkproject == 1}">安全</c:if><c:if test="${requestScope.form.checkproject == 2}">质量</c:if><c:if test="${requestScope.form.checkproject == 3}">卫生</c:if><c:if test="${requestScope.form.checkproject == 4}">价格</c:if><c:if test="${requestScope.form.checkproject == 5}">其它</c:if>' >
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">检查结果：</td>
				            <td>
				            	<input type="text" class="inponly" id="checkresult"  name="checkresult" readonly maxlength="20" value="<c:if test="${requestScope.form.checkresult == 1}">合格</c:if><c:if test="${requestScope.form.checkresult == 2}">不合格</c:if><c:if test="${requestScope.form.checkresult == 3}">未检查</c:if>">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">药材批次号：</td>
				            <td>
				            	<input type="text" class="inponly" id="cpcmeds"  name="cpcmeds" readonly maxlength="20" value="${requestScope.form.cpcmeds }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">扣分：</td>
				            <td>
				            	<input type="text" class="inponly" id="deductscore"  name="deductscore" readonly maxlength="20" value="${requestScope.form.deductscore }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">执行人员：</td>
				            <td>
				            	<input type="text" class="inponly" id="checkperson"  name="checkperson" readonly maxlength="20" value="${requestScope.form.checkperson }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="30" align="right">执行单位：</td>
				            <td>
				            	<input type="text" class="inponly" id="opername"  name="opername" readonly maxlength="20" value="${requestScope.form.opername }">
				            </td>
				          </tr>
				          <tr>
				            <td width="150" height="96" align="right" valign="top">备注说明：</td>
				            <td>
				            	<textarea rows="5" cols="40">${requestScope.form.checknote }</textarea>
				            </td>
				          </tr>
				        </table>
					</div>
					<div class="fb-bom">
			        	<cite><input type="button" value="返回"  class="sbt" id="back"></cite>
			    </div>
			</div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript">
		$("#back").click(function(){
			history.go(-1);
		});
	</script>
	</body>
</html>