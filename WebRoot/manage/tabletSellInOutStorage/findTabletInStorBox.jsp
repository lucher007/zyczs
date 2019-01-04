<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head> 
		<meta charset="utf-8">
		<base href="<%=basePath%>">    
		<title>入库详情</title>   
		<link type="text/css" rel="stylesheet" href="/style/plant.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：库存管理  &gt; 入库查询</div>
		<div class="form-box">
	    	<form action="" method="post" name="searchform" id="searchform">
	    	<input type="hidden" name="inoutstorid" id="inoutstorid" value="${requestScope.inoutstorid }"/>
	    	<div class="fb-tit">入库详情</div>
	        <div class="fb-con">
<!--	            <table cellpadding="0" cellspacing="0" border="0" width="100%">-->
<!--	                <tr>-->
<!--	                    <td height="40" >销售企业：${requestScope.inoutstorage.sellcorpname }</td>-->
<!--	                    <td>入库时间：${fn:substring(requestScope.inoutstorage.opertime, 0, 11) }</td>-->
<!--	                    <td>总重量(kg)：<b class="red">${requestScope.inoutstorage.strtotalweight }</b></td>-->
<!--	                </tr>-->
<!--	 			</table>-->
               
                <table id="source" width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		          <tr class="fbc-tit">
		            <td>品名</td>
		            <td>批次号</td>
		            <td>小包装规格(g/包)</td>
		            <td>包装类型</td>
		            <td>溯源码数</td>
		            <td>总重量(Kg)</td>
		          </tr>
		          <c:forEach items="${requestScope.inoutstorboxlist}" var="inoutstorbox">
			  	  <tr class="fb-list">
			  		<td height="30">
			  		${(inoutstorbox.prodname==null || inoutstorbox.prodname == '')?'--大包装--':inoutstorbox.prodname }&nbsp;
			  		</td>
			  		<td>${inoutstorbox.batchcpc }&nbsp;</td>
			  		<td>
			  		<c:set var="boxnumweight" value="${inoutstorbox.boxnumweight}" scope="request" />
	           		 <%
	           		Object boxnumweight=request.getAttribute("boxnumweight");	
	           		if(boxnumweight == null){
              		   boxnumweight = 0;
              		}
	           		 %>   
	                <%=Tools.scienceToString(Tools.division(boxnumweight.toString(),"10"))%>       
                
			  		&nbsp;
			  		</td>
			  		<td>
			  		    <c:if test="${inoutstorbox.codetype==5}">
			  		        	小包
			  		    </c:if>
			  		    <c:if test="${inoutstorbox.codetype==6}">
			  		           	 中包
			  		    </c:if>
			  		    <c:if test="${inoutstorbox.codetype==7}">
			  		           	大包
			  		    </c:if>
			  		    <c:if test="${inoutstorbox.codetype==8}">
			  		           	大包
			  		    </c:if>
			  		</td>
			  		<td><a href="<%=basePath %>inOutStorBox!findTabletInStorItem_tabletSell.shtml?inoutstorboxid=${inoutstorbox.inoutstorboxid }&codetype=${inoutstorbox.codetype }&inoutstorid=${requestScope.inoutstorid }" class="btn-bag">${inoutstorbox.boxnum }&nbsp;</a></td>
			  		<td>
			  		<c:set var="strtotalweight" value="${inoutstorbox.strtotalweight }" scope="request" />
	           		 <%
	           		Object strtotalweight=request.getAttribute("strtotalweight");	
	           		 %>   
	                <%=Tools.scienceToString(Tools.dealNullDouble(strtotalweight.toString(),0))%>       
                
			  		&nbsp;
			  		</td>
			  	  </tr>
		  		  </c:forEach>
		        </table>
		        
		        <table id="nosource" width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		          <tr class="fbc-tit">
		            <td width="20">品名</td>
		            <td width="40">批次号</td>
		            <td width="20">总重量(Kg)</td>
		          </tr>
		          <c:forEach items="${requestScope.inoutstorboxlist}" var="inoutstorbox">
			  	  <tr class="fb-list">
			  		<td height="30" >${inoutstorbox.prodname }&nbsp;</td>
			  		<td >${inoutstorbox.batchcpc }&nbsp;</td>
			  		<td>${inoutstorbox.strtotalweight }&nbsp;</td>
			  	  </tr>
		  		  </c:forEach>
		        </table>
		        
		        <div class="page">
					<cite>
					<pg:pager url="inOutStorBox!findTabletInStorBox_tabletSell.shtml"
						items="${requestScope.pager_count}" index="center" maxPageItems="10"
						maxIndexPages="5" isOffset="<%=true%>"
						export="offset,currentPageNumber=pageNumber" scope="request">
						<pg:param name="index" />
						<pg:param name="maxPageItems" />
						<pg:param name="maxIndexPages" />
						<pg:param name="inoutstorid" value="${requestScope.inoutstorid }" />
						<pg:param name="zstype" value="${requestScope.zstype }" />
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
								<a href="<%=pageUrl%>">首页</a>
							</pg:first>
							<pg:prev export="prevPageUrl=pageUrl">
								<a href="<%=prevPageUrl%>" title="上一页" class="prev">&nbsp;</a>
							</pg:prev>
							<pg:pages>
								<%
									if (pageNumber == currentPageNumber) {
								%><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a>
								<%
									} else {
								%><a href="<%=pageUrl%>"><%=pageNumber%></a>
								<%
									}
								%>
							</pg:pages>
							<pg:next export="nextPageUrl=pageUrl">
								<a href="<%=nextPageUrl%>" title="下一页" class="next">&nbsp;</a>
							</pg:next>
							<pg:last>
								<a href="<%=pageUrl%>">末页</a>
							</pg:last>
						</pg:index>
					</pg:pager>　
					</cite>
				</div>
	    	</div>
	        <div class="fb-bom">
	            <input type="button" value="返回上一页" onclick="javascript:goBack();" class="sbt"/>
	        </div>
	        </form>
	     </div>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
	<script type="text/javascript">
		var zstype = '${zstype}';
	    if(zstype == 0){
	    	$("#source").show();
	    	$("#nosource").hide();
	    }else{
	        $("#source").hide();
	    	$("#nosource").show();
	    }
	    
	     function goBack(){
	        $("#searchform").attr("action","inOutStor!findTabletInStor_tabletSell.shtml");
			$("#searchform").submit();
	    }
	</script>
	</body>
</html>
 