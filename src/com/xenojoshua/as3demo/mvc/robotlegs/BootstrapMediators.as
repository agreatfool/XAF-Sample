package com.xenojoshua.as3demo.mvc.robotlegs
{
	import com.xenojoshua.as3demo.mvc.view.AppGameMediator;
	import com.xenojoshua.as3demo.mvc.view.AppGameView;
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
		}
	}
}