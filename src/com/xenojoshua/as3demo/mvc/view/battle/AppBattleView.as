package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.resource.manager.XafImageManager;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.mvc.view.battle.background.AppBattleBackgroundView;
	import com.xenojoshua.as3demo.mvc.view.battle.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.view.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierInfo;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class AppBattleView extends XafRobotlegsView
	{
		private var _backgroundLayer:AppBattleBackgroundView;
		private var _gridsLayer:AppBattleGridView;
		
		/**
		 * Initialize AppBattleView.
		 * @return void
		 */
		public function AppBattleView() {
			super();
			
			this._backgroundLayer = AppBattleBackgroundView.instance;
			this._gridsLayer      = AppBattleGridView.instance;
			
			this.addChild(this._backgroundLayer);
			this.addChild(this._gridsLayer);
			
			this.startLoading();
		}
		
		/**
		 * Start to load necessary resources.
		 * @return void
		 */
		private function startLoading():void {
			// in production case, this list shall be changeable, since not every battle requires the same resources
			var started:Boolean = XafRsManager.instance.initializeLoadingBar().prepareLoading([
				AppResources.FILE_BATTLE_BG,
				AppResources.FILE_BATTLE_GRIDS,
				AppResources.FILE_BATTLE_ROLE_001,
				AppResources.FILE_BATTLE_ROLE_100,
				AppResources.FILE_BATTLE_ROLE_101,
				AppResources.FILE_BATTLE_ROLE_102,
				AppResources.FILE_BATTLE_PHY_ATK,
				AppResources.FILE_BATTLE_MGK_ATK,
				AppResources.FILE_BATTLE_SKILLS
			]).registerCompleteSignal(this.endLoading).startLoading();
			
			if (!started) { // not started: resources already loaded
				this.endLoading(XafRsManager.instance);
			}
		}
		
		/**
		 * Resources loading completed, start to initialize the battle stage.
		 * @param XafRsManager rsManager
		 * @return void
		 */
		private function endLoading(rsManager:XafRsManager):void {
			rsManager.dispose();
			AppBattleBackgroundView.instance.registerBgImage(XafImageManager.instance.getImage(AppResources.FILE_BATTLE_BG));
			AppBattleGridView.instance.registerGrids(XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_GRIDS, AppResources.CLASS_BATTLE_GRIDS));
			
			// FOR TEST
			var attackers:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldierInfo(0, '102', 10000, 1000, 200, true, false, 0),
				new AppBattleSoldierInfo(1, '100', 10000, 1000, 200, true, false, 1),
				new AppBattleSoldierInfo(2, '101', 10000, 1000, 200, true, true, 2)
			];
			var defenders:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldierInfo(0, '001', 10000, 1000, 200, false, false, 0),
				new AppBattleSoldierInfo(1, '102', 10000, 1000, 200, false, false, 1),
				new AppBattleSoldierInfo(2, '101', 10000, 1000, 200, false, true, 2)
			];
			new AppBattleProcessor(attackers, defenders);
		}
	}
}