package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	import org.robotlegs.mvcs.Mediator;
	
	public class AppBattleSoldierMediator extends Mediator
	{
		[Inject]
		public var view:AppBattleSoldierView;
		
		public function AppBattleSoldierMediator() {
			super();
		}
	}
}