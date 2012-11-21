package 
{
	import com.xenojoshua.af.resource.config.XafIRsConfig;
	
	public class Resources implements XafIRsConfig
	{
		// FILES
		public static const FILE_MAIN:String    = 'file.main';
		public static const FILE_SOLDIER:String = 'file.soldier';
		public static const FILE_LISU:String    = 'file.lisu';
		
		// CLASSES
		public static const CLASS_LOADING:String = 'main.loadingUI';
		
		// CONFIGS
		public static const CONF_SOLDIER:String = 'config.soldier';
		
		// FONTS
		public static const FONT_LISU:String = 'LiSu';
		
		private static var _configs:Object = {
			'file.main': {
				url: 'assets/swf/MainUI.swf',
				type: 'swf',
				preload: true,
				main: true
			},
			'file.soldier': {
				url: 'assets/sth/shark_soldier.json',
				type: 'config',
				preload: true,
				config: 'config.soldier'
			},
			'file.lisu': {
				url: 'assets/swf/Font.swf',
				type: 'font',
				preload: true,
				font: {'LISU1': 'LiSu'}
			}
		};
		
		public static function setConfigs(resources:Object):void {
			Resources._configs = resources;
		}
		
		public static function getConfigs():Object {
			return Resources._configs;
		}
		
		public static function getConfig(name:String):Object {
			return Resources._configs[name];
		}
	}
}