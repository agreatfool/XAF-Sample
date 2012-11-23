package com.xenojoshua.as3demo.mvc.model.battle
{
	public class AppBattleSoldier
	{
		public var gridId:int;
		public var roleId:String;
		public var hp:int;
		public var attack:int; // FIXME demo: damage = attack - defence
		public var defence:int;
		public var isAttacker:Boolean;
		public var isMagic:Boolean; // FIXME demo: only affect the effect anime
		public var skillId:int; // FIXME demo: all skills would affect all enemies
		
		public function AppBattleSoldier(
			gridId:int, roleId:String, hp:int, attack:int,
			defence:int, isAttacker:Boolean, isMagic:Boolean, skillId:int
		) {
			this.gridId = gridId;
			this.roleId = roleId;
			this.hp = hp;
			this.attack = attack;
			this.defence = defence;
			this.isAttacker = isAttacker;
			this.isMagic = isMagic;
			this.skillId = skillId;
		}
	}
}