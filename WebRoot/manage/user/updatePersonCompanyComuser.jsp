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
			<input type="hidden" name="userid" id="userid" value="${sessionScope.comuser.userid }" />
    		<div class="fb-tit">企业详情 <span>企业CPC码：${sessionScope.comuser.cpccorp }</span></div>
        	<div class="fb-con">
		        <table width="736" class="ml10">
		          <tr>
		            <td height="30" width="150" align="right" bgcolor="#EEEEEE">所属企业：</td>
		            <td>
		            	${sessionScope.comuser.org.orgname }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业类型：</td>
		            <td style="line-height:22px;">
		            	<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 4, 5)=='1'}">药材市场 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 5, 6)=='1'}">医院 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 6, 7)=='1'}">管理机构 </c:if>
		           		<c:if test="${fn:substring(sessionScope.comuser.org.zyctype, 7, 8)=='1'}">其他</c:if>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业联系人：</td>
		            <td>
		            	${sessionScope.comuser.org.linkman }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业法人：</td>
		            <td>
		            	${sessionScope.comuser.org.masterman }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业法人身份证：</td>
		            <td>
		            	${sessionScope.comuser.org.identitycard }
		           	</td>
		          </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">营业执照号：</td>
		            <td>
		            	${sessionScope.comuser.org.businesscode }
		           	</td>
		          </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">组织机构代码证：</td>
		            <td>
		            	${sessionScope.comuser.org.orgcode }
		           	</td>
		          </tr>
		          <c:if test="${sessionScope.comuser.org.gapcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GAP：</td>
		            <td>
		            	${sessionScope.comuser.org.gapcode }
		           	</td>
		          </tr>
		          </c:if>
		          <c:if test="${sessionScope.comuser.org.gspcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GSP：</td>
		            <td>
		            	${sessionScope.comuser.org.gspcode }
		           	</td>
		          </tr>
		          </c:if>
		          <c:if test="${sessionScope.comuser.org.gmpcode!=null }">
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">GMP：</td>
		            <td>
		            	${sessionScope.comuser.org.gmpcode }
		           	</td>
		          </tr>
		          </c:if>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">企业所属区域：</td>
		            <td>
		            	${sessionScope.comuser.org.province } - 
		            	${sessionScope.comuser.org.city } - 
		            	${sessionScope.comuser.org.area }
		           	</td>
		          </tr>
		         <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">详细地址：</td>
		            <td>
		            	${sessionScope.comuser.org.registeraddress }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">移动电话：</td>
		            <td>
		            	${sessionScope.comuser.org.mobile }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">固定电话：</td>
		            <td>
		            	${sessionScope.comuser.org.telephone }
		            </td>
		           </tr>
		          <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">传真：</td>
		            <td>
		            	${sessionScope.comuser.org.officephone }
		            </td>
		           </tr>
		           
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">电子邮件：</td>
		            <td>
		            	${sessionScope.comuser.org.email }
		            </td>
		           </tr>
		           <tr>
		            <td height="30" align="right" bgcolor="#EEEEEE">邮编：</td>
		            <td>
		            	${sessionScope.comuser.org.postcode }
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
