package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.mvc.view.battle.anime.AppBattleAnimeManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AppBattleSoldierView extends XafRobotlegsView
	{
		private var _hpLayer:Sprite;
		private var _roleLayer:Sprite;
		private var _effectLayer:Sprite;
		
		private var _roleId:String;
		private var _hp:int;
		private var _attack:int;
		private var _defence:int;
		private var _isAttacker:Boolean;
		private var _isMagic:Boolean;
		private var _skillId:int;
		
		private var _grid:DisplayObjectContainer;
		
		/**
		 * Initialize AppSoldierView.
		 * @param String soldierId
		 * @param Sprite grid where soldier stand on it
		 * @return void
		 */
		public function AppBattleSoldierView(soldierInfo:AppBattleSoldierInfo, grid:DisplayObjectContainer) {
			super();
			
			this._roleId     = soldierInfo.roleId;
			this._hp         = soldierInfo.hp;
			this._attack     = soldierInfo.attack;
			this._defence    = soldierInfo.defence;
			this._isAttacker = soldierInfo.isAttacker;
			this._isMagic    = soldierInfo.isMagic;
			this._skillId    = soldierInfo.skillId;
			
			this._grid = grid;
			
			this._hpLayer = new Sprite();
			this._roleLayer = new Sprite();
			this._effectLayer = new Sprite();
			
			this.stand();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* PLAY ANIMATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		public function stand():void {
			this.removeAllLayerAnime();
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleStand(this._roleId);
			this.scale(movie);
			this._roleLayer.addChild(movie);
		}
		
		public function attack():void {
			
		}
		
		public function skill():void {
			
		}
		
		public function hurt():void {
			
		}
		
		public function die():void {
			
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* UTILITIES
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Horizontal scale the movie.
		 * @param MovieClip movie
		 * @return void
		 */
		private function scale(movie:MovieClip):void {
			var scale:int = this._isAttacker ? 1 : -1;
			movie.scaleX *= scale;
		}
		
		/**
		 * Remove all animes.
		 * @param Boolean includeHp default false
		 * @return void
		 */
		private function removeAllLayerAnime(includeHp:Boolean = false):void {
			if (includeHp) {
				this.removeAllAnime(this._hpLayer);
			}
			this.removeAllAnime(this._roleLayer);
			this.removeAllAnime(this._effectLayer);
		}
		
		/**
		 * Remove all playing anime.
		 * @param Sprite layer
		 * @return void
		 */
		private function removeAllAnime(layer:Sprite):void {
			if (layer.numChildren) {
				for (var i:int; i < layer.numChildren; ++i) {
					layer.removeChildAt(i);
				}
			}
		}
	}
}