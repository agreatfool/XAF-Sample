package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleAnimeManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.xenojoshua.as3demo.mvc.model.battle.AppBattleSoldier;
	
	public class AppBattleSoldierView extends XafRobotlegsView
	{
		private var _dataLayer:Sprite;
		private var _roleLayer:Sprite;
		private var _effectLayer:Sprite;
		
		private var _roleId:String;
		private var _hp:int;
		private var _rage:int;
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
		public function AppBattleSoldierView(soldierInfo:AppBattleSoldier, grid:DisplayObjectContainer) {
			super();
			
			this._roleId     = soldierInfo.roleId;
			this._hp         = soldierInfo.hp;
			this._rage       = 50;
			this._attack     = soldierInfo.attack;
			this._defence    = soldierInfo.defence;
			this._isAttacker = soldierInfo.isAttacker;
			this._isMagic    = soldierInfo.isMagic;
			this._skillId    = soldierInfo.skillId;
			
			this._grid = grid;
			
			this._dataLayer = new Sprite();
			this._roleLayer = new Sprite();
			this._effectLayer = new Sprite();
			
			this.addChild(this._dataLayer);
			this.addChild(this._roleLayer);
			this.addChild(this._roleLayer);
			
			this._grid.addChild(this);
			this.playStand();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* PLAY ANIMATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		public function playStand():void {
			this.removeAllLayerAnime();
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleStand(this._roleId);
			this.scale(movie);
			this._roleLayer.addChild(movie);
		}
		
		public function playAttack():void {
			
		}
		
		public function playSkill():void {
			
		}
		
		public function playHurt():void {
			
		}
		
		public function playSkillHurt():void {
			
		}
		
		public function playDie():void {
			
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
				this.removeAllAnime(this._dataLayer);
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
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* GETTER & SETTER
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
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