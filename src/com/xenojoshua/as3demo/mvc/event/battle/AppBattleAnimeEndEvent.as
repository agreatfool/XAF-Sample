package com.xenojoshua.as3demo.mvc.event.battle
{
	import flash.events.Event;
	
	public class AppBattleAnimeEndEvent extends Event
	{
		public function AppBattleAnimeEndEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}