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
<title>出库数量统计</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：统计分析 &gt; 出库统计</div>
	<div class="form-box">
    	<div class="fb-tit">
    	     出库数量统计
        </div>
        <div class="fb-con">
        	<div class="fb-tip">
	        <form action="" method="post" name="searchform" id="searchform">
	          <table width="100%">
                  <tr>
                    <td height="26"  align="right">查询对象：</td>
                    <td >
                    	<select id="type" name="type" style="width:128px" onchange="typeChange(this.value);">
                    		<option value="0" <c:if test="${requestScope.type == 0 }">selected</c:if>>药材</option>
                    		<option value="1" <c:if test="${requestScope.type ==1 }">selected</c:if>>饮片</option>
                    	</select>
                    </td>
                    <td  align="right">流通节点：</td>
                    <td>
                       <select id="zyctype" name="zyctype" style="width:128px" >
                    		<option value="" <c:if test="${requestScope.zyctype == ''}">selected</c:if>>--所有节点--</option>
                    		<option value="10000000" <c:if test="${requestScope.zyctype == '10000000'}">selected</c:if>>药材种植</option>
                    		<option value="01000000" <c:if test="${requestScope.zyctype == '01000000'}">selected</c:if>>药材经销</option>
                    		<option value="00001000" <c:if test="${requestScope.zyctype == '00001000'}">selected</c:if>>药材市场</option>
                    	</select>
                    </td>
                    <td  align="right">统计方式：</td>
                    <td >
                    	<select id="datestattype" name="datestattype" style="width:128px">
                    		<option value="yyyy-MM-dd" <c:if test="${requestScope.datestattype == 'yyyy-MM-dd' }">selected</c:if>>天</option>
                    		<option value="yyyy-IW" <c:if test="${requestScope.datestattype =='yyyy-IW' }">selected</c:if>>周</option>
                    		<option value="yyyy-MM" <c:if test="${requestScope.datestattype =='yyyy-MM' }">selected</c:if>>月</option>
                    	</select>
                    </td>
                  </tr>
                  <tr>
                    <td height="26"  align="right">开始日期：</td>
                    <td>
                    	<input type="text" name="querybegintime" id="querybegintime" value="${fn:substring(querybegintime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,maxDate:'#F{$dp.$D(\'queryendtime\');}'});"/>
                    </td>
                    <td align="right">结束日期：</td>
                    <td>
                    	<input type="text" name="queryendtime" id="queryendtime" value="${fn:substring(queryendtime,0,11)}" class="Wdate inp w120" 
						onfocus="WdatePicker({skin:'blueFresh',isShowWeek:true,isShowClear:true,minDate:'#F{$dp.$D(\'querybegintime\');}'});">
					</td>
					<td colspan="2">
						<input type="button" value="查询" class="sch" onclick="return checkForm();">
					</td>
                  </tr>
                </table>   
	        </form>
		    </div>
		    <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		  	  <tr>
				<td style="padding:0">
				  <div id="chartline" style="padding-top: 10px; text-align:center" >   
				  </div>
				</td>
              </tr>
            </table>
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt10">
		  	  <tr>
				<td style="padding:0">
				    <div id="chartpie"  style="padding-top: 10px; text-align:center" >   
				    </div>
				</td>
              </tr>
            </table>
            <br/>
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10">
		     <tr class="fbc-tit">
	            <td align="center">品名</td>
	            <td align="center">交易 重量(Kg)</td>
	          </tr>
	          <c:forEach items="${requestScope.govmentstatlist}" var="govmentstat">
		  	  <tr class="fb-list">
		  		<td height="30" align="center">${govmentstat.prodname }&nbsp;</td>
		  		<td align="center">${govmentstat.strtotalweight}&nbsp;</td>
		  	  </tr>
	  		  </c:forEach>
	        </table>
	        <div class="page">
	        	<cite>
					<pg:pager
					    url="govmentStat!getSellTotalWeightStat.shtml"
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
						<pg:param name="zyctype" value="${requestScope.zyctype }"/>
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
<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaSearch.js"></script>
<script type="text/javascript">
	function checkForm(){
		$("#searchform").attr("action","govmentStat!getSellTotalWeightStat.shtml");
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
    
    typeChange('${type}');
    
    
    function flashJFreeChart(){
        var urlLine = "jFreeChartStat!getTotalWeightJFreeChartLineStat.shtml"
		var neSrcLine = urlLine + "?type="+$("#type").val()+"&zyctype="+$("#zyctype").val()+"&datestattype="+$("#datestattype").val()
		                +"&querybegintime="+$("#querybegintime").val()+"&queryendtime="+$("#queryendtime").val();   
	    $("#chartline").html("<IMG SRC="+neSrcLine+" height=300>");
	    
	    if($("#zyctype").val() == ''){//统计所有的节点，此时需要显示各节点的饼形图
	       var urlPie = "jFreeChartStat!getAreaWeightJFreeChartPieStat.shtml"
		   var neSrcPie = urlPie + "?type="+$("#type").val()+"&zyctype="+$("#zyctype").val()
		                   +"&querybegintime="+$("#querybegintime").val()+"&queryendtime="+$("#queryendtime").val();   
		   $("#chartpie").html("<IMG SRC="+neSrcPie+" height=300>");
	       
	      
	    }
	    
	    resetH();//页面自适应高度
    }
    
    //刷新报表图片
    flashJFreeChart();
    
</script>
</body>
</html>
 