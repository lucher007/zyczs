<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


String type=request.getParameter("type");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'inputCodeCount.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/form.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/comtools.js"></script>

<script type="text/javascript">
	function onkeyupNum2(obj){    	
		obj.value=$.trim(obj.value);//去空格			
		obj.value=obj.value.replace(/\D/g,'');//保留数字
				
		if(obj.value == 'undefined')
			obj.value='';
		if(obj.value!='')
		{
			//obj.value=addtr(obj.value,0);
		}
		//大于0
		if(obj.value<1&&obj.value.length==1) {
			obj.value = "";
		}	
	}
	
	function onclk(){
		var t = $.trim($("#downCount").val());
		if(t==""){
			alert("请输入打印数量");
			return;
		}
		var selArray=new Array(1);
		selArray[0]=t;
		selArray[1]=<%=type%>;
		
		parent.closeDG(selArray);
	}
	
</script>

<style type="text/css">
input.sch{ width:73px; height:25px; line-height:25px; cursor:pointer; border:0; background:url(../images/frame/frame-bg.png) no-repeat left -230px; color:#FFF; font-weight:bold;}
</style>
  </head>
  
  <body style="padding:0px;" >
  	<div style="font-weight:bold;border:solid #999 1px;"">
  	
  	<table style="margin-top:0px;  border="0" >	
  		<tr height="10px"><td></td></tr>
  		<tr>
  			<td width="140px">请输入打印数量：</td>
  			<td><input type="text" id="downCount" onkeyup="onkeyupNum2(this);" onkeypress="onkeyupNum2(this);"  onblur="onkeyupNum2(this);" maxlength="6" size="6"></td>
  			<td width="35px">&nbsp;</td>
  		</tr>
  		<tr height="10px"><td></td></tr>
  	</table>
  	
  	</div>
  	<table width="100%">
  		<tr>
  			<td align="right">
  			<input type="button" id="sur_but" value="确定" onclick="onclk();" class="sch" > 
  			</td>
  		</tr>
  	</table>
    
  </body>
</html>
