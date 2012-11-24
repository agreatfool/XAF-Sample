package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleAnimeManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleRender;
	import com.xenojoshua.as3demo.battle.display.util.AppBattleUtil;
	import com.xenojoshua.as3demo.mvc.model.enum.battle.AppSoldierAnimeName;
	import com.xenojoshua.as3demo.mvc.model.vo.battle.AppBattleSoldier;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AppBattleSoldierView extends XafRobotlegsView
	{
		private var _dataLayer:Sprite;
		private var _roleLayer:Sprite;
		private var _effectLayer:Sprite;
		
		/**
		 * Initialize AppSoldierView.
		 * @return void
		 */
		public function AppBattleSoldierView() {
			super();
			
			this._dataLayer = new Sprite();
			this._roleLayer = new Sprite();
			this._effectLayer = new Sprite();
			
			this.addChild(this._dataLayer);
			this.addChild(this._roleLayer);
			this.addChild(this._effectLayer);
		}
		
		/**
		 * Add movie on data layer.
		 * @param MovieClip movie
		 * @return void
		 */
		public function addDataMovie(movie:MovieClip):void {
			this._dataLayer.addChild(movie);
		}
		
		/**
		 * Add movie on role layer.
		 * @param MovieClip movie
		 * @return void
		 */
		public function addRoleMovie(movie:MovieClip):void {
			this._roleLayer.addChild(movie);
		}
		
		/**
		 * Add movie on effect layer.
		 * @param MovieClip movie
		 * @return void
		 */
		public function addEffectMovie(movie:MovieClip):void {
			this._effectLayer.addChild(movie);
		}
		
		/**
		 * Remove all layer animes.
		 * @param Boolean includeData default false
		 * @return void
		 */
		public function removeAllLayer(includeData:Boolean = false):void {
			if (includeData) {
				this.removeLayerChildren(this._dataLayer);
			}
			this.removeLayerChildren(this._roleLayer);
			this.removeLayerChildren(this._effectLayer);
		}
		
		/**
		 * Remove all children DisplayObject(s).
		 * @param Sprite layer
		 * @return void
		 */
		public function removeLayerChildren(layer:Sprite):void {
			if (layer.numChildren) {
				for (var i:int; i < layer.numChildren; ++i) {
					layer.removeChildAt(i);
				}
			}
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* PLAY ANIMATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//		public function playStand():void {
//			this.removeAllLayerAnime();
//			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleStand(this._roleId, this._isAttacker);
//			this._roleLayer.addChild(movie);
//			movie.gotoAndPlay(1);
//			AppBattleRender.instance.callbackAnimeEnd(
//				AppBattleUtil.buildGridIdString(this._gridId, this._isAttacker),
//				AppSoldierAnimeName.STAND
//			);
//		}
//		
//		public function playAttack():void {
//			if (this._roleId != '100' //弓手
//				&& this._roleId != '101') { // 法师
////				this.move(targetGrid); // 近身单位，需要移动
//			}
//			this.removeAllLayerAnime();
//			var movie:MovieClip = AppBattleAnimeManager.instance.getAttackEffect(
//				this._isMagic ? AppBattleAnimeManager.ATTACK_TYPE_MGK : AppBattleAnimeManager.ATTACK_TYPE_PHY,
//				this._isAttacker
//			);
//			this._roleLayer.addChild(movie);
//			movie.addEventListener(Event.ENTER_FRAME, attackEnd);
//			var attackEnd:Function = function(e:Event):void {
//				var display:MovieClip = e.target as MovieClip;
//				if (display.currentFrame == display.totalFrames) {
//					display.removeEventListener(Event.ENTER_FRAME, attackEnd);
//				}
//				AppBattleRender.instance.callbackAnimeEnd(
//					AppBattleUtil.buildGridIdString(this._gridId, this._isAttacker),
//					AppSoldierAnimeName.ATTACK
//				);
//				this.playStand();
//			};
//			movie.gotoAndPlay(1);
//		}
//		
//		public function playSkill():void {
//			this.removeAllLayerAnime();
//			var movie:MovieClip = AppBattleAnimeManager.instance.getSkillEffect(this._skillId, this._isAttacker);
//			this._roleLayer.addChild(movie);
//			movie.addEventListener(Event.ENTER_FRAME, skillEnd);
//			var skillEnd:Function = function(e:Event):void {
//				var display:MovieClip = e.target as MovieClip;
//				if (display.currentFrame == display.totalFrames) {
//					display.removeEventListener(Event.ENTER_FRAME, skillEnd);
//				}
//				AppBattleRender.instance.callbackAnimeEnd(
//					AppBattleUtil.buildGridIdString(this._gridId, this._isAttacker),
//					AppSoldierAnimeName.SKILL
//				);
//				this.playStand();
//			};
//			movie.gotoAndPlay(1);
//		}
//		
//		public function playHurt():void {
//			this.removeAllLayerAnime();
//			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleHit(this._roleId, this._isAttacker);
//			this._roleLayer.addChild(movie);
//			movie.addEventListener(Event.ENTER_FRAME, hurtEnd);
//			var hurtEnd:Function = function(e:Event):void {
//				var display:MovieClip = e.target as MovieClip;
//				if (display.currentFrame == display.totalFrames) {
//					display.removeEventListener(Event.ENTER_FRAME, hurtEnd);
//				}
//				AppBattleRender.instance.callbackAnimeEnd(
//					AppBattleUtil.buildGridIdString(this._gridId, this._isAttacker),
//					AppSoldierAnimeName.HURT
//				);
//				this.playStand();
//			};
//			movie.gotoAndPlay(1);
//		}
//		
//		public function playSkillHurt(skillId:):void {
//			this.removeAllLayerAnime();
//			var movie:MovieClip = AppBattleAnimeManager.instance.getSkillEffect(this._roleId, this._isAttacker);
//			this._roleLayer.addChild(movie);
//			movie.addEventListener(Event.ENTER_FRAME, hurtEnd);
//			var hurtEnd:Function = function(e:Event):void {
//				var display:MovieClip = e.target as MovieClip;
//				if (display.currentFrame == display.totalFrames) {
//					display.removeEventListener(Event.ENTER_FRAME, hurtEnd);
//				}
//				AppBattleRender.instance.callbackAnimeEnd(
//					AppBattleUtil.buildGridIdString(this._gridId, this._isAttacker),
//					AppSoldierAnimeName.HURT
//				);
//				this.playStand();
//			};
//			movie.gotoAndPlay(1);
//		}
//		
//		public function playDie():void {
//			
//		}
//		
//		private function move(targetGrid:DisplayObjectContainer):void { //FIXME do move later, first play the movie correctly
//			var offsetX:Number = this.width / 2;
//			var offsetY:Number = this.height / 2;
//			
//			// disapper
//			var targetPosX:Number = 0;
//			var targetPosY:Number = 0;
//			if (this._isAttacker) {
//				
//			}
//			// show
//		}
	}
}