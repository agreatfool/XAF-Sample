package com.xenojoshua.as3demo.mvc.view
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.mask.XafLoadingMaskMaker;
	import com.xenojoshua.as3demo.mvc.view.city.AppCityView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class AppGameMediator extends Mediator
	{
		[Inject]
		public var view:AppGameView;
		
		public function AppGameMediator() {
			super();
		}
		
		override public function onRegister():void {
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_ROOT, this.view.stage, true);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_GAME);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_UI);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_BATTLE);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_POPUP, null, false, false);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_CONSOLE);
			
			XafConsole.restart();
			XafLoadingMaskMaker.startup(AppResources.FILE_MAIN, AppResources.CLASS_LOADING);
			
			XafScreenManager.instance.getLayer(XafConst.SCREEN_GAME).addChild(new AppCityView());
		}
	}
}