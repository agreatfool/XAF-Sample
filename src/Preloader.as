package
{
	import com.xenojoshua.af.config.XafConfig;
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.preloader.XafIPreloader;
	import com.xenojoshua.af.resource.XafInitLoader;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.mask.XafLoadingMaskMaker;
	import com.xenojoshua.as3demo.resource.AppResources;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="950", height="600", frameRate="30", backgroundColor="#FFFFFF")]
	public class Preloader extends Sprite implements XafIPreloader
	{
		private var _isLocal:Boolean = true;
		
		/**
		 * Initialize Preloader.
		 * @return void
		 */
		public function Preloader() {
			super();
			if (this.stage) {
				this.parseFlashVars();
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, this.parseFlashVars);
			}
		}
		
		/**
		 * Parse flash vars & set into config manager.
		 * @param Event e default null
		 * @return void
		 */
		public function parseFlashVars(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.parseFlashVars);
			XafConfig.instance.isLocal = this._isLocal;
			
			if (!XafConfig.instance.isLocal) {
				var params:Object = this.loaderInfo.parameters;
				if (!params.hasOwnProperty('playerId')
					|| !params.hasOwnProperty('mediaHost')
					|| !params.hasOwnProperty('apiHost')
					|| !params.hasOwnProperty('stageWidth')
					|| !params.hasOwnProperty('stageHeight')) {
					XafConsole.instance.log(XafConsole.ERROR, 'Preloader: SWF LoaderInfo not provided!');
				}
				XafConfig.instance.playerId    = params['playerId'];
				XafConfig.instance.mediaHost   = params['mediaHost'];
				XafConfig.instance.apiHost     = params['apiHost'];
				XafConfig.instance.stageWidth  = params['stageWidth'];
				XafConfig.instance.stageHeight = params['stageHeight'];
			} else {
				XafConfig.instance.playerId    = 292514701;
				XafConfig.instance.mediaHost   = 'http://aslocal.com/';
				XafConfig.instance.apiHost     = 'http://localhost/';
				XafConfig.instance.stageWidth  = 950;
				XafConfig.instance.stageHeight = 600;
			}
			
			this.loadResourceListConfig();
		}
		
		/**
		 * Load resource list config file.
		 * @return void
		 */
		public function loadResourceListConfig():void {
			new XafInitLoader(
				XafConfig.instance.mediaHost + 'assets/json/resources.json?v=10.' + Math.random(),
				this.loadPreloadItems
			);
		}
		
		/**
		 * Resource list loaded, start to load preload items.
		 * @return void
		 */
		public function loadPreloadItems(loader:XafInitLoader):void {
			// register resources
			var resources:Object = loader.getJSON();
			loader.dispose();
			
			// register sceen layers
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_ROOT, this.stage, true);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_GAME);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_UI);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_BATTLE);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_POPUP, null, false, false);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_CONSOLE);
			
			// initialize utility
			XafConsole.restart();
			XafLoadingMaskMaker.startup(AppResources.FILE_MAIN, AppResources.CLASS_LOADING);
			
			// resource loading
			XafRsManager.instance.initializeLoadingBar(null, null, 1);
			XafRsManager.instance.registerResources(resources);
			XafRsManager.instance.registerCompleteSignal(this.loadSystem);
			XafRsManager.instance.loadPreloads();
		}
		
		/**
		 * Start to load system.
		 * @return void
		 */
		public function loadSystem(rsManager:XafRsManager):void {
			XafRsManager.instance.dispose();
			var gameClass:Class = rsManager.getClassDefInSwf(AppResources.FILE_GAME, AppResources.CLASS_GAME);
			this.stage.addChild(new gameClass());
			this.stage.removeChild(this);
		}
	}
}