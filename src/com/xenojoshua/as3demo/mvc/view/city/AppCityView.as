package com.xenojoshua.as3demo.mvc.view.city
{
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.resource.manager.XafSwfManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class AppCityView extends XafRobotlegsView
	{
		// MOVIE NAMES
		public var MV_CITY:String = 'MV_CITY';
		
		// COMPONENT NAMES
		public var CP_BTN_ITEM:String     = 'recBtn';
		public var CP_BTN_BATTLE:String   = 'startBtn';
		public var CP_BTN_SHUTDOWN:String = 'euiBtn';
		
		// SIGNAL NAMES
		public var SIG_BTN_ITEM_CLICK:String     = 'SIG_BTN_ITEM_CLICK';
		public var SIG_BTN_BATTLE_CLICK:String   = 'SIG_BTN_BATTLE_CLICK';
		public var SIG_BTN_SHUTDOWN_CLICK:String = 'SIG_BTN_SHUTDOWN_CLICK';
		
		/**
		 * Initialize AppCityView.
		 * @param Boolean withBgMask default false
		 * @return void
		 */
		public function AppCityView(withBgMask:Boolean = false) {
			super(withBgMask);
			this.draw();
		}
		
		/**
		 * Draw view.
		 * @return void
		 */
		private function draw():void {
			// get movie
			var movie:MovieClip = XafSwfManager.instance.getMovieClipInSwf(AppResources.FILE_MAIN, AppResources.CLASS_CITY);
			
			// register movies
			this.registerMovie(this.MV_CITY, movie);
			// register components
			this.registerComponent(this.MV_CITY, this.CP_BTN_ITEM);
			this.registerComponent(this.MV_CITY, this.CP_BTN_BATTLE);
			this.registerComponent(this.MV_CITY, this.CP_BTN_SHUTDOWN);
			// init signals
			this.registerSignal(this.CP_BTN_ITEM, this.SIG_BTN_ITEM_CLICK, MouseEvent.CLICK, MouseEvent);
			this.registerSignal(this.CP_BTN_BATTLE, this.SIG_BTN_BATTLE_CLICK, MouseEvent.CLICK, MouseEvent);
			this.registerSignal(this.CP_BTN_SHUTDOWN, this.SIG_BTN_SHUTDOWN_CLICK, MouseEvent.CLICK, MouseEvent);
		}
	}
}