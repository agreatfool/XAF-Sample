package com.xenojoshua.as3demo.battle.display.render
{
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.MovieClip;

	public class AppBattleAnimeManager
	{
		private static var _mgr:AppBattleAnimeManager;
		
		/**
		 * Get instance of AppBattleAnimeManager.
		 * @return AppBattleAnimeManager _mgr
		 */
		public static function get instance():AppBattleAnimeManager {
			if (!AppBattleAnimeManager._mgr) {
				AppBattleAnimeManager._mgr = new AppBattleAnimeManager();
			}
			return AppBattleAnimeManager._mgr;
		}
		
		public static const ATTACK_TYPE_PHY:String = 'ATTACK_TYPE_PHY';
		public static const ATTACK_TYPE_MGK:String = 'ATTACK_TYPE_MGK';
		
		private const SOLDIER_FILE_PREFIX:String = 'file.battlerole';
		private const SKILL_NAME_PREFIX:String = 'S';
		
		/**
		 * Get role stand animation.
		 * @param String roleId e.g. '001'
		 * @return MovieClip movie
		 */
		public function getRoleStand(roleId:String):MovieClip {
			return XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_STAND + roleId);
		}
		
		/**
		 * Get role hit animation.
		 * @param String roleId e.g. '001'
		 * @return MovieClip movie
		 */
		public function getRoleHit(roleId:String):MovieClip {
			return XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_HIT + roleId);
		}
		
		/**
		 * Get role attack animation.
		 * @param String roleId e.g. '001'
		 * @return MovieClip movie
		 */
		public function getRoleAttack(roleId:String):MovieClip {
			return XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_ATTACK + roleId);
		}
		
		/**
		 * Get role skill animation.
		 * @param String roleId e.g. '001'
		 * @return MovieClip movie
		 */
		public function getRoleSkill(roleId:String):MovieClip {
			return XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_SKILL + roleId);
		}
		
		/**
		 * Get skill effect animation.
		 * @param String skillId e.g. 0
		 * @return MovieClip movie
		 */
		public function getSkillEffect(skillId:int):MovieClip {
			return XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_SKILLS, this.SKILL_NAME_PREFIX + skillId);
		}
		
		/**
		 * Get attack effect animation.
		 * @param String attackType e.g. AppBattleAnimeManager.ATTACK_TYPE_PHY
		 * @return MovieClip movie
		 */
		public function getAttackEffect(attackType:String):MovieClip {
			var movie:MovieClip = null;
			
			if (attackType == AppBattleAnimeManager.ATTACK_TYPE_PHY) {
				movie = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_PHY_ATK, AppResources.CLASS_BATTLE_PSY_ATK);
			} else if (attackType == AppBattleAnimeManager.ATTACK_TYPE_MGK) {
				movie = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_MGK_ATK, AppResources.CLASS_BATTLE_MGK_ATK);
			}
			
			return movie;
		}
	}
}