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
	<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤规格配置</div>
    <div class="seh-box">
    	<cite><a href="scalesstat!synchronousPlu.shtml" class="btn-a"><span class="new">同步PLU</span></a></cite>
        <form action="scaleAction!findByList.shtml" method="post" id="searchForm" name="searchForm">
			溯源秤号：<input type="text" size="50" maxlength="32" name="scalecode" id="scalecode" onkeyup="check_IsNum(this.value)"  onkeypress="check_IsNum(this.value)" value="${requestScope.scalecode }">
        	<input type="submit" value="查询" class="sch">
        	
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>溯源秤号</td>
            <td>规格</td>
            <td>经营户名称</td>
            <td>发放日期</td>
            <td>状态</td>
            <td>锁定操作</td>
            <td>快捷键操作</td>
            <td>PLU操作</td>
            <td>键盘图</td>
          </tr>
          <c:forEach items="${requestScope.scaleList}" var="dataList">
          <tr class="lb-list">
            <td height="30">${dataList.scalecode }&nbsp;</td>
            <td>${dataList.scalenorm }&nbsp;</td>
            <td>${dataList.userName }&nbsp;</td>
            <td>${dataList.addtime }&nbsp;</td>
            <td>
            	<c:choose>
            		<c:when test="${dataList.differtime == '2'}">
            			离线
            		</c:when>
            		<c:otherwise>
            			在线
            		</c:otherwise>
            	</c:choose>
			</td>
            <td>
            	<c:if test="${dataList.locked=='0' && dataList.comlocked=='1'}">锁定中</c:if>
            	<c:if test="${dataList.locked=='1' && dataList.comlocked=='0'}">解锁中</c:if>
            	<c:if test="${dataList.locked=='0' && dataList.locked==dataList.comlocked}"><a href="javascript:updateScale('${dataList.scalecode }',1);">锁定</a></c:if>
            	<c:if test="${dataList.locked=='1' && dataList.locked==dataList.comlocked}"><a href="javascript:updateScale('${dataList.scalecode }',0);">解锁</a></c:if> 
            </td>
            <td>
            	<c:if test="${dataList.keyver==dataList.comkeyver}"><a href="javascript:updateKeyver('${dataList.scalecode }');">修改</a></c:if>
            	<c:if test="${dataList.keyver==dataList.comkeyver}"><a href="javascript:updateKeyverValue('${dataList.scalecode }',${dataList.comkeyver });">更新</a></c:if>
            	<c:if test="${dataList.keyver!=dataList.comkeyver}">更新中</c:if>
            </td>
            <td>
            	<c:if test="${dataList.pluver==dataList.compluver}"><a href="javascript:updatePluver('${dataList.scalecode }',${dataList.compluver });">更新</a></c:if>
            	<c:if test="${dataList.pluver!=dataList.compluver}">更新中</c:if>
            	&nbsp;
            </td>
            <td>
            	<a >下载</a>
            </td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scaleAction!findByList.shtml"
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
					<pg:param name="scalecode" value="${requestScope.scalecode }"/>
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
<script type="text/javascript">

function updateScale(scalecode,comlocked){
	var scale = document.getElementById("scalecode");
	scale.value=scalecode;
	if(!confirm("确认操作?")){
		return;
	}
	$("#searchForm").attr("action", "scalesstat!updateScale.shtml?comlocked="+comlocked);
	$("#searchForm").submit();
}
//修改键所对应商品
function updateKeyver(scalecode){
	var scale = document.getElementById("scalecode");
	scale.value=scalecode;
	$("#searchForm").attr("action", "scaleAction!updateScaleInit.shtml");
	$("#searchForm").submit();
}
//修改快捷键命令版本
function updateKeyverValue(scalecode,comkeyver){
	if(!confirm("确认操作?")){
		return;
	}
	var scale = document.getElementById("scalecode");
	scale.value=scalecode;
	$("#searchForm").attr("action", "scalesstat!updateKeyver.shtml?comkeyver="+comkeyver);
	$("#searchForm").submit();
}

//修改Plu命令版本
function updatePluver(scalecode,compluver){
	if(!confirm("确认操作?")){
		return;
	}
	var scale = document.getElementById("scalecode");
	scale.value=scalecode;
	$("#searchForm").attr("action", "scalesstat!updatePluver.shtml?compluver="+compluver);
	$("#searchForm").submit();
}

//1.js验证只能输入数字.
	function checkNumberChar(ob){
		if(/^\d+$/.test(ob)){
			return true;
		}else{
			return false;
		}
	}
	
	function check_IsNum(value){
		//先把非数字的都替换掉，除了数字
		//value = value.replace(/^\d+$/,"");  
	    //定义正则表达式部分
        if(!checkNumberChar(value)){
        	document.getElementById("scalecode").value = "";
        }
	}
</script>
</body>
</html>

