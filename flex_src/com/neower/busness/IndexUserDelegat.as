package com.neower.busness
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.neower.vo.IndexUser;
	
	import mx.rpc.IResponder;
	/**
	 * IndexUser代理类
	 * */
	public class IndexUserDelegat
	{
		private var responder:IResponder;
		private var service:Object;
		
		public function IndexUserDelegat(responder:IResponder)
		{
			this.responder = responder;
			service = ServiceLocator.getInstance().getRemoteObject("indexUserDao");
		}
		
		/**
		 * 根据品名和时间种植统计
		 * */
		public function getPriceChartByPlantName(indexUser:IndexUser):void
		{
			var call:Object = service.getPriceChartByPlantName(indexUser);
			call.addResponder(responder);
		}
	}
}