package com.xenojoshua.as3demo.mvc.view.city
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.as3demo.mvc.view.item.AppItemView;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AppCityMediator extends Mediator
	{
		[Inject]
		public var view:AppCityView;
		
		/**
		 * Initialize AppCityMediator.
		 * @return void
		 */
		public function AppCityMediator() {
			super();
		}
		
		/**
		 * @see org.robotlegs.base.MediatorBase.onRegister()
		 */
		override public function onRegister():void {
			this.view.getSignal(this.view.SIG_BTN_ITEM_CLICK).add(this.onItemButtonClick);
			this.view.getSignal(this.view.SIG_BTN_SHUTDOWN_CLICK).add(this.onShutdownButtonClick);
		}
		
		/**
		 * City view "ITEM" button onclick event.
		 * @param MouseEvent e
		 * @return void
		 */
		private function onItemButtonClick(e:MouseEvent):void {
			XafScreenManager.instance.getLayer(XafConst.SCREEN_UI).addChild(new AppItemView(true));
		}
		
		/**
		 * City view "SHUTDOWN" button onclick event.
		 * @param MouseEvent e
		 * @return void
		 */
		private function onShutdownButtonClick(e:MouseEvent):void {
			this.view.dispose();
		}
	}
}