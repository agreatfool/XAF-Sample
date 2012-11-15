package com.xenojoshua.as3demo.view
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class AppGameView extends Sprite
	{
		/**
		 * Construction.
		 * Call initialization function.
		 */
		public function AppGameView(stage:Stage) {
			super();
			this.init(stage);
		}
		
		/**
		 * Initialize robotlegs context.
		 * And add self view into stage, to trigger Mediator events.
		 * @param Stage stage
		 */
		private function init(stage:Stage):void {
			stage.addChild(this);
		}
	}
}