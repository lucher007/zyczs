package com.neower.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	
	[Bindable]
	/**
	 * 单例模式
	 */
	public class ModelLocator implements IModelLocator
	{
		//私有类静态变量
		private static var instance : ModelLocator;
		//需要绑定到ModelLocator里面的变量
		
		public var endPoint:String = null;
		
		public function ModelLocator()
		{
			if(instance != null){
				throw new Error("单例模式只能通过getInstance()初始化");
			}
			ModelLocator.instance = this;
		}
		//获取对象实例
		public   static function getInstance():ModelLocator
		{
			if(instance == null){
				instance = new ModelLocator();
			}
			return instance;
		}
	}
}