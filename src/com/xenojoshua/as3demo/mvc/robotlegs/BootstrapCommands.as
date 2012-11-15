package com.xenojoshua.as3demo.mvc.robotlegs
{
	import com.xenojoshua.as3demo.mvc.controller.AppItemLoadCommand;
	import com.xenojoshua.as3demo.mvc.controller.AppItemUpdateCommand;
	import com.xenojoshua.as3demo.mvc.event.AppEvent;
	
	import org.robotlegs.core.ICommandMap;

	public class BootstrapCommands
	{
		public function BootstrapCommands(commandMap:ICommandMap) {
			commandMap.mapEvent(AppEvent.ITEM_LOAD_START,   AppItemLoadCommand);
			commandMap.mapEvent(AppEvent.ITEM_UPDATE_START, AppItemUpdateCommand);
		}
	}
}