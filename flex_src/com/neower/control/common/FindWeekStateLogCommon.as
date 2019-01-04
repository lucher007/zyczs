package com.neower.control.common
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.neower.busness.ChengStateDelegat;
	import com.neower.event.FindWeekStateLogEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	public class FindWeekStateLogCommon implements ICommand,IResponder
	{
		private var delegat:ChengStateDelegat;
		public function FindWeekStateLogCommon()
		{
			delegat = new ChengStateDelegat(this);
		}
		
		public function execute(event:CairngormEvent):void
		{
			var evt:FindWeekStateLogEvent = event as FindWeekStateLogEvent;
			delegat.findWeekStateLog(evt.chengstate);
		} 
		
		public function result(data:Object):void
		{
			CairngormEventDispatcher.getInstance().dispatchEvent(new FindWeekStateLogEvent(FindWeekStateLogEvent.findWeekStateLog_return,null,data.result as ArrayCollection));
		}
		
		public function fault(data:Object):void
		{
			
		}
	}
}