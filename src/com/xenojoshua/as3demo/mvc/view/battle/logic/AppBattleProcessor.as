package com.xenojoshua.as3demo.mvc.view.battle.logic
{
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.time.XafTime;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleView;
	import com.xenojoshua.as3demo.mvc.view.battle.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierInfo;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;

	public class AppBattleProcessor
	{
		// GLOBAL PARAMS
		private var battleView:AppBattleView; // battle main view, used to end battle
		private var startTime:int; // battler start millisecond
		private var round:int = 0; // 总战斗回合数
		
		// CONFIG
		private const BATTLE_TARGET_GRIDS:Array = [ // 默认的战斗目标查找顺序
			[0,3,6,1,4,7,2,5,8], // 行1、行2、行3
			[1,4,7,0,3,6,2,5,8], // 行2、行1、行3
			[2,5,8,1,4,7,0,3,6]  // 行3、行2、行1
		];
		
		// DATA
		private var _attackers:Object; // <gridId:int, soldier:AppBattleSoldierView>
		private var _defenders:Object; // <gridId:int, soldier:AppBattleSoldierView>
		
		
		/**
		 * Initialize AppGameProcesser.
		 * @param AppBattleView view
		 * @param Array attackers 'AppBattleSoldierInfo'
		 * @param Array defenders 'AppBattleSoldierInfo'
		 * @return void
		 */
		public function AppBattleProcessor(view:AppBattleView, attackers:Array, defenders:Array) {
			this.battleView = view;
			
			this._attackers = new Object();
			this._defenders = new Object();
			
			for each (var atkInfo:AppBattleSoldierInfo in attackers) {
				this._attackers[atkInfo.gridId] = new AppBattleSoldierView(atkInfo, AppBattleGridView.instance.getAtkGrid(atkInfo.gridId));
			}
			for each (var defInfo:AppBattleSoldierInfo in defenders) {
				this._defenders[defInfo.gridId] = new AppBattleSoldierView(defInfo, AppBattleGridView.instance.getDefGrid(defInfo.gridId));
			}
			
			// start to play the game
			this.startTime = XafTime.getRelativeTimer();
			XafConsole.instance.log(XafConsole.ERROR, 'AppBattleProcessor: Battle start!');
			this.findActor(-1, true);
		}
		
		/**
		 * End the battle.
		 * @return void
		 */
		private function endBattle():void {
			XafConsole.instance.log(
				XafConsole.DEBUG,
				'AppBattleProcessor: Battle end! Time consumed: [' + (XafTime.getRelativeTimer() - this.startTime) + '] millisecond'
			);
			this.battleView.dispose();
		}
		
		/**
		 * Find actor soldier, and play battle round.
		 * @param int previousGridId
		 * @param Boolean isAttacker
		 * @return void
		 */
		private function findActor(previousGridId:int, isAttacker:Boolean):void {
			var target:String = '';
			
			var actors:Object = isAttacker ? this._attackers : this._defenders;
			if (-1 == previousGridId) { // means it's the start of the attackers or defenders
				if (isAttacker) {
					++this.round;
					XafConsole.instance.log(XafConsole.ERROR, 'AppBattleProcessor: Round: ' + this.round);
				}
				for (var firstGridId:String in actors) {
					target = firstGridId;
					break;
				}
			} else {
				for (var gridId:String in actors) {
					if (Number(gridId) > previousGridId) {
						target = gridId;
						break;
					}
				}
			}
			
			if (target == '') { // no next target found
				var attackerCount:int = 0;
				var defenderCount:int = 0;
				for (var atkKey:String in this._attackers) {
					++attackerCount;
				}
				for (var defKey:String in this._defenders) {
					++defenderCount;
				}
				if (attackerCount == 0 || defenderCount == 0) { // one side all dead, end battle
					this.endBattle();
				} else { // not dead, switch to another side
					this.findActor(-1, !isAttacker);
				}
			} else {
				this.playRound(Number(target), isAttacker);
			}
		}
		
		/**
		 * One unit do one action.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @return void
		 */
		private function playRound(gridId:int, isAttacker:Boolean):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Actor[' + (isAttacker ? 'ATK' : 'DEF') + '], grid: ' + gridId);
			
			var actor:AppBattleSoldierView = isAttacker ? this._attackers[gridId] : this._defenders[gridId];
			var useSkill:Boolean = (actor.rage >= 100) ? true : false;
			var targets:Object = this.findTargetInBattle(gridId, isAttacker, useSkill);
		}
		
		/**
		 * Find action target.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @param Boolean useSkill
		 * @return Object targets 'gridId:int, soldier:AppBattleSoldierView'
		 */
		private function findTargetInBattle(gridId:int, isAttacker:Boolean, useSkill:Boolean):Object {
			var targets:Object = new Object();
			
			var recipients:Object = isAttacker ? this._attackers : this._defenders;
			
			// 目标全体
			if (useSkill) {
				for (var recpGridId:String in recipients) {
					if (recipients[recpGridId]) {
						targets[recpGridId] = recipients[recpGridId];
					}
				}
				XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Target found: ' + JSON.stringify(targets));
				return targets;
			}
			
			var target:int = -1; // 将target初始化成-1用来判断目标是否被找到
			// 查找初始的目标单位
			var posRowNo:int = gridId % 3; // gridId所在的行号(0-2)
			var grids:Array = this.BATTLE_TARGET_GRIDS[posRowNo]; // 根据行号，查找默认目标搜索顺序
			for each (var gridNum:int in grids) {
				if (recipients.hasOwnProperty(gridNum)) {
					target = gridNum;
					break;
				}
			}
			if (target == -1) {
				targets[0] = null;
				XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Target not found!'); // 初始目标未找到
			} else {
				targets[target] = recipients[target];
			}
			
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Targets found: ' + JSON.stringify(targets));
			
			return targets;
		}
	}
}