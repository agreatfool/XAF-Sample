package com.xenojoshua.as3demo.battle.display.render
{
	import com.xenojoshua.as3demo.battle.display.util.AppBattleUtil;
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.event.battle.AppBattleAnimeStartEvent;
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
			this._playList = new Object();
		}
		
		/**
		 * Destory the render.
		 * @return void
		 */
		public function dispose():void {
			this._mediator = null;
			this._playList = {};
		}
		
		/**
		 * Used to control battle view systems, since the battle logic processor is out of the robotlegs system.
		 * It's impossible to touch the views without the mediator registered in it.
		 */
		private var _mediator:AppBattleMediator;
		/**
		 * KEY:   gridIdString:String, please refer to AppBattleUtil.buildGridIdString() <br/>
		 * VALUE: commands:Array, array of AppBattleAnimeStartCommand
		 */
		private var _playList:Object; // <gridIdString:String, commands:Array>
		private var _animeCount:int; // total animes count to be played
		
		/**
		 * Register battle robotlegs mediator.
		 * @param AppBattleMediator mediator
		 * @return void
		 */
		public function registerRobotlegsController(mediator:AppBattleMediator):void {
			this._mediator = mediator;
		}
		
		/**
		 * Add a animation command into play list.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @param String eventName
		 * @return void
		 */
		public function addToPlayList(gridId:int, isAttacker:Boolean, eventName:String):void {
			var gridIdString:String = AppBattleUtil.buildGridIdString(gridId, isAttacker);
			var command:AppBattleAnimeStartEvent = new AppBattleAnimeStartEvent(AppBattleAnimeStartEvent[eventName]);
			
			command.gridId = gridId;
			command.isAttacker = isAttacker;
			
			if (!this._playList.hasOwnProperty(gridIdString)) {
				this._playList[gridIdString] = new Array();
			}
			this._playList[gridIdString].push(command);
			++this._animeCount;
		}
		
		/**
		 * Start to play the animation in the play list.
		 * @return void
		 */
		public function startToPlay():void {
			for (var gridIdString:String in this._playList) {
				for each (var event:AppBattleAnimeStartEvent in this._playList[gridIdString]) {
					this._mediator.sendCommand(event);
				}
			}
		}
		
		/**
		 * Called when an anime ends.
		 * Check whether it's the last anime in the play list,
		 * if true, go on to loop the game logic.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @param String eventName
		 * @return void
		 */
		public function callbackAnimeEnd(gridId:int, isAttacker:Boolean, eventName:String):void {
			var gridIdString:String = AppBattleUtil.buildGridIdString(gridId, isAttacker);
			
			if (this._playList.hasOwnProperty(gridIdString)) {
				for (var index:String in this._playList[gridIdString]) {
					var event:AppBattleAnimeStartEvent = this._playList[gridIdString][index];
					if (event.type == eventName) {
						delete this._playList[gridIdString][index];
						--this._animeCount;
					}
				}
			}
			if (this._animeCount <= 0) {
				AppBattleProcessor.instance.loop();
			}
		}
	}
}