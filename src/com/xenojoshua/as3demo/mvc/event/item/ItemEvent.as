package com.xenojoshua.as3demo.mvc.event.item
{
	import com.xenojoshua.af.mvc.controller.event.XafEvent;
	
	public class ItemEvent extends XafEvent
	{
		// ITEM API
		public static const ITEM_LOAD_START:String   = 'ITEM_LOAD_START';
		public static const ITEM_LOAD_DONE:String    = 'ITEM_LOAD_DONE';
		public static const ITEM_UPDATE_START:String = 'ITEM_UPDATE_START';
		public static const ITEM_UPDATE_DONE:String  = 'ITEM_UPDATE_DONE';
		
		public function ItemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}