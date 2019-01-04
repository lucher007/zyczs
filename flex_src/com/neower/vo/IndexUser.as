package com.neower.vo
{
	

	
	[RemoteClass(alias="cn.gov.zyczs.cspt.po.IndexUser")]	
	[Bindable]
	public class IndexUser
	{

		public var startindexweekdate:String;
		public var endindexweekdate:String;
		public var pilltype:int;
		public var indexweekdate:String;
		public var indexweekname:String;
		public var indexweekvalue:Number;
		public var indexuserid:int;
		public var indexusercode:String;
		public var indexusername:String;
		public var indexweekid:String;
		public var indexweekcode:String;
		public var indexweekperiod:String;
		public var inserttime:int;
		public var price:String;
		public var pricelimits:String;
		public var weekpriceindex:String = "本周价格指数";
		public var monthpriceindex:String = "本月价格指数";
		public var weekupdownvalue:String = "本周涨跌幅";
		public var orgid:int;
		public var corptype:int;
		public var cpccorp:String;
		
		public function IndexUser()
		{
			
		}
	}
}