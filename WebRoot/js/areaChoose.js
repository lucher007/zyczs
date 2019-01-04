$(document).ready(function(){
//alert($("#showinfo").val());
	var url = "codeAreaAjax!queryProvince.shtml";
	var data = "pcode=0";
	$.getJSON(url,data,function(data){
		var codeAreaList = data.model.codeAreaList;
		
		var vProvince = $("#province").attr('v');
		var vCity = $("#city").attr('v');
		var vArea = $("#area").attr('v');
		
		$.each(codeAreaList, function(i, codeArea){
			if(codeArea.name == vProvince){
				$("#province").append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
			}else{
				$("#province").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
			}
		});
		$("#province").hide().show();
		var pvd = $("#province").val();
		var data = "pcode=" + $("#province option[value='"+pvd+"']").attr("code");
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
			var cvd = $("#city").val();
			data = "pcode=" + $("#city option[value='"+cvd+"']").attr("code");
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				$.each(codeAreaList, function(i, codeArea){
					if(codeArea.name == vArea){
						$("#area").append("<option selected='selected' code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}else{
						$("#area").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					}
					if(i==codeAreaList.length-1){
						$("#registeraddress").val($("#province").val()+$("#city").val()+$("#area").val());
					}
				});
				$("#area").hide().show();
				$("#finishcodebtn").removeAttr("disabled");
			});
		});
		
	});
	
	$("#province").change(function(){
		var url = "codeAreaAjax!queryProvince.shtml";
		var pvd = $("#province").val();
		var data = "pcode=" + $("#province option[value='"+pvd+"']").attr("code")+"&rid="+Math.random();
		
		$.getJSON(url,data,function(data){
			var codeAreaList = data.model.codeAreaList;
			$("#city").hide().empty();
			$.each(codeAreaList, function(i, codeArea){
				$("#city").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
			});
			$("#city").show();
			data = "pcode=" + codeAreaList[0].code;
			$.getJSON(url,data,function(data){
				var codeAreaList = data.model.codeAreaList;
				$("#area").hide().empty();
				$.each(codeAreaList, function(i, codeArea){
					$("#area").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
					$("#registeraddress").val($("#province").val()+$("#city").val()+$("#area").val());
				});
				$("#area").show();
			});
		});
	});
	
	$("#city").change(function(){
		var url = "codeAreaAjax!queryProvince.shtml";
		var cvd = $("#city").val();
		var data = "pcode=" + $("#city option[value='"+cvd+"']").attr("code")+"&rid="+Math.random();
		
		$.getJSON(url,data,function(data){
			var codeAreaList = data.model.codeAreaList;
			$("#area").hide().empty();
			$.each(codeAreaList, function(i, codeArea){
				$("#area").append("<option code="+codeArea.code+" value=" + codeArea.name + ">" + codeArea.name + "</option>");
				$("#registeraddress").val($("#province").val()+$("#city").val()+$("#area").val());
			});
			$("#area").show();
		});
	});
	
	$("#area").change(function(){
		$("#registeraddress").val($("#province").val()+$("#city").val()+$("#area").val());
	});
	
	
});

