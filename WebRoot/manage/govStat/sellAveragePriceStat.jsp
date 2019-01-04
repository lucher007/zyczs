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
<meta charset="utf-8">
<title>出库价格统计</title>
<link type="text/css" rel="stylesheet" href="/style/user.css">
<link type="text/css" rel="stylesheet" href="/style/market.css"/>
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 出库统计</div>
    <div class="form-box">
    	<div class="fb-tit">
    	     出库价格统计
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	          <table width="100%">
                  <tr>
                    <td height="26" width="90" align="right">查询对象：</td>
                    <td >
                    	<select id="type" name="type" class="w158" >
                    		<option value="0" <c:if test="${requestScope.type == 0 }">selected</c:if>>药材</option>
                    		<option value="1" <c:if test="${requestScope.type ==1 }">selected</c:if>>饮片</option>
                    	</select>
                    </td>
                    <td width="90" align="right">品名：</td>
                    <td>
                    	<input maxlength="20" type="text" id="prodname" name="prodname" class="inp fl" value="${requestScope.prodname }">
                    	<a href="javascript:void(0);" id="xzyc" class="btn-xz fl">查询</a>
                    </td>
                  </tr>
                  <tr>
                    <td height="26"  align="right">流通节点：</td>
                    <td>
                       <select id="zyctype" name="zyctype" class="w158" >
                    		<option value="" <c:if test="${requestScope.zyctype == ''}">selected</c:if>>--所有节点--</option>
                    		<option value="10000000" <c:if test="${requestScope.zyctype == '10000000'}">selected</c:if>>药材种植</option>
                    		<option value="01000000" <c:if test="${requestScope.zyctype == '01000000'}">selected</c:if>>药材经销</option>
                    		<option value="00100000" <c:if test="${requestScope.zyctype == '00100000'}">selected</c:if>>饮片生产</option>
                    	</select>
                    </td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td height="26"  align="right">所属区域：</td>
                    <td colspan="3">
                    	 <select name="province" id="province" v="${province }">
                    	 </select>
                    	 <select name="city" id="city"  v="${city }">
                    	 </select>
	        			 <select name="area" id="area"   v="${area }">
	        			 </select>
                    </td>
                  </tr>
                  <tr>
                    <td height="26"  align="right">开始日期：</td>
                    <td>
                    	<input type="text" name="querybegintime" id="querybegintime" value="${fn:substring(querybegintime,0,11)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'queryendtime\');}'});"/>
                    </td>
                    <td align="right">结束日期：</td>
                    <td>
                    	<input type="text" name="queryendtime" id="queryendtime" value="${fn:substring(queryendtime,0,11)}" class="Wdate inp w150" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'querybegintime\');}'});">
						<input type="button" value="查询" class="sch" onclick="return checkForm();"></td>
                  </tr>
                  
                </table>   
                         
	        </form>
	    </div>
    
	    <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		     <tr class="fbc-tit">
	            <td align="center">品名</td>
	            <td align="center">流通节点</td>
	            <td align="center">区域</td>
	            <td align="center">平均价格(元/Kg)</td>
	          </tr>
	          <c:forEach items="${requestScope.govmentstatlist}" var="govmentstat">
		  	  <tr class="fb-list">
		  		<td height="30" align="center">${govmentstat.prodname }&nbsp;</td>
		  		<td align="center">
		  		    <c:if test="${govmentstat.zyctype == '10000000'}">
		  		                    药材种植
		  		    </c:if>
		  		    <c:if test="${govmentstat.zyctype == '01000000'}">
		  		                    药材经销
		  		    </c:if>
		  		    <c:if test="${govmentstat.zyctype == '00100000'}">
		  		                    饮片生产
		  		    </c:if>
		  		    <c:if test="${govmentstat.zyctype == '00010000'}">
		  		                    饮片经销
		  		    </c:if>
		  		    <c:if test="${govmentstat.zyctype == '00001000'}">
		  		                    药材市场
		  		    </c:if>
		  		    <c:if test="${govmentstat.zyctype == '00000100'}">
		  		                    医院药店
		  		    </c:if>
		  		</td>
		  		<td align="center">${govmentstat.area }&nbsp;</td>
		  		<td align="center">
		  			<c:if test="${fn:indexOf(govmentstat.straverageprice,'.')==0}">
		  				0${govmentstat.straverageprice}
		  			</c:if>
		  			<c:if test="${fn:indexOf(govmentstat.straverageprice,'.')!=0}">
		  				${govmentstat.straverageprice}
		  			</c:if>
		  		&nbsp;</td>
		  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="govmentStat!getSellAveragePriceStat.shtml"
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
						<pg:param name="type" value="${requestScope.type }"/>
						<pg:param name="prodname" value="${requestScope.prodname }"/>
						<pg:param name="zyctype" value="${requestScope.zyctype }"/>
						<pg:param name="province" value="${requestScope.province }"/>
						<pg:param name="city" value="${requestScope.city }"/>
						<pg:param name="area" value="${requestScope.area }"/>
						<pg:param name="querybegintime" value="${requestScope.querybegintime }"/>
						<pg:param name="queryendtime" value="${requestScope.queryendtime }"/>
						<pg:index>
						总共${requestScope.pager_count}条记录
						<pg:first unless="current">
							<a href="<%=pageUrl %>">首页</a>
						</pg:first>
						<pg:prev export="prevPageUrl=pageUrl">
						  	<a href="<%= prevPageUrl %>" title="上一页" class="prev">&nbsp;</a>
						</pg:prev>
						<pg:pages>
			   				<%if (pageNumber == currentPageNumber) { 
						        %><a href="<%=pageUrl%>" class="current"><%=pageNumber%></a><%
						      } else { 
						        %><a href="<%= pageUrl %>"><%= pageNumber %></a><%
						      }
						    %>  
						</pg:pages>
						<pg:next export="nextPageUrl=pageUrl">
						  	<a href="<%= nextPageUrl %>" title="下一页" class="next">&nbsp;</a>
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
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js" defer="defer"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/areaSearch.js"></script>
	<script type="text/javascript">
		function checkForm(){
			$("#prodname").val($.trim($("#prodname").val()));
			if(checkquotmarks($("#prodname").val())){
				$("#prodname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
			}
			$("#searchform").attr("action","govmentStat!getSellAveragePriceStat.shtml");
			$("#searchform").submit();
		}
    
        // 统计类型变化刷新节点变化
	    function typeChange(type) {
	        var html = "<option value=''>--所有节点--</option>";
	        if (type=='1'){
	           html += "<option value=\"00100000\" " + ('${zyctype}' == '00100000' ? 'selected':'') + " >饮片生产</option>";
	           html += "<option value=\"00010000\" " + ('${zyctype}' == '00010000' ? 'selected':'') + " >饮片经销</option>";
	           html += "<option value=\"00000100\" " + ('${zyctype}' == '00000100' ? 'selected':'') + " >医院</option>";
	        } else {
	           html += "<option value=\"10000000\" " + ('${zyctype}' == '10000000' ? 'selected':'') + " >药材种植</option>";
	           html += "<option value=\"01000000\" " + ('${zyctype}' == '01000000' ? 'selected':'') + " >药材经销</option>";
	           html += "<option value=\"00001000\" " + ('${zyctype}' == '00001000' ? 'selected':'') + " >药材市场</option>";
	        }
	        $('#zyctype').html(html);
	    }
	    
	    typeChange('${type}')
        $("#xzyc").click(function(){
	    	selMedBase();
	    	return false;
	    });
         function selMedBase(){
            if($("#type").val() == '1'){
               t2 = $.dialog({
					title:'选择饮片品名',
					id:'medWindow',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>tabletBase!tabletBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
			   });
           }else{
               t2 = $.dialog({
					title:'选择药材品名',
					id:'medWindow',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
			   });
           }
	            
				
		}
			
		function closeDG(s){
			$("#prodname").val(s[1]);
			t2.close();
		}
        
    </script>
	</body>
</html>
 