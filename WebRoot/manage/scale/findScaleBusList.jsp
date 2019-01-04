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
	<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤交易查询</div>
    <div class="seh-box">
        <form action="scalesbus!findByList.shtml" method="post" id="searchForm" name="searchForm">
        	<table width="100%">
        		<tr>
        			<td align="right" width="13%">企业名称：</td>
        			<td><input type="text" name="corpname" maxlength="20" value="${requestScope.corpname }"></td>
        			<td align="right" width="13%">&nbsp;</td>
        			<td>&nbsp;</td>
        		</tr>
        		
        		<tr>
        			<td align="right" width="13%">交易开始时间：</td>
        			<td><input type="text" class="inp" name="starttime"
										id="starttime"
										onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true});"
										onblur="onBlurCheck(this.name)"
										style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" />
        	        </td>	
        			<td align="right" width="13%">交易结束时间：</td>
        			<td><input type="text" class="inp" name="endtime"
										id="endtime"
										onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true});"
										onblur="onBlurCheck(this.name)"
										style="background: #ffffff url('images/growaddunittime.png') no-repeat right;" />
        			&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" class="sch"></td>
        		</tr>
        	</table>
        </form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
            <td>企业名称</td>
            <td>药材名称</td>
            <td>销售码</td>
            <td>单价（元/Kg）</td>
            <td>重量（Kg）</td>
            <td>总价（元）</td>
            <td>交易时间</td>
          </tr>
          <c:forEach items="${requestScope.mappdataList}" var="dataList">
          <tr class="lb-list">
            <td width="100" height="30">${dataList.corpname }</td>
            <td>${dataList.name }</td>
            <td>${dataList.sourcecode }</td>
            <td>${dataList.unitprice }</td>
            <td>${dataList.weight }</td>
            <td>${dataList.totalprice }</td>
            <td >${dataList.tradingtime }</td>
          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="scalesbus!findByList.shtml"
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
					<pg:param name="username" value="${requestScope.username }"/>
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
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
 <script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript">

function updateInit(userid,orgid){
	$("#searchForm").attr("action", "user!updateInit.shtml?userid="+userid+"&orgid="+orgid);
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

