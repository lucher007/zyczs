<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.gov.zyczs.cspt.common.ToolsValid" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>错误提示页面</title>
<link type="text/css" rel="stylesheet" href="/style/login.css">
<script type="text/javascript">
function htmlCheck(str){
	var fString=str
	fString=fString.replace(new RegExp("<","gi"),"&lt;");			
	fString=fString.replace(new RegExp(">","gi"),"&gt;");		
	fString=fString.replace(new RegExp("--","gi"),"&#45;&#45;");
	fString=fString.replace(new RegExp("\'","gi"),"&#39;");
	fString=fString.replace(new RegExp("\"","gi"),"&#34;");
	fString=fString.replace(new RegExp("\n","gi"),"<BR>");
	return fString;
}
</script>
</head>
 
<body id="bg404">
	<div class="img404">
    	<div class="box404">
        	<div class="bt-404">
        		<c:if test="${param.returninfo!=null}">
        			<script type="text/javascript">
        			 var returninfo="${param.returninfo}";
        			 returninfo=htmlCheck(returninfo);
        			 document.write(returninfo);
        			</script>
        		</c:if>
        		<c:if test="${requestScope.returninfo!=null}">
        			<script type="text/javascript">
        			 var returninfo="${requestScope.returninfo}";
        			 returninfo=htmlCheck(returninfo);
        		     document.write(returninfo);
        			</script>
        		</c:if>
        		<c:if test="${requestScope.returninfo==null&&param.returninfo==null}">
        			您访问的页面发生错误或不存在!
        		</c:if>
            </div>
            <div class="bl-404">
            <c:if test="${requestScope.returninfo=='该用户没有权限!'||param.returninfo=='该用户没有权限!'}">
            	<a href="/login.jsp">返回上一页</a>
            </c:if>
            <c:if test="${requestScope.returninfo!='该用户没有权限!'&&param.returninfo!='该用户没有权限!'}">
            	<a href="javascript:history.go(-1);">返回上一页</a>
            </c:if>
                <a href="/login.jsp" class="log404">重新登录</a>
            </div>
        </div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
    <script type="text/javascript">
    var url=top.location.href;
    if(url.indexOf("logined")>0){
    	top.location='error.jsp?returninfo=${returninfo }';
    }
	forbg();
	$(window).resize(function(){
		forbg();
	});

	function forbg(){
		var t = (($(window).width()-1044)/2)%18;
		if(t!=0){$("body").css("background-position","-"+(t)+"px top")};
		$(".img404").height($(window).height());
		if($(window).height()<816){
			var hh=($(window).height()-816)/2;
			$(".img404").css("background-position","center "+hh+"px");
			$(".box404").css("padding-top",417+hh+"px")
		}
	}
	
    </script>
</body>
</html>

