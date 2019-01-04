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
		<input type="hidden" name="orgid" id="orgid" value="" />
		<s:token></s:token>
	    <div class="form-box">
    		<div class="fb-tit">新建处罚</div>
	       	<div class="fb-con">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="30" align="right" width="120">处罚单位：</td>
		            <td>
		            	<input type="text"  class="inp fl" readonly="readonly" value="" id="orgname" name="orgname" style="background:#eeeeee;"><a href="javascript:void(0);" id="selectCpccorp" class="btn-xzs fl">选择单位</a>
		           	</td>
		           	<td><label name="orgnameLab" id="orgnameLab" class="noico"></label></td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位CPC：</td>
		            <td colspan="2">
		            	<input type="text" class="inp fl" readonly="readonly" value="" id="cpccorp" name="cpccorp" style="background:#eeeeee;">
		           	</td>
		          </tr>	
		          <tr>
		            <td height="30" align="right">单位所属区域：</td>
		            <td colspan="2"> 
		            	<input type="text" name="province" id="province" value="" class="inponly" readonly="readonly" />
		            	<input type="text" name="city" id="city" value="" class="inponly" readonly="readonly" />
		            	<input type="text" name="area" id="area" value="" class="inponly" readonly="readonly" />
		            </td>
		          </tr>
		          <tr>
		            <td height="30" align="right">单位类型：</td>
		            <td colspan="2">
		            	<input type="text" class="inp fl" readonly="readonly" value="" id="zyctype" name="zyctype" style="background:#eeeeee;">
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
		            <td height="30" align="right" valign="top">处罚原因：</td>
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
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script type="text/javascript" language="javascript" charset="utf-8" src="/js/common/areaChoose.js"></script>
	<script language="javascript" type="text/javascript" src="/js/comtools.js"></script>
	<script type="text/javascript">
	$("#selectCpccorp").click(function(){
    	queryCompany();
    	return false;
    });
    
    function queryCompany(){
	    t2 = $.dialog({
			title:'选择单位名称',
			id:'cpccorpWindow',
			lock:true,
			content: '<iframe frameborder="0" scrolling="no" name="tFrame" id="tFrame" width="650" height="300" src="'+"<%=basePath%>scoreDeduct!companyChoice.shtml?ischoice="+Math.random()+'"></iframe>'
		 });
	}
    function closeDG(s){
		$("#orgname").val(s[1]);
		$("#cpccorp").val(s[2]);
		$("#province").val(s[3]);
		$("#city").val(s[4]);
		$("#area").val(s[5]);
		$("#orgid").val(s[7]);

		if(s[6]=="10000000"){
			$("#zyctype").val("药材种植");
		}else if(s[6]=="01000000"){
			$("#zyctype").val("药材经销商");
		}else if(s[6]=="00100000"){
			$("#zyctype").val("饮片生产");
		}else if(s[6]=="00010000"){
			$("#zyctype").val("饮片经销商");
		}else if(s[6]=="00001000"){
			$("#zyctype").val("药材市场");
		}else if(s[6]=="00000100"){
			$("#zyctype").val("医院");
		}else if(s[6]=="00000010"){
			$("#zyctype").val("管理机构");
		}else if(s[6]=="00000001"){
			$("#zyctype").val("其他");
		}
		checksuccess("orgname");
		$("#orgname").focus();
		t2.close();
	}
	
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
		
		if(name=="orgname"){
			if(nameval==null||nameval==""){
				checkerror(name);
				namelab.html("单位没有选择!");
				return false;
	    	}
			checksuccess(name);
		}
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
		$("#dataForm").attr("action", "scoreDeduct!saveChoose.shtml");
		$("#dataForm").submit();
	}
	
	function findByList_scorededuct(){
		$("#duducttype").val("");
		$("#dataForm").attr("action", "scoreFinal!findByListInit.shtml");
		$("#dataForm").submit();
	}
	</script>   
	</body>
</html>
