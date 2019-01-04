<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.gov.zyczs.cspt.common.Tools"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>药材出库</title>
<link type="text/css" rel="stylesheet" href="/style/production.css">
</head>

<body>
<form action="" name="searchform" id="searchform" method="post">
<s:token></s:token>
<input type="hidden" name="datastr" id="datastr" />
<input type="hidden" name="totalweight" id="totalweight">

<input type="hidden" name="buycorpname" id="buycorpname" />
<input type="hidden" name="codestr" id="codestr" value="${requestScope.codestr }" />
<input type="hidden" name="uncodestr" id="uncodestr" value="${requestScope.uncodestr }" />

<div id="body">


	
		<div class="cur-pos">当前位置：库存销售 > 药材入库</div>
		<div class="form-box">
	    	<c:if test="${fn:length(sessionScope.medMarketInStoragemap.listMap)>0}">
	    	<div class="fb-tit">药材入库成功列表</div>
	        <div class="fb-con">
	        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10" id="content">
	              <tr class="fbc-tit">
	                <td>品名</td>
	                <td>批次号</td>
	                <td>商品编码</td>
	                <td>规格(Kg/包)</td>
	                <td>包数</td>
	                <td>重量(Kg)</td>               
	              </tr>
	              <c:set var="totalweightall" value="0" scope="request" />
	              <c:forEach items="${sessionScope.medMarketInStoragemap.listMap}" var="instoragemap" varStatus="vs">
	              	<tr id="tr_${vs.index }" class="fb-list">
	              	
	             	<c:set var="boxitemnumall" value="0" scope="request" />
	             	<c:set var="boxsweightall" value="0" scope="request"/>
	             	
	              	<c:forEach items="${instoragemap.value}" var="list" varStatus="vs">
		              <c:set var="pname" value="${list.pname }" />
		              <c:set var="batchno" value="${list.batchno }" />
		              <c:set var="pcode" value="${list.pcode }" />
		              <c:set var="weight" value="${list.weight}" scope="request"  /> <!-- 规格 每包重量-->
		              <%
	              		Object weight=request.getAttribute("weight");
	              		 %>
		              <c:set var="areacode" value="${list.areacode}" /> 
		                		                  
		              <%--包数===============--%>
					  <c:set var="boxitemnumall" value="${fn:length(instoragemap.value)}" scope="request" />
					  	<%
	              		Object boxitemnumall=request.getAttribute("boxitemnumall");
	              		%>	  		                      					
			           
			          <%--重量================--%>		          
		              <!-- 规格乘以包数 -->
		              <c:set var="boxsweightall" value="<%=Tools.multiply(weight.toString(),boxitemnumall.toString()) %>" scope="request"/>
		              	
		              		            
	              	</c:forEach>
	              		<c:set var="weightall" value="${boxsweightall}" scope="request" />
	              		 <%
	              		Object weightall=request.getAttribute("weightall");
	              		Object totalweightall=request.getAttribute("totalweightall");
	              		 %>    
	              		<c:set var="totalweightall" value="<%=Tools.addtr(totalweightall.toString(),weightall.toString()) %>" scope="request"/>
	              		  
	              		  
	              		<td height="30" id="name${vs.index }">${pname }<input type="hidden" name="keyid${vs.index }" id="keyid${vs.index }" value="${instoragemap.key}" /></td>
		                <td id="batchno${vs.index }">${batchno }</td>
		                <td id="pcode${vs.index }">${pcode }</td>	                		                               
		                <td id="weight${vs.index }">${weight}</td> 
		                <td id="boxnum${vs.index }">${fn:length(instoragemap.value)}</td> 
		                <td id="areacode${vs.index }"><%=Tools.scienceToString(Tools.dealNullDouble(weightall,0))%></td>	            
	              	</tr>
	              </c:forEach>     	              
	            </table>
	            <%
	              		Object totalweightall=request.getAttribute("totalweightall");
	              		 %>
	            <table width="734" border="0" cellspacing="0" cellpadding="0">
		              <tr>
		                <td height="30"></td>
		                <td width="229"><cite>合计重量：<b class="red" id="totalweightval"><%=Tools.scienceToString(Tools.dealNullDouble(totalweightall,0) )%></b>(Kg)</cite></td>
		              </tr>
		        </table>
	            
	        </div>
	        </c:if>
	        
	        <c:if test="${fn:length(sessionScope.medMarketInStoragemap.failList)>0}">	
	        <div class="fb-tit tpline">药材入库失败列表</div>
	        <div class="fb-con">
	        	<table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10" id="content">
	              <tr class="fbc-tit">
	                <td width="50%" class="line-r">溯源码</td>
	                <td>失败原因</td>
	              </tr>
	              
	              <c:forEach items="${sessionScope.medMarketInStoragemap.failList}" var="failList">              
	              <tr class="fb-list">
	                <td height="30" class="line-r">${failList.code}</td>
	                <td class="red">
<%--	                	<c:if test="${failList.reason=='0'}">溯源码不存在</c:if>--%>
<%--	                	<c:if test="${failList.reason=='1'}">溯源码已冻结</c:if>--%>
<%--	                	<c:if test="${failList.reason=='2'}">溯源码未出库</c:if>--%>
<%--	                	<c:if test="${failList.reason=='3'}">货权信息不匹配</c:if>--%>
<%--	                	<c:if test="${failList.reason!='0'&&failList.reason!='1'&&failList.reason!='2'&&failList.reason!='3'}">--%>
<%--	                	无效的溯源码--%>
<%--	                	</c:if>--%>
							${failList.reasonMap}
	                </td>
	              </tr>
              	  </c:forEach>
	            </table>
	            <table width="734" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="30"> 
	               <b style="color:red;"> 提示：查询失败的溯源码将不会入库。</b>
	                </td>                
	              </tr>
	            </table>
	        </div>
	        </c:if>
	        
	        <div class="fb-bom">
	        	<c:if test="${fn:length(sessionScope.medMarketInStoragemap.listMap)>0}">
	        	<cite class="gray"><input type="button" value="提交入库" id="subBut" class="sbt" onclick="checkForm(2);"></cite>
	            </c:if>
	            <input type="button" value="取 消" id="backBut" class="sbt" onclick="goBack();">
	        </div>
	       
	    </div>
    </div>
    

</form>




    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
		inp(".outarea","请使用扫描抢进行扫码或者请输入出库药材溯源码箱码");
		function goBack(){
			window.location="<%=basePath %>/manage/medMarketInOutStorage/findInStorage.jsp";
		}	

		function checkForm(){
			$("#searchform").attr("action", "medMarketInOut!addInStorage.shtml");
			$.dialog.confirm('确认要提交吗？', function(){
    			var totalweightval=$("#totalweightval").text();			
				var totalweight=multiply(totalweightval,10000);
				$("#totalweight").val(totalweight);
    			$("#searchform").submit();	
    			$("#subBut").attr("disabled","disabled");
				$("#backBut").attr("disabled","disabled");	
			}, function(){
    			//$.dialog.tips('执行取消操作');
			});
			
		}
		
	</script>
</body>
</html>
