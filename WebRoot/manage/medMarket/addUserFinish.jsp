<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>新增经营户信息</title>
<link type="text/css" rel="stylesheet" href="/style/market.css">
</head>

<body>
<div id="body">
	<div class="cur-pos">当前位置：市场管理 &gt; 添加新经营户</div>
	<div class="form-box">
    	<form action="" name="searchform" id="searchform" method="post">
    	<div class="fb-tit">操作成功</div>
        <div class="fb-con">
        	<div class="fb-msg">
                <img src="../images/frame/dui.png">
                <b class="green">添加新经营户完成！</b>
                <b class="green">经营户CPC：${org.cpccorp}</b>
            </div>
            <table width="726" border="0" cellspacing="0" cellpadding="0" class="fbc-box ml10 mt10">
              <tr class="fbc-tit">
                <td>商户信息</td>
              </tr>
              <tr>
                <td style="padding:10px;">
                	<table width="100%">
                      <tr>
                        <td height="30" align="right" bgcolor="#EEEEEE">经营户名称：</td><td>${org.corpname }</td>
                        <td align="right" bgcolor="#EEEEEE">商户编号：</td><td>${ org.businessnumber}</td>
                      </tr>
                      <tr>
                          <td height="30" align="right" bgcolor="#EEEEEE">商户名称：</td><td>${org.orgname }</td>
                          <td height="30" align="right" bgcolor="#EEEEEE">商户简称：</td><td>${org.orgshortname }</td>
                      </tr>
                      <tr>
                        <td height="30" align="right" bgcolor="#EEEEEE">法人：</td><td>${org.masterman }</td>
                        <td align="right" bgcolor="#EEEEEE">身份证号：</td><td>${org.identitycard }</td>
                      </tr>
                      <tr>	
                        <td height="30" align="right" bgcolor="#EEEEEE">进场经营时间：</td><td>${addtime }</td>
                        <td align="right" bgcolor="#EEEEEE">移动电话：</td><td>${org.mobile }</td>
                      </tr>
                      <tr>
                        <td height="30" align="right" bgcolor="#EEEEEE">电话：</td><td>${org.telephone }</td>
                        <td align="right" bgcolor="#EEEEEE">电子邮件：</td><td>${org.email }</td>
                      </tr>
                      <tr>
                        <td height="30" align="right" bgcolor="#EEEEEE">经营地址：</td><td>${org.registeraddress }</td>
                        <td align="right" bgcolor="#EEEEEE">营业执照号：</td><td>${org.businesscode }</td>
                      </tr>
                    </table>
                </td>
              </tr>
            </table>
    	</div>
        <div class="fb-bom">
        	<cite><input type="button" value="返回经营户管理" class="sbt" onclick="goToUrl()"></cite>
          <!--   <input type="button" value="添加溯源秤" class="sbt"> 
            <input type="button" value="发卡" class="sbt">-->
        </div>
        </form>
    </div>
</div>
<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" language="javascript" src="/js/form.js"></script>
<script type="text/javascript" language="javascript">
function goToUrl(){
		$("#searchform").attr("action", "<%=basePath %>medMarket!findByList.shtml");
		$("#searchform").submit();
}
</script>
</body>
</html>