package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	public class AppBattleView extends XafRobotlegsView
	{
		// Resources have to be loaded before battle UI display
		private var _resources:Array = [
			AppResources.FILE_BATTLE_BG,
			AppResources.FILE_BATTLE_ROLE_001,
			AppResources.FILE_BATTLE_ROLE_100,
			AppResources.FILE_BATTLE_ROLE_101,
			AppResources.FILE_BATTLE_ROLE_102,
			AppResources.FILE_BATTLE_PHY_ATK,
			AppResources.FILE_BATTLE_MGK_ATK,
			AppResources.FILE_BATTLE_SKILLS
		];
		
		/**
		 * Initialize AppBattleView.
		 * @param Boolean withBgMask default false
		 * @return void
		 */
		public function AppBattleView(withBgMask:Boolean = false) {
			super(withBgMask);
		}
		
		private function startLoading():void {
			
		}
		
		private function endLoading():void {
			
		}
	}
}