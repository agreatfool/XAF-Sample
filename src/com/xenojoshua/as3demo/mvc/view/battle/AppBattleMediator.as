package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	
	public class AppBattleMediator extends XafRobotlegsMediator
	{
		[Inject]
		public var view:AppBattleView;
		
		/**
		 * Initialize AppBattleMediator.
		 * @return void
		 */
		public function AppBattleMediator() {
			super();
		}
	}
}