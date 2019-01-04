// system.window.js
// 具体功能看相应的注释

/*
* 调用:Object.Window
* 作用:Window 引用类
* 参数:
* Method 窗口打开方式
* Href 窗口地址
* Name 窗口标签
* ToolBar 显示工具条 yes/no
* MenuBar 显示菜单栏 yes/no
* ScrollBar 显示滚动条 yes/no
* UrlBar 显示地址栏 yes/no
* Status 显示状态栏 yes/no
* FullScreen 全屏窗口 yes/no
* Resize 重设窗口大小 yes/no
* Width 窗口宽度 yes/no
* Height 窗口高度 yes/no
* Place 窗口位置 center/top/openpop
* ReturnValue 返回值
* TextValue 文本显示
* ConfirmTrue 确认返回
* ConfirmFalse 取消返回
* Params 参数
* 返回:
*/
function Window()
{
	var Method;
	var Params;
	var Splits;
	var Href;
	var Name;
	var ToolBar;
	var MenuBar;
	var ScrollBar;
	var UrlBar;
	var Status;
	var FullScreen;
	var Resize;
	var Width;
	var Height;
	var Place;
	var Top;
	var Left;
	var ReturnValue;
	var TextValue;
	var ConfirmTrue;
	var ConfirmFalse;
	
	this.Method = Method;
	this.Params = Params;
	this.Splits = Splits;
	this.Href = Href;
	this.Name = Name;
	this.ToolBar = ToolBar;
	this.MenuBar = MenuBar;
	this.ScrollBar = ScrollBar;
	this.UrlBar = UrlBar;
	this.Status = Status;
	this.FullScreen = FullScreen;
	this.Resize = Resize;
	this.Width = Width;
	this.Height = Height;
	this.Place = Place;
	this.Top = Top;
	this.left = Left;
	this.ReturnValue = ReturnValue;
	this.TextValue = TextValue;
	this.ConfirmTrue = ConfirmTrue;
	this.ConfirmFalse = ConfirmFalse;
}

Window.prototype.Init = function()
{
	this.Method = this.Method?this.Method:"open";
	this.Params = this.Params?this.Params:"";
	this.Splits = this.Splits?this.Splits:"|";
	this.Href = this.Href?this.Href:"about:blank";
	this.Name = this.Name?this.Name:Math.round(Math.random() * 100000);
	this.ToolBar = this.ToolBar?this.ToolBar:"no";
	this.MenuBar = this.MenuBar?this.MenuBar:"no";
	this.ScrollBar = this.ScrollBar?this.ScrollBar:"no";
	this.UrlBar = this.UrlBar?this.UrlBar:"no";
	this.Status = this.Status?this.Status:"no";
	this.FullScreen = this.FullScreen?this.FullScreen:"no";
	this.Resize = this.Resize?this.Resize:"no";
	this.Width = this.Width?this.Width:parseInt(screen.width/2);
	this.Height = this.Height?this.Height:parseInt(screen.height/2);
	this.Place = this.Place?this.Place:"center";
	this.Top = this.Top?this.Top:"30";
	this.Left = this.Left?this.Left:"30";
	this.ReturnValue = this.ReturnValue?this.ReturnValue:"";
	this.TextValue = this.TextValue?this.TextValue:"";
	this.ConfirmTrue = this.ConfirmTrue?this.ConfirmTrue:true;
	this.ConfirmFalse = this.ConfirmFalse?this.ConfirmFalse:false;
}

Window.prototype.Open = function()
{
// .toLowerCase()
switch (this.Method)
{
/*
* 类别:Open
* 功能:Window.Open 弹出窗口 中所有功能;
*/
case "open":
if (this.Place == "center")
{
OpenWinTopXY = "top="+((screen.availHeight-this.Height)/2)+",left="+((screen.availWidth-this.Width)/2);
}else if (this.Place == "top"){
OpenWinTopXY = "top=0,left=0";
}else{
OpenWinTopXY = "top="+this.Top+",left="+this.Left+"";
}

window.open (this.Href,""+this.Name+"","location=no;toolbar="+this.ToolBar+",menubar="+this.MenuBar+",scrollbars="+this.ScrollBar+",resizable="+this.Resize+",directories="+this.UrlBar+",fullscreen="+this.FullScreen+",status="+this.Status+",titlebar=no,width="+this.Width+",height="+this.Height+","+OpenWinTopXY+"");
break;

/*
* 类别:showModlDialog
* 功能:对话窗口
*/
case "showModalDialog":
var DialogObj;
DialogObj = window.showModalDialog (this.Href,"","dialogWidth:'"+this.Width+"';dialogHeight:'"+this.Height+"';status:'"+this.Status+"';scroll='"+this.ScrollBar+"';help:no");
return (""+DialogObj+"");
break;

/*
* 类别:showHelp
* 功能:HELP帮助
*/
case "showHelp":
window.showHelp(this.Href);
break;

/*
* 类别:Confirm
* 功能:确认对话框
*/
case "confirm":
var msgbox = window.confirm(this.TextValue);
if (msgbox)
{
eval(this.ConfirmTrue);
}else{
eval(this.ConfirmFalse);
}
break;

case "popup":
if (this.ie)
{
this.PopTop=50;
this.oPopup = window.createPopup();
var html=this.TextValue;
this.oPopup.document.body.innerHTML = html;
popshow();
}
break;

/*
* 类别:缺省状态
* 功能:当前页面转发
*/
default:
top.location=this.Href;
break;
}
}
