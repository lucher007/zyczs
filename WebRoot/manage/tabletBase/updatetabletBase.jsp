<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>" >
		<title>新建种植</title>
		<link type="text/css" rel="stylesheet" href="/style/production.css"/>
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：饮片品名管理 > 修改饮片品名</div>
		<div class="form-box">
  		  	<form action="tabletBase!updateObject.shtml" method="post" name="myform" id="myform">
  		  	<input  type="hidden" id="id" name="id" value="${requestScope.vo.id }" />
			<s:token></s:token>
    		<div class="fb-tit">修改饮片品名</div>
        	<div class="fb-con">
				
			   	<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="200" height="30" align="right">
							饮片中文名称：
						</td>
						<td width="170">
							<input type="text" class="inp" name="name" maxlength="20" value="${requestScope.vo.name }"
								id="name" onblur="onBlurCheck(this.name)"/>
							<span class="red">*</span>
						</td>
						<td width="330">
							<label name="nameLab" id="nameLab" class="noico">
								饮片中文名称未输入
							</label>
						</td>
					</tr>
					<tr>
						<td height="30" align="right">
							饮片英文名称：
						</td>
						<td>
							<input type="text" class="inp" name="keyword" value="${requestScope.vo.keyword }"
								id="keyword" maxlength="15"/>
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
								
				</table>
			</div>
			<div class="fb-bom">
		        <cite><input type="button" value="提  交" onclick="checkInfo()" id="subBut" class="sbt"></cite>
				<input type="button" value="返  回" onclick="findByList()" id="backBut" class="sbt">
		    </div>
			</form>
		</div>
	</div>
	<script language="javascript" type="text/javascript" src="/js/common/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>	
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript" language="javascript">
		var errmsg = "${requestScope.returnInfo }";
		$("#name").focus();
		if(errmsg!=""){
			$.dialog.tips(errmsg,3,'alert.gif');	
		}
		
		function checkInfo(){
		    if($("#name").val() ==''){
		    	return false;
		    }
		    
		    $.dialog.confirm('确认要提交更新吗？', function(){
	
    			$("#subBut").attr("disabled","disabled");
    			$("#backBut").attr("disabled","disabled");
    			
    			$("#myform").submit();
			}, function(){
    			
			});
		    

		}
		
		function findByList()
		{
			window.location="tabletBase!findByList.shtml";
		}
		
		
	</script>
	</body>
</html>