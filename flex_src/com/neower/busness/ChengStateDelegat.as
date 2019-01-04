package com.neower.busness
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.neower.vo.ChengState;
	
	import mx.rpc.IResponder;
	
	/**
	 * 用来记录秤一周历史变化的代理类
	 * */
	public class ChengStateDelegat
	{	
		private var responder:IResponder;
		private var service:Object;
		
		public function ChengStateDelegat(responder:IResponder)
		{
			this.responder = responder;
			service = ServiceLocator.getInstance().getRemoteObject("chengDao");
		}
		
		public function findWeekStateLog(chengState:ChengState):void
		{
			var call:Object = service.findWeekStateLog(chengState);
			call.addResponder(responder);
		}
	}
}