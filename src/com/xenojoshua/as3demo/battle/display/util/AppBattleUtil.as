package com.xenojoshua.as3demo.battle.display.util
{
	public class AppBattleUtil
	{
		/**
		 * Build gridId & isAttacker into a String.
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @return String gridIdString
		 */
		public static function buildGridIdString(gridId:int, isAttacker:Boolean):String {
			return (isAttacker ? '+' : '-') + gridId.toString();
		}
		
		/**
		 * Parse grid id string to meaningful params. <br/>
		 * e.g. <br/>
		 *     gridIdString = '+0' => gridId:int = 0 & isAttacker:Boolean = true <br/>
		 *     gridIdString = '-8' => gridId:int = 8 & isAttacker:Boolean = false
		 * @return Array 'gridId:int, isAttacker:Boolean'
		 */
		public static function parseGridIdString(gridIdString:String):Array {
			var gridId:int = Number(gridIdString.substr(1));
			var isAttacker:Boolean = gridIdString.substr(0, 1) == '+' ? true : false;
			
			return [gridId, isAttacker];
		}
	}
}