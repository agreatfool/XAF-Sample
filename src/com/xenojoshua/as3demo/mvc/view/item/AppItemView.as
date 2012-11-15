package com.xenojoshua.as3demo.mvc.view.item
{
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AppItemView extends Sprite
	{
		public function AppItemView() {
			super();
			this.draw();
		}
		
		private function draw():void {
			var movie:MovieClip = XafRsManager.instance.getClassDefInSwf(AppResources.FILE_MAIN, AppResources.CLASS_ITEM);
			XafScreenManager.instance.getLayer(XafConst.SCREEN_UI).addChild(movie);
		}
	}
}