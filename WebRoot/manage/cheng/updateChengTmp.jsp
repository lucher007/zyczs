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
			var api; 
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
	        
	        function addChengConf(){
	            var columnnum = $('#columnnum').val();
	            var rowsnum = $('#rowsnum').val();
				if(columnnum>20||rowsnum>20){
					$.dialog.alert('行列数最大不超过20！');
					return;
				}
				
				//所有已经配置的键值
				var keystring= $('#keystring').val();
				
				//已经配置快捷键的列表
				var arrStr= keystring.split('-');

                //组装配置键值的2维数组
                var keyMp = new Array();
				for (var i=1;i<arrStr.length;i++) {
					var arrStr2=arrStr[i].split(',');
					keyMp['-' + arrStr2[0] +','+ arrStr2[1]] = arrStr2[2];
				}
                
	            var iCnt = 1;
	            var para1= 1;
	            var para2= "";
	            var HTMLStr = "";
	            var str = "";
	            for(var i = 1;i <= rowsnum;i++){
					HTMLStr += "<tr>";
	                for (var j=1;j<=columnnum;j++){
	                    para1 = iCnt; //就是每个配置的位置值
	                    
	                    //组合本按钮的连接字符
	                	var tmpKeyLink = "-" + i+"," + j;
		                	
                        // 判断此按钮是否配置了快捷键(有快捷键）
						if ($('#oldStrList' + i + '-' + j).length >0){
							para2 = $('#oldStrList' + i + "-" + j).val();
							
							para2 = para2.replaceAll('\n','<br/>',"g");//对数据库以前的带有\n的数据替换成<br/>
							
							//对已经配置的快捷键进行截取
						    var strArry = para2.split("@");
							str = '<td>'
							    + '<button id="strId[#P2]" name="strId[#P2]" maxlength="2">'+strArry[2]+'</button>'
						         +'<input type="hidden" name="strList[#P1]" id="strList[#P1]" value="#P2"/></td>';
							str=str.replaceAll('#P1',para1,"g");
							str=str.replaceAll('#P2',para2,"g");
							
						} else if(keystring.indexOf(tmpKeyLink)>-1) {//判断此按钮是否有键值（无快捷键有键值）
						    
		                	var tmpValue = keyMp[tmpKeyLink];
		                	
	                        para2 = tmpValue+'@';
							str = '<td>'
							    + '<button id="strId[#P2]" name="strId[#P2]" maxlength="2">'+tmpValue+'</button>'
						         +'<input type="hidden" name="strList[#P1]" id="strList[#P1]" value="#P2"/></td>';
							str=str.replaceAll('#P1',para1,"g");
							str=str.replaceAll('#P2',para2,"g");
						} else { //未配置键值的按钮
						    str = '<td> <button disabled="disabled" value="" maxlength="2" />'
							    + '<input type="hidden" /></td>';
						}
						HTMLStr+=str;
						iCnt++;	//#P1
	                }
	                HTMLStr += "</tr>";
	            }
	            $('#chengTR').html(HTMLStr).css("padding","10px 0");
				$('#chengTR td').css("padding","3px 0");
				var wh=720/columnnum-10;
				$('#chengTR input').height(wh).width(wh).css("padding","0");
				$('#chengTR button').height(wh).width(wh).css("padding","0");
				resetH();
	        }
	        
	        $("#chengTR button").live('click',function(){
	        	// $('#menuSetKey').style = '';
				var nn = $("#chengTR button").index(this);
				///////////////////////////////////////////
				var str = $("#menuSetKey").html();
				var thisl = $(this).offset().left;
				if(thisl<120){
					thisl=24;
				}else if(thisl>523){
					thisl=thisl-90;
				}else{
					thisl=thisl-Math.abs($(this).width()-265)/2;
				};
				var thist = $(this).offset().top;
				thist = thist-(196-$(this).height())/2;
				api=$.dialog({
					title:'编辑键位值',
					id:'moni',
					top:thist,
					min:false,
					max:false,
					left:thisl,
					lock:true,
					content:str,
					okVal:'确定', 
					ok:function(){
						var hv1 = $("#Hmedname1").val();
						var hv2 = $("#Hmedname2").val();
						var hv3 = $("#Hmedname3").val();
						var pluv = hv1 + "," + hv2 + "," + hv3;
						
						var hv = $("#chengTR input[type=hidden]").eq(nn).val().split("@");
						var inputName = $("#medname1").val() + "<br/>" + $("#medname2").val() + "<br/>" + $("#medname3").val();
						
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
						
						//判断是否清空此快捷键
						if($("#medname1").val()== "" && $("#medname2").val() == "" && $("#medname3").val() == ""){
						    inputName = hv[0];
						}
						
						$("#chengTR button").eq(nn).html(inputName);
						$("#chengTR input[type=hidden]").eq(nn).val(hiddenvale);
					},
					cancelVal:'取消',
					cancel:true 
				});
			});
			
			$(".btn-xz").live('click',function(){
				var thist = $(this).offset().top;
				
				if(thist<375){
					thist = 50;
				}else if(thist>$("body").height()-375){
					thist = $("body").height()-375;
				}else{
					thist=($("body").height()-375)/2;
				}
	    	    $("#backOBJ").val("medname"+($("a.btn-xz").index(this)+1));
				$("#returninfo_lastcheck").html("");
				t2 = $.dialog({
					title:'选择药材品名',
					id:'tabletChos',
					lock:true,
					min:false,
					max:false,
					top:thist,
					//parent:api,
					content: '<iframe frameborder="0" scrolling="no" name="tFrame"  id="tFrame" width="650" height="300" src="'+"<%=basePath%>medBase!medBaseChoice.shtml?ischoice="+Math.random()+'"></iframe>'
				});
				return false;
			});
			
			function closeDG2(s,PLU,objName){
				var hiddenStr = PLU;
				var str = s[1];
				$("#" +objName).val(str);
				$("#H" +objName).val(hiddenStr);
				t2.close();
				api.lock();
			}
	    </script>
	</head>
	
	<body>
	<input type="hidden" id="backOBJ" name="backOBJ"/>
	<input type="hidden" id="keystring" name="keystring" value="${keystring }"/>
	
	<div id="menuSetKey" name="menuSetKey" style="display:none">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="30">
					<input type="text" class="inp fl" id="medname1" readonly="readonly" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname1" name="Hmedname1">
				</td>
				<td>
	  				<a href="javascript:void(0);" class="btn-xz fl">选择药材品种</a>
				</td>
				</tr>
				<tr>
				<td height="30">
					<input type="text" class="inp fl"  readonly="readonly"  id="medname2" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname2" name="Hmedname2">
				</td>
				<td>
	  				<a href="javascript:void(0);" class="btn-xz fl">选择药材品种</a>
				</td>
				</tr>
				<tr>
				<td height="30">
					<input type="text" class="inp fl"  readonly="readonly" id="medname3" name="medname" maxlength="20" />
					<input type="hidden" id="Hmedname3" name="Hmedname3">
				</td>
				<td>
	  				<a href="javascript:void(0);" class="btn-xz fl">选择药材品种</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="body" >
		<c:if test="${sessionScope.User.org.zyctype=='00001000'}">
			<div class="cur-pos">当前位置：市场管理 > 溯源秤模板管理</div>
		</c:if>
		<c:if test="${sessionScope.User.org == null ||sessionScope.User.org.zyctype=='00000010'}">
			<div class="cur-pos">当前位置：溯源秤管理 > 溯源秤模板管理</div>
		</c:if>
		<div class="form-box">
		<form action="" method="post" id="searchform" name="searchform">
		<input type="hidden" id="tmpid" name="tmpid" value="${chengtmp.tmpid }"/>
		<input type="hidden" id="confid" name="confid" value="${chengtmp.confid }"/>
		<input type="hidden" id="rowsnum"  name="rowsnum" value="${chengConf.rowsnum }" >
		<input type="hidden" id="columnnum" name="columnnum" value="${chengConf.columnnum }" >
		
		<c:forEach items="${requestScope.chengfcktmplist}" var="dataList" varStatus="s">
		 	<input type="hidden" id="oldStrList${dataList.rowsnum}-${dataList.columnnum}" value="${dataList.keyvalue}@${dataList.plucodes}@${dataList.medname}"/>
		 </c:forEach>
		 
		 <s:token></s:token>
        	  <div class="fb-tit">模板修改</div>
              <div class="fb-con">
			   <table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
                      <td>
							模板名称：<input type="text" size="25" class="inp" name="tmpname" id="tmpname" maxlength="20" value="${chengtmp.tmpname }">
                      </td>
                      <td>
							规格名称：${chengtmp.normname }
					  </td>
					 </tr>
				</table>
                <table width="724" border="0" cellpadding="0" cellspacing="0" class="fbc-box ml10 mt10">
                  <tr class="fbc-tit">
                    <td class="b">模板快捷键</td>
                  </tr>
                  <tr>
                    <td style="padding:0">
                    <table width="720" id="chengTR" border="0" cellpadding="0" cellspacing="0">
                    </table>
                    </td>
                  </tr>
                </table>
			</div>
            <div class="fb-bom">
                <cite><input type="button" value="保存" class="sbt" onclick="saveChengFck();" id="btnfinish"></cite>
                <span class="red">${requestScope.returninfo }</span>
            </div>
            </form>
        </div>
    </div>
    	<script type="text/javascript">
		  	//初始化页面按钮
		  	addChengConf();
		  	
		  	function checkArea(str){
				return /[\·\'\"\~\`\@\#\^\&\*\|\{\}\[\]\+\=?\<\>\/\\]/.test(str);
			}
		  	
		  	function saveChengFck(){
		  	    if($("#tmpname") != undefined && $("#tmpname").val() == ""){
					$.dialog.tips("模板名称必须填写！",1,'alert.gif');
					$("#tmpname").focus();
					return;
				}
				
				if(checkArea($("#tmpname").val())){
					$("#tmpname").focus();
					$.dialog.tips('不要输入非法字符',1,'alert.gif');
					return false;
				}
		  	    
				if(!confirm("确定保存?")){
					return;
				}
				
				$("#searchform").attr("action", "<%=basePath%>chengTmp!updateChengTmp.shtml");
				$("#searchform").submit();
			}
		  	
		 </script>
	</body>
</html>
