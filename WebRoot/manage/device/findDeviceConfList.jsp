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
	<div class="cur-pos">当前位置：设备管理 > 设备规格配置</div>
    <div class="seh-box">
    	<cite><a href="/manage/device/addDeviceConf.jsp" class="btn-a"><span class="new">新建设备规格</span></a></cite>
        <form action="" method="post" name="searchform" id="searchform">
			厂商名称：<input type="text" maxlength="40" class="inp w250" id="companyname" name="companyname" value="${requestScope.companyname }">
                                　设备类型：<select id="conftype" name="conftype" class="w100" >
                        <option value="" <c:if test="${requestScope.conftype == null }">selected</c:if>>--请选择--</option>
                   		<option value="1" <c:if test="${requestScope.conftype == 1 }">selected</c:if>>打印机</option>
                   		<option value="2" <c:if test="${requestScope.conftype == 2 }">selected</c:if>>扫描设备</option>
                   		<option value="3" <c:if test="${requestScope.conftype == 3 }">selected</c:if>>移动终端</option>
                   		<option value="4" <c:if test="${requestScope.conftype == 4 }">selected</c:if>>IC卡</option>
                   		<option value="5" <c:if test="${requestScope.conftype == 5 }">selected</c:if>>查询机</option>
                   		<option value="6" <c:if test="${requestScope.conftype == 6 }">selected</c:if>>耗材</option>
                   		<option value="7" <c:if test="${requestScope.conftype == 7 }">selected</c:if>>计算机</option>
                   		<option value="8" <c:if test="${requestScope.conftype == 8 }">selected</c:if>>读写卡器</option>
                   		<option value="9" <c:if test="${requestScope.conftype == 9 }">selected</c:if>>其他设备</option>
                   	 </select>
        	         <input type="button" value="查询" class="sch" onclick="return checkForm();"/>
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>厂商名称</td>
            <td>规格名称</td>
            <td>设备类型</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.deviceconflist}" var="dataList">
          <tr class="lb-list">
            <td height="30">${fn:substring(dataList.companyname, 0, 15)}</td>
            <td>${fn:substring(dataList.normname, 0, 15)}</td>
            <td>
               <c:if test="${dataList.conftype==1}">打印机</c:if>
               <c:if test="${dataList.conftype==2}">扫描设备</c:if>
               <c:if test="${dataList.conftype==3}">移动终端</c:if>
               <c:if test="${dataList.conftype==4}">IC卡</c:if>
               <c:if test="${dataList.conftype==5}">查询机</c:if>
               <c:if test="${dataList.conftype==6}">耗材</c:if>
               <c:if test="${dataList.conftype==7}">计算机</c:if>
               <c:if test="${dataList.conftype==8}">读写卡器</c:if>
               <c:if test="${dataList.conftype==9}">其他设备</c:if>
            </td>
            <td>
            	<a class="btn-edit" href="<%=basePath %>deviceConf!updateInit.shtml?confid=${dataList.confid }">修改</a>
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="deviceConf!findByList.shtml"
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
					<pg:param name="companyname" value="${requestScope.companyname }" />
					<pg:param name="conftype" value="${requestScope.conftype }" />
					<pg:index>
					总共${requestScope.pager_count}条记录
					<pg:first unless="current">
						<a href="<%=pageUrl %>">首页</a>
					</pg:first>
					<pg:prev export="prevPageUrl=pageUrl">
					  	<a href="<%= prevPageUrl %>">前一页</a>
					</pg:prev>
					<pg:pages>
		   				<%if (pageNumber == currentPageNumber) { 
					        %><span style="font:bold 16px arial;"><%= pageNumber %></span><%
					      } else { 
					        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
					      }
					    %>  
					</pg:pages>
					<pg:next export="nextPageUrl=pageUrl">
					  	<a href="<%= nextPageUrl %>">下一页</a>
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
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript">
		function checkForm(){
			$("#companyname").val($.trim($("#companyname").val()));
			if(checkquotmarks($("#companyname").val())){
				$("#companyname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","deviceConf!findByList.shtml");
			$("#searchform").submit();
		}    
	</script>
</body>
</html>

