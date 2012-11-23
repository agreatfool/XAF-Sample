package com.xenojoshua.as3demo.battle.display.render
{
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleMediator;
	
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
		}
		
		/**
		 * Destory the render.
		 * @return void
		 */
		public function dispose():void {
			this._mediator = null;
			this._playingList = {};
		}
		
		/**
		 * Used to control battle view systems, since the battle logic processor is out of the robotlegs system.
		 * It's impossible to touch the views without the mediator registered in it.
		 */
		private var _mediator:AppBattleMediator;
		
		private var _playingList:Object;
		
		/**
		 * Register battle robotlegs mediator.
		 * @param AppBattleMediator mediator
		 * @return void
		 */
		public function registerRobotlegsController(mediator:AppBattleMediator):void {
			this._mediator = mediator;
		}
	}
}