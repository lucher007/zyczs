package com.neower.vo
{
	

	
	[RemoteClass(alias="cn.gov.zyczs.cspt.po.ChengState")]	
	[Bindable]
	public class ChengState
	{
		public var chengcode:String;
		public var addtime:String;
		public var statestr:String;
		public var connection:String="已开机";//已开机
		public var trading:String="交易中";//交易中
		public var noconnection:String="未连接";//未连接
		public var state:String="";
		public function ChengState()
		{
			
		}


		
	}
}