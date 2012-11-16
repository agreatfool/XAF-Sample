package com.xenojoshua.as3demo.mvc.view.city
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	public class AppCityMediator extends Mediator
	{
		[Inject]
		private var view:AppCityView;
		
		public function AppCityMediator() {
			super();
		}
		
		override public function onRegister():void {
			this.view.getSignal(this.view.SIG_BTN_ITEM_CLICK).add(this.onItemButtonClick);
		}
		
		override public function onRemove():void {
			this.view.dispose();
		}
		
		private function onItemButtonClick(e:MouseEvent):void {
			trace('CITY ITEM BUTTON CLICKED!');
		}
	}
}