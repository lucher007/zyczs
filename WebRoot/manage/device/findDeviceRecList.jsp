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
<link type="text/css" rel="stylesheet" href="js/plugin/poshytip/tip-yellowsimple/tip-yellowsimple.css">
</head>

<body>
	<div id="body">
	<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
		<div class="cur-pos">当前位置：市场管理 > 设备回收查询</div>
	</c:if>
	<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
		<div class="cur-pos">当前位置：设备管理 > 设备回收查询</div>
	</c:if>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <input type="hidden" name="deviceid" id="deviceid" value=""/>
   			<table border="0" width="100%">
                  <tr>
                    <td height="26"  align="right">设备编号：</td>
	                 <td>
	                    <input type="text" size="20" maxlength="32" class="inp w150" name="devicecode" id="devicecode" value="${requestScope.devicecode }">
	                </td>
                    <td height="26" width="90" align="right">所属单位名称：</td>
                    <td width="170">
                    	<input type="text" size="25" maxlength="32" class="inp w200" name="corpname" id="corpname"  value="${requestScope.corpname }">
                    </td>
                  </tr>
                  <tr>
                      <td align="right" >设备类型：</td>
                  	  <td >
	                  	  <select id="devicetype" name="devicetype" onchange="typeChange(this.value);" class="w158">
	                  	        <option value="">--请选择--</option>
								<option value="1" <c:if test="${requestScope.devicetype == 1 }">selected</c:if>>打印机</option>
								<option value="2" <c:if test="${requestScope.devicetype == 2 }">selected</c:if>>扫描设备</option>
								<option value="3" <c:if test="${requestScope.devicetype == 2 }">selected</c:if>>移动终端</option>
								<option value="4" <c:if test="${requestScope.devicetype == 4 }">selected</c:if>>IC卡</option>
								<option value="5" <c:if test="${requestScope.devicetype == 5 }">selected</c:if>>查询机</option>
								<option value="6" <c:if test="${requestScope.devicetype == 6 }">selected</c:if>>耗材</option>
								<option value="7" <c:if test="${requestScope.devicetype == 7 }">selected</c:if>>计算机</option>
								<option value="8" <c:if test="${requestScope.devicetype == 8 }">selected</c:if>>读写卡器</option>
								<option value="9" <c:if test="${requestScope.devicetype == 9 }">selected</c:if>>其他设备</option>
						  </select>
			         </td>
                  	  <td align="right" >配置规格名称：</td>
                  	  <td id="confidTD">
	                  	  <select id="confid" name="confid" style="width:208px;">
	                  	        <option value="">--请选择--</option>
								<c:forEach items="${requestScope.deviceconfmap}" var="deviceMap" varStatus="s">
							 		<option value="${deviceMap.key}" <c:if test="${requestScope.confid == deviceMap.key }">selected</c:if>>${fn:substring(deviceMap.value, 0, 20)}</option>
								</c:forEach>
						  </select>
			         </td>
                    <td>
                    	&nbsp;<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
                    </td>
                  </tr>
                </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>设备编号</td>
          	<td>设备类型</td>
            <td>规格名称</td>
            <td>所属单位</td>
            <td>回收原因</td>
            <td>回收时间</td>
            <td>备注信息</td>
          </tr>
          <c:forEach items="${requestScope.deviceRecList}" var="dataList">
	          <tr class="lb-list">
	            <td height="30" class="remarkClass" title="${dataList.devicecode }">${fn:substring(dataList.devicecode, 0, 10)}&nbsp;</td>
	            <td>
	            	<c:if test="${dataList.devicetype=='1'}">打印机</c:if>
	            	<c:if test="${dataList.devicetype=='2'}">扫描设备</c:if>
	            	<c:if test="${dataList.devicetype=='3'}">移动终端</c:if>
	            	<c:if test="${dataList.devicetype=='4'}">IC卡</c:if>
	            	<c:if test="${dataList.devicetype=='5'}">查询机</c:if>
	            	<c:if test="${dataList.devicetype=='6'}">耗材</c:if>
	            	<c:if test="${dataList.devicetype=='7'}">计算机</c:if>
	            	<c:if test="${dataList.devicetype=='8'}">读写卡器</c:if>
	            	<c:if test="${dataList.devicetype=='9'}">其他设备</c:if>
				</td>
	            <td class="remarkClass" title="${dataList.normname }">${fn:substring(dataList.normname, 0, 10)}&nbsp;</td>
	            <td class="remarkClass" title="${dataList.corpname }">${fn:substring(dataList.corpname, 0, 10)}&nbsp;</td>
	            <td>
	            	<c:if test="${dataList.reason=='1'}">回收</c:if>
	            	<c:if test="${dataList.reason=='2'}">维修</c:if>
	            	<c:if test="${dataList.reason=='3'}">更换</c:if>
				</td>
				<td>${fn:substring(dataList.addtime, 0, 19)}&nbsp;</td>
	            <td class="remarkClass" title="${dataList.remark }">${fn:substring(dataList.remark, 0, 10)}&nbsp;</td>
	          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="deviceRec!findByList.shtml"
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
					<pg:param name="devicecode" value="${requestScope.devicecode }"/>
					<pg:param name="corpname" value="${requestScope.corpname }"/>
					<pg:param name="confid" value="${requestScope.confid }"/>
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
<script language="javascript" type="text/javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
<script type="text/javascript" language="javascript" src="js/plugin/poshytip/jquery.poshytip.min.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript">
	function checkForm(){
	    $("#devicecode").val($.trim($("#devicecode").val()));
			if(checkquotmarks($("#devicecode").val())){
				$("#devicecode").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
		}
		$("#corpname").val($.trim($("#corpname").val()));
			if(checkquotmarks($("#corpname").val())){
				$("#corpname").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
		}
		$("#searchForm").attr("action","deviceRec!findByList.shtml");
		$("#searchForm").submit();
	}	 
	
	
	function typeChange(deviceType){
	    
	    $.getJSON("<%=basePath%>deviceRec!deviceConfQuery.shtml?devicetype=" + deviceType + "&randon="+Math.random(),{},
	         function(data){
	    	    var confidVal=' <select id="confid" name="confid"> <option value="">--请选择--</option> '
	    		if(data != null){
	    		    for(i=0;i<data.length;i++){
					    id = data[i].confid;
					    text = data[i].normname;
					    confidVal += ' <option value="'+id+'">'+text.substr(0,20)+'</option> ';
					}
	    		}
	    		confidVal +=' </select> ';
	    		
	    		$("#confidTD").html(confidVal);
	  		}
		);
	}
</script>
</body>
</html>

