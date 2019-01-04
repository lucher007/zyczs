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
	<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
		<div class="cur-pos">当前位置：市场管理 > 溯源秤规格配置</div>
	</c:if>
	<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
		<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤规格配置</div>
	</c:if>
    <div class="seh-box">
    	<cite><a href="/manage/cheng/addChengConf.jsp" class="btn-a"><span class="new">新建溯源秤规格</span></a></cite>
        	
        <form action="" method="post" name="searchform" id="searchform">
			厂商名称：
			<select id="companyname" name="companyname" class="w158" onchange="return checkForm();"></select>
<!--			<input type="text" maxlength="40" class="inp w250" id="companyname" name="companyname" value="${requestScope.companyname }">-->
<!--        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>-->
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>厂商名称</td>
            <td>规格名称</td>
            <td>行数</td>
            <td>列数</td>
            <td>操作</td>
          </tr>
          <c:forEach items="${requestScope.chengconflist}" var="dataList">
          <tr class="lb-list">
            <td height="30">${dataList.companyname }</td>
            <td>${dataList.normname }</td>
            <td>${dataList.rowsnum }&nbsp;行</td>
            <td>${dataList.columnnum }&nbsp;列</td>
            <td>
            	<a href="javascript:update(${dataList.confid });" class="btn-edit">修改
            </a> 
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="chengConf!findByList.shtml"
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
	    $(document).ready(function(){
            var html = "<option value=''>--请选择--</option>";//拼接溯源秤厂商下拉框
            var companys = '${initParam.cheng_company}';
            var compnayArr = companys.split(',');
            if(compnayArr != null){
                for(var i=0;i<compnayArr.length;i++){
                   var company = compnayArr[i];
                   var valueArr= company.split('-');
                   
                   if(valueArr.length ==2 ){
                       if('${requestScope.companyname}' == valueArr[0]){
                           html += "<option value=\"" +valueArr[0]+ "\" selected " + " >" +valueArr[1]+ "</option>";
                       }else{
                           html += "<option value=\"" +valueArr[0]+ "\" " + " >" +valueArr[1]+ "</option>";
                       }
                   }
                }
            }
            $("#companyname").html(html);
        });
	    
	    
		function checkForm(){
			$("#searchform").attr("action","chengConf!findByList.shtml");
			$("#searchform").submit();
		}	   
		function update(confid){
			$("#searchform").attr("action", "chengConf!updateInit.shtml?confid="+confid);
			$("#searchform").submit();
		}
	</script>
</body>
</html>

