package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	public class AppBattleSoldierInfo
	{
		public var gridId:int;
		public var roleId:String;
		public var hp:int;
		public var attack:int;
		public var defence:int;
		public var isAttacker:Boolean;
		public var isMagic:Boolean;
		public var skillId:int;
		
		public function AppBattleSoldierInfo(
			gridId:int, roleId:String, hp:int, attack:int,
			defence:int, isAttacker:Boolean, isMagic:Boolean, skillId:int
		) {
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