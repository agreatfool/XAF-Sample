package com.xenojoshua.as3demo.resource
{
	import com.xenojoshua.af.resource.XafIRsConfig;
	
	public class AppResources implements XafIRsConfig
	{
		// FILES
		public static const FILE_GAME:String    = 'file.game';
		public static const FILE_MAIN:String    = 'file.main';
		public static const FILE_SOLDIER:String = 'file.soldier';
		public static const FILE_LISU:String    = 'file.lisu';
		
		// CLASSES
		public static const CLASS_GAME:String    = 'AppGame';
		public static const CLASS_LOADING:String = 'main.loadingUI';
		public static const CLASS_ITEM:String    = 'main.InventoryUI';
		
		// CONFIGS
		public static const CONF_SOLDIER:String = 'config.soldier';
		
		// FONTS
		public static const FONT_LISU:String = 'LiSu';
		
		private static var _configs:Object;
		
		public static function setConfigs(resources:Object):void {
			AppResources._configs = resources;
		}
		
		public static function getConfigs():Object {
			return AppResources._configs;
		}
		
		public static function getConfig(name:String):Object {
			return AppResources._configs[name];
		}
	}
}