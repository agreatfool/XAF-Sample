package com.xenojoshua.as3demo.mvc.controller
{
	import org.robotlegs.mvcs.Command;
	
	public class AppItemLoadCommand extends Command
	{
		public function AppItemLoadCommand() {
			super();
		}
		
		override public function execute():void {
			commandMap.detain(this);
		}
		
		private function releaseThis():void {
			commandMap.release(this);
		}
	}
}