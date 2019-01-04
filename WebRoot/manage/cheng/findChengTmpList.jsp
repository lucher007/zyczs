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
		<div class="cur-pos">当前位置：市场管理 > 溯源秤模板管理</div>
	</c:if>
	<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
		<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤模板管理</div>
	</c:if>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <cite><a href="chengTmp!addChengTmpInit.shtml" class="btn-a"><span class="new">新建模板</span></a></cite>
			规格名称：<select id="confid" name="confid" class="w158">
	                  	        <option value="">--请选择--</option>
								<c:forEach items="${requestScope.chengconfmap}" var="chengMap" varStatus="s">
							 		<option value="${chengMap.key}" <c:if test="${requestScope.confid == chengMap.key }">selected</c:if>>${fn:substring(chengMap.value, 0, 15)}</option>
								</c:forEach>
						  </select>
        	 　模板名称：<input type="text" size="20" maxlength="32" class="inp w150" name="tmpname" id="tmpname"  value="${requestScope.tmpname }">
        	<input type="button" value="查询" class="sch" onclick="return checkForm();"/>
   		    <input type="hidden" name="tmpid" id="tmpid" value=""/>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>模板名称</td>
            <td>规格名称</td>
            <td>修改操作</td>
            <td>删除操作</td>
          </tr>
          <c:forEach items="${requestScope.chengtmplist}" var="dataList">
	          <tr class="lb-list">
	            <td height="30" class="remarkClass" title="${dataList.tmpname }">${fn:substring(dataList.tmpname, 0, 20)}&nbsp;</td>
	            <td class="remarkClass" title="${dataList.normname }">${fn:substring(dataList.normname, 0, 20)}&nbsp;</td>
	            <td>
	            	<a href="javascript:updateTmp('${dataList.tmpid }');" class="btn-edit">修改</a>
	            </td>
	            <td>
	            	<a href="javascript:deleteTmp('${dataList.tmpid }');" class="btn-del">删除</a>
	            </td>
	          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="chengTmp!findByList.shtml"
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
					<pg:param name="confid" value="${requestScope.confid }"/>
					<pg:param name="tmpname" value="${requestScope.tmpname }"/>
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
		function deleteTmp(tmpid){
			if(!confirm("确定删除?")){
				return;
			}
			$("#tmpid").val(tmpid);
			$("#searchForm").attr("action", "chengTmp!deleteChengTmp.shtml");
			$("#searchForm").submit();
		}
		
		//修改键所对应商品
		function updateTmp(tmpid){
		    $("#tmpid").val(tmpid);
			$("#searchForm").attr("action", "chengTmp!updateChengTmpInit.shtml");
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
		        	document.getElementById("chengcode").value = "";
		        }
			}
			
			function checkForm(){
				$("#tmpname").val($.trim($("#tmpname").val()));
					if(checkquotmarks($("#tmpname").val())){
						$("#tmpnameTm").focus();
						$.dialog.tips('不要输入非法字符',1,'alert.gif');
						return false;
				}
				
				$("#searchForm").attr("action","chengTmp!findByList.shtml");
				$("#searchForm").submit();
			}	 
			
			$(function(){
			    if('${returninfo}' !=null && '${returninfo}' != "" ){
			        $.dialog.tips('${returninfo}',1,'alert.gif');
			    }
			}) 
		</script>
</body>
</html>

