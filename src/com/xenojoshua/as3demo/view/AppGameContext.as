package com.xenojoshua.as3demo.view
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class AppGameContext extends Context
	{
		public function AppGameContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) {
			super(contextView, autoStartup);
		}
		
		override public function startup():void {
			super.startup();
		}
	}
}