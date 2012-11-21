package
{
	import com.greensock.events.LoaderEvent;
	import com.xenojoshua.af.resource.manager.XafConfigManager;
	import com.xenojoshua.af.constant.XafConst;
	import com.xenojoshua.af.mvc.view.screen.XafScreenManager;
	import com.xenojoshua.af.resource.XafInitLoader;
	import com.xenojoshua.af.resource.XafRsManager;
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.font.XafFontManager;
	import com.xenojoshua.af.utils.mask.XafLoadingMaskMaker;
	import com.xenojoshua.af.utils.time.XafTime;
	import com.xenojoshua.af.utils.timer.XafTimerManager;
	import com.xenojoshua.as3demo.mvc.view.AppGameView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	[SWF(width="950", height="600", frameRate="24", backgroundColor="#FFFFFF")]
	public class Wrapper extends Sprite
	{
		/**
		 * Construction.
		 * Add one listener, will be triggered when stage initialized.
		 */
		public function Wrapper() {
			var obj:Object = new Object();
			try {
				obj.testhasnotexistfunction();
			} catch (e:Error) {
				trace('Error ID: ' + e.errorID, ' , MSG: ' + e.message);
			}
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		
		/**
		 * Initialize view entrance WrapperView.
		 * @param Event e
		 */
		private function init(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			
			XafConfigManager.instance.stageWidth  = 760;
			XafConfigManager.instance.stageHeight = 600;
			XafConfigManager.instance.mediaHost   = 'http://aslocal.com/';
			XafConfigManager.instance.apiHost     = 'http://localhost/';
			
			// INIT LOAD
			new XafInitLoader(
				XafConfigManager.instance.mediaHost + 'assets/sth/shark_soldier.json', // json case
//				XafConfig.instance.mediaHost + 'assets/sth/sample.xml', // xml case
//				XafConfig.instance.mediaHost + 'abc.xml', // failed case
				this.onInitComplete
			);
			
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_ROOT, this.stage, true);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_GAME);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_UI);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_BATTLE);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_POPUP, null, false, false);
			XafScreenManager.instance.registerLayer(XafConst.SCREEN_CONSOLE);
			
			XafLoadingMaskMaker.startup(Resources.FILE_MAIN, Resources.CLASS_LOADING);
			
			XafRsManager.instance.registerResources(Resources.getConfigs());
			XafRsManager.instance.registerCompleteSignal(this.onLoadResourceComplete);
			XafRsManager.instance.prepareLoading([Resources.FILE_MAIN, Resources.FILE_SOLDIER, Resources.FILE_LISU]).startLoading();
//			XafRsManager.instance.loadPreloads();
		}
		
		private function onInitComplete(loader:XafInitLoader):void {
			trace(JSON.stringify(loader.getJSON())); // json case
//			trace(loader.getXML().toString()); // xml case
		}
		
		private function onLoadResourceComplete(loader:XafRsManager):void  {
			// get loaded object config
			var soldierConfig:Object = XafConfigManager.instance.loadConfigs(Resources.CONF_SOLDIER);
//			trace(soldierConfig[3]['soldierName']);
//			trace(soldierConfig[9]['initGrowthRate']);
			for (var key:String in soldierConfig) {
//				trace(key);
//				trace(JSON.stringify(soldierConfig[key]));
			}
			
			// destory loader & go on process logics
			loader.dispose();
			this.processLogics();
		}
		
		private function processLogics():void {
			XafTimerManager.instance.registerTimer('loading', 1500, this.showLoading, 3, this.loadingComplete);
		}
		
		private function showLoading(e:TimerEvent):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'Show loading!');
			XafLoadingMaskMaker.instance.loading();
		}
		
		private function loadingComplete(e:TimerEvent):void {
			XafTimerManager.instance.destoryTimer('loading');
			XafTimerManager.instance.registerTimer('closeLoading', 1000, this.closeLoading, 3, this.closeComplete);
		}
		
		private function closeLoading(e:TimerEvent):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'Close loading!');
			XafLoadingMaskMaker.instance.hide();
		}
		
		private function closeComplete(e:TimerEvent):void {
			XafTimerManager.instance.destoryTimer('closeLoading');
			XafConsole.instance.log(XafConsole.NOTICE, 'Loading 3 times & closing 3 times done!');
		}
	}
}