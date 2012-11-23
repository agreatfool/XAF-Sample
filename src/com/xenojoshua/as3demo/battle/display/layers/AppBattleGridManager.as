package com.xenojoshua.as3demo.battle.display.layers
{
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	public class AppBattleGridManager
	{
		private static var _instance:AppBattleGridManager;
		
		/**
		 * Get instance of AppBattleGridManager.
		 * @return AppBattleGridManager _mgr
		 */
		public static function get instance():AppBattleGridManager {
			if (!AppBattleGridManager._instance) {
				AppBattleGridManager._instance = new AppBattleGridManager();
			}
			return AppBattleGridManager._instance;
		}
		
		/**
		 * Initialize AppBattleGridManager.
		 * @return void
		 */
		public function AppBattleGridManager() {
			this._grids = new Object();
		}
		
		private const GRID_PREFIX:String = 'grid';
		private const GRID_ATK_ID_PREFIX:String = '0';
		private const GRID_DEF_ID_PREFIX:String = '1';
		
		private var _view:AppBattleGridView;
		
		private var _grids:Object; // <name:String, grid:DisplayObjectContainer>
		
		/**
		 * Register AppBattleGridView into this manager.
		 * @param AppBattleGridView view
		 * @return void
		 */
		public function regiterGridView(view:AppBattleGridView):void {
			this._view = view;
			
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_GRIDS, AppResources.CLASS_BATTLE_GRIDS);
			for (var gridId:int = 0; gridId < 9; ++gridId) {
				var gridAtkName:String = this.GRID_PREFIX + this.GRID_ATK_ID_PREFIX + gridId.toString();
				var gridDefName:String = this.GRID_PREFIX + this.GRID_DEF_ID_PREFIX + gridId.toString();
				this._grids[gridAtkName] = movie[gridAtkName] as DisplayObjectContainer;
				this._grids[gridDefName] = movie[gridDefName] as DisplayObjectContainer;
			}
			
			this._view.addChild(movie);
		}
		
		/**
		 * Get attacker grid.
		 * @param int gridId
		 * @return DisplayObjectContainer grid
		 */
		public function getAtkGrid(gridId:int):DisplayObjectContainer {
			var gridName:String = this.GRID_PREFIX + this.GRID_ATK_ID_PREFIX + gridId.toString();
			return this._grids[gridName];
		}
		
		/**
		 * Get defender grid.
		 * @param int gridId
		 * @return DisplayObjectContainer grid
		 */
		public function getDefGrid(gridId:int):DisplayObjectContainer {
			var gridName:String = this.GRID_PREFIX + this.GRID_DEF_ID_PREFIX + gridId.toString();
			return this._grids[gridName];
		}
	}
}