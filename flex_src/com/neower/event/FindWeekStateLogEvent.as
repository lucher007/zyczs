package com.neower.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.neower.vo.ChengState;
	
	import mx.collections.ArrayCollection;
	
	public class FindWeekStateLogEvent extends CairngormEvent
	{
		public static const findWeekStateLog:String = "findWeekStateLog";
		public static const findWeekStateLog_return:String = "findWeekStateLog_return";
		
		public var list:ArrayCollection;
		public var chengcode:String;
		public var chengstate:ChengState;
		
		public function FindWeekStateLogEvent(type:String,chengstate:ChengState,list:ArrayCollection)
		{
			super(type);
			this.chengstate = chengstate;
			this.list = list;
		}

	}
}