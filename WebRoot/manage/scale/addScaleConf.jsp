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
		<link type="text/css" rel="stylesheet" href="/style/market.css">
		<script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
   	 	<script type="text/javascript" language="javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
    	<script type="text/javascript" language="javascript" src="/js/form.js"></script>
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
            for(var i = 1;i <= rowsnum;i++){
				HTMLStr += "<tr>";
                for (var j=1;j<=columnnum;j++)
                {
                    para1 = iCnt;
                    para2 = i + "," + j + "," + ""; 
                    var str = '<td align=center><input type="button" name="strId[#P2]" maxlength="2" id="strId[#P2]" value=""> <input type="hidden" name="strList[#P1]" id="strList[#P1]" value="#P2"></td>';
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
					var num=~~$("#monitable input[type=text]").val();
					if(num<1){num=""};
					$("#scaleTR input[type=button]").eq(nn).val(num);
					var hv = $("#scaleTR input[type=hidden]").eq(nn).val().split(",");
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
		
		function checkIsNull(){
			if($("#companyname").val() == "")
			{
				$.dialog.tips("厂商名称必须填写！",1,'alert.gif');
				$("#companyname").focus();
				return;	
			};
			if($("#modelnumber").val() == "")
			{
				$.dialog.tips("型号必须填写！",1,'alert.gif');
				$("#modelnumber").focus();
				return;	
			};
			if($("#rowsnum").val() == "")
			{
				$.dialog.tips("按键行数必须填写！",1,'alert.gif');
				$("#rowsnum").focus();
				return;	
			};
			if($("#columnnum").val() == "")
			{
				$.dialog.tips("按键列数必须填写！",1,'alert.gif');
				$("#columnnum").focus();
				return;	
			};
			if($("#keynum").val() == "")
			{
				$.dialog.tips("按键总数必须填写！",1,'alert.gif');
				$("#keynum").focus();
				if($("#keynum").val() > $("#rowsnum").val()*$("#columnnum").val()){
					$.dialog.tips("按键总数超过总个数！",1,'alert.gif');
					$("#keynum").focus();
				}
				return;	
			};
			$("#searchform").attr("action", "<%=basePath%>scaleConf!save.shtml");
			$("#searchform").submit();
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
		
	</head>
	<body>
	<div id="body">
		<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤发放</div>
		<div class="form-box">
		<form action="scaleConf!save.shtml" method="post" id="searchform" name="searchform">
			<s:token></s:token>
        	  <div class="fb-tit">新建溯源秤规格</div>
              <div class="fb-con">
			   	<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
					  <td height="30">
							厂商名称：<input type="text" class="inp w100" name="companyname" maxlength="20" id="companyname">
					  </td>
                      <td>
							型号：<input type="text" class="inp w100" name="modelnumber" id="modelnumber" maxlength="15">
                      </td>
                      <td>
							按键行数：<input type="text" onkeyup="check_IsNum2(this.value)"  onkeypress="check_IsNum2(this.value)"  class="inp" size="2" name="rowsnum" maxlength="2" id="rowsnum" >
                      </td>
                      <td>
							按键列数：<input type="text" onkeyup="check_IsNum(this.value)"  onkeypress="check_IsNum(this.value)" class="inp" size="2" name="columnnum" maxlength="2" id="columnnum">
					  </td>
                      <td>
							按键总数：<input type="text" onkeyup="check_IsNum1(this.value)"  onkeypress="check_IsNum1(this.value)" class="inp" size="2" name="keynum" maxlength="2" id="keynum">
					  </td>
                      <td>
                      	<input type="button" value="生产按键" onclick="addScaleConf();" class="btn" id="next">
                      </td>
					</tr>
				</table>
                <table width="724" border="0" cellpadding="0" cellspacing="0" class="fbc-box ml10 mt10">
                  <tr class="fbc-tit">
                    <td class="b">点击按钮设置溯源秤按键序号</td>
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
                <cite><input type="button" value="提交" id="next" name="next" onclick="checkIsNull()" class="sbt"></cite>
            </div>
            </form>
        </div>
    </div>
	</body>
</html>
