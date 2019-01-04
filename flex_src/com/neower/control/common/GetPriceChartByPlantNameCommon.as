package com.neower.control.common
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.neower.busness.IndexUserDelegat;
	import com.neower.event.GetPriceChartByPlantNameEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class GetPriceChartByPlantNameCommon implements ICommand,IResponder
	{
		private var delegat:IndexUserDelegat;
		
		public function GetPriceChartByPlantNameCommon()
		{
			delegat = new IndexUserDelegat(this);
		}
		
		public function execute(event:CairngormEvent):void
		{
			var evt:GetPriceChartByPlantNameEvent = event as GetPriceChartByPlantNameEvent;
			delegat.getPriceChartByPlantName(evt.indexUser);
		} 
		
		public function result(data:Object):void
		{
			CairngormEventDispatcher.getInstance().dispatchEvent(new GetPriceChartByPlantNameEvent(GetPriceChartByPlantNameEvent.getPriceChartByPlantName_return,null,data.result as ArrayCollection));
		}
		
		public function fault(data:Object):void
		{
			
		}
	}
}