package com.xenojoshua.as3demo.mvc.robotlegs
{
	import com.xenojoshua.as3demo.mvc.view.AppGameMediator;
	import com.xenojoshua.as3demo.mvc.view.AppGameView;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleView;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.background.AppBattleBackgroundMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.background.AppBattleBackgroundView;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.grid.AppBattleGridMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.layers.grid.AppBattleGridView;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;
	import com.xenojoshua.as3demo.mvc.view.city.AppCityMediator;
	import com.xenojoshua.as3demo.mvc.view.city.AppCityView;
	import com.xenojoshua.as3demo.mvc.view.item.AppItemMediator;
	import com.xenojoshua.as3demo.mvc.view.item.AppItemView;
	
	import org.robotlegs.core.IMediatorMap;

	public class BootstrapMediators
	{
		public function BootstrapMediators(mediatorMap:IMediatorMap) {
			mediatorMap.mapView(AppGameView, AppGameMediator);
			mediatorMap.mapView(AppCityView, AppCityMediator);
			mediatorMap.mapView(AppItemView, AppItemMediator);
			mediatorMap.mapView(AppBattleView, AppBattleMediator);
			mediatorMap.mapView(AppBattleSoldierView, AppBattleSoldierMediator);
			mediatorMap.mapView(AppBattleBackgroundView, AppBattleBackgroundMediator);
			mediatorMap.mapView(AppBattleGridView, AppBattleGridMediator);
		}
	}
}