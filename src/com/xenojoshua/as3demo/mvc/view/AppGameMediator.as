package com.xenojoshua.as3demo.mvc.view
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.as3demo.mvc.view.city.AppCityView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AppGameMediator extends Mediator
	{
		[Inject]
		public var view:AppGameView;
		
		public function AppGameMediator() {
			super();
		}
		
		override public function onRegister():void {
			XafScreenManager.instance.getLayer(XafConst.SCREEN_GAME).addChild(new AppCityView());
		}
	}
}