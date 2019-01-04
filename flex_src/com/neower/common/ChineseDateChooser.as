package com.neower.common
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.DateField;
	
	public class ChineseDateChooser extends DateField
	{
		public var monthNames_override:Array = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"];
		public var dayNames_override:Array = ["日","一","二","三","四","五","六"];
		public var formatString_override = "YYYY-MM-DD";
		public function ChineseDateChooser()
		{
			super.monthNames = monthNames_override;
			super.dayNames = dayNames_override;
			super.formatString = formatString_override;
			yearNavigationEnabled = true;//启用年份导航
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			this.textInput.toolTip = "鼠标单击清空时间!";
			if(enabled)
			{
				this.textInput.addEventListener(MouseEvent.CLICK ,clearDate);
				this.textInput.addEventListener(Event.CHANGE ,onTextChange);
			}
		}
		
		protected function onTextChange(event:Event):void
		{
			// TODO 由子类实现
		}
		public function clearDate(event:MouseEvent):void
		{
			this.textInput.text = "";
			this.selectedDate = null;
			this.textInput.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}