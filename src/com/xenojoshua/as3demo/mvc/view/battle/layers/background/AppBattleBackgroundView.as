package com.xenojoshua.as3demo.mvc.view.battle.layers.background
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class AppBattleBackgroundView extends XafRobotlegsView
	{
		private static var _instance:AppBattleBackgroundView;
		
		/**
		 * Get instance of AppBattleBackgroundView.
		 * @return AppBattleBackgroundView _mgr
		 */
		public static function get instance():AppBattleBackgroundView {
			if (!AppBattleBackgroundView._instance) {
				AppBattleBackgroundView._instance = new AppBattleBackgroundView();
			}
			return AppBattleBackgroundView._instance;
		}
		
		/**
		 * Initialize AppBattleBackgroundManager.
		 * @return void
		 */
		public function AppBattleBackgroundView() {
			super(false);
		}
		
		/**
		 * Apply the battle background image.
		 * @param DisplayObject background
		 * @return void
		 */
		public function registerBgImage(background:DisplayObject):void {
			this.addChild(background);
		}
	}
}