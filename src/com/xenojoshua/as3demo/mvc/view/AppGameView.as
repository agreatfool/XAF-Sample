package com.xenojoshua.as3demo.mvc.view
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import com.xenojoshua.as3demo.mvc.context.AppGameContext;
	
	public class AppGameView extends Sprite
	{
		private var _context:AppGameContext;
		
		/**
		 * Initialization AppGameView.
		 * @param Stage stage
		 * @return void
		 */
		public function AppGameView(stage:Stage) {
			super();
			this._context = new AppGameContext(stage);
			stage.addChild(this);
		}
	}
}