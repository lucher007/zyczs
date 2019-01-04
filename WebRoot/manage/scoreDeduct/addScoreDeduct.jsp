<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title></title>
		<link type="text/css" rel="stylesheet" href="/style/user.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：诚信评价 > 新建处罚</div>
		<form action="scoreDeduct!save.shtml" id="dataForm" name="dataForm" method="post">
		<input type="hidden" name="orgid" id="orgid" value="${requestScope.org.orgid }" />
		<input type="hidden" name="addtime" id="addtime" value="${requestScope.addtime }" />
		<s:token></s:token>
	    <div class="form-box">
    		<div class="fb-tit">新建处罚</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="30" align="right" width="120">处罚单位：</td>
		            <td colspan="2">
		            	${requestScope.org.orgname }
		           	</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位CPC：</td>
		            <td colspan="2">
		            	${requestScope.org.cpccorp }
		           	</td>
		          </tr>	
		          <tr>
		            <td height="30" align="right">单位所属区域：</td>
		            <td colspan="2">${requestScope.org.province }${requestScope.org.city }${requestScope.org.area }</td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位类型：</td>
		            <td colspan="2">
		            	<c:if test="${fn:substring(requestScope.org.zyctype, 0, 1)=='1'}">药材种植 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 1, 2)=='1'}">药材经销商 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 2, 3)=='1'}">饮片生产 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 3, 4)=='1'}">饮片经销商 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 4, 5)=='1'}">药材市场 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 5, 6)=='1'}">医院 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 6, 7)=='1'}">管理机构 </c:if>
		           		<c:if test="${fn:substring(requestScope.org.zyctype, 7, 8)=='1'}">其他 </c:if>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">处罚类型：</td>
		            <td colspan="2">
		            	<select style="width:155px;" name="deducttype" id="deducttype">
							<option value="1">投诉</option>
							<option value="2">质量问题</option>
							<option value="3">诚信检查</option>								
						</select>
						<span class="red">*</span>
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">所扣分数(2-5分)：</td>
		            <td width="250">
		            	<input type="text" class="inp" name="score" id="score" maxlength="1" onblur="checkVal(this.name);" onkeyup="onkeyupCheck(this);" onkeypress="onkeypressCheck(this);"> <span class="red">*</span>
		            </td>
		            <td><label name="scoreLab" id="scoreLab" class="noico"></label></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">操作人员：</td>
		            <td><input type="text" class="inp" name="deductoper" id="deductoper" maxlength="10" value="" onblur="checkVal(this.name);"> <span class="red">*</span></td>
		            <td><label name="deductoperLab" id="deductoperLab" class="noico"></label></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">处罚原因：</td>
		            <td>
		            	<textarea class="inp" rows="4" id="deductreason" name="deductreason" cols="25" onblur="checkVal(this.name);"></textarea><span class="red">*</span>
		            </td>
		            <td><label name="deductreasonLab" id="deductreasonLab" class="noico"></label></td>
		          </tr>
		        </table>
	        </div>
	        <div class="fb-bom">
	        	<input type="button" value="返回" class="sbt" onclick="findByList_scorededuct();">
		        <cite><input type="button" value="确认" class="sbt" onclick="showinfo();" id="btnfinish"></cite>
		        <span class="red">${requestScope.returninfo }</span>
		    </div> 
		</div>
	    </form>
	</div>
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?skin=igreen"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	function onkeypressCheck(obj){
		if (!obj.value.match(/^[2-5]?$/)) {
			obj.value = obj.t_value;
		} else {
			obj.t_value = obj.value;
		}
		if (obj.value.match(/^(?:[2-5])?$/)) {
			obj.o_value = obj.value;
		}
	}
	
	function onkeyupCheck(obj){
		if (!obj.value.match(/^[2-5]?$/)) {
				obj.value = obj.t_value;
			} else {
				obj.t_value = obj.value;
			}
			if (obj.value.match(/^\.$/)) {
				obj.value = "";
			}
			if (obj.value.match(/^\-$/)) {
				obj.value = "";
			}
			if(obj.value == 'undefined'){
				obj.value='';
			}
	} 
	function checkNumber(ob){
		if((/\d+$/.test(ob))){
			return true;
		}else{
			return false;
		}
	}
	function checkVal(name){
		var nameobj = $("#"+name);
		var nameval = $.trim(nameobj.val());
		var namelab = $("#"+name+"Lab");
		if(name=="score"){
			if(checkNumber(nameval)==false||nameval==null||nameval==""){
				checkerror(name);
				namelab.html("所扣分数没有输入");
				return false;
	    	}
			checksuccess(name);
		}
		
		if(name=="deductoper"){
			if(nameval==null||nameval==""||nameval.length>20){
				checkerror(name);
				namelab.html("操作人员没有填写或者填写不正确!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}

		if(name=="deductreason"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("处罚原因没有填写或者填写不正确!");
				return false;
	    	}
	    	if(nameval.length>100){
	    		checkerror(name);
				namelab.html("处罚原因内容最多100个字符!");
				return false;
	    	}
			if(checkquotmarks(nameval)){
				checkerror(name);
				namelab.html("不要输入非法字符！");
				return false;
			}
			checksuccess(name);
		}

		return true;
	}

	function showinfo(){
		var flag=0;
		$("input").each(function(){
		    if(checkVal($(this).attr("name"))==false){
			    flag =1;
				return false;
			}
		});
		$("textarea").each(function(){
		    if(checkVal($(this).attr("name"))==false){
			    flag =1;
				return false;
			}
		});
		if(flag==1){
			return false;
		}
		document.getElementById("btnfinish").disabled=true;
		$("#dataForm").attr("action", "scoreDeduct!save.shtml");
		$("#dataForm").submit();
	}
	
	
	function findByList_scorededuct(){
		$("#duducttype").val("");
		$("#dataForm").attr("action", "scoreDeduct!findByList.shtml");
		$("#dataForm").submit();
	}
	</script>   
	</body>
</html>
