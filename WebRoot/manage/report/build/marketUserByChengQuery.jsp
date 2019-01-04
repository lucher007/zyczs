<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<meta charset="utf-8">
<title>库存和交易量统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 统计导出</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     库存和交易量统计
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	          <table width="100%">
                  <tr>
                    <td height="26"  align="right" >是否发秤：</td>
                    <td>
                    	<select id="chengflag" name="chengflag" style="width:128px">
                    	    <option value="0" <c:if test="${requestScope.chengflag == 0}">selected</c:if>>未发秤</option>
                    	    <option value="1" <c:if test="${requestScope.chengflag == 1}">selected</c:if>>已发秤</option>
                    	</select>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
					<td colspan="2" align="right" >
						<input type="button" value="查询" class="sch" onclick="return checkForm();">
					</td>
					<td>
						<cite><a href="javascript:void(0)" class="btn-a" onclick="return checkForm_exp();"><span class="new">导出EXCEL</span></a></cite>
					</td>
                  </tr>
                </table>   
	        </form>
		    </div>
		    <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		  	  <tr class="fbc-tit">
	            <td align="center">企业CPC</td>
	            <td align="center">企业名称</td>
	            <td align="center">联系电话</td>
	            <td align="center">固定电话</td>
	            <td align="center">联系人</td>
	            <td align="center">法人</td>
	            <td align="center">注册地址</td>
	          </tr>
	          <c:forEach items="${requestScope.buildlist}" var="build">
		          <tr class="lb-list">
		            <td width="100" height="30">${build.cpccorp }&nbsp;</td>
		            <td class="remarkClass" title="${build.orgname }">${fn:substring(build.orgname, 0, 5)}&nbsp;</td>
		            <td>${build.mobile }&nbsp;</td>
		            <td>${build.telephone }&nbsp;</td>
		            <td>${build.linkman }&nbsp;</td>
		            <td>${build.masterman }&nbsp;</td>
		            <td class="remarkClass" title="${build.registeraddress }">${fn:substring(build.registeraddress, 0, 5)}&nbsp;</td>
		          </tr>
		     </c:forEach>
            </table>
             <div class="page">
        	<cite>
            	<pg:pager
				    url="rp_Build!marketUserByChengQuery.shtml"
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
					<pg:param name="chengflag" value="${requestScope.chengflag }"/>
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
            <br/>
		</div>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaSearch.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/highcharts.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/highcharts-more.js"></script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/highcharts/exporting.js"></script>
<script type="text/javascript">
   function checkForm(){
		$("#searchform").attr("action","rp_Build!marketUserByChengQuery.shtml");
		$("#searchform").submit();
	}	   
   
   function checkForm_exp(){
		$("#searchform").attr("action","rp_Build!marketUserByChengStat_excel.shtml");
		$("#searchform").submit();
	}	
   
</script>
</body>
</html>
 