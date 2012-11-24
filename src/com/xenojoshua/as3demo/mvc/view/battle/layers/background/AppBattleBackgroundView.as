package com.xenojoshua.as3demo.mvc.view.battle.layers.background
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class AppBattleBackgroundView extends XafRobotlegsView
	{
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