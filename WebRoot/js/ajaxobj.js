// AjaxObj Class 
var AjaxObj = function()
{
  var xmlHttpObj = null
  
  var arrSignatures = ["MSXML2.XMLHTTP.5.0", "MSXML2.XMLHTTP.4.0",
                                 "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP",
                                 "Microsoft.XMLHTTP","XMLHttpRequest"];
  
  var isContinue;


  //xmlHttpObj = new XMLHttpRequest();

  if(xmlHttpObj==null||typeof xmlHttpObj!="undefined"){
	  for (var i=0; i < arrSignatures.length; i++) {
	  
			try {        
				xmlHttpObj = new ActiveXObject(arrSignatures[i]);  
				isContinue=0;           
			} catch (oError) { 
				isContinue=1
			/*ignore*/ 
			}
			
			if(isContinue==0)
			  break;
	  }          
  }
  
  if(!xmlHttpObj&&typeof XMLHttpRequest!="undefined") {
    xmlHttpObj=new XMLHttpRequest();
  }
  
  return  xmlHttpObj;
}

function doActon(method,url,callBackFun,data)
{
	var ajaxObj =new AjaxObj();
	if(ajaxObj==null)
	{	
		alert("no instance ajax !!");
	}
	ajaxObj.onreadystatechange=function (){ dealReqsXmlStatechange(ajaxObj,callBackFun);}
    
	if(method=="GET")
	{ 
	
	  ajaxObj.open ('GET',url+"?"+"&"+data,true);
	  //ajaxObj.open ('GET',url+"?requestFlag="+new Date().getTime()+"&"+data, true);
	//ajaxObj.setRequestHeader("Cache-Control","no-cache");
	  ajaxObj.send(new Date());
	}else if(method=="POST") 
	{
	  ajaxObj.open ('POST',url, true); 
	  ajaxObj.setRequestHeader("content-type","application/x-www-form-urlencoded");
	//ajaxObj.setRequestHeader("Content-Type","utf-8");
      //ajaxObj.send ("requestFlag="+new Date().getTime()+"&"+data);
      ajaxObj.send (data);
	}else{
	  alert("request method unkonw!!");
	}
}

function dealReqsXmlStatechange(ajaxObj,callBackFun)     //AjaxObj,action
{
	if(ajaxObj.readyState == 4){
	 // alert(ajaxObj.status);
	  if(ajaxObj.status == 200){
	  	var responseText=ajaxObj.responseText;
	    if(typeof(functionName)== 'string ')
			eval(callBackFun+"(\""+responseText+"\")");					 
        else 
			callBackFun(responseText); 
	  }
	}
}
