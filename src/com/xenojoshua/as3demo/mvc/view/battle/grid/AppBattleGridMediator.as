package com.xenojoshua.as3demo.mvc.view.battle.grid
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	
	public class AppBattleGridMediator extends XafRobotlegsMediator
	{
		[Inject]
		public var view:AppBattleGridView;
		
		public function AppBattleGridMediator()
		{
			super();
		}
	}
}