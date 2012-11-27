package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.timer.XafTimerManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleRender;
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.model.vo.battle.AppBattleSoldier;
	
	import flash.events.Event;
	
	public class AppBattleMediator extends XafRobotlegsMediator
	{
		[Inject]
		public var view:AppBattleView;
		
		private var WAIT_TO_START_TIMER:String = 'WAIT_TO_START_TIMER';
		
		private var _totalWaitCount:int;
		
		/**
		 * Initialize AppBattleMediator.
		 * @return void
		 */
		public function AppBattleMediator() {
			super();
			this._totalWaitCount = 0;
		}
		
		/**
		 * On register, prepare data & start to play the game.
		 * @return void
		 */
		override public function onRegister():void {
			super.onRegister();
			XafTimerManager.instance.registerTimer(this.WAIT_TO_START_TIMER, 10, this.waitToStart);
		}
		
		/**
		 * End the battle.
		 * @return void
		 */
		public function endBattle():void {
			this.view.dispose();
		}
		
		/**
		 * Wait resources loading to be finished, and then start the battle logic.
		 * @param Event e
		 * @return void
		 */
		private function waitToStart(e:Event):void {
			++this._totalWaitCount;
			if (this.view.areResourcesLoaded()) {
				XafTimerManager.instance.removeTimer(this.WAIT_TO_START_TIMER);
				this.startBattle();
				this._totalWaitCount = 0;
			}
		}
		
		/**
		 * Get the battle data & start to play the game.
		 * @return void
		 */
		private function startBattle():void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleMediator: startBattle(), waiting count : ' + this._totalWaitCount);
			// FIXME FOR TEST: data shall got form server, not hard coded here
			// ROLES: 001: 剑领剑士, 100: 弓手, 101: 法师, 102: 道术剑士
			var attackers:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldier(3, '102', 1000, 1000, 200, true, false, 0),
//				new AppBattleSoldier(1, '100', 1000, 1000, 200, true, false, 1),
//				new AppBattleSoldier(2, '101', 1000, 1000, 200, true, true, 2)
			];
			var defenders:Array = [
				// griId: roleId, hp, attack, defence, isAttacker, isMagic, skillId
				new AppBattleSoldier(3, '001', 1000, 1000, 200, false, false, 0),
				new AppBattleSoldier(1, '102', 1000, 1000, 200, false, false, 1),
//				new AppBattleSoldier(5, '101', 1000, 1000, 200, false, true, 2)
			];
			AppBattleRender.instance.registerBattleSoldierView(attackers, defenders);
			AppBattleProcessor.instance.registerRobotlegsController(this).registerBattleData(attackers, defenders).startBattle(); // start the battle
		}
	}
}