package com.xenojoshua.as3demo.resource
{
	import com.xenojoshua.af.resource.XafIRsConfig;
	
	public class AppResources implements XafIRsConfig
	{
		// FILES GAME ENTER
		public static const FILE_GAME:String            = 'file.game';
		// FILES MAIN RESOURCE
		public static const FILE_MAIN:String            = 'file.main';
		// FILES CONFIG
		public static const FILE_SOLDIER:String         = 'file.soldier';
		// FILES FONT
		public static const FILE_LISU:String            = 'file.lisu';
		// FILES IMAGE
		public static const FILE_BATTLE_BG:String       = 'file.battlebg';
		// FILES SWF ANIMATION
		public static const FILE_BATTLE_ROLE_100:String = 'file.battlerole100';
		public static const FILE_BATTLE_ROLE_101:String = 'file.battlerole101';
		public static const FILE_BATTLE_ROLE_102:String = 'file.battlerole102';
		public static const FILE_BATTLE_ROLE_103:String = 'file.battlerole103';
		
		// CLASSES
		public static const CLASS_GAME:String    = 'AppGame';
		public static const CLASS_LOADING:String = 'main.loadingUI';
		public static const CLASS_CITY:String    = 'main.TestBg1';
		public static const CLASS_ITEM:String    = 'main.InventoryUI';
		public static const CLASS_BATTLE_STAND   = '';
		
		// CONFIGS
		public static const CONF_SOLDIER:String = 'config.soldier';
		
		// FONTS
		public static const FONT_LISU:String = 'LiSu';
		
		// DUMMY
		public static const DUMMY:String = 'file.dummy';
		
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