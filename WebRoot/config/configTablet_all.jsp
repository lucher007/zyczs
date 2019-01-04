<%@page contentType="text/html; charset=utf-8" language="java"%>
<div id="step2" class="hide">
			    <div class="fb-tit">选择生产工艺</div>
		        <div class="fb-con">
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box">
						<tr>
                			<td class="fbc-tit b" width="20">净制</td>
                			<td>
                				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="processtr1">
			                      <tr>
			                        <td height="24" align="right">净制方法：</td>
			                        <td colspan="3">
			                        <input type="checkbox" name="pick" id="pick" /><label for="pick" class="labelcss">挑选</label>
			  						<input type="checkbox" name="winnowing" id="winnowing" /><label for="winnowing" class="labelcss">风选</label>
			  						<input type="checkbox" name="filtrate" id="filtrate" /><label for="filtrate" class="labelcss">筛选</label>
			                        </td>
			                      </tr>
			                      <tr>
			                        <td height="24" align="right">净制内容：</td>
			                        <td colspan="3">
			                        <input type="checkbox" name="impurity" id="impurity"><label for="impurity" class="labelcss">去杂质</label>
					  				<input type="checkbox" name="nub" id="nub"><label for="nub" class="labelcss">去残根</label>
					  				<input type="checkbox" name="stem" id="stem"><label for="stem" class="labelcss">去残茎</label>
					  				<input type="checkbox" name="twigs" id="twigs"><label for="twigs" class="labelcss">去枝梗</label>
					  				<input type="checkbox" name="cot" id="cot"><label for="cot" class="labelcss">去皮壳</label>
					  				<input type="checkbox" name="hair" id="hair"><label for="hair" class="labelcss">去毛</label>
					  				<input type="checkbox" name="heart" id="heart"><label for="heart" class="labelcss">去心</label>
					  				<input type="checkbox" name="pit" id="pit"><label for="pit" class="labelcss">去核</label>
					  				<input type="checkbox" name="flesh" id="flesh"><label for="flesh" class="labelcss">去残肉</label>
					  				<input type="checkbox" name="cephalopodium" id="cephalopodium"><label for="cephalopodium" class="labelcss">去头足</label>
			                        </td>
			                      </tr>
			                      <tr>
			                        <td height="30">净制负责人：</td>
			                        <td><input type="text" class="inp" name="username1" id="username1" maxlength="20"></td>
			                        <td>填写更多净制内容，以逗号","间隔：</td>
			                        <td><input type="text" class="inp" name="usermethod1" id="usermethod1" maxlength="20"></td>
			                      </tr>
			                    </table>
                			</td>
                		</tr>
                	</table>
                	<table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box mt5" id="processtr2">
		              <tr>
		                <td class="fbc-tit b" width="20">洗润</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tr>
		                        <td height="24" align="right">软化方法：</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="argosols" id="argosols"><label for="argosols" class="labelcss">淋润</label>
				  				<input type="checkbox" name="elutriation" id="elutriation"><label for="elutriation" class="labelcss">淘洗</label>
				  				<input type="checkbox" name="soakage" id="soakage"><label for="soakage" class="labelcss">浸润</label>
				  				<input type="checkbox" name="marinate" id="marinate"><label for="marinate" class="labelcss">浸泡</label>
				  				<input type="checkbox" name="steam" id="steam"><label for="steam" class="labelcss">蒸汽润</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">洗润负责人：</td>
		                        <td><input type="text" class="inp" name="username2" id="username2" maxlength="20"></td>
		                        <td>填写更多洗润内容，以逗号","间隔：</td>
		                        <td><input type="text" class="inp" name="usermethod2" id="usermethod2" maxlength="20"></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box mt5" id="processtr3">
		              <tr>
		                <td class="fbc-tit b" width="20">切割</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tr>
		                        <td height="30" align="right">切制规格：</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="flake" id="flake"><label for="flake" class="labelcss">薄片1~2mm</label>
			  					<input type="checkbox" name="slab" id="slab"><label for="slab" class="labelcss">厚片2~4mm</label>
			  					<input type="checkbox" name="slice" id="slice"><label for="soakage" class="labelcss">斜片</label><input type="text" class="inp w60"  name="slice1" maxlength="5"> mm
			  					<input type="checkbox" name="segment" id="segment"><label for="segment" class="labelcss">段</label><input type="text" class="inp w60"  name="segment1" maxlength="5"> mm
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30" align="right">&nbsp;</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="drawing" id="drawing"><label for="drawing" class="labelcss">轨制</label>
			  					<input type="checkbox" name="quadrel" id="quadrel"><label for="quadrel" class="labelcss">方块</label><input type="text" class="inp w60" maxlength="5" name="quadrel1">X<input type="text" class="inp w60" maxlength="5" name="quadrel2"> mm
			  					<input type="checkbox" name="silk" id="silk"><label for="silk" class="labelcss">丝</label><input type="text" class="inp w60" name="silk1" maxlength="5"> mm
			  					<input type="checkbox" name="pulverize" id="pulverize"><label for="pulverize" class="labelcss">粉碎</label><input type="text" class="inp w60" name="pulverize1" maxlength="5">目
			  					<input type="checkbox" name="wool" id="wool"><label for="wool" class="labelcss">制绒</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">切割负责人：</td>
		                        <td><input type="text" class="inp" name="username3" id="username3" maxlength="20"></td>
		                        <td>填写更多切割内容，以逗号","间隔：</td>
		                        <td><input type="text" class="inp" name="usermethod3" id="usermethod3" maxlength="20"></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box mt5" id="processtr4">
		              <tr>
		                <td class="fbc-tit b" width="20">干燥</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tr>
		                        <td height="24" align="right">干燥方法：</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="hypothermia" id="hypothermia"><label for="hypothermia" class="labelcss">低温干燥50℃</label>
			  					<input type="checkbox" name="mesotherm" id="mesotherm"><label for="mesotherm" class="labelcss">中温干燥70℃</label>
			  					<input type="checkbox" name="thermotherapy" id="thermotherapy"><label for="thermotherapy" class="labelcss">高温干燥80℃</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">干燥负责人：</td>
		                        <td><input type="text" class="inp" name="username4" id="username4" maxlength="20"></td>
		                        <td>填写更多干燥内容，以逗号","间隔：</td>
		                        <td><input type="text" class="inp" name="usermethod4" id="usermethod4" maxlength="20"></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box mt5" id="processtr5">
		              <tr>
		                <td class="fbc-tit b" width="20">筛选</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tr>
		                        <td height="24" align="right">筛选方法：</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="downaperture" id="downaperture"><label for="downaperture" class="labelcss">下网孔径</label><input type="text" class="inp w60" name="downaperture1" maxlength="5"> mm
			  					<input type="checkbox" name="upaperture" id="upaperture"><label for="upaperture" class="labelcss">上筛网孔径</label><input type="text" class="inp w60" name="upaperture1" maxlength="5"> mm
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">筛选负责人：</td>
		                        <td><input type="text" class="inp" name="username5" id="username5" maxlength="20"></td>
		                        <td>填写更多筛选内容，以逗号","间隔：</td>
		                        <td><input type="text" class="inp" name="usermethod5" id="usermethod5" maxlength="20"></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
			  	</div>
			    <div class="fb-bom">
		        	<cite class="gray"><input type="button" value="下一步" class="sbt" onclick="forStep(3);"></cite>
		            <input type="button" value="返回上一步" class="sbt" onclick="forStep(1);">
		        </div>		  
		    </div>
			<div id="step3" class="hide">
			    <div class="fb-tit">选择生产工艺</div>
		        <div class="fb-con">
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box">
		              <tr>
		                <td class="fbc-tit b" width="20">炮制</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="processtr6">
		                      <tr>
		                        <td height="26" align="right">炒制：</td>
		                        <td>
		                       	   　清炒：
		                        <input type="checkbox" name="fryyellowish" id="fryyellowish"><label for="fryyellowish" class="labelcss">炒黄</label>
				  				<input type="checkbox" name="frybaketobrown" id="frybaketobrown"><label for="frybaketobrown" class="labelcss">炒焦</label>
				  				<input type="checkbox" name="frycharring" id="frycharring"><label for="frycharring" class="labelcss">炒炭</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26">&nbsp;</td>
		                        <td>
								辅料炒：            
		                        <input type="checkbox" name="frybran" id="frybran"><label for="frybran" class="labelcss">麸炒</label>
				  				<input type="checkbox" name="fryrice" id="fryrice"><label for="fryrice" class="labelcss">米炒</label>
				  				<input type="checkbox" name="frysoil" id="frysoil"><label for="frysoil" class="labelcss">土炒</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">炙制：</td>
		                        <td>
		                        <input type="checkbox" name="roasthoney" id="roasthoney"><label for="roasthoney" class="labelcss">蜜炙</label>
				  				<input type="checkbox" name="roastwine" id="roastwine"><label for="roastwine" class="labelcss">酒炙</label>
				  				<input type="checkbox" name="roastvinegar" id="roastvinegar"><label for="roastvinegar" class="labelcss">醋炙</label>
				  				<input type="checkbox" name="roastbrine" id="roastbrine"><label for="roastbrine" class="labelcss">盐水炙</label>
				  				<input type="checkbox" name="roastgingerjuice" id="roastgingerjuice"><label for="roastgingerjuice" class="labelcss">姜汁炙</label>
				  				<input type="checkbox" name="roastliquorice" id="roastliquorice"><label for="roastliquorice" class="labelcss">甘草汁炙</label>
				  				<input type="checkbox" name="roastsoybean" id="roastsoybean"><label for="roastsoybean" class="labelcss">黑豆汁炙</label>
				  				<input type="checkbox" name="roastsaponin" id="roastsaponin"><label for="roastsaponin" class="labelcss">皂角汁炙</label>
				  				<input type="checkbox" name="roastbile" id="roastbile"><label for="roastbile" class="labelcss">胆汁炙</label>
				  				<input type="checkbox" name="roastsuet" id="roastsuet"><label for="roastsuet" class="labelcss">羊脂炙</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">蒸制：</td>
		                        <td>
		                        <input type="checkbox" name="steamwine" id="steamwine"><label for="steamwine" class="labelcss">酒蒸</label>
				  				<input type="checkbox" name="steamvinegar" id="steamvinegar"><label for="steamvinegar" class="labelcss">醋蒸</label>
				  				<input type="checkbox" name="steambrine" id="steambrine"><label for="steambrine" class="labelcss">盐蒸</label>
				  				<input type="checkbox" name="steamliquorice" id="steamliquorice"><label for="steamliquorice" class="labelcss">甘草汁蒸</label>
				  				<input type="checkbox" name="steamsoybean" id="steamsoybean"><label for="steamsoybean" class="labelcss">黑豆汁蒸</label>
				  				<input type="checkbox" name="steamgingerjuice" id="steamgingerjuice"><label for="steamgingerjuice" class="labelcss">姜汁蒸</label>
				  				<input type="checkbox" name="steamsimple" id="steamsimple"><label for="steamsimple" class="labelcss">清蒸</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">煮制：</td>
		                        <td>
		                        <input type="checkbox" name="cookmarslin" id="cookmarslin"><label for="cookmarslin" class="labelcss">清水煮</label>
				  				<input type="checkbox" name="cookgingerjuice" id="cookgingerjuice"><label for="cookgingerjuice" class="labelcss">姜汁煮</label>
				  				<input type="checkbox" name="cookradish" id="cookradish"><label for="cookradish" class="labelcss">萝卜煮</label>
				  				<input type="checkbox" name="cookliquorice" id="cookliquorice"><label for="cookliquorice" class="labelcss">甘草汁煮</label>
				  				<input type="checkbox" name="cooksoybean" id="cooksoybean"><label for="cooksoybean" class="labelcss">黑豆汁煮</label> 
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">烫制：</td>
		                        <td>
		                        <input type="checkbox" name="hotgrit" id="hotgrit"><label for="hotgrit" class="labelcss">砂烫</label>
				  				<input type="checkbox" name="hotvinegar" id="hotvinegar"><label for="hotvinegar" class="labelcss">砂烫醋淬</label>
				  				<input type="checkbox" name="hotclamshell" id="hotclamshell"><label for="hotclamshell" class="labelcss">蛤壳粉烫</label>
				  				<input type="checkbox" name="hotpowder" id="hotpowder"><label for="hotpowder" class="labelcss">滑石粉烫</label> 
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">煅制：</td>
		                        <td>
		                        <input type="checkbox" name="calciningopenly" id="calciningopenly"><label for="calciningopenly" class="labelcss">明煅</label>
				  				<input type="checkbox" name="calciningobturation" id="calciningobturation"><label for="calciningobturation" class="labelcss">密闭煅</label>
				  				<input type="checkbox" name="calciningquench" id="calciningquench"><label for="calciningquench" class="labelcss">煅淬</label>	
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">煨制：</td>
		                        <td>
		                        <input type="checkbox" name="simmernoodle" id="simmernoodle"><label for="simmernoodle" class="labelcss">面裹煨</label>
				  				<input type="checkbox" name="simmerpapyrus" id="simmerpapyrus"><label for="simmerpapyrus" class="labelcss">草纸煨</label>
				  				<input type="checkbox" name="simmerwheat" id="simmerwheat"><label for="simmerwheat" class="labelcss">麦麸煨</label>	
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26" align="right">复制：</td>
		                        <td>
		                        <input type="checkbox" name="processdrug" id="processdrug"><label for="processdrug" class="labelcss">药汁制</label>
				  				<input type="checkbox" name="processalum" id="processalum"><label for="processalum" class="labelcss">姜矾制</label>
				  				<input type="checkbox" name="processliquorice" id="processliquorice"><label for="processliquorice" class="labelcss">甘草石灰制</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="26">&nbsp;</td>
		                        <td>
		                        <input type="checkbox" name="fbjj" id="fbjj"><label for="fbjj" class="labelcss">燀制</label>
				  				<input type="checkbox" name="water" id="water"><label for="water" class="labelcss">水飞</label>
				  				<input type="checkbox" name="ferment" id="ferment"><label for="ferment" class="labelcss">发酵</label>
				  				<input type="checkbox" name="mix" id="mix"><label for="mix" class="labelcss">拌衣</label>
				  				<input type="checkbox" name="frostlike" id="frostlike"><label for="frostlike" class="labelcss">制霜</label>
				  				<input type="checkbox" name="deoil" id="deoil"><label for="deoil" class="labelcss">去油</label>	
		                        </td>
		                      </tr>
		                      <tr>
		                        <td colspan="2" height="30">
		                          炮制负责人：<input type="text" class="inp" name="username6" id="username6" maxlength="20">　　填写更多炮制内容，以逗号","间隔：<input type="text" class="inp" name="usermethod6" id="usermethod6" maxlength="20">
		                        </td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
		            <table width="726" border="0" cellspacing="0" cellpadding="0" class="ml10 fbc-box mt5" id="processtr7">
		              <tr>
		                <td class="fbc-tit b" width="20">精选</td>
		                <td>
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                      <tr>
		                        <td height="24" align="right">精选方法：</td>
		                        <td colspan="3">
		                        <input type="checkbox" name="specialpill" id="specialpill"><label for="specialpill" class="labelcss">  异形片</label>
			  					<input type="checkbox" name="isfit" id="isfit"><label for="isfit" class="labelcss">炮制不符合要求</label>
		                        </td>
		                      </tr>
		                      <tr>
		                        <td height="30">精选负责人：</td>
		                        <td><input type="text" class="inp" name="username7" id="username7" maxlength="20"></td>
		                        <td align="right">填写更多精选内容，以逗号","间隔：</td>
		                        <td><input type="text" class="inp" name="usermethod7" id="usermethod7" maxlength="20"></td>
		                      </tr>
		                    </table>
		                </td>
		              </tr>
		            </table>
			  	</div>
			  	<div class="fb-bom">
		        	<cite class="gray"><input type="button" value="下一步" class="sbt" onclick="forStep(4);"></cite>
		            <input type="button" value="返回上一步" class="sbt" onclick="forStep(2);">
		        </div>	
		    </div>