package com.xenojoshua.as3demo.mvc.view.battle.layers.background
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	
	public class AppBattleBackgroundMediator extends XafRobotlegsMediator
	{
		[Inject]
		public var view:AppBattleBackgroundView;
		
		public function AppBattleBackgroundMediator()
		{
			super();
		}
	}
}