////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// updated: Jan 16, 2011 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.CityVO;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.interfaces.IVenueView;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class VenueMediator extends Mediator
	{

		[Inject]
		public var view:IVenueView;
		
		[Inject]
		public var signalBus:FoursquareSignalBus;
		
		public function VenueMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.nearbyRequest.add( getNearbyLocations );
			view.venueSelected.add( onVenueSelected );
			signalBus.nearbyResult.add( onNearbyResults );
			//getUserLocation();
		}
		
		public function getNearbyLocations(city:CityVO, query:String=""):void{
			signalBus.nearbyRequest.dispatch( city, query );
		}
		
		public function onNearbyResults( results: Array ):void{
			view.setNearbyResults( new ArrayCollection(results) );
		}
		
		private function onVenueSelected( item : Object ):void{
			//model.selectedVenue = item;
			signalBus.venueSelected.dispatch( item );
		}
		
	}
}