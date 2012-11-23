package com.xenojoshua.as3demo.mvc.event.battle
{
	import flash.events.Event;
	
	public class AppBattleAnimeStartEvent extends Event
	{
		public static const STAND:String     = 'STAND';
		public static const ATTACK:String    = 'ATTACK';
		public static const SKILL:String     = 'SKILL';
		public static const HURT:String      = 'HURT';
		public static const SKILLHURT:String = 'SKILLHURT';
		public static const DIE:String       = 'DIE';
		
		public var gridId:int;
		public var isAttacker:Boolean;
		
		/**
		 * Initialize AppBattleAnimeStartEvent.
		 * @param String type
		 * @param Boolean bubbles default false
		 * @param Boolean cancelable default false
		 * @return void
		 */
		public function AppBattleAnimeStartEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}