$(document).ready(function(){
	//<div class='selPCA'><select></select><select></select><select></select></div>
	var url = "codeAreaAjax!queryProvince.shtml";
	var data = "pcode=0&rid="+Math.random();
	$.getJSON(url,data,function(data){
		var codeAreaList = data.model.codeAreaList;
		$('.selPCA').each(function(j,o){			
			var Province = $(o).find("select[id^='province']");
			var City = $(o).find("select[id^='city']");
			var Area = $(o).find("select[id^='area']");
			var vProvince = $(Province).attr('v');
			var vCity = $(City).attr('v');
			var vArea = $(Area).attr('v');
			
			$.each(codeAreaList, function(i, codeArea){
				if(codeArea.name == vProvince){
					$(Province).append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
				}else{
					$(Province).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
				}
			});
			$(Province).hide().show();
			var pvd = $(Province).val();
			var data = "pcode=" + $(Province).find("option[value='"+pvd+"']").attr("code");
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				$.each(codeAreaList, function(i, codeArea){
					if(codeArea.name == vCity){
						$(City).append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}else{
						$(City).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}
				});
				$(City).hide().show();
				var cvd = $(City).val();
				data = "pcode=" + $(City).find("option[value='"+cvd+"']").attr("code");
				$.getJSON(url,data,function(data){
					var codeAreaList = data.model.codeAreaList;
					$.each(codeAreaList, function(i, codeArea){
						if(codeArea.name == vArea){
							$(Area).append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
						}else{
							$(Area).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
						}
						if(i==codeAreaList.length-1){
							$("#registeraddress"+(j==0?'':j)).val($(Province).val()+$(City).val()+$(Area).val());
						}
					});
					$(Area).hide().show();
					$("#finishcodebtn").removeAttr("disabled");
				});
			});
			
			$(Province).change(function(){
				var url = "codeAreaAjax!queryProvince.shtml";
				var pvd = $(this).val();
				var data = "pcode=" + $(this).find("option[value='"+pvd+"']").attr("code")+"&rid="+Math.random();
				
				$.getJSON(url,data,function(data){
					var codeAreaList = data.model.codeAreaList;
					$(City).hide().empty();
					$.each(codeAreaList, function(i, codeArea){
						$(City).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					});
					$(City).show();
					data = "pcode=" + codeAreaList[0].code;
					$.getJSON(url,data,function(data){
						var codeAreaList = data.model.codeAreaList;
						$(Area).hide().empty();
						$.each(codeAreaList, function(i, codeArea){
							$(Area).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
							$("#registeraddress"+(j==0?'':j)).val($(Province).val()+$(City).val()+$(Area).val());
						});
						$(Area).show();
					});
				});
			});
			
			$(City).change(function(){
				var url = "codeAreaAjax!queryProvince.shtml";
				var cvd = $(this).val();
				var data = "pcode=" + $(this).find("option[value='"+cvd+"']").attr("code")+"&rid="+Math.random();
				
				$.getJSON(url,data,function(data){
					var codeAreaList = data.model.codeAreaList;
					$(Area).hide().empty();
					$.each(codeAreaList, function(i, codeArea){
						$(Area).append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
						$("#registeraddress"+(j==0?'':j)).val($(Province).val()+$(City).val()+$(Area).val());
					});
					$(Area).show();
				});
			});
			
			$(Area).change(function(){
				$("#registeraddress"+(j==0?'':j)).val($(Province).val()+$(City).val()+$(Area).val());
			});
		})
	});
})