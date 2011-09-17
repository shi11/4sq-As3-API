////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// updated: Jan 16, 2011 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.models.vo.CityVO;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.interfaces.ILocationView;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class LocationMediator extends Mediator
	{

		
		[Inject]
		public var view:ILocationView;
		
		[Inject]
		public var signalBus:FoursquareSignalBus;
		
		public function LocationMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.nearbyRequest.add( getNearbyLocations );
			signalBus.nearbyResult.add( onNearbyResults );
			//getUserLocation();
		}
		
		public function getNearbyLocations(city:CityVO):void{
			
		}
		
		public function onNearbyResults( results: ArrayCollection ):void{
			view.setNearbyResults( results );
		}
		
		/*private function getUserLocation():void{
		}
		
		public function setUserLocation(cityVO:CityVO):void{
			view.setUserLocation( cityVO );
		}*/
		
	}
}