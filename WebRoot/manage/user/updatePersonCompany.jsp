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
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：企业详情</div>
    	<div class="form-box">
    		<form action="user!updatePerson.shtml" id="dataForm" name="dataForm" method="post">
			<input type="hidden" name="userid" id="userid" value="${sessionScope.User.userid }" />
    		<div class="fb-tit">企业详情 <span>企业CPC码：${sessionScope.User.cpccorp }</span></div>
        	<div class="fb-con">
		        <table width="736" class="ml10">
		          <tr>
		            <td height="30" width="150" align="right" bgcolor="#EEEEEE">所属企业：</td>
		            <td>
		            	${sessionScope.User.company.corpname }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" width="150" align="right" bgcolor="#EEEEEE">企业简称：</td>
		            <td>
		            	${sessionScope.User.company.corpshortname }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业类型：</td>
		            <td style="line-height:22px;">
		            	<c:if test="${fn:substring(sessionScope.User.company.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 4, 5)=='1'}">药材市场 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 5, 6)=='1'}">医院 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 6, 7)=='1'}">管理机构 </c:if>
		           		<c:if test="${fn:substring(sessionScope.User.company.zyctype, 7, 8)=='1'}">其他</c:if>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业联系人：</td>
		            <td>
		            	${sessionScope.User.company.linkman }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业法人：</td>
		            <td>
		            	${sessionScope.User.company.masterman }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业法人身份证：</td>
		            <td>
		            	${sessionScope.User.company.identitycard }
		           	</td>
		          </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">营业执照号：</td>
		            <td>
		            	${sessionScope.User.company.businesscode }
		           	</td>
		          </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">组织机构代码证：</td>
		            <td>
		            	${sessionScope.User.company.orgcode }
		           	</td>
		          </tr>
		          <c:if test="${sessionScope.User.company.gapcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GAP：</td>
		            <td>
		            	${sessionScope.User.company.gapcode }
		           	</td>
		          </tr>
		          </c:if>
		          <c:if test="${sessionScope.User.company.gspcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GSP：</td>
		            <td>
		            	${sessionScope.User.company.gspcode }
		           	</td>
		          </tr>
		          </c:if>
		          <c:if test="${sessionScope.User.company.gmpcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GMP：</td>
		            <td>
		            	${sessionScope.User.company.gmpcode }
		           	</td>
		          </tr>
		          </c:if>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业所属区域：</td>
		            <td>
		            	${sessionScope.User.company.province } - 
		            	${sessionScope.User.company.city } - 
		            	${sessionScope.User.company.area }
		           	</td>
		          </tr>
		         <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">详细地址：</td>
		            <td>
		            	${sessionScope.User.company.registeraddress }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">移动电话：</td>
		            <td>
		            	${sessionScope.User.company.mobile }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">固定电话：</td>
		            <td>
		            	${sessionScope.User.company.telephone }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">传真：</td>
		            <td>
		            	${sessionScope.User.company.officephone }
		            </td>
		           </tr>
		           
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">电子邮件：</td>
		            <td>
		            	${sessionScope.User.company.email }
		            </td>
		           </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">邮编：</td>
		            <td>
		            	${sessionScope.User.company.postcode }
		            </td>
		           </tr>
		      </table>
        	</div>
        	</form>
        </div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	</body>
</html>
