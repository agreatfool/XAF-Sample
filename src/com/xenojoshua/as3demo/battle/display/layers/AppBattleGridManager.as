package com.xenojoshua.as3demo.battle.display.layers
{
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.mvc.model.vo.battle.AppBattleSoldier;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;
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
		private const GRID_ID_PREFIX:String = '0';
		private const GRID_CENTER_ID_PREFIX:String = '9';
		
		private var _view:AppBattleGridView;
		
		private var _grids:Object; // <gridId:String, grid:DisplayObjectContainer>
		
		/**
		 * Register AppBattleGridView into this manager.
		 * @param AppBattleGridView view
		 * @return void
		 */
		public function regiterGridView(view:AppBattleGridView):void {
			this._view = view;
			
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_BATTLE_GRIDS, AppResources.CLASS_BATTLE_GRIDS);
			for (var atkGridId:int = 0; atkGridId < 9; ++atkGridId) {
				var strAtkGridId:String = this.formatGridId(atkGridId, true);
				var atkGridName:String = this.GRID_PREFIX + strAtkGridId;
				this._grids[strAtkGridId] = movie[atkGridName] as DisplayObjectContainer;
			}
			for (var defGridId:int = 0; defGridId < 9; ++defGridId) {
				var strDefGridId:String = this.formatGridId(defGridId, false);
				var defGridName:String = this.GRID_PREFIX + strDefGridId;
				this._grids[strDefGridId] = movie[defGridName] as DisplayObjectContainer;
			}
			for (var rowId:int = 0; rowId < 3; ++rowId) {
				var centerGridId:String = this.formatCenterGridId(rowId);
				var centerGridName:String = this.GRID_PREFIX + centerGridId;
				this._grids[centerGridId] = movie[centerGridName] as DisplayObjectContainer;
			}
			
			this._view.addChild(movie);
		}
		
		/**
		 * Get target grid.
		 * @param AppBattleSoldier target
		 * @return DisplayObjectContainer grid
		 */
		public function getGrid(target:AppBattleSoldier):DisplayObjectContainer {
			var gridName:String = this.formatGridId(target.gridId, target.isAttacker);
			return this._grids[gridName];
		}
		
		/**
		 * Get center grid.
		 * @param int rowId
		 * @return DisplayObjectContainer grid
		 */
		public function getCenterGrid(rowId:int):DisplayObjectContainer {
			return this._grids[this.formatCenterGridId(rowId)];
		}
		
		/**
		 * Get target recipient's neighbour grid to play movie anime.
		 * @param AppBattleSoldier target
		 * @return DisplayObjectContainer grid
		 */
		public function getTargetGrid(target:AppBattleSoldier):DisplayObjectContainer {
			var grid:DisplayObjectContainer = null;
			
			if (target.gridId <= 2 && target.gridId >= 0) { // first line of grid, actor is in the center grids
				var rowId:int = target.gridId % 3;
				grid = this.getCenterGrid(rowId);
			} else {
				grid = this.getGrid(new AppBattleSoldier(target.gridId - 3, 'roleId', 0, 0, 0, target.isAttacker, true, 0));
			}
			
			return grid;
		}
		
		/**
		 * Format grid id from int to String. <br/>
		 * 0-8   => '00'-'08' <br/>
		 * 10-18 => '10'-'18' <br/>
		 * center grid: 0-2 => '90'-'92'
		 * @param int gridId
		 * @param Boolean isAttacker
		 * @return String gridId
		 */
		private function formatGridId(gridId:int, isAttacker:Boolean):String {
			var id:String = '';
			
			if (!isAttacker) {
				gridId += 10;
			}
			if (gridId.toString().length == 1) { // e.g: 0, 1, ..., 8
				id = this.GRID_ID_PREFIX + gridId;
			} else {
				id = gridId.toString();
			}
			
			return id;
		}
		
		/**
		 * Format center grid id to string.
		 * @param int rowId
		 * @return String gridIdStr
		 */
		private function formatCenterGridId(rowId:int):String {
			return this.GRID_CENTER_ID_PREFIX + rowId;
		}
	}
}