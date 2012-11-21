package com.xenojoshua.as3demo.mvc.view.item
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.robotlegs.XafRobotlegsView;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.utils.display.XafDisplayUtil;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class AppItemView extends XafRobotlegsView
	{
		// MOVIE NAMES
		public var MV_ITEM:String = 'MV_ITEM';
		
		// COMPONENT NAMES
		public var CP_CONTAINER_ITEM_LIST:String = 'itemContainer';
		public var CP_BTN_CLOSE:String           = 'closeBtn';
		
		// BUTTON NAMES
		public var CP_TAB_ALL:String    = 'tab1';
		public var CP_TAB_WEAPON:String = 'tab2';
		public var CP_TAB_GEMS:String   = 'tab3';
		public var CP_TAB_FUNC:String   = 'tab4';
		public var CP_TAB_DUMMY:String  = 'tab5';
		public var CP_BTN_EXPAND:String = 'expandBtn';
		public var CP_BTN_BLACK_MARKET:String = 'blackMarketBtn';
		
		// SIGNAL NAMES
		public var SIG_BTN_CLOSE_CLICK:String = 'SIG_BTN_CLOSE_CLICK';
		
		/**
		 * Initialize AppItemView.
		 * @param Boolean withBgMask default true
		 * @return void
		 */
		public function AppItemView(withBgMask:Boolean = true) {
			super(withBgMask);
			this.draw();
		}
		
		private function draw():void {
			var movie:MovieClip = XafRsManager.instance.getMovieClipInSwf(AppResources.FILE_MAIN, AppResources.CLASS_ITEM);
			
			// register movie
			this.registerMovie(this.MV_ITEM, movie);
			XafDisplayUtil.putStageCenter(this);
			// register components
			this.registerComponent(this.MV_ITEM, this.CP_CONTAINER_ITEM_LIST);
			this.registerComponent(this.MV_ITEM, this.CP_BTN_CLOSE);
			// register buttons
			this.registerButton(this.MV_ITEM, this.CP_TAB_ALL);
			this.registerButton(this.MV_ITEM, this.CP_TAB_WEAPON);
			this.registerButton(this.MV_ITEM, this.CP_TAB_GEMS);
			this.registerButton(this.MV_ITEM, this.CP_TAB_FUNC);
			this.registerButton(this.MV_ITEM, this.CP_TAB_DUMMY);
			this.registerButton(this.MV_ITEM, this.CP_BTN_EXPAND);
			this.registerButton(this.MV_ITEM, this.CP_BTN_BLACK_MARKET);
			// register tab
			this.registerTabs([
				this.CP_TAB_ALL,
				this.CP_TAB_WEAPON,
				this.CP_TAB_GEMS,
				this.CP_TAB_FUNC,
				this.CP_TAB_DUMMY
			]);
			// register signals
			this.registerSignal(this.CP_BTN_CLOSE, this.SIG_BTN_CLOSE_CLICK, MouseEvent.CLICK, MouseEvent);
		}
	}
}