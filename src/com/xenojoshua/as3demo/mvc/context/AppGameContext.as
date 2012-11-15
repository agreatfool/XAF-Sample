package com.xenojoshua.as3demo.mvc.context
{
	import com.xenojoshua.as3demo.mvc.robotlegs.BootstrapCommands;
	import com.xenojoshua.as3demo.mvc.robotlegs.BootstrapMediators;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class AppGameContext extends Context
	{
		/**
		 * Initialize AppGameContext.
		 * @param DisplayObjectContainer contextView default null
		 * @param Boolean autoStartup default null
		 * @return void
		 */
		public function AppGameContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}
		
		/**
		 * @see org.robotlegs.mvcs.Context.startup()
		 */
		override public function startup():void {
			super.startup();
			new BootstrapMediators(this.mediatorMap);
			new BootstrapCommands(this.commandMap);
		}
	}
}