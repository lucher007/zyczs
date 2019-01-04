<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<link type="text/css" rel="stylesheet" href="<%=basePath%>style/market.css">
	</head>
	
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：溯源秤配置 > 修改</div>
		<div class="form-box">
		<form action="scaleConf!update.shtml" method="post">
		<input type="hidden" name="scaleid" value="${scale.scaleid }"/>
		<c:forEach items="${requestScope.keyConfList}" var="dataList" varStatus="s">
		 	<input type="hidden" name="oldStrList[${dataList.rowsname},${dataList.columnname},${dataList.confvale}]" id="oldStrList${s.index + 1}" value="${dataList.confvale}"/>
		 </c:forEach>
		 
		 <s:token></s:token>
        	  <div class="fb-tit">添加新溯源秤</div>
              <div class="fb-con">
			   	<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
					  <td height="30">
							厂商名称：<input type="text" class="inp w100" name="companyname" maxlength="20" value="${scale.companyname }" id="companyname">
					  </td>
                      <td>
							型号：<input type="text" class="inp w100" name="modelnumber" id="modelnumber" value="${scale.modelnumber }" maxlength="15">
                      </td>
                      <td>
							行数：<input type="text" onkeyup="check_IsNum2(this.value)"  onkeypress="check_IsNum2(this.value)"   class="inp" size="2" name="rowsnum" maxlength="2" value="${scale.rowsnum }" id="rowsnum" value="" >
                      </td>
                      <td>
							列数：<input type="text" onkeyup="check_IsNum(this.value)"  onkeypress="check_IsNum(this.value)"   class="inp" size="2" name="columnnum" maxlength="2" value="${scale.columnnum }" id="columnnum" value="">
					  </td>
                      <td>
							键数：<input type="text" onkeyup="check_IsNum1(this.value)"  onkeypress="check_IsNum1(this.value)"   class="inp" size="2" name="keynum" maxlength="2" value="${scale.keynum }" id="keynum">
					  </td>
                      <td>
                      	<input type="button" value="模拟" onclick="addScaleConf();" class="btn" id="next">
                      </td>
					</tr>
				</table>
                <table width="724" border="0" cellpadding="0" cellspacing="0" class="fbc-box ml10 mt10">
                  <tr class="fbc-tit">
                    <td class="b">模拟键位</td>
                  </tr>
                  <tr>
                    <td style="padding:0">
                    <table width="720" id="scaleTR" border="0" cellpadding="0" cellspacing="0">
                    </table>
                    </td>
                  </tr>
                </table>
			</div>
            <div class="fb-bom">
                <cite><input type="submit" value="提交" class="sbt"></cite>
            </div>
            </form>
        </div>
    </div>
    <script type="text/javascript" language="javascript" src="<%=basePath%>js/common/jquery.js"></script>
   	 	<script type="text/javascript" language="javascript" src="<%=basePath%>js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    	<script type="text/javascript" language="javascript" src="<%=basePath%>js/form.js"></script>
<script type="text/javascript">
        String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
            /*
            string：字符串表达式包含要替代的子字符串。
            reallyDo：被搜索的子字符串。
            replaceWith：用于替换的子字符串。
            */
            if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
                return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);
            } else {
                return this.replace(reallyDo, replaceWith);
            }
        }
		
        function addScaleConf(){
            var columnnum = $('#columnnum').val();
            var rowsnum = $('#rowsnum').val();
			if(columnnum>20||rowsnum>20){
				$.dialog.alert('行列数最大不超过20！');
				return;
			}
            var iCnt = 1;
            var para1= 1;
            var para2= 1;
            var HTMLStr = "";
            var tmpvar= "";//临时存放value
            for(var i = 1;i <= rowsnum;i++){
				HTMLStr += "<tr>";
                for (var j=1;j<=columnnum;j++)
                {
                    para1 = iCnt;
						para2 = i + "," + j + ","; 
						var tmpObj = document.getElementById('oldStrList' + iCnt);
						if (tmpObj != undefined)
							tmpvar = document.getElementById('oldStrList' + iCnt).value;
						else
							tmpvar= "";
						para2 += tmpvar;
						var str = '<td> <input value="'+tmpvar+'" type="button" name="strId[#P2]" maxlength="2" id="strId[#P2]"/>'
						         +'<input type="hidden" name="strList[#P1]" id="strList[#P1]" value="#P2"/></td>';
						str=str.replaceAll('#P1',para1,"g");
						str=str.replaceAll('#P2',para2,"g");
						HTMLStr+=str;						
						iCnt++;	//#P1
                }
                HTMLStr += "</tr>";
            }
            $('#scaleTR').html(HTMLStr).css("padding","10px 0");
			$('#scaleTR td').css("padding","3px 0");
			var wh=720/columnnum-10;
			$('#scaleTR input').height(wh).width(wh).css("padding","0");
			resetH();
        }
        $("#scaleTR input[type=button]").live('click',function(){
			var nn = $("#scaleTR input[type=button]").index(this);
			var str = '<table id="monitable"><tr><td colspan="4" align="center"><input type="text" style="padding:10px; text-align:right;" readonly></td></tr><tr><td align="center" height="40"><input type="button" value="1"></td><td align="center"><input type="button" value="2"></td><td align="center"><input type="button" value="3"></td><td align="center"><input type="button" value="4"></td></tr><tr><td align="center" height="40"><input type="button" value="5"></td><td align="center"><input type="button" value="6"></td><td align="center"><input type="button" value="7"></td><td align="center"><input type="button" value="8"></td></tr><tr><td align="center" height="40"><input type="button" value="9"></td><td align="center"><input type="button" value="0"></td><td><input type="button" value="←"></td><td>&nbsp;</td></tr></table>';
			$.dialog({
				title:'编辑键位值',
				id:'moni',
				lock:true,
				content:str, 
				okVal:'确定', 
				ok:function(){
					$("#scaleTR input[type=button]").eq(nn).val(~~$("#monitable input[type=text]").val());
					var hv=$("#scaleTR input[type=hidden]").eq(nn).val().split(",");
					hv[2]=~~$("#monitable input[type=text]").val();
					$("#scaleTR input[type=hidden]").eq(nn).val(hv[0]+","+hv[1]+","+hv[2]);
				},
				cancelVal:'取消',
				cancel:true 
			});
			$("#monitable input[type=button]").height(38).width(38)
		});
		$("#monitable input[type=button]").live('click',function(){
			var val=$("#monitable input[type=text]").val();
			if($(this).val()+""=="←"){
				$("#monitable input[type=text]").val(val.substring(0,val.length-1));
			}else{
				if((val+""+$(this).val())>999){
					return;
				};
				$("#monitable input[type=text]").val(val+""+$(this).val());
			}
		});
		addScaleConf();
    </script>
    <script type="text/javascript">
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
        	document.getElementById("columnnum").value = "";
        }else{
        	if(parseInt(value) >= 20){
        		document.getElementById("columnnum").value = "";
        	}
        }
	}
	function check_IsNum1(value){
		//先把非数字的都替换掉，除了数字
		//value = value.replace(/^\d+$/,"");  
	    //定义正则表达式部分
        if(!checkNumberChar(value)){
        	document.getElementById("keynum").value = "";
        }else{
        	if(parseInt(value) >= 80){
        		document.getElementById("keynum").value = "";
        	}
        }
	}
	function check_IsNum2(value){
		//先把非数字的都替换掉，除了数字
		//value = value.replace(/^\d+$/,"");  
	    //定义正则表达式部分
        if(!checkNumberChar(value)){
        	document.getElementById("rowsnum").value = "";
        }else{
        	if(parseInt(value) >= 20){
        		document.getElementById("rowsnum").value = "";
        	}
        }
	}
    </script>
	</body>
</html>
