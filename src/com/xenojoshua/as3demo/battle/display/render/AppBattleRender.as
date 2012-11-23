package com.xenojoshua.as3demo.battle.display.render
{
	import org.osflash.signals.Signal;

	public class AppBattleRender
	{
		private static var _instance:AppBattleRender;
		
		/**
		 * Get instance of AppBattleRender.
		 * @return AppBattleRender _instance
		 */
		public static function get instance():AppBattleRender {
			if (!AppBattleRender._instance) {
				AppBattleRender._instance = new AppBattleRender();
			}
			return AppBattleRender._instance;
		}
		
		/**
		 * Initialize AppBattleRender.
		 * @return void
		 */
		public function AppBattleRender() {
			this._playingList = new Object();
			this._animeCompleteSignal = new Signal();
		}
		
		/**
		 * Destory the render.
		 * @return void
		 */
		public function dispose():void {
			this._playingList = {};
			this._animeCompleteSignal.removeAll();
		}
		
		private var _playingList:Object;
		private var _animeCompleteSignal:Signal;
		
		/**
		 * Register 
		 */
		public function registerAnimeCompleteHandler():void {
			this._animeCompleteSignal.add();
		}
	}
}