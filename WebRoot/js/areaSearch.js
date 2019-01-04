$(document).ready(function(){
		
	var url = "codeAreaAjax!queryProvince.shtml";
	var data = "pcode=0";
	$.getJSON(url,data,function(data){
		var codeAreaList = data.model.codeAreaList;
		
		var vProvince = $("#province").attr('v');
		var vCity = $("#city").attr('v');
		var vArea = $("#area").attr('v');
		
		$("#province").append("<option value=''>--请选择省份--</option>");
		$("#city").append("<option value=''>--请选择城市--</option>");
		$("#area").append("<option value=''>--请选择区/县--</option>");
		$.each(codeAreaList, function(i, codeArea){
			if(codeArea.name == vProvince){
				$("#province").append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
			}else{
				$("#province").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
			}
		});
		$("#province").hide().show();
		if(""+vProvince != "undefined" && vProvince != ""){
			data = "pcode=" + $("#province option[selected='selected']").attr("code");
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				
				$.each(codeAreaList, function(i, codeArea){
					if(codeArea.name == vCity){
						$("#city").append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}else{
						$("#city").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}
				});
				$("#city").hide().show();
				if(""+vCity != "undefined" && vCity != ""){
					data = "pcode=" + $("#city option[selected='selected']").attr("code");
					$.getJSON(url,data,function(data){
						var codeAreaList = data.model.codeAreaList;
						
						$.each(codeAreaList, function(i, codeArea){
							if(codeArea.name == vArea){
								$("#area").append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
							}else{
								$("#area").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
							}
						});
						$("#area").hide().show();
					});
				}
			});
		}
	});
	
	$("#province").change(function(){
		var url = "codeAreaAjax!queryProvince.shtml";
		var pvd = $("#province").val();
		var data = "pcode=" + $("#province option[value='"+pvd+"']").attr("code");
		if($.trim(data).length == 6){
			$("#city").hide().empty();
			$("#city").append("<option value=''>--请选择城市--</option>");
			$("#city").show();
			$("#area").hide().empty();
			$("#area").append("<option value=''>--请选择区/县--</option>");
			$("#area").show();
		}else{
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				$("#city").hide().empty();
				$("#city").append("<option value=''>--请选择城市--</option>");
				$("#area").hide().empty();
				$("#area").append("<option value=''>--请选择区/县--</option>");
				$.each(codeAreaList, function(i, codeArea){
					$("#city").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
				});
				$("#city").show();
				$("#area").show();
			});
		}
	});
	
	$("#city").change(function(){
		var url = "codeAreaAjax!queryProvince.shtml";
		var cvd = $("#city").val();
		var data = "pcode=" + $("#city option[value='"+cvd+"']").attr("code");
		
		if($.trim(data).length == 6){
			$("#area").hide().empty();
			$("#area").append("<option value=''>--请选择区/县--</option>");
			$("#area").show();
		}else{
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				$("#area").hide().empty();
				$("#area").append("<option value=''>--请选择区/县--</option>");
				$.each(codeAreaList, function(i, codeArea){
					$("#area").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
				});
				$("#area").show();
			});
		}
	});
	
});

