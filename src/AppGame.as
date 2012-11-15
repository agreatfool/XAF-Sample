package
{
	import com.xenojoshua.as3demo.mvc.view.AppGameView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AppGame extends Sprite
	{
		/**
		 * Initialize AppGame.
		 * @return void
		 */
		public function AppGame() {
			super();
			if (this.stage) {
				this.loadSystem();
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, this.loadSystem);
			}
		}
		
		/**
		 * Start to load game system.
		 * @param Event e default null
		 * @return void
		 */
		public function loadSystem(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.loadSystem);
			new AppGameView(this.stage);
		}
	}
}