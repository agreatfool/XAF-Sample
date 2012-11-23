package com.xenojoshua.as3demo.battle.display.layers
{
	import com.xenojoshua.af.resource.manager.XafImageManager;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.background.AppBattleBackgroundView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObject;

	public class AppBattleBgManager
	{
		private static var _instance:AppBattleBgManager;
		
		/**
		 * Get instance of AppBattleBgManager.
		 * @return AppBattleBgManager _mgr
		 */
		public static function get instance():AppBattleBgManager {
			if (!AppBattleBgManager._instance) {
				AppBattleBgManager._instance = new AppBattleBgManager();
			}
			return AppBattleBgManager._instance;
		}
		
		/**
		 * Initialize AppBattleBgManager.
		 * @return void
		 */
		public function AppBattleBgManager() {
			
		}
		
		private var _view:AppBattleBackgroundView;
		
		/**
		 * Register background view.
		 * @param AppBattleBackgroundView view
		 * @return void
		 */
		public function registerBgView(view:AppBattleBackgroundView):void {
			this._view = view;
			
			var background:DisplayObject = XafImageManager.instance.getImage(AppResources.FILE_BATTLE_BG);
			
			this._view.addChild(background);
		}
	}
}