package com.xenojoshua.as3demo.mvc.view.battle
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsMediator;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleRender;
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.model.battle.AppBattleSoldier;
	
	import flash.events.Event;
	
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
		
		/**
		 * On register, prepare data & start to play the game.
		 * @return void
		 */
		override public function onRegister():void {
			super.onRegister();
			this.startBattle();
		}
		
		/**
		 * End the battle.
		 * @return void
		 */
		public function endBattle():void {
			this.view.dispose();
		}
		
		/**
		 * Send Event command.
		 * @param Event e
		 * @return void
		 */
		public function sendCommand(e:Event):void {
			this.dispatch(e);
		}
		
		/**
		 * Get the battle data & start to play the game.
		 * @return void
		 */
		private function startBattle():void {
			AppBattleRender.instance.registerRobotlegsController(this);
			
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
			AppBattleProcessor.instance.registerRobotlegsController(this).registerBattleData(attackers, defenders).startBattle(); // start the battle
		}
	}
}