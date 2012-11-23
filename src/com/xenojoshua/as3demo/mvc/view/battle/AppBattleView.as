package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.resource.manager.XafImageManager;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.battle.display.layers.AppBattleBgManager;
	import com.xenojoshua.as3demo.battle.display.layers.AppBattleEffectManager;
	import com.xenojoshua.as3demo.battle.display.layers.AppBattleGridManager;
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.background.AppBattleBackgroundView;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.effect.AppBattleEffectView;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.model.battle.AppBattleSoldier;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class AppBattleView extends XafRobotlegsView
	{
		private var _backgroundLayer:AppBattleBackgroundView;
		private var _gridsLayer:AppBattleGridView;
		private var _effectLayer:AppBattleEffectView;
		
		/**
		 * Initialize AppBattleView.
		 * @return void
		 */
		public function AppBattleView() {
			super();
			
			this._backgroundLayer = new AppBattleBackgroundView();
			this._gridsLayer      = new AppBattleGridView();
			this._effectLayer     = new AppBattleEffectView();
			
			this.addChild(this._backgroundLayer);
			this.addChild(this._gridsLayer);
			this.addChild(this._effectLayer);
			
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
			this.prepareBattle();
			this.startBattle();
		}
		
		/**
		 * Prepare battle display.
		 * @return void
		 */
		private function prepareBattle():void {
			AppBattleBgManager.instance.registerBgView(this._backgroundLayer);
			AppBattleGridManager.instance.regiterGridView(this._gridsLayer);
			AppBattleEffectManager.instance.registerBgView(this._effectLayer);
		}
		
		/**
		 * Get the battle data & start to play the game.
		 * @return void
		 */
		private function startBattle():void {
			// FIXME FOR TEST: data shall got form server, not hard coded here
			var attackers:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldier(3, '102', 50000, 1000, 200, true, false, 0),
				new AppBattleSoldier(1, '100', 50000, 1000, 200, true, false, 1),
				new AppBattleSoldier(2, '101', 50000, 1000, 200, true, true, 2)
			];
			var defenders:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldier(3, '001', 50000, 1000, 200, false, false, 0),
				new AppBattleSoldier(1, '102', 50000, 1000, 200, false, false, 1),
				new AppBattleSoldier(5, '101', 50000, 1000, 200, false, true, 2)
			];
			new AppBattleProcessor(this, attackers, defenders); // start the battle
		}
	}
}