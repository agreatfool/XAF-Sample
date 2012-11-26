package com.xenojoshua.as3demo.battle.display.render
{
	import com.greensock.loading.SWFLoader;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.af.utils.XafUtil;
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
		
		/**
		 * Get role stand animation.
		 * @param String roleId e.g. '001'
		 * @param Boolean isAttacker
		 * @return MovieClip movie
		 */
		public function getRoleStand(roleId:String, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_STAND + roleId);
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Get role hit animation.
		 * @param String roleId e.g. '001'
		 * @param Boolean isAttacker
		 * @return MovieClip movie
		 */
		public function getRoleHit(roleId:String, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_HIT + roleId);
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Get role attack animation.
		 * @param String roleId e.g. '001'
		 * @param Boolean isAttacker
		 * @return MovieClip movie
		 */
		public function getRoleAttack(roleId:String, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_ATTACK + roleId);
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Get role skill animation.
		 * @param String roleId e.g. '001'
		 * @param Boolean isAttacker
		 * @return MovieClip movie
		 */
		public function getRoleSkill(roleId:String, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(this.SOLDIER_FILE_PREFIX + roleId, AppResources.CLASS_BATTLE_SKILL + roleId);
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Get skill effect animation.
		 * @param int skillId e.g. 0
		 * @param Boolean isAttacker means is recipient attacker or not
		 * @return MovieClip movie
		 */
		public function getSkillEffect(skillId:int, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_SKILLS, AppResources.CLASS_BATTLE_SKILLS + '0' + skillId);
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Get attack effect animation.
		 * @param String attackType e.g. AppBattleAnimeManager.ATTACK_TYPE_PHY
		 * @param Boolean isAttacker means is recipient attacker or not
		 * @return MovieClip movie
		 */
		public function getAttackEffect(attackType:String, isAttacker:Boolean):MovieClip {
			var movie:MovieClip = null;
			
			if (attackType == AppBattleAnimeManager.ATTACK_TYPE_PHY) {
				movie = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_PHY_ATK, AppResources.CLASS_BATTLE_PSY_ATK);
			} else if (attackType == AppBattleAnimeManager.ATTACK_TYPE_MGK) {
				movie = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_MGK_ATK, AppResources.CLASS_BATTLE_MGK_ATK);
			}
			
			return this.horizontallyScaleMovie(movie, isAttacker);
		}
		
		/**
		 * Horizontally scale the movie.
		 * @param MovieClip movie
		 * @param Boolean isAttacker
		 * @return void
		 */
		private function horizontallyScaleMovie(movie:MovieClip, isAttacker:Boolean):MovieClip {
			movie.gotoAndStop(1);
			
			var scale:int = isAttacker ? 1 : -1;
			movie.scaleX *= scale;
			
			return movie;
		}
	}
}