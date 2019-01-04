package com.neower.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	
	public class IndexUserEvent extends CairngormEvent
	{
		public static const getUserWeekByCodeAndWeekName:String = "getUserWeekByCodeAndWeekName";
		public static const getUserWeekByCodeAndWeekName_return:String = "getUserWeekByCodeAndWeekName_return";
		
		public var queryType:String;
		public var list:ArrayCollection;
		
		public function IndexUserEvent(type:String,queryType:String,list:ArrayCollection)
		{
			super(type);
			this.queryType = queryType;
			this.list = list;
		}
	}
}