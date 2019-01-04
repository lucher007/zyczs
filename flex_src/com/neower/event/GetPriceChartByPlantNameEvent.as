package com.neower.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.neower.vo.IndexUser;
	
	import mx.charts.chartClasses.InstanceCache;
	import mx.collections.ArrayCollection;
	
	public class GetPriceChartByPlantNameEvent extends CairngormEvent
	{
		public static const getPriceChartByPlantName:String = "GetPriceChartByPlantName";
		public static const getPriceChartByPlantName_return:String = "getPriceChartByPlantName_return";
		
		public var indexUser:IndexUser;
		public var list:ArrayCollection;
		
		
		public function GetPriceChartByPlantNameEvent(type:String,indexUser:IndexUser,list:ArrayCollection)
		{		
				super(type);
				this.indexUser = indexUser;
				this.list = list;
		}

	}
}