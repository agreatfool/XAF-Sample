package com.xenojoshua.as3demo.mvc.model.vo.battle
{
	public class AppBattleSoldier
	{
		private var _gridId:int;
		private var _roleId:String;
		private var _hp:int;
		private var _rage:int;
		private var _attack:int;         // FIXME demo: damage = attack - defence
		private var _defence:int;
		private var _isAttacker:Boolean;
		private var _isMagic:Boolean;    // FIXME demo: only affect the effect anime
		private var _skillId:int;        // FIXME demo: all skills would affect all enemies
		
		/**
		 * Initialize AppBattleSoldier.
		 * @param int gridId
		 * @param String roleId
		 * @param int hp
		 * @param int attack
		 * @param int defence
		 * @param Boolean isAttacker
		 * @param Boolean isMagic
		 * @param int skillId
		 * @return void
		 */
		public function AppBattleSoldier(
			gridId:int, roleId:String, hp:int, attack:int,
			defence:int, isAttacker:Boolean, isMagic:Boolean, skillId:int
		) {
			this._gridId     = gridId;
			this._roleId     = roleId;
			this._hp         = hp;
			this._rage       = 50;
			this._attack     = attack;
			this._defence    = defence;
			this._isAttacker = isAttacker;
			this._isMagic    = isMagic;
			this._skillId    = skillId;
		}
		
		public function get gridId():int { return this._gridId; }
		public function set gridId(val:int):void { this._gridId = val; }
		
		public function get roleId():String { return this._roleId; }
		public function set roleId(val:String):void { this._roleId = val; }
		
		public function get hp():int { return this._hp; }
		public function set hp(val:int):void { this._hp = val; }
		
		public function get rage():int { return this._rage; }
		public function set rage(val:int):void { this._rage = val; }
		
		public function get attack():int { return this._attack; }
		public function set attack(val:int):void { this._attack = val; }
		
		public function get defence():int { return this._defence; }
		public function set defence(val:int):void { this._defence = val; }
		
		public function get isAttacker():Boolean { return this._isAttacker; }
		public function set isAttacker(val:Boolean):void { this._isAttacker = val; }
		
		public function get isMagic():Boolean { return this._isMagic; }
		public function set isMagic(val:Boolean):void { this._isMagic = val; }
		
		public function get skillId():int { return this._skillId; }
		public function set skillId(val:int):void { this._skillId = val; }
	}
}