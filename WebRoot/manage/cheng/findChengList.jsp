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
		<div class="cur-pos">当前位置：市场管理 > 溯源秤管理</div>
	</c:if>
	<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
		<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤管理</div>
	</c:if>
    <div class="seh-box">
        <form action="" method="post" id="searchForm" name="searchForm">
            <table width="100%">
		    	<tr><td align="right" width="120">溯源秤编号：</td><td><input type="text" size="28" maxlength="32" class="inp w250" name="chengcode" id="chengcode" onkeyup="check_IsNum(this.value)"  onkeypress="check_IsNum(this.value)" value="${requestScope.chengcode }"></td>
		    		<td width="130"><a href="cheng!addChengInit.shtml" class="btn-a"><span class="new">发放溯源秤</span></a></td></tr>
        		<tr><td align="right">所属单位名称：</td><td><input type="text" size="20" maxlength="32" class="inp w250" name="corpname" id="corpname"  value="${requestScope.corpname }"></td>
        			<td><input type="button" value="查询" class="sch" onclick="return checkForm();"/>
   		    			<input type="hidden" name="chengid" id="chengid" value=""/>
   		    			<input type="hidden" name="locked" id="locked" value=""/>
   		    		</td>
   		    	</tr>
   		    </table>
   		</form>
    </div>
    <div class="lst-box">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="lb-tit">
          	<td>溯源秤号</td>
            <td>规格名称</td>
            <td>所属单位</td>
            <td>类型</td>
            <td>发放原因</td>
            <td>发放时间</td>
            <td>回收操作</td>
            <td>交易查询</td>
            <td>状态变化</td>
          </tr>
          <c:forEach items="${requestScope.chengList}" var="dataList">
	          <tr class="lb-list">
	            <td height="30" class="remarkClass" title="${dataList.chengcode }">${fn:substring(dataList.chengcode, 0, 32)}&nbsp;</td>
	            <td class="remarkClass" title="${dataList.normname }">${fn:substring(dataList.normname, 0, 9)}&nbsp;</td>
	            <td class="remarkClass" title="${dataList.corpname }">${fn:substring(dataList.corpname, 0, 9)}&nbsp;</td>
	            <td>
	            	<c:if test="${dataList.type==1}">案秤</c:if>
	            	<c:if test="${dataList.type==2}">台秤</c:if>
				</td>
                <td>
	            	<c:if test="${dataList.reason=='1'}">初次发放</c:if>
	            	<c:if test="${dataList.reason=='2'}">维修</c:if>
	            	<c:if test="${dataList.reason=='3'}">更换</c:if>
	            	<c:if test="${dataList.reason=='4'}">回收</c:if>
				</td>
				<td >${fn:substring(dataList.addtime, 0, 10)}&nbsp;</td>
	           <td>
	            	<a href="javascript:recoverDevice_cheng('${dataList.chengid }');">回收</a>
	            </td>
	            <td>
	            	<a class="btn-look" href="<%=basePath %>cheng!findChengDataByList_chengCode.shtml?chengcode=${dataList.chengcode }&opertype=1">详情</a>
	            </td>
	            <td>
	            	<a class="btn-look" href="<%=basePath %>cheng!findChengStateLogByList_chengCode.shtml?chengcode=${dataList.chengcode }&opertype=1">详情</a>
	            </td>
	          </tr>
          </c:forEach>
        </table>
        <div class="page">
        	<cite>
            	<pg:pager
				    url="cheng!findByList.shtml"
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
					<pg:param name="chengcode" value="${requestScope.chengcode }"/>
					<pg:param name="corpname" value="${requestScope.corpname }"/>
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

function updateCheng(chengid,locked){
	if(!confirm("确定操作?")){
		return;
	}
	$("#chengid").val(chengid);
	$("#locked").val(locked); 
	
	$("#searchForm").attr("action", "cheng!updateChengLocked.shtml");
	$("#searchForm").submit();
}

//修改键所对应商品
function updateKeyver(chengid){
    $("#chengid").val(chengid);
	$("#searchForm").attr("action", "cheng!updateChengInit.shtml");
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
	    $("#chengcode").val($.trim($("#chengcode").val()));
			if(checkquotmarks($("#chengcode").val())){
				$("#chengcode").focus();
				$.dialog.tips('不要输入非法字符',1,'alert.gif');
				return false;
		}
		$("#corpname").val($.trim($("#corpname").val()));
			if(checkquotmarks($("#corpname").val())){
				$("#corpname").focus();
				$.dialog.tips('名称不能包含~ # *等字符',1,'alert.gif');
				return false;
		}
		$("#searchForm").attr("action","cheng!findByList.shtml");
		$("#searchForm").submit();
	}	
	
	//回收溯源秤信息
	function recoverDevice_cheng(chengid){
	    $("#chengid").val(chengid);
		$("#searchForm").attr("action", "cheng!recoverDeviceInit_cheng.shtml");
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

