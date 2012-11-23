package com.xenojoshua.as3demo.battle.display.layers
{
	import com.xenojoshua.as3demo.mvc.view.battle.layers.effect.AppBattleEffectView;

	public class AppBattleEffectManager
	{
		private static var _instance:AppBattleEffectManager;
		
		/**
		 * Get instance of AppBattleEffectManager.
		 * @return AppBattleEffectManager _mgr
		 */
		public static function get instance():AppBattleEffectManager {
			if (!AppBattleEffectManager._instance) {
				AppBattleEffectManager._instance = new AppBattleEffectManager();
			}
			return AppBattleEffectManager._instance;
		}
		
		/**
		 * Initialize AppBattleEffectManager.
		 * @return void
		 */
		public function AppBattleEffectManager() {
			
		}
		
		private var _view:AppBattleEffectView;
		
		/**
		 * Register effect view.
		 * @param AppBattleEffectView view
		 * @return void
		 */
		public function registerBgView(view:AppBattleEffectView):void {
			this._view = view;
		}
	}
}