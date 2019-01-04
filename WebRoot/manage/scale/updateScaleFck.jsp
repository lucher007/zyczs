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
				//可以使用的所有按钮     按钮上数字值，x,y
				//var keyArray=new Array("1,1,1","2,1,2","2,2,3","2,3,4","2,5,5","3,5,6");
				//  - x,y  - x,y 
				//var keyString = "-1,1,1-2,1,2-2,2,3-2,3,4-2,5,4-3,5,6";
				var keyMp = new Array();
				//keyMp["-1,1"]="1"; // [x,y]=value
				//keyMp["-2,1"]="2";
				//keyMp["-2,2"]="3";
				//keyMp["-2,3"]="4";
				//keyMp["-2,5"]="5";
				//keyMp["-3,5"]="6";
				
				var tmpStr= $('#keyString').val();
				var arrStr= tmpStr.split('-');

				var keyString ="";
				for (var i=1;i<arrStr.length;i++)
				{
					var arrStr2=arrStr[i].split(',');
					keyString += '-' + arrStr2[0] +','+ arrStr2[1]  +','+ arrStr2[2];
					keyMp['-' + arrStr2[0] +','+ arrStr2[1]]=arrStr2[2];
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
	                	//组合本按钮的连接字符
	                	var tmpKeyLink = "-" + i+"," + j 
	                	// value="序号"
	                	//document.getElementById('oldVandSqu' + iCnt);
	                	
	                	
	    				//判断是配置后的按键
	                	if (keyString.indexOf(tmpKeyLink)>-1)
	                	{
	                		var tmpValue = keyMp[tmpKeyLink];
	                    	para1 = iCnt;
							//para2 = i + "," + j + ","; 
							var tmpObj = document.getElementById('oldStrList' + i + "," + j);
							if (tmpObj != undefined){
								tmpvar = document.getElementById('oldStrList' + i + "," + j).value;
							}else{
								tmpvar= "";
							}
							
							var strArry = tmpvar.split("@");
							//var hiddenvale = hv[2] + "@" + pluv +"@" + inputName ;
							
							
							if (strArry[0]=='')strArry[0]=' ';
							//if (strArry[1]==undefined)strArry[1]=' ';	
							//if (strArry[2]==undefined)strArry[2]=' ';
							//判断是否对应药材名称，如果没有显示所在位子的坐标值
							var confvaule = '';
							if(strArry[2] == '' || strArry[2] == undefined){
							
								strArry[2] = keyMp['-' + i+','+  j];
							}
							if(strArry[0] == '' || strArry[0] == ' ' || strArry[0] == undefined){
								strArry[0] = para1;
							}
							tmpValue = strArry[2];
							confvaule = strArry[0];
							para2 = confvaule + "@" + strArry[1] + "@" + strArry[2];
							
							var str = '<td> <input  value="'+tmpValue+'" type="button" name="strId[#P2]" maxlength="2" id="strId[#P2]"/>'
							         +'<input type="hidden" name="strList[#P1]" id="strList[#P1]" value="#P2"/></td>';
							str=str.replaceAll('#P1',para1,"g");
							str=str.replaceAll('#P2',para2,"g");
							//if (strArry[0] == " ")
							//str=str.replaceAll('#P3','disabled="disabled"',"g");				
							
							HTMLStr+=str;
							iCnt++;	//#P1
						}
						else
						{
							var str = '<td> <input disabled="disabled" value="" type="button" maxlength="2" />'
							 + '<input type="hidden" /></td>';
							HTMLStr+=str;
						}						
						
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
	        	$('#menuSetKey').style = '';
				var nn = $("#scaleTR input[type=button]").index(this);
				///////////////////////////////////////////
				var str = $("#menuSetKey").html();
				$.dialog({
					title:'编辑键位值',
					id:'moni',
					lock:true,
					content:str, 
					okVal:'确定', 
					ok:function(){
						var hv1 = $("#Hmedname1").val();
						var hv2 = $("#Hmedname2").val();
						var hv3 = $("#Hmedname3").val();
						var pluv = hv1 + "," + hv2 + "," + hv3;
						
						var hv = $("#scaleTR input[type=hidden]").eq(nn).val().split("@");
						var inputName = $("#medname1").val() + "\n" + $("#medname2").val() + "\n" + $("#medname3").val();
						
						if(pluv == undefined){
							pluv == "";
						}
						if(inputName == undefined){
							inputName == "";
						}
						var hvInfo = "";
						if(hv != undefined){
							hvInfo = hv[0];
						}
						var hiddenvale = hvInfo + "@" + pluv +"@" + inputName ;
						$("#scaleTR input[type=button]").eq(nn).val(inputName);
						$("#scaleTR input[type=hidden]").eq(nn).val(hiddenvale);
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
	    </script>
	    <script language="javascript" type="text/javascript" src="/js/plugin/lhgdialog/lhgdialog.min.js?self=true&skin=igreen"></script>
	    <script type="text/javascript">
	    	function selMedBase(OjbID){
	    	
	    	
	    	    $("#backOBJ").val(OjbID);
				$("#returninfo_lastcheck").html("");
				t2 = $.dialog({
					title:'选择饮片品名',
					id:'tabletChos',
					lock:true,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame"  id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
			});
			}
			
			function closeDG2(s,PLU,objName){
				var hiddenStr = PLU;
				var str = s[1];
				$("#" +objName).val(str);
				$("#H" +objName).val(hiddenStr);
				t2.close();
			}
	    </script>
	</head>
	
	<body>
	<input type="hidden" id="backOBJ" name="backOBJ"/>
	<input type="hidden" id="keyString" name="keyString" value="${keyString }"/>
	<input type="hidden" id="keyMap" name="keyMap" value="${keyMap }"/>
	
	<div id="menuSetKey" name="menuSetKey" style="display:none">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<input type="text" class="inp fl" id="medname1" readonly="readonly" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname1" display="true" name="Hmedname1"/>
	  				<a href="javascript:void(0);" onclick="selMedBase('medname1');" class="btn-xz fl">选择药材品种</a>
					<br/><br/>
				</td>
				</tr>
				<tr>
				<td>
					<input type="text" class="inp fl"  readonly="readonly" display="true"  id="medname2" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname2" name="Hmedname2"/>
	  				<a href="javascript:void(0);" onclick="selMedBase('medname2');" class="btn-xz fl">选择药材品种</a>
					<br/><br/>
				</td>
				</tr>
				<tr>
				<td>
					<input type="text" class="inp fl" display="true"  readonly="readonly" id="medname3" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname3" name="Hmedname3"/>
	  				<a href="javascript:void(0);" onclick="selMedBase('medname3');" class="btn-xz fl">选择药材品种</a>
					<br/><br/>
				</td>
			</tr>
		</table>
	</div>
	<div id="body" >
		<div class="cur-pos">当前位置：溯源秤配置 > 修改</div>
		<div class="form-box">
		<form action="scaleAction!updateScalefck.shtml" method="post">
		<input type="hidden" name="scaleid" value="${scale.scaleid }"/>
		<input type="hidden" value="${scaleConf.rowsnum }" id="rowsnum">
		<input type="hidden" value="${scaleConf.columnnum }" id="columnnum">
		
		<c:forEach items="${requestScope.scalefckList}" var="dataList" varStatus="s">
		 	<input type="hidden" id="oldStrList${dataList.rowsname},${dataList.columnname}" value="${dataList.confvale}@${dataList.plucodes}@${dataList.medname}"/>
		 </c:forEach>
		 
		 <s:token></s:token>
        	  <div class="fb-tit">添加新溯源秤</div>
              <div class="fb-con">
			   <table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
                      <td>
							经营户名称：
                      </td>
                      <td>
							市场编号：
					  </td>
                      <td>
							溯源编号：
					  </td>
					 </tr>
					 <tr>
                      <td>
                      		溯源秤编号：${scale.scalecode }
                      		<input type="hidden" name="scalecode" value="${scale.scalecode }"/>
                      		
                      </td>
                      <td>
                      		溯源秤型号：${scale.scalenorm }
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
    	<script type="text/javascript">
		  	addScaleConf();
		 </script>
	</body>
</html>
