package com.xenojoshua.as3demo.mvc.view.battle.grid
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class AppBattleGridView extends XafRobotlegsView
	{
		private static var _instance:AppBattleGridView;
		
		/**
		 * Get instance of AppBattleGridManager.
		 * @return AppBattleGridManager _mgr
		 */
		public static function get instance():AppBattleGridView {
			if (!AppBattleGridView._instance) {
				AppBattleGridView._instance = new AppBattleGridView();
			}
			return AppBattleGridView._instance;
		}
		
		/**
		 * Initialize AppBattleGridView.
		 * @return void
		 */
		public function AppBattleGridView() {
			super();
		}
		
		protected const GRID_PREFIX:String = 'grid';
		protected const GRID_ATK_ID_PREFIX:String = '0';
		protected const GRID_DEF_ID_PREFIX:String = '1';
		
		protected var _grids:Object; // <name:String, grid:DisplayObjectContainer>
		
		/**
		 * Register battle background grids.
		 * @param MovieClip movie
		 * @return void
		 */
		public function registerGrids(movie:MovieClip):void {
			for (var gridId:int = 0; gridId < 9; ++gridId) {
				var gridAtkName:String = this.GRID_PREFIX + this.GRID_ATK_ID_PREFIX + gridId.toString();
				var gridDefName:String = this.GRID_PREFIX + this.GRID_DEF_ID_PREFIX + gridId.toString();
				this._grids[gridAtkName] = movie[gridAtkName] as DisplayObjectContainer;
				this._grids[gridDefName] = movie[gridDefName] as DisplayObjectContainer;
			}
			
			this.addChild(movie);
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