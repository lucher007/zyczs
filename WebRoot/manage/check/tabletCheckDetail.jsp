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
		<base href="<%=basePath%>" target="_self" />   
    	<title></title>
    	<link type="text/css" rel="stylesheet" href="/style/production.css">
  	</head>
  
  	<body>
  	<div id="body">
	  	<div class="cur-pos">当前位置：检验管理 > 已检饮片详情</div>
		<div class="form-box">
		  	<form action="" method="post" name="searchform" id="searchform">
		  	<div class="fb-tit">已检药材详情</div>
	        <div class="fb-con">
	            <table cellpadding="0" cellspacing="0" border="0" width="100%">
	              <tr>
	                  <td height="30" colspan="2">饮片批次号：${check.cpctablet }</td>
	                  <td>饮片名：${check.tabletname }</td>
	              </tr>
	              <tr>
	                  <td height="30" colspan="2">执行标准：${check.checkmethod }</td>
	                  <td>检验人员：${check.checkuser }</td>
	              </tr>
	              <tr>
	                  <td height="30" colspan="2">贮藏条件：${check.checkcondition }</td>
	                  <td>检验时间：${check.checktime }</td>
	              </tr>
	 			</table>
	 			
	 			<table cellpadding="0" cellspacing="0" border="0" width="726" class="fbc-box ml10">
	 			  <tr class="fbc-tit">
	                  <td height="30" class="b">检验检测报告</td>
	              </tr>
	              <tr>
	              	<td id="checkDetail"></td>
	              </tr>
	 			</table>
	    	</div>
	        <div class="fb-bom">
	            <input type="button" value="返回上一页" class="sbt" onclick="history.go(-1);">
	        </div>
	        </form>
	    </div>
	</div>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/common/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/form.js"></script>
	<script type="text/javascript" language="javascript">
		//cMenu(1,0);
		
		displayuploaddiv();
    	function displayuploaddiv(){
    		var url="<%=request.getContextPath()%>/checkAjax!findByMaterial.shtml?rid="+Math.random();
    		$.getJSON(url,{tabletid:'${check.prodid }',type:'${check.type}',orgid:'${check.orgid}'}, function(data) {
	    		var loginForm = data;
		    	var matlist = loginForm.model.materiallist;
		    	var str="";
		    	for(var i=0;i<matlist.length;i++){        	

		        	var matcont = matlist[i].matcontent;
	    			matcont=matcont.substring(matcont.length-3,matcont.length);
		    		if(matcont=="jpg"||matcont=="gif"||matcont=="png"||matcont=="bmp"){
	    				str+="<div class=\"checkinfo-list\"><cite><a class=\"btn-look\" target=\"_blank\" id=\"name"+matlist[i].matid +"\" href=\"<%=basePath%>checkMatImage.shtml?matcontent="+matlist[i].matcontent+"\">点击查看</a></cite><a target=\"_blank\" id=\"name"+matlist[i].matid +"\" href=\"<%=basePath%>checkMatImage.shtml?matcontent="+matlist[i].matcontent+"\">"+matlist[i].matname+"</a></div>";
		    		}else{
		    			str+="<div class=\"checkinfo-list\"><cite><a class=\"btn-look\" target=\"_blank\" id=\"name"+matlist[i].matid +"\" href=\"<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent="+matlist[i].matcontent+"\">点击查看</a></cite><a target=\"_blank\" id=\"name"+matlist[i].matid +"\" href=\"<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent="+matlist[i].matcontent+"\">"+matlist[i].matname+"</a></div>";
		    		}   
		    		   		        	    		
		    	}
		    	
		    	$("#checkDetail").html(str);
		    	resetH();
			});
	    };
    </script>
  	</body>
 </html>
  