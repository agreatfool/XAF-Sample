package com.xenojoshua.as3demo.mvc.view.city
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class AppCityView extends XafRobotlegsView
	{
		// MOVIE NAMES
		public var MV_CITY:String = 'MV_CITY';
		
		// COMPONENT NAMES
		public var CP_BTN_ITEM:String = 'recBtn';
		
		// SIGNAL NAMES
		public var SIG_BTN_ITEM_CLICK:String = 'SIG_BTN_ITEM_CLICK';
		
		/**
		 * Initialize AppCityView.
		 * @return void
		 */
		public function AppCityView() {
			super();
			this.draw();
		}
		
		/**
		 * Draw view.
		 * @return void
		 */
		private function draw():void {
			// get movie
			var movie:MovieClip = XafRsManager.instance.getMovieClipInSwf(AppResources.FILE_MAIN, AppResources.CLASS_CITY);
			
			// register movies
			this.registerMovie(this.MV_CITY, movie);
			// register components
			this.registerComponent(this.MV_CITY, this.CP_BTN_ITEM);
			// init signals
			this.registerSignal(this.MV_CITY, this.CP_BTN_ITEM, this.SIG_BTN_ITEM_CLICK, MouseEvent.CLICK, MouseEvent);
		}
	}
}