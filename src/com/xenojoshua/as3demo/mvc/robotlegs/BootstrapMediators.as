package com.xenojoshua.as3demo.mvc.robotlegs
{
	import com.xenojoshua.as3demo.mvc.view.AppGameMediator;
	import com.xenojoshua.as3demo.mvc.view.AppGameView;
	
	import org.robotlegs.core.IMediatorMap;

	public class BootstrapMediators
	{
		public function BootstrapMediators(mediatorMap:IMediatorMap) {
			mediatorMap.mapView(AppGameView, AppGameMediator);
		}
	}
}