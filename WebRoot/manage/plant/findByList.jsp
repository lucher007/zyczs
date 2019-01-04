<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">		
  <head>
    <base href="<%=basePath%>" />    
    <title></title>    	
    <style type="text/css">
    	html,body {
			margin:0px;
    		padding:0px;
    		font-size:12px;
    		width:741px;
    		height:513px;
    		font-family: "微软雅黑",arial;
		}

		.tablecss{
			text-align:center;
		}
		.tr1{
			width:5px;
			height:29px;
			/*background:url('images/growfindtabletr1.png') no-repeat;
			display:inline-block;*/
		}
		.tr2{			
			width:auto;			
			height:29px;
			/*background:url('images/growfindtabletr2.png') repeat-x;
			display:inline-block;*/
		}
		.tr3{
			/*width:5px;
			height:29px;
			background:url('images/growfindtabletr3.png') no-repeat;
			display:inline-block;*/
		}
		.tr4{
			width:5px;
			height:25px;
		}
		.tr5{
			overflow: hidden;
		}
		.searchmoredivall{
    		position: absolute;
    		left:0px;
    		top:0px;
    		width:100%;
    		height:100%;
    		background-color: #000000;
    		z-index:1;
    		filter:alpha(opacity=50);
    		display:none;
    	}
    	.searchmorediv{
    		width:467px;
    		height:262px;
    		position: absolute;
    		left:100px;
    		top:70px;
    		z-index:2;
    		background:url('images/growfindpopwindowbg.png') no-repeat;
    		display:none;
    	}
    	.searchmoreul{
    		width:400px;
    		height:190px;
    		list-style: none;
    		position:relative;
    		left:6px;
    		top:21px;
    	}
    </style>
   	<script type="text/javascript" src="<%=request.getContextPath() %>/js/ajaxobj.js" ></script>
    <script type="text/javascript" language="javascript">
    function findByList(){
        document.searchform.action="grow!findByList.shtml";
    	document.searchform.submit();
	}	

	function addgrow(){
		window.location.href="manage/grow/addGrow.jsp";
	}

	function findByFertilizer(syscodetemp){
		document.searchform.action="fertilizer!findByList.shtml?growsyscode="+syscodetemp;
		document.searchform.submit();
	}
	function findByPesticide(syscodetemp){
		document.searchform.action="pesticide!findByList.shtml?growsyscode="+syscodetemp;
		document.searchform.submit();
	}
	function findById(syscodetemp){
		document.searchform.action="grow!findById.shtml?syscode="+syscodetemp;
		document.searchform.submit();
	}
	function findByGain(growidtemp){
		document.searchform.action="grow!findByGain.shtml?growid="+growidtemp;
		document.searchform.submit();
	}
	
	function queryByGrowSysCode(growSysCode){
		document.searchform.action="growMed!queryByGrowSysCode.shtml?growSysCode="+growSysCode;
		document.searchform.submit();
	}
    </script>    
  </head>
  
  <body>
  	<form action="" method="post" name="searchform" id="searchform">
  	<input type="hidden" name="delid" id="delid" />
  	  	
	<table cellpadding="0" cellspacing="0" border="0" width="740">
		<tr>
			<td style="width:6px;height:513px;background:url('images/growmanagetablecontentleft.png') no-repeat;"></td>
			<td style="height:513px;background:url('images/growmanagetablecontentcenter.png') repeat-x;" valign="top">				
				<table cellpadding="0" cellspacing="0" border="0" width="720" style="margin-top:14px;">
					<tr>
						<td width="400">
							种子种苗植物名:
							<input type="text" name="plantname" id="plantname" value="${requestScope.plantname }" />							
							<input type="button" value="查询"  onclick="return findByList();" />							
						</td>
						<td align="right"><input type="button" value="新建种植任务" onclick="addgrow();" /></td>
					</tr>
				</table>
				
				
				
				<div style="background:url('images/growfindtabletd.png') repeat-y 0 27px;height:425px;width:728px;">
				<table cellpadding="0" cellspacing="0" border="0" width="728" style="margin-top:5px;" class="tablecss">
					<tr>
						<!--<th class="tr1"></th><th class="tr2" width="50"><input type="checkbox" name="controlchk" id="controlchk" onclick="return selectAllChk(this)"/><span style="position: relative;top:-1px;">操作</span></th><th class="tr3"></th>  -->
						<th class="tr1"></th><th class="tr2" width="100">种植批次号</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="300">种子种苗植物名</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="190">面积（亩）</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="70">种植时间</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="70">肥料管理/次</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="70">农药管理/次</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="40">收获</th><th class="tr3"></th>
						<th class="tr1"></th><th class="tr2" width="30">详细</th><th class="tr3"></th>
					</tr>
					<c:forEach items="${requestScope.growlist}" var="growlist">
					
				  		<tr>
				  		<!-- 	<td class="tr4"></td><td class="tr5" width="50"><input type="checkbox" name="chk" id="chk${growlist.growid}" value="${growlist.growid}" onclick="chooseRole(this)"/></td><td class="tr4"></td> -->
				  			<c:set var="plantcodeLength" value="${fn:length(growlist.syscode ) }"></c:set>
				  			<c:choose>
				  				<c:when test="${plantcodeLength > 6}">
						  			<td class="tr4"></td><td class="tr5" width="160" title="${growlist.syscode }">${growlist.syscode }<!-- ${fn:substring(growlist.syscode,0,6) }... --></td><td class="tr4"></td>
				  				</c:when>
				  				<c:otherwise>
						  			<td class="tr4"></td><td class="tr5" width="80">${growlist.syscode}</td><td class="tr4"></td>
				  				</c:otherwise>
				  			</c:choose>
				  			<td class="tr4"></td><td class="tr5" width="150">${growlist.plantname }</td><td class="tr4"></td>
				  			<td class="tr4"></td><td class="tr5" width="110" title="${growlist.plantarea }">${fn:substring(growlist.plantarea, 0, 4)}</td><td class="tr4"></td>
				  			<td class="tr4"></td><td class="tr5" width="100">${fn:substring(growlist.planttime, 0, 11)}</td><td class="tr4"></td>
				  			<c:if test="${growlist.state == 0}">
					  			<td class="tr4"></td><td class="tr5" width="70"><div style="cursor:hand;width:35px;height:21px;background:url('images/growfindtablefertilizer.png') no-repeat;padding:2px 0 0 42px;color:#ffffff;" onclick="return findByFertilizer('${growlist.syscode}');">${growlist.fertilizer }</div></td><td class="tr4"></td>
					  			<td class="tr4"></td><td class="tr5" width="70"><div style="cursor:hand;width:35px;height:21px;background:url('images/growfindtablepesticide.png') no-repeat;padding:2px 0 0 42px;color:#ffffff;" onclick="return findByPesticide('${growlist.syscode}');">${growlist.pesticide }</div></td><td class="tr4"></td>
				  			</c:if>
				  			<c:if test="${growlist.state == 1}">
					  			<td class="tr4"></td><td class="tr5" width="70"><div>已施肥(${growlist.fertilizer })</div></td><td class="tr4"></td>
					  			<td class="tr4"></td><td class="tr5" width="70"><div>已施农药(${growlist.pesticide })</div></td><td class="tr4"></td>
				  			</c:if>
				  			<c:if test="${growlist.state == 0}">
					  			<td class="tr4"></td><td class="tr5" width="80"><div style="cursor:hand;width:30px;height:21px;background:url('images/growfindtablegain.png') no-repeat;padding:2px 0 0 52px;color:#ffffff;" onclick="return queryByGrowSysCode('${growlist.syscode}');">${growlist.growmed }</div></td><td class="tr4"></td>
				  			</c:if>
				  			<c:if test="${growlist.state == 1}">
				  				<td class="tr4"></td><td class="tr5" width="80"><div>已收获(${growlist.growmed })</div></td><td class="tr4"></td>
				  			</c:if>
				  			<td class="tr4"></td><td class="tr5"><input type="button" value="详细" onclick="return findById('${growlist.syscode}');"></td><td class="tr4"></td>
				  		</tr>
					  
			  		</c:forEach>
				</table>
				</div>
				<div style="height:1px;background-color:#E0E0E0;margin-top:3px;"></div>
				<div style="height:1px;background-color:#ffffff;margin-bottom:3px;"></div>
				<!-- <input type="button" style="cursor:hand;border:none;width:67px;height:26px;background:url('images/growfinddelbtn.png') no-repeat;float:left;" onclick="return deleteObjectAll();" /> -->
				<div style="text-align:right;height:26px;">
					<pg:pager
				    url="grow!findByList.shtml"
				    items="${requestScope.pager_count}"
				    index="center"
				    maxPageItems="16"
				    maxIndexPages="5"
				    isOffset="<%= true %>"
				    export="offset,currentPageNumber=pageNumber"
				    scope="request">			
					<pg:param name="index"/>
					<pg:param name="maxPageItems"/>
					<pg:param name="maxIndexPages"/>
					<pg:param name="plantname" value="${requestScope.plantname }"/>
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
				</div>
			</td>
			<td style="width:6px;height:513px;background:url('images/growmanagetablecontentright.png') no-repeat;"></td>
		</tr>
	</table>
	</form>
  </body>
 </html>
 