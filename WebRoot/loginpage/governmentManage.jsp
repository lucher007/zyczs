<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>中药材流通追溯地方监管子系统${initParam.titlename }</title>
<link type="text/css" rel="stylesheet" href="/style/frame.css">
<script type="text/javascript">
var returncode = "${requestScope.returncode}";
if(returncode==111||returncode==""||returncode==null){
	window.location.href="<%=request.getContextPath() %>login.jsp";
}
</script>
</head>
<body>
    <div id="top" class="user_logo"><div class="site">${initParam.titlename }</div></div>
    <div id="menu">
    	<div class="m-list">
            <cite>
                <c:if test="${sessionScope.User.loginname!='admin'}"><a href="user!findByPerson.shtml" class="m-user" target="MainFrame">个人资料</a></c:if>
                <a href="logined!logout.shtml" class="m-out">退出系统</a>
            </cite>
            <div style="width:720px;">
            	<c:if test="${sessionScope.User.loginname!='admin'}">
	            	<c:forEach items="${requestScope.menulist}" var="menu" varStatus="vs">
			    	<c:if test="${menu.menuparentid==0 }">
			    		<c:if test="${vs.index==0}">
	                		<a href="javascript:void(0);" class="act gov"><span>${menu.menutitle }</span></a>
	                	</c:if>
	                	<c:if test="${vs.index!=0}">
	                		<a href="javascript:void(0);" class="gov"><span>${menu.menutitle }</span></a>
	                	</c:if>
	                </c:if>
	                </c:forEach>
				</c:if>
				<c:if test="${sessionScope.User.loginname=='admin'}">
	                <a href="javascript:void(0);" class="act gov"><span>备案管理</span></a>
	                <a href="javascript:void(0);" class="gov"><span>统计分析</span></a>
	                <a href="javascript:void(0);" class="gov"><span>应急处置</span></a>
	                <a href="javascript:void(0);" class="gov"><span>运行状况</span></a>
	                <a href="javascript:void(0);" class="gov"><span>溯源秤管理</span></a>
	                <a href="javascript:void(0);" class="gov"><span>设备管理</span></a>
	                <a href="javascript:void(0);" class="gov"><span>诚信评价</span></a>
	                <a href="javascript:void(0);" class="gov"><span>绩效考核</span></a>
	                <a href="javascript:void(0);" class="gov"><span>日常检查</span></a>
                </c:if>
            </div>
        </div>
    </div>
    <div id="main">
    	<div class="m-left">
        	<ul class="ml-user">
              <li>欢迎用户：${sessionScope.User.loginname }</li>
              <li><c:if test="${sessionScope.User.loginname!='admin'}">CPC: <a href="<%=basePath %>/manage/user/updatePersonCompany.jsp"  target="MainFrame">${sessionScope.User.cpccorp }</a></c:if></li>
            </ul>
            <c:set var="mainurl" />
            <c:set var="i" value="${0}" />
            <c:if test="${sessionScope.User.loginname!='admin'}">
				           <c:set var="mainurl" />
				            <c:set var="i" value="${0}" />
				            <c:set var="k" value="${0}" />
				            <c:forEach items="${requestScope.menulist}" var="menu" varStatus="vs">
				            	<c:set var="j" value="${0}" />
				            	<c:set var="m" value="${0}" />
				            	
				            	<c:set var="x1" value="${0}" />
				            	<c:set var="x11" value="${0}" />
					            <c:set var="x2" value="${0}" />
					            <c:set var="x22" value="${0}" />
					            <c:set var="x3" value="${0}" />
					            <c:set var="x33" value="${0}" />
					            
				            	<c:forEach items="${requestScope.menulist}" var="submenu">
				            		<c:if test="${submenu.menuparentid==menu.menumainid }">
				            			<c:if test="${j==0&&k==0}">
						            		<ul class="ml-menu">
						            		<c:set var="k" value="${1}" />
						            		<c:set var="j" value="${1}" />
						            	</c:if>
						            	<c:if test="${j==0&&k!=0}">
						            		<ul class="ml-menu hide">
						            		<c:set var="j" value="${1}" />
						            	</c:if>
				            			<c:if test="${vs.index==0&&i==0}">
					            			<c:set var="mainurl" value="${submenu.menuurl}" />
					            			<c:set var="i" value="${1}" />
					            		</c:if>
					            		
					            		<c:if test="${submenu.menumainid>=164&&submenu.menumainid<=255}"> 
					            			<c:if test="${submenu.menumainid>=164&&submenu.menumainid<=179}">
					            				<c:if test="${x1==0}">
					            					<div class="mlm-list">
					            					<div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt; 建设统计</a></div>
					            					<ul>
					            					<c:set var="x1" value="${1}" />
					            				</c:if>
					            				
					            				<li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame">&gt;&gt;${submenu.menutitle }</a></li>
					            			</c:if>
					            			
					            			
					            			<c:if test="${submenu.menumainid>=179&&x1==1&&x11==0}">
					            				</ul>
					            				</div>
					            				<c:set var="x11" value="${1}" />
					            			</c:if>
					            			
					            			
					            			<c:if test="${submenu.menumainid>=180&&submenu.menumainid<=196}">
					            				<c:if test="${x2==0}">
					            					<div class="mlm-list">
					            					<div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt; 建设统计</a></div>
					            					<ul class="hide">
					            					<c:set var="x2" value="${1}" />
					            				</c:if>
					            				
					            				<li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame">&gt;&gt;${submenu.menutitle }</a></li>
					            			</c:if>
					            			
					            			
					            			<c:if test="${submenu.menumainid>=196&&x2==1&&x22==0}">
					            				</ul>
					            				</div>
					            				<c:set var="x22" value="${1}" />
					            			</c:if>
					            			
					            			<c:if test="${submenu.menumainid>=250&&submenu.menumainid<=255}">
					            				<c:if test="${x3==0}">
					            					<div class="mlm-list">
					            					<div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt; 报表统计</a></div>
					            					<ul class="hide">
					            					<c:set var="x3" value="${1}" />
					            				</c:if>
					            				
					            				<li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame">&gt;&gt;${submenu.menutitle }</a></li>
					            			</c:if>
					            			
					            			
					            			<c:if test="${submenu.menumainid>=255&&x3==1&&x33==0}">
					            				</ul>
					            				</div>
					            				<c:set var="x33" value="${1}" />
					            			</c:if>
					            			
					            		</c:if> 
					            		
					            		<c:if test="${menu.menumainid<163||menu.menumainid>255}">
							            <c:if test="${m!=0}">
							            	<li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame">&gt;&gt; ${submenu.menutitle }</a></li>
							            </c:if>
							            <c:if test="${m==0}">
					            			<c:set var="m" value="${1}" />
								            <li><a href="<%=basePath %>${submenu.menuurl}" target="MainFrame" class="act">&gt;&gt; ${submenu.menutitle }</a></li>
							            </c:if>
							            </c:if>
				            		</c:if>
				            	</c:forEach>
				            	<c:if test="${j==1}">
				            		</ul>
				            	</c:if>
				            </c:forEach>
            </c:if>
            
            <c:if test="${sessionScope.User.loginname=='admin'}">
				            <ul class="ml-menu">
				              <li><a href="company!findByList.shtml" target="MainFrame" class="act">&gt;&gt; 备案企业管理</a></li>
				              <li><a href="company!findByListVerify.shtml" target="MainFrame">&gt;&gt; 备案审核</a></li>
				            </ul>
				            <div class="ml-menu hide">
				                <div class="mlm-list">
				                    <div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt; 建设统计</a></div>
				                    <ul>
				                      	<li><a href="rp_Build!platformBuildStat.shtml" target="MainFrame" class="act">中药材追溯平台建设情况</a></li>
										<li><a href="rp_Rate!shopsData.shtml" target="MainFrame">溯源商户数</a></li>
										<li><a href="rp_Build!chengSendStat.shtml" target="MainFrame">溯源秤分发统计</a></li>
										<li><a href="rp_Build!chengStartStat.shtml" target="MainFrame">溯源秤开机统计</a></li>
										<li><a href="rp_Build!chengUserStat.shtml" target="MainFrame">溯源秤使用统计</a></li>
										<li><a href="rp_Rate!chengData.shtml" target="MainFrame">溯源秤交易量</a></li>
										<li><a href="rp_Rate!chengCount.shtml" target="MainFrame">溯源秤交易次数</a></li>
										<li><a href="rp_Build!codeNumStat.shtml" target="MainFrame">中药材打码数量统计</a></li>
										<li><a href="rp_Build!codeNumContrastStat.shtml" target="MainFrame">中药材打码数量同比</a></li>
										<li><a href="rp_Build!codeNumByMonthStat.shtml" target="MainFrame">中药材饮片打码比</a></li>
										<li><a href="rp_Build!tradeTimesStat.shtml" target="MainFrame">中药材交易次数统计</a></li>
										<li><a href="rp_Build!tradeTimesContrastStat.shtml" target="MainFrame">中药材交易次数同比</a></li>
										<li><a href="rp_Build!tradeTimesByMonthStat.shtml" target="MainFrame">中药材饮片交易比</a></li>
										<li><a href="rp_Build!tradeWeightStat.shtml" target="MainFrame">中药材流通追溯交易量</a></li>
										<li><a href="rp_Build!tradeWeightContrastStat.shtml" target="MainFrame">中药材交易重量同比</a></li>
										<li><a href="rp_Stat!findSellWeightByYear.shtml" target="MainFrame">溯源药材销售量</a></li>
				                    </ul>
				                </div>
				                <div class="mlm-list">
				                    <div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt; 使用统计</a></div>
				                    <ul class="hide">
				                      	<li><a href="rp_Build!formalMedStat.shtml" target="MainFrame" class="act">溯源药材统计</a></li>
										<li><a href="rp_Stat!findPlantAreaSumByYear.shtml" target="MainFrame">药材种植面积</a></li>
										<li><a href="rp_Stat!findMedRateByYear.shtml" target="MainFrame">药材种植集中月份</a></li>
										<li><a href="rp_Build!plantSourceStat.shtml" target="MainFrame">种子种苗来源统计</a></li>
										<li><a href="rp_Rate!medTypeRate.shtml" target="MainFrame">溯源药材入库所占比</a></li>
										<li><a href="rp_Build!medCheckedStat.shtml" target="MainFrame">中药材检验率</a></li>
										<li><a href="rp_Build!medCheckedContrastStat.shtml" target="MainFrame">中药材检验率同比</a></li>
										<li><a href="rp_Build!medCheckedByMonthStat.shtml" target="MainFrame">中药材检验率按月比</a></li>
										<li><a href="rp_Build!mattedStat.shtml" target="MainFrame">中药材合格率</a></li>
										<li><a href="rp_Build!mattedContrastStat.shtml" target="MainFrame">中药材合格率同比</a></li>
										<li><a href="rp_Build!mattedByMonthStat.shtml" target="MainFrame">中药材合格率按月比</a></li>
										<li><a href="rp_Rate!medContrast.shtml" target="MainFrame">药材实际产出与预计产出</a></li>
										<li><a href="rp_Stat!findSellWeightByYear_NotAdmin.shtml" target="MainFrame">药材交易量走势</a></li>	
										<li><a href="rp_Stat!findTabletProAndSellByYear.shtml" target="MainFrame">饮片生产量与销售量</a></li>
										<li><a href="rp_Rate!companyUseRate.shtml" target="MainFrame">企业使用率</a></li>
										<li><a href="rp_Rate!companyUseRate_double.shtml" target="MainFrame">企业使用率-同比</a></li>
										<li><a href="rp_Rate!companyUseRate_month.shtml" target="MainFrame">企业使用率-每月</a></li>
				                    </ul>
				                </div>
				                 <div class="mlm-list">
				                    <div class="mlm-tit"><a href="javascript:void(0);" class="b">&gt;&gt;报表统计</a></div>
				                    <ul class="hide">
				                      	<li><a href="rp_Build!platformBuildQuery.shtml" target="MainFrame" class="act">平台各类型企业统计</a></li>
				                   		<li><a href="rp_Build!storAndTradeQuery.shtml" target="MainFrame">库存和交易量统计</a></li>
				                   		<li><a href="rp_Build!marketUserByChengQuery.shtml" target="MainFrame">市场用户发秤统计</a></li>
				                        <li><a href="rp_Build!orgCodeNumQuery.shtml" target="MainFrame">企业打印溯源码数量统计</a></li>
				                        <li><a href="rp_Build!orgChengTradeQuery.shtml" target="MainFrame">企业溯源秤交易统计</a></li>
				                        <li><a href="rp_Build!medTabletChengCodeNumQuery.shtml" target="MainFrame">药材饮片溯源秤打码统计</a></li>
				                    </ul>
				                </div>
				            </div>
				            <ul class="ml-menu hide">
				              <li><a href="freeze!findByList.shtml" target="MainFrame" class="act">&gt;&gt; 应急公示</a></li>
<%--				              <li><a href="/manage/govStat/addGovFreeze.jsp" target="MainFrame">&gt;&gt; 追溯锁定</a></li>--%>
				            </ul>
				            <ul class="ml-menu hide">
				            	<li><a href="opLog!findByList.shtml" target="MainFrame" class="act">&gt;&gt; 平台操作日志</a></li>
				              <!-- 	<li><a href="manage/govStat/findScaleMapStat.jsp" target="MainFrame" class="act">&gt;&gt; 平台运行状况</a></li> -->
				              	<li><a href="manage/map/findOrgCheng.jsp" target="MainFrame" class="act">&gt;&gt; 溯源秤状态</a></li>
				            </ul>
				            <ul class="ml-menu hide">             
				              <!-- 新版溯源秤 -->
				              <li><a href="chengConf!findByList.shtml" target="MainFrame">&gt;&gt; 溯源秤规格配置</a></li> 
				              <li><a href="cheng!findByList.shtml" target="MainFrame">&gt;&gt; 溯源秤管理</a></li>
<!--				              <li><a href="cheng!addChengInit.shtml" target="MainFrame">&gt;&gt; 溯源秤添加</a></li>-->
				              <li><a href="cheng!findChengFckByList.shtml" target="MainFrame">&gt;&gt; 快捷键管理</a></li>
				              <li><a href="cheng!findChengLockedByList.shtml" target="MainFrame">&gt;&gt; 溯源秤锁定</a></li>
<!--				              <li><a href="cheng!findChengModeByList.shtml" target="MainFrame">&gt;&gt; 工作模式管理</a></li>-->
<!--				              <li><a href="cheng!findChengCardByList.shtml" target="MainFrame">&gt;&gt; 溯源秤发卡</a></li>-->
				              <li><a href="cheng!findChengDataByList.shtml" target="MainFrame">&gt;&gt; 溯源秤交易查询</a></li>
				              <li><a href="deviceRec!findByList_cheng.shtml" target="MainFrame">&gt;&gt; 溯源秤回收查询</a></li>
				              <li><a href="chengTmp!findByList.shtml" target="MainFrame">&gt;&gt; 溯源秤模板管理</a></li>
				            </ul>
				            <ul class="ml-menu hide">             
				              <!-- 设备管理 -->
				              <li><a href="deviceConf!findByList.shtml" target="MainFrame">&gt;&gt; 设备规格配置</a></li> 
				              <li><a href="device!findByList_printer.shtml" target="MainFrame">&gt;&gt; 打印机</a></li>
				              <li><a href="device!findByList_scanner.shtml" target="MainFrame">&gt;&gt; 二维码扫描设备</a></li>
				              <li><a href="device!findByList_mobile.shtml" target="MainFrame">&gt;&gt; 移动终端</a></li>
				              <li><a href="device!findByList_card.shtml" target="MainFrame">&gt;&gt; IC卡</a></li>
				              <li><a href="device!findByList_querymachine.shtml" target="MainFrame">&gt;&gt; 查询机</a></li>
				              <li><a href="device!findByList_material.shtml" target="MainFrame">&gt;&gt; 耗材</a></li>
				              <li><a href="device!findByList_computer.shtml" target="MainFrame">&gt;&gt; 计算机</a></li>
				              <li><a href="device!findByList_reader.shtml" target="MainFrame">&gt;&gt; 读写卡器</a></li>
				              <li><a href="device!findByList_others.shtml" target="MainFrame">&gt;&gt; 其他设备</a></li>
				              <li><a href="deviceRec!findByList.shtml" target="MainFrame">&gt;&gt; 设备回收查询</a></li>
				              
				            </ul>
				            <ul class="ml-menu hide">             
				              <!-- 诚信评价 -->
				              <li><a href="scoreFinal!findByListInit.shtml" target="MainFrame">&gt;&gt; 诚信等级</a></li>
				              <li><a href="scoreDeduct!findByListSelectAll.shtml" target="MainFrame">&gt;&gt; 处罚管理</a></li>
				              <li><a href="manage/scoreDeduct/addScoreDeductChoose.jsp" target="MainFrame">&gt;&gt; 新建处罚</a></li> 
				            </ul> 
				            <ul class="ml-menu hide">             
				              <!-- 绩效考核 -->
				              <li><a href="examine!home.shtml" target="MainFrame">&gt;&gt; 考核结果</a></li>
<%--				              <li><a href="examine!findByList.shtml" target="MainFrame">&gt;&gt; 考核地区查询</a></li>--%>
				              <li><a href="examine!calculateList.shtml" target="MainFrame">&gt;&gt; 考核计算</a></li>
				            </ul>
				             <ul class="ml-menu hide">             
				              <!-- 日常检查 -->
				              <li><a href="dailyCheck!findByList.shtml" target="MainFrame">&gt;&gt; 日常检查管理</a></li>
				            </ul>
            </c:if>
            
        </div>
        <div class="m-right">
        	<c:if test="${sessionScope.User.loginname=='admin'}">
        	<iframe frameborder="0" scrolling="no" name="MainFrame" id="MainFrame" src="company!findByList.shtml" width="788" height="460"></iframe>
        	</c:if>
        	<c:if test="${sessionScope.User.loginname!='admin'}">
        	<iframe frameborder="0" scrolling="no" name="MainFrame" id="MainFrame" src="<%=basePath %>${mainurl }" width="788" height="460"></iframe>
        	</c:if>
        </div>
    </div>
    <div id= "foot">
    	<div class="copy">${initParam.copyright }</div>
    </div>
    <script type="text/javascript" language="javascript" src="/js/common/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/frame.js"></script>
</body>
</html>

