package com.xenojoshua.as3demo.mvc.view.battle.soldier
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleAnimeManager;
	import com.xenojoshua.as3demo.battle.display.render.AppBattleRender;
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
		 * Initialize AppBattleSoldierView.
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
		 * Destory the AppBattleSoldierView.
		 * @return void
		 */
		override public function dispose():void {
			super.dispose();
			this.removeAllLayer();
			this._dataLayer = null;
			this._roleLayer = null;
			this._effectLayer = null;
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
		 * Get role movie from role layer.
		 * @return MovieClip movie
		 */
		public function getRoleMovie():MovieClip {
			var movie:MovieClip = null;
			try {
				movie = this._roleLayer.getChildAt(0) as MovieClip;
			} catch (e:Error) {
				if (e.errorID != 2006) { // throw exception if it's not what we wished
					throw e;
				}
			}
			return movie;
		}
		
		/**
		 * Remove all layer animes.
		 * @return void
		 */
		public function removeAllLayer():void {
			this.removeLayerChildren(this._dataLayer);
			this.removeLayerChildren(this._roleLayer);
			this.removeLayerChildren(this._effectLayer);
		}
		
		/**
		 * Remove all data layer anime.
		 * @return void
		 */
		public function removeDataLayer():void {
			this.removeLayerChildren(this._dataLayer);
		}
		
		/**
		 * Remove all role layer anime.
		 * @return void
		 */
		public function removeRoleLayer():void {
			this.removeLayerChildren(this._roleLayer);
		}
		
		/**
		 * Remove all effect layer anime.
		 * @return void
		 */
		public function removeEffectLayer():void {
			this.removeLayerChildren(this._effectLayer);
		}
		
		/**
		 * Remove all children DisplayObject(s).
		 * @param Sprite layer
		 * @return void
		 */
		private function removeLayerChildren(layer:Sprite):void {
			if (layer.numChildren > 0) {
				for (var i:int; i < layer.numChildren; ++i) {
					layer.removeChildAt(i);
				}
			}
		}
	}
}