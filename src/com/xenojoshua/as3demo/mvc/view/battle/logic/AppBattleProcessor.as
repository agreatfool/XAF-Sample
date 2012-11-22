package com.xenojoshua.as3demo.mvc.view.battle.logic
{
	import com.xenojoshua.as3demo.mvc.view.battle.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierInfo;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;

	public class AppBattleProcessor
	{
		private var _attackers:Object; // <gridId:int, soldier:AppBattleSoldierView>
		private var _defenders:Object; // <gridId:int, soldier:AppBattleSoldierView>
		
		/**
		 * Initialize AppGameProcesser.
		 * @param Array attackers 'AppBattleSoldierInfo'
		 * @param Array defenders 'AppBattleSoldierInfo'
		 * @return void
		 */
		public function AppBattleProcessor(attackers:Array, defenders:Array) {
			this._attackers = new Object();
			this._defenders = new Object();
			
			for each (var atkInfo:AppBattleSoldierInfo in attackers) {
				this._attackers[atkInfo.gridId] = new AppBattleSoldierView(atkInfo, AppBattleGridView.instance.getAtkGrid(atkInfo.gridId));
			}
			for each (var defInfo:AppBattleSoldierInfo in defenders) {
				this._defenders[defInfo.gridId] = new AppBattleSoldierView(defInfo, AppBattleGridView.instance.getDefGrid(defInfo.gridId));
			}
			
			this.play();
		}
		
		/**
		 * Start to loop to play the game.
		 * @return void
		 */
		private function play():void {
			
		}
	}
}