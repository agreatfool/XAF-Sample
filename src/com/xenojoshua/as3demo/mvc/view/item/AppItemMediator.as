package com.xenojoshua.as3demo.mvc.view.item
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	
	import flash.events.MouseEvent;
	
	public class AppItemMediator extends XafRobotlegsMediator
	{
		[Inject]
		public var view:AppItemView;
		
		/**
		 * Initialize AppItemMediator.
		 * @return void
		 */
		public function AppItemMediator() {
			super();
		}
		
		/**
		 * @see org.robotlegs.base.MediatorBase.onRegister()
		 */
		override public function onRegister():void {
			this.view.registerTabButtonClickFunc(this.onTabButtonClick);
			this.view.getSignal(this.view.SIG_BTN_CLOSE_CLICK).add(this.onCloseButtonClick);
			this.view.getButton(this.view.CP_BTN_EXPAND).registerClickCallback(this.onExpandButtonClick);
			this.view.getButton(this.view.CP_BTN_BLACK_MARKET).registerClickCallback(this.onBlackMarketButtonClick);
		}
		
		/**
		 * Tab button click handler.
		 * @param String tabButtonName
		 * @return void
		 */
		private function onTabButtonClick(tabButtonName:String):void {
			trace(tabButtonName);
		}
		
		/**
		 * Item view "EXPAND" button onclick event.
		 * @param MouseEvent e
		 * @return void
		 */
		private function onExpandButtonClick(e:MouseEvent):void {
			trace('EXPAND PACKAGE');
		}
		
		/**
		 * Item view "BLACK MARKET" button onclick event.
		 * @param MouseEvent e
		 * @return void
		 */
		private function onBlackMarketButtonClick(e:MouseEvent):void {
			trace('ENTER BLACK MARKET');
		}
		
		/**
		 * Item view "CLOSE" button onclick event.
		 * @param MouseEvent e
		 * @return void
		 */
		private function onCloseButtonClick(e:MouseEvent):void {
			this.view.dispose();
		}
	}
}