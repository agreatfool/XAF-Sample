package com.xenojoshua.as3demo.mvc.robotlegs
{
	import com.xenojoshua.as3demo.mvc.controller.AppItemLoadCommand;
	import com.xenojoshua.as3demo.mvc.controller.AppItemUpdateCommand;
	import com.xenojoshua.as3demo.mvc.event.item.ItemEvent;
	
	import org.robotlegs.core.ICommandMap;

	public class BootstrapCommands
	{
		public function BootstrapCommands(commandMap:ICommandMap) {
			commandMap.mapEvent(ItemEvent.ITEM_LOAD_START,   AppItemLoadCommand);
			commandMap.mapEvent(ItemEvent.ITEM_UPDATE_START, AppItemUpdateCommand);
		}
	}
}