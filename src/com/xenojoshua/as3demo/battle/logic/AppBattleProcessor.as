package com.xenojoshua.as3demo.battle.logic
{
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.time.XafTime;
	import com.xenojoshua.as3demo.battle.display.layers.AppBattleGridManager;
	import com.xenojoshua.as3demo.mvc.model.vo.battle.AppBattleSoldier;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleView;

	public class AppBattleProcessor
	{
		private static var _instance:AppBattleProcessor;
		
		/**
		 * Get instance of AppBattleProcessor.
		 * @return AppBattleProcessor _instance;
		 */
		public static function get instance():AppBattleProcessor {
			if (!AppBattleProcessor._instance) {
				AppBattleProcessor._instance = new AppBattleProcessor();
			}
			return AppBattleProcessor._instance;
		}
		
		/**
		 * Initialize AppGameProcesser.
		 * @return void
		 */
		public function AppBattleProcessor() {
			this._attackers = new Object();
			this._defenders = new Object();
		}
		
		/**
		 * Destory the battle processor.
		 * @return void
		 */
		public function dispose():void {
			this._mediator = null;
			this._startTime = 0;
			this._round = 0;
			this._attackers = {};
			this._defenders = {};
		}
		
		// GLOBAL PARAMS
		/**
		 * Used to control battle view systems, since the battle logic processor is out of the robotlegs system.
		 * It's impossible to touch the views without the mediator registered in it.
		 */
		private var _mediator:AppBattleMediator;
		/**
		 * Battler started time (millisecond)
		 */
		private var _startTime:int;
		/**
		 * Total battle rounds
		 */
		private var _round:int = 0;
		
		// CONFIG
		private const BATTLE_TARGET_GRIDS:Array = [ // 默认的战斗目标查找顺序
			[0,3,6,1,4,7,2,5,8], // 行1、行2、行3
			[1,4,7,0,3,6,2,5,8], // 行2、行1、行3
			[2,5,8,1,4,7,0,3,6]  // 行3、行2、行1
		];
		
		// DATA
		private var _attackers:Object; // <gridId:int, soldier:AppBattleSoldierView>
		private var _defenders:Object; // <gridId:int, soldier:AppBattleSoldierView>
		
		// STATUS
		private var _currGridId:int;
		private var _currIsAttacker:Boolean;
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* INITIALIZATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Register battle robotlegs mediator.
		 * @param AppBattleMediator mediator
		 * @return AppBattleProcessor processor
		 */
		public function registerRobotlegsController(mediator:AppBattleMediator):AppBattleProcessor {
			this._mediator = mediator;
			return this;
		}
		
		/**
		 * Register battle data.
		 * @param Array attackers 'AppBattleSoldierInfo'
		 * @param Array defenders 'AppBattleSoldierInfo'
		 * @return AppBattleProcessor processor
		 */
		public function registerBattleData(attackers:Array, defenders:Array):AppBattleProcessor {
			for each (var atkSoldier:AppBattleSoldier in attackers) {
				this._attackers[atkSoldier.gridId] = atkSoldier;
			}
			for each (var defSoldier:AppBattleSoldier in defenders) {
				this._defenders[defSoldier.gridId] = defSoldier;
			}
			return this;
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* BATTLE CONTROL
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Start the battle.
		 * @return void
		 */
		public function startBattle():void {
			this._startTime = XafTime.getRelativeTimer();
			XafConsole.instance.log(XafConsole.ERROR, 'AppBattleProcessor: Battle start!');
			this.findActor(-1, true);
		}
		
		/**
		 * Called after animation ends.
		 * Go on to loop the game logic.
		 * @return void
		 */
		public function loop():void {
			this.findActor(this._currGridId, this._currIsAttacker);
		}
		
		/**
		 * End the battle.
		 * @return void
		 */
		private function endBattle():void {
			XafConsole.instance.log(
				XafConsole.DEBUG,
				'AppBattleProcessor: Battle end! Time consumed: [' + (XafTime.getRelativeTimer() - this._startTime) + '] millisecond'
			);
			this.dispose();
			this._mediator.endBattle();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* BATTLE LOGICS
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
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
					++this._round;
					XafConsole.instance.log(XafConsole.ERROR, 'AppBattleProcessor: Round: ' + this._round);
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
				this._currGridId = Number(target);
				this._currIsAttacker = isAttacker;
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
			var actor:AppBattleSoldier = this.getSoldierViaGridId(gridId, isAttacker);
			var target:AppBattleSoldier = this.findTargetInBattle(gridId, isAttacker);
			var useSkill:Boolean = (actor.rage >= 100) ? true : false;
			
			
		}
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* BATTLE LOGICS: FORMULA
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* UTILITIES
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Find action target.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @return AppBattleSoldier target
		 */
		private function findTargetInBattle(gridId:int, isAttacker:Boolean):AppBattleSoldier {
			var recipients:Object = isAttacker ? this._attackers : this._defenders;
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
				XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Target not found!'); // 初始目标未找到
			}
			
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleProcessor: Target gridId found: ' + target);
			
			return this.getSoldierViaGridId(target, !isAttacker);
		}
		
		/**
		 * Get AppBattleSoldier via grid id.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @return AppBattleSoldier soldier
		 */
		private function getSoldierViaGridId(gridId:int, isAttacker:Boolean):AppBattleSoldier {
			var recipients:Object = isAttacker ? this._attackers : this._defenders;
			var soldier:AppBattleSoldier = null;
			if (recipients.hasOwnProperty(gridId)) {
				soldier = recipients[gridId];
			}
			
			return soldier;
		}
	}
}