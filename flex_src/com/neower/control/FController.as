package com.neower.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.neower.control.common.FindWeekStateLogCommon;
	import com.neower.control.common.GetPriceChartByPlantNameCommon;
	import com.neower.event.FindWeekStateLogEvent;
	import com.neower.event.GetPriceChartByPlantNameEvent;
	//前端控制器,捕获前端事件,并注册给command处理
	public class FController extends FrontController
	{
		public function FController()
		{
			this.addCommand(GetPriceChartByPlantNameEvent.getPriceChartByPlantName,GetPriceChartByPlantNameCommon);
			this.addCommand(FindWeekStateLogEvent.findWeekStateLog,FindWeekStateLogCommon);
		}
	}
}