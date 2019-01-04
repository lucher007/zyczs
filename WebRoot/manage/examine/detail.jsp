<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>饮片基础列表</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css">
	</head>

	<body onload="resetH();">
	
	<form action=""  method="post" name="searchform" id="searchform">
	<input type="hidden" name="year" value="${requestScope.year}"/>
	<input type="hidden" name="quarter" value="${requestScope.quarter}"/>
	<div id="body">
	 	<div class="cur-pos">
			当前位置：绩效考核 > 考核结果
		</div>
		
		<c:if test="${fn:length(sessionScope.detailList)>0}">	
		<div class="lst-box">
			<div class="page">
				<b style="font-size:18px;">企业覆盖率</b>			
			</div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						地区编号
					</td>
					<td>
						区县名称
					</td>
					<td>
						种植基地
					</td>
						
					<td>
						中药材<br>经销企业
					</td>
					<td>
						专业市场<br>经营企业
					</td>
					<td>
						饮片生产<br>企业
					</td>
					<td>
						饮片经销<br>企业
					</td>
					<td>
						饮片使用<br>单位
					</td>
					<td>
						综合
					</td>
				</tr>
				<c:forEach items="${sessionScope.detailList}" var="list">
					<c:if test="${list.ratetype=='1' }">
					<tr class="lb-list" id="tr_${list.id }">
						
						<td height="30">
							${list.areacode }&nbsp;
						</td>
						<td>
							${list.areas }&nbsp;
						</td>
						<td>	
							
							
							<c:set var="medrate" value="${fn:split(list.medrate, ',')}"  />
							
							<c:if test="${medrate[1]==0 }">
								0
								<c:set var="medrate_rate" value="0" />
							</c:if>
							<c:if test="${medrate[1]!=0 }">
							<fmt:formatNumber  var="medrate_rate" value="${medrate[0]/medrate[1] }" pattern="#0"/>
								${medrate_rate*100}
							</c:if>							
							%
							
						</td>						
						<td>
							<c:set var="medsellrate" value="${fn:split(list.medsellrate, ',')}"  />
							
							<c:if test="${medsellrate[1]==0 }">
								0
								<c:set var="medsellrate_rate" value="0" />
							</c:if>
							<c:if test="${medsellrate[1]!=0 }">
							<fmt:formatNumber  var="medsellrate_rate" value="${medsellrate[0]/medsellrate[1] }" pattern="#0"/>
							${medsellrate_rate*100}
							</c:if>							
							%
						</td>
						<td>

							<c:set var="medmarketrate" value="${fn:split(list.medmarketrate, ',')}"  />
							
							<c:if test="${medmarketrate[1]==0 }">
								0
								<c:set var="medmarketrate_rate" value="0" />
							</c:if>
							<c:if test="${medmarketrate[1]!=0 }">
							<fmt:formatNumber  var="medmarketrate_rate" value="${medmarketrate[0]/medmarketrate[1] }" pattern="#0"/>
							${medmarketrate_rate*100}
							</c:if>							
							%
						</td>
						<td>

							<c:set var="tabletrate" value="${fn:split(list.tabletrate, ',')}"  />
							
							<c:if test="${tabletrate[1]==0 }">
								0
								<c:set var="tabletrate_rate" value="0" />
							</c:if>
							<c:if test="${tabletrate[1]!=0 }">
							<fmt:formatNumber  var="tabletrate_rate" value="${tabletrate[0]/tabletrate[1] }" pattern="#0"/>
							${tabletrate_rate*100}
							</c:if>							
							%
						</td>
						<td>

							<c:set var="tabletsellrate" value="${fn:split(list.tabletsellrate, ',')}"  />
							
							<c:if test="${tabletsellrate[1]==0 }">
								0
								<c:set var="tabletsellrate_rate" value="0" />
							</c:if>
							<c:if test="${tabletsellrate[1]!=0 }">
							<fmt:formatNumber  var="tabletsellrate_rate" value="${tabletsellrate[0]/tabletsellrate[1] }" pattern="#0"/>
							${tabletsellrate_rate*100}
							</c:if>							
							%
						</td>
						<td>
							<c:set var="tablethosprate" value="${fn:split(list.tablethosprate, ',')}"  />
							
							<c:if test="${tablethosprate[1]==0 }">
								0
								<c:set var="tablethosprate_rate" value="0" />
							</c:if>
							<c:if test="${tablethosprate[1]!=0 }">
							<fmt:formatNumber   var="tablethosprate_rate" value="${tablethosprate[0]/tablethosprate[1] }" pattern="#0"/>
							${tablethosprate_rate*100}
							</c:if>							
							%
						</td>
						<td>
							<fmt:formatNumber   value="${(medrate_rate+medsellrate_rate+medmarketrate_rate+tabletrate_rate+tabletsellrate_rate+tablethosprate_rate)/6}" pattern="#0"/>
							%											
							
						</td>
									
					</tr>
					</c:if>
				</c:forEach>
			</table>
			
			<div class="page">
				<b style="font-size:18px;">追溯环节使用率</b>	
			</div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						地区编号
					</td>
					<td>
						区县名称
					</td>
					<td>
						种植基地
					</td>
						
					<td>
						中药材<br>经销企业
					</td>
					<td>
						专业市场<br>经营企业
					</td>
					<td>
						饮片生产<br>企业
					</td>
					<td>
						饮片经销<br>企业
					</td>
					<td>
						饮片使用<br>单位
					</td>
					<td>
						综合
					</td>
				</tr>
				<c:forEach items="${sessionScope.detailList}" var="list">
					<c:if test="${list.ratetype=='2' }">
					<tr class="lb-list" id="tr_${list.id }">
						<td height="30">
							${list.areacode }&nbsp;
						</td>
						<td>
							${list.areas }&nbsp;
						</td>
						<td>						
							
							<c:set var="medrate" value="${fn:split(list.medrate, ',')}"  />
							
							<c:if test="${medrate[1]==0 }">
								0
								<c:set var="medrate_rate2" value="0" />
							</c:if>
							<c:if test="${medrate[1]!=0 }">
							<fmt:formatNumber   var="medrate_rate2" value="${medrate[0]/medrate[1] }" pattern="#0"/>
							${medrate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>						
						<td>

							<c:set var="medsellrate" value="${fn:split(list.medsellrate, ',')}"  />
							
							<c:if test="${medsellrate[1]==0 }">
								0
								<c:set var="medsellrate_rate2" value="0" />
							</c:if>
							<c:if test="${medsellrate[1]!=0 }">
							<fmt:formatNumber   var="medsellrate_rate2" value="${medsellrate[0]/medsellrate[1] }" pattern="#0"/>
							${medsellrate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>
						<td>

							<c:set var="medmarketrate" value="${fn:split(list.medmarketrate, ',')}"  />
							
							<c:if test="${medmarketrate[1]==0 }">
								0
								<c:set var="medmarketrate_rate2" value="0" />
							</c:if>
							<c:if test="${medmarketrate[1]!=0 }">
							<fmt:formatNumber   var="medmarketrate_rate2" value="${medmarketrate[0]/medmarketrate[1] }" pattern="#0"/>
							${medmarketrate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>
						<td>
	
							<c:set var="tabletrate" value="${fn:split(list.tabletrate, ',')}"  />
							
							<c:if test="${tabletrate[1]==0 }">
								0
								<c:set var="tabletrate_rate2" value="0" />
							</c:if>
							<c:if test="${tabletrate[1]!=0 }">
							<fmt:formatNumber   var="tabletrate_rate2" value="${tabletrate[0]/tabletrate[1] }" pattern="#0"/>
							${tabletrate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>
						<td>

							<c:set var="tabletsellrate" value="${fn:split(list.tabletsellrate, ',')}"  />
							
							<c:if test="${tabletsellrate[1]==0 }">
								0
								<c:set var="tabletsellrate_rate2" value="0" />
							</c:if>
							<c:if test="${tabletsellrate[1]!=0 }">
							<fmt:formatNumber   var="tabletsellrate_rate2" value="${tabletsellrate[0]/tabletsellrate[1] }" pattern="#0"/>
							${tabletsellrate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>
						<td>

							<c:set var="tablethosprate" value="${fn:split(list.tablethosprate, ',')}"  />
							
							<c:if test="${tablethosprate[1]==0 }">
								0
								<c:set var="tablethosprate_rate2" value="0" />
								<set >
							</c:if>
							<c:if test="${tablethosprate[1]!=0 }">
							<fmt:formatNumber   var="tablethosprate_rate2" value="${tablethosprate[0]/tablethosprate[1] }" pattern="#0"/>
							${tablethosprate_rate2*100}&nbsp;
							</c:if>							
							%
						</td>
						<td>
							
							<fmt:formatNumber   value="${(medrate_rate2+medsellrate_rate2+medmarketrate_rate2+tabletrate_rate2+tabletsellrate_rate2+tablethosprate_rate2)/6}" pattern="#0"/>
							%
							&nbsp;
						</td>
									
					</tr>
					</c:if>
				</c:forEach>
			</table>
			
			<div class="page">
				<b style="font-size:18px;">溯源秤使用率</b>
			</div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="lb-tit">
					<td>
						地区编号
					</td>
					<td>
						区县名称
					</td>
					<td>
						案秤-专业市场经营企业
					</td>
						
					<td>
						台秤-种植基地
					</td>
					<td>
						台秤-中药材经销企业
					</td>
					<td>
						台秤-专业市场经营企业
					</td>
					
				</tr>
				<c:forEach items="${sessionScope.detailList}" var="list">
					<c:if test="${list.ratetype=='3' }">
					<tr class="lb-list" id="tr_${list.id }">
						<td height="30">
							${list.areacode }&nbsp;
						</td>
						<td>
							${list.areas }&nbsp;
						</td>
						<td>						

							<c:set var="medrate" value="${fn:split(list.medrate, ',')}"  />
							
							<c:if test="${medrate[1]==0 }">
								0
							</c:if>
							<c:if test="${medrate[1]!=0 }">
							<fmt:formatNumber   value="${medrate[0]/medrate[1]*100 }" pattern="#0"/>
							
							</c:if>							
							%
						</td>						
						<td>

							<c:set var="medsellrate" value="${fn:split(list.medsellrate, ',')}"  />
							
							<c:if test="${medsellrate[1]==0 }">
								0
							</c:if>
							<c:if test="${medsellrate[1]!=0 }">
							<fmt:formatNumber   value="${medsellrate[0]/medsellrate[1]*100 }" pattern="#0"/>
							
							</c:if>							
							%
						</td>
						<td>

							<c:set var="medmarketrate" value="${fn:split(list.medmarketrate, ',')}"  />
							
							<c:if test="${medmarketrate[1]==0 }">
								0
							</c:if>
							<c:if test="${medmarketrate[1]!=0 }">
							<fmt:formatNumber   value="${medmarketrate[0]/medmarketrate[1]*100 }" pattern="#0"/>
							
							</c:if>							
							%
						</td>
						</td>
						<td>

							<c:set var="tabletrate" value="${fn:split(list.tabletrate, ',')}"  />
							
							<c:if test="${tabletrate[1]==0 }">
								0
							</c:if>
							<c:if test="${tabletrate[1]!=0 }">
							<fmt:formatNumber   value="${tabletrate[0]/tabletrate[1]*100 }" pattern="#0"/>
							
							</c:if>							
							%
						</td>				
									
					</tr>
					</c:if>
				</c:forEach>
				
			</table>
		</div>
		</c:if>
		
		
		<c:if test="${fn:length(sessionScope.detailList)<=0}">	 	
        <div class="fb-con">
        	<div class="fb-msg">
            <img src="/images/frame/Warning.png">
            <b class="green">该季度没有数据!</b>     
    	</div>
    	</c:if>
    	<div>
	<cite>
		<input type="button" value="保  存" class="sbt" onclick="checkForm();" id="btnfinish"/></cite>
		<br>
	</div>
	</div>
	</form>
	
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	
	<script type="text/javascript">
		function checkForm(){			
			$("#searchform").attr("action","examine!createXml.shtml");
			$("#searchform").submit();
		}
		
	</script>	
	
	</body>
</html>
